import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/apt_scaffold.dart';
import 'package:aptapp/exercises/bloc/training_plan_repository.dart';
import 'package:aptapp/external_app/bloc/external_app_bloc.dart';
import 'package:aptapp/external_app/bloc/external_app_repository.dart';
import 'package:aptapp/global_apt_cubit.dart';
import 'package:aptapp/global_apt_state.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/language_cubit.dart';
import 'package:aptapp/authentication/auth_listener.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/beamer/healthcare_professional_locations.dart';
import 'package:aptapp/beamer/super_admin_locations.dart';
import 'package:aptapp/exercises/bloc/exercise_repository.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/exercises/bloc/workout_repository.dart';
import 'package:aptapp/firebase_options.dart';
import 'package:aptapp/institution/bloc/institution_bloc.dart';
import 'package:aptapp/institution/bloc/institution_repository.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/message/bloc/message_repository.dart';
import 'package:aptapp/patient/bloc/mailrepository.dart';
import 'package:aptapp/push_notifications_manager.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/social/social_controller_repository.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/string_extension.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/video/bloc/video_bloc.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'activity/bloc/activity_repository.dart';
import 'authentication/bloc/authentication.dart';
import 'authentication/user_repository.dart';
import 'beamer/institutsadmin_locations.dart';
import 'beamer/patient_locations.dart';
import 'beamer/root_locations.dart';
import 'user/user_controller_repository.dart';
import 'video/bloc/video_repository.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("receivedNotification", true);
  PushNotificationsManager().setReceivedNotification(true);
}

void main() async {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    launchApp();
  }, (error, stackTrace) {
    // bad request, no internet connection?
    if (error is ApiException && error.code == 400) {
      APTApp.globalAptCubit.triggerNoInternet();
    }
  });
}

void launchApp() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await MatomoTracker.instance.initialize(siteId: matomoSiteId, url: '$matomoUrl/matomo.php', contentBaseUrl: basePath);

  KiwiContainer()
    ..registerSingleton((c) => UserRepository())
    ..registerSingleton((c) => MailRepository())
    ..registerSingleton((c) => UserControllerRepository())
    ..registerSingleton((c) => MessageRepository())
    ..registerSingleton((c) => VideoRepository())
    ..registerSingleton((c) => InstitutionRepository())
    ..registerSingleton((c) => ActivityRepository())
    ..registerSingleton((c) => SocialControllerRepository());
  final userRepository = KiwiContainer().resolve<UserRepository>();

  await userRepository.hasToken(null);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(
      desktop: 1100,
      tablet: 680,
      watch: 300,
    ),
  );
  Intl.defaultLocale = "de";
  SharedPreferences preferences = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!PushNotificationsManager().hasReceivedNotification()) {
    PushNotificationsManager().setReceivedNotification(preferences.getBool("receivedNotification") == true);
  }
  preferences.setBool("receivedNotification", false);

  runApp(APTApp(initialLanguageCode: preferences.getString("language_code") ?? ""));
}

class APTApp extends StatefulWidget {
  final String initialLanguageCode;

  static GlobalAptCubit _globalAptCubit = GlobalAptCubit();
  static GlobalAptCubit get globalAptCubit => _globalAptCubit;

  APTApp({required this.initialLanguageCode});

  @override
  _APTAppState createState() => _APTAppState();
}

class _APTAppState extends State<APTApp> with WidgetsBindingObserver {
  DateTime resumeTime = DateTime.now();

  void checkForCurrentVersion() async {
    String serverVersion = json.decode((await http.get(Uri.parse("$basePath/assets/assets/version/version.json"))).body)["minimumRequired"];
    String currentVersion = json.decode((await rootBundle.loadString("assets/version/version.json")))["minimumRequired"];
    List<String> serverVersionNumbers = serverVersion.split(".");
    List<String> currentVersionNumbers = currentVersion.split(".");
    bool needUpdate = false;
    for (int i = 0; i < serverVersionNumbers.length; i++) {
      int currentVersionServer = int.parse(serverVersionNumbers[i]);
      int currentVersionCurrent = int.parse(currentVersionNumbers[i]);
      if (currentVersionServer > currentVersionCurrent) {
        needUpdate = true;
        break;
      }
      if (currentVersionCurrent > currentVersionServer) {
        break;
      }
    }
    if (needUpdate) {
      APTApp.globalAptCubit.triggerNeedUpdate(serverVersion);
    }
  }

  @override
  void initState() {
    super.initState();
    PushNotificationsManager().init();
    APTApp.globalAptCubit.reset();
    resumeTime = DateTime.now();
    trackCurrentLifeCycleState(WidgetsBinding.instance.lifecycleState);
    WidgetsBinding.instance.addObserver(this);
    checkForCurrentVersion();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState: $state");
    if (state == AppLifecycleState.resumed) {
      checkForCurrentVersion();
      showResumeScreen();
    }
    trackCurrentLifeCycleState(state);
  }

  showResumeScreen() async {
    KiwiContainer().resolve<UserRepository>().hasToken(null);
  }

  trackCurrentLifeCycleState(AppLifecycleState? state) {
    // inactive always followed by paused
    if (state == null || state == AppLifecycleState.inactive || kIsWeb) {
      return;
    }
    if (KiwiContainer().resolve<UserRepository>().userRole == UserRole.PATIENT && PushNotificationsManager().hasReceivedNotification()) {
      APTApp.globalAptCubit.clickedNotification();
    }
    if (state == AppLifecycleState.resumed) {
      resumeTime = DateTime.now();
    } else if (state == AppLifecycleState.paused) {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_LIFE_CYCLE,
          name: EVENT_NAME_FOREGROUND,
          action: "App in Foreground",
          value: DateTime.now().difference(resumeTime).inSeconds,
        ),
      );
    }
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
        category: EVENT_CATEGORY_LIFE_CYCLE,
        name: EVENT_NAME_CHANGE_LIFE_CYCLE,
        action: "Switched State to ${state.name.capitalize()}",
      ),
    );
  }

  @override
  Widget build(BuildContext rootContext) {
    final routerDelegate = BeamerDelegate(
      initialPath: "/login",
      guards: [
        ...guards,
      ],
      locationBuilder: BeamerLocationBuilder(
        beamLocations: [
          ...rootLocations,
          ...superAdminLocations,
          ...institutsAdminLocations,
          ...hcprofessionalLocations,
          ...patientLocations,
        ],
      ),
      notFoundRedirect: NotFoundLocation(),
    );

    return BlocBuilder<GlobalAptCubit, GlobalAptState>(
      bloc: APTApp.globalAptCubit,
      builder: (context, globalState) {
        return OverlaySupport.global(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                lazy: false,
                create: (context) => AuthenticationBloc()..add(AuthenticationStarted()),
              ),
              BlocProvider<UserBloc>(lazy: false, create: (context) => UserBloc()),
              BlocProvider<ActivityBloc>(
                lazy: false,
                create: (context) => ActivityBloc(
                  activityRepository: ActivityRepository(),
                  messageRepository: MessageRepository(),
                ),
              ),
              BlocProvider<ExerciseBloc>(
                lazy: false,
                create: (context) => ExerciseBloc(
                  exerciseRepository: ExerciseRepository(),
                  workoutRepository: WorkoutRepository(),
                  trainingPlanRepository: TrainingPlanRepository(),
                ),
              ),
              BlocProvider<InstitutionBloc>(
                lazy: false,
                create: (context) => InstitutionBloc(
                  institutionRepository: InstitutionRepository(),
                ),
              ),
              BlocProvider<MessageBloc>(
                create: (context) => MessageBloc(
                  messageRepository: MessageRepository(),
                ),
              ),
              BlocProvider<VideoBloc>(
                create: (context) => VideoBloc(
                  videoRepository: VideoRepository(),
                ),
              ),
              BlocProvider<ExternalAppBloc>(
                create: (context) => ExternalAppBloc(
                  externalAppRepository: ExternalAppRepository(),
                ),
              ),
              BlocProvider<LanguageCubit>(
                create: (context) => LanguageCubit(widget.initialLanguageCode.isNotEmpty ? Locale(widget.initialLanguageCode) : Locale('de')),
              ),
              BlocProvider<SocialBloc>(
                lazy: false,
                create: (context) => SocialBloc(),
              ),
            ],
            child: BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return BeamerProvider(
                  routerDelegate: routerDelegate,
                  child: MaterialApp.router(
                    onGenerateTitle: (context) => "aktivplan+",
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      ...GlobalMaterialLocalizations.delegates,
                    ],
                    locale: locale,
                    supportedLocales: const [Locale('de'), Locale('en')],
                    builder: (context, child) {
                      if (globalState is NoInternetAptState) {
                        return AptScaffold(
                          body: Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SelectableText(context.i18n.errorNoInternet, textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                                  SizedBox(height: 20),
                                  SaveButton(
                                    title: context.i18n.tryAgain.toUpperCase(),
                                    callback: () {
                                      APTApp.globalAptCubit.reset();
                                      showResumeScreen();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (globalState is NeedUpdateAptState) {
                        double totalHeight = MediaQuery.of(context).size.height;
                        return Scaffold(
                          backgroundColor: Colors.white,
                          appBar: AppBar(automaticallyImplyLeading: false, actions: [
                            TextButton(
                              key: Key(KEY_BUTTON_CHANGE_LANGUAGE),
                              child: Text(Localizations.localeOf(context).languageCode == "de" ? "EN" : "DE"),
                              onPressed: () {
                                BlocProvider.of<LanguageCubit>(context).changeLanguage(context);
                              },
                            )
                          ]),
                          body: Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Wrap(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        child: Image.asset(
                                          "assets/images/logo.png",
                                        ),
                                      ),
                                      SizedBox(height: totalHeight * 0.1),
                                      SelectableText(context.i18n.newVersionAvailable,
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      SelectableText(context.i18n.newVersionAvailableText(globalState.latestVersion),
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                                      SizedBox(height: 20),
                                      SaveButton(
                                        title: context.i18n.update.toUpperCase(),
                                        callback: () {
                                          if (Platform.isAndroid || Platform.isIOS) {
                                            final appId = Platform.isAndroid ? 'at.lbidhp.aktivplan' : '6484315372';
                                            final url = Uri.parse(
                                              Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
                                            );
                                            launchUrl(
                                              url,
                                              mode: LaunchMode.externalApplication,
                                            );
                                          }
                                        },
                                      ),
                                      SizedBox(height: totalHeight * 0.4),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (globalState is ClickedNotificationAptState) {
                        APTApp.globalAptCubit.reset();
                        PushNotificationsManager().setReceivedNotification(false);
                        SharedPreferences.getInstance().then((value) => value.setBool("receivedNotification", false));
                        Beamer.of(context).beamToNamed("/personal-messages");
                      }
                      return AuthListener(child: child);
                    },
                    title: 'aktivplan',
                    theme: getAptTheme(context),
                    debugShowCheckedModeBanner: false,
                    routeInformationParser: BeamerParser(),
                    routerDelegate: routerDelegate,
                    backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegate),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

final basePath = const String.fromEnvironment('BASE_URL', defaultValue: 'https://aktivplan-plus.ap-stage.at');
final matomoUrl = const String.fromEnvironment('MATOMO_URL', defaultValue: 'https://analytics.ap-dev.at');
final matomoSiteId = const int.fromEnvironment('MATOMO_SITE_ID', defaultValue: 2);

final String iosStoreUrl = "https://apps.apple.com/us/app/aktivplan/id6484315372";
final String googlePlayStoreUrl = "https://play.google.com/store/apps/details?id=at.lbidhp.aktivplan";

final ApiClient apiClient = ApiClient(basePath: basePath);
