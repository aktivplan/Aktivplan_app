import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/institutsadmin_locations.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/widgets/time_picker_row.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/percent_indicator.dart';
import 'package:aptapp/patient/patient_calendar/done_slider.dart';
import 'package:aptapp/patient/share_button.dart';
import 'package:aptapp/patient/training_videos_page.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/exercise_time_data.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/location_picker.dart';
import 'package:aptapp/sensors/sensor_repository.dart';
import 'package:aptapp/widget/video_player_preview.dart';
import 'package:kiwi/kiwi.dart' hide Factory;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jiffy/jiffy.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:screenshot/screenshot.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:math' as math;

import '../activity/bloc/activity_bloc.dart';

class ActivityDialog extends StatefulWidget {
  final PatientGetDTO patient;
  final ActivityOverviewDTO activity;
  final ActiveMinutesOverviewDTO activeMinutes;
  final bool rateActivity;
  final InstitutionDTO institution;
  final Function(String, ActivityType) deleteActivity;
  final VoidCallback? onSaved;

  const ActivityDialog(
      {Key? key,
      required this.patient,
      required this.activity,
      required this.activeMinutes,
      required this.rateActivity,
      required this.deleteActivity,
      required this.institution,
      this.onSaved})
      : super(key: key);

  static Future<void> showUndoRatingDialog(
    BuildContext context,
    PatientGetDTO patient,
    ActivityOverviewDTO activity,
    ActiveMinutesOverviewDTO activeMinutes,
    bool rateActivity,
    InstitutionDTO institution,
    Function(String, ActivityType) deleteActivity,
  ) {
    final AlertDialog alert = AlertDialog(
      content: SelectableText(context.i18n.undoRatingText),
      actions: [
        if (activity.type == ActivityType.EXTRA)
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith(
                    (states) => primaryColor,
                  ),
                ),
                child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.editActivity)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ActivityDialog(
                          patient: patient,
                          activity: activity,
                          activeMinutes: activeMinutes,
                          rateActivity: rateActivity,
                          deleteActivity: deleteActivity,
                          institution: institution,
                        );
                      });
                }),
          ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => primaryColor,
              ),
            ),
            child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.undoExecution)),
            onPressed: () {
              final activityBloc = BlocProvider.of<ActivityBloc>(context);
              var rating = ActivityPatientRatingPostDTO()..done = false;
              activityBloc.add(UpdateActivityRatingEvent(
                  activityType: activity.type!, rating: rating, id: activity.activityId!, date: activity.date!, patientId: patient.id!));
              Navigator.of(context, rootNavigator: true).pop();
            }),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => errorColor,
            ),
          ),
          child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.cancel)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> showActiveMinutesAchieved(
      BuildContext context, double percentage, int activeMinutes, int durationMinutes, double height, bool isKlimafit) async {
    double containerHeight = height * 0.35;
    final ScreenshotController screenshotController = ScreenshotController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 0, left: 5, right: 5),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    key: Key(KEY_BUTTON_CLOSE),
                    child: Icon(
                      Icons.close,
                      size: 24,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              FittedBox(
                child: SelectableText(
                  context.i18n.achievedActivityShort,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              FittedBox(
                child: SelectableText(
                  isKlimafit
                      ? context.i18n.activeMinutesPerWeekAmountKlimafit(activeMinutes)
                      : context.i18n.activeMinutesPerWeekAmount(activeMinutes),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                ),
              ),
            ],
          ),
          content: Container(
            height: containerHeight,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: containerHeight * (kIsWeb ? 0.9 : 0.8),
                  width: containerHeight * (kIsWeb ? 0.9 : 0.8),
                  child: Screenshot(
                    controller: screenshotController,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: PercentIndicator(
                        percentage: percentage,
                        durationMinutesActive: activeMinutes,
                        durationMinutes: durationMinutes,
                        cardContainerHeight: 360,
                        isKlimafit: isKlimafit,
                      ),
                    ),
                  ),
                ),
                if (!kIsWeb)
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ShareButton(screenshotController: screenshotController, shareContext: "Active Minutes"),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  _ActivityDialogState createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  final _activityFormKey = GlobalKey<FormState>();
  ActivityBloc? activityBloc;
  bool rateActivity = false;
  double ratingValue = 0;
  final heartrateController = TextEditingController();
  final durationController = TextEditingController();
  final notesController = TextEditingController();
  final nameController = TextEditingController();
  List<bool> workoutShowHints = [];
  DateTime? rateTime;
  Map<String, String> youtubeIdMapping = {};
  final moveDateController = MaskedTextController(mask: "00.00.0000");
  DateTime? moveDate;
  DateTime? allowedFirstMoveDate;
  DateTime? allowedLastMoveDate;
  // by default the dialog is for setting activity to done
  bool isDone = true;
  String extraActivityName = "";
  String time = "";
  String endTime = "";
  FocusNode dropDownFocusNode = FocusNode();

  List<YoutubePlayerController> playerControllers = [];
  final FileControllerApi fileControllerApi = FileControllerApi(apiClient);
  List<String> videoSources = [];

  LocationDTO? location;
  String locationAddress = "";
  LocationDTO? endLocation;
  String endLocationAddress = "";
  String startLocationErrorText = "";

  PredefinedActivityType? predefinedActivityType;

  List<ActivityData> _healthKitActivities = [];

  // so we can also enable time entry when institution focus changed over time
  get isKlimafitEntry =>
      ((widget.activity.type == ActivityType.APPOINTMENT) && widget.institution.institutionFocus?.isKlimafit() == true) ||
      widget.activity.type == ActivityType.PREDEFINED_ACTIVITY ||
      widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY;

  get isEdit => widget.activity.activityId?.isNotEmpty ?? false;

  // patient can only edit activity planned by himself or when entering --> isEdit = true
  get canEditWholeActivity => (userRepository.userRole != UserRole.PATIENT ||
      (widget.activity.plannedBy ?? "") == (userRepository.user!.patient!.id ?? "") ||
      (widget.activity.activityId ?? "").isEmpty);

  @override
  void initState() {
    super.initState();

    isDone = true;
    rateTime = DateTime.now();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    rateActivity = widget.rateActivity;
    moveDate = englishDateFormat.parse(widget.activity.date!);
    moveDateController.text = germanDateFormat.format(moveDate!);
    if (widget.activity.type == ActivityType.EXTRA) {
      allowedFirstMoveDate = DateTime(2015, 8);
      allowedLastMoveDate = DateTime(2100);
    } else {
      allowedFirstMoveDate = Jiffy.parseFromDateTime(moveDate!).startOf(Unit.week).dateTime;
      allowedLastMoveDate = Jiffy.parseFromDateTime(moveDate!).endOf(Unit.week).dateTime;
    }
    if (widget.activity.rating != null) {
      if ((widget.activity.rating?.heartrate ?? 0) > 0) {
        heartrateController.text = widget.activity.rating!.heartrate!.toString();
      }
      if (widget.activity.rating?.durationMinutes != null && (widget.activity.rating?.done ?? false)) {
        durationController.text = widget.activity.rating!.durationMinutes!.toString();
      } else if (widget.activity.durationMinutes != null) {
        durationController.text = widget.activity.durationMinutes.toString();
      }
      notesController.text = widget.activity.rating!.note ?? "";

      if ((widget.activity.type == ActivityType.EXTRA ||
              ((widget.activity.type == ActivityType.PREDEFINED_ACTIVITY || widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) &&
                  (widget.activity.activityId ?? "").isEmpty)) &&
          !(widget.activity.rating?.done ?? false)) {
        isDone = false;
      }
      ratingValue = widget.activity.rating!.rating != null ? widget.activity.rating!.rating!.toDouble() : 0;
    }
    if (widget.activity.type == ActivityType.WORKOUT) {
      workoutShowHints = widget.activity.activity!.workout!.exercises.map((e) => false).toList();
    }
    time = widget.activity.time ?? "";
    endTime = widget.activity.endTime ?? "";
    if (widget.activity.type == ActivityType.APPOINTMENT) {
      location = widget.activity.activity?.appointment?.locationCoordinates ?? null;
      locationAddress = widget.activity.activity?.appointment?.locationAddress ?? "";
    } else if (widget.activity.type == ActivityType.PREDEFINED_ACTIVITY || widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
      predefinedActivityType = widget.activity.activity?.predefinedActivity?.predefinedActivityType;
      location = widget.activity.rating?.startLocation ?? widget.activity.activity?.predefinedActivity?.startLocation ?? null;
      locationAddress = widget.activity.rating?.startLocationAddress ?? "";
      // always show rate dialog, as there is no useful information in adjust dialog
      rateActivity = true;
      if (locationAddress.isEmpty) {
        locationAddress = widget.activity.activity?.predefinedActivity?.startLocationAddress ?? "";
      }
      endLocation = widget.activity.rating?.endLocation ?? widget.activity.activity?.predefinedActivity?.endLocation ?? null;
      endLocationAddress = widget.activity.rating?.endLocationAddress ?? "";
      if (endLocationAddress.isEmpty) {
        endLocationAddress = widget.activity.activity?.predefinedActivity?.endLocationAddress ?? "";
      }
    }
    Future.delayed(Duration.zero, () {
      initYouTubePlayerControllers();
      if (widget.activity.type == ActivityType.EXTRA ||
          widget.activity.type == ActivityType.APPOINTMENT ||
          widget.activity.type == ActivityType.PREDEFINED_ACTIVITY ||
          widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
        nameController.text = getTranslatedText(widget.activity.name, context);
      }
      loadVideoSources();
      _fetchHealthKitActivities();
    });

    // can be entered by patient, so deliver autocomplete suggestions
    if ([ActivityType.EXTRA, ActivityType.APPOINTMENT, ActivityType.PREDEFINED_ACTIVITY, ActivityType.PREDEFINED_ACTIVE_MOBILITY]
        .contains(widget.activity.type)) {
      // autocomplete for new
      activityBloc!.add(FetchAutocompleteEvent(type: widget.activity.type!));
    }
  }

  List<String> getFileKeysForStrengtheningAndHypertrophy(StrengtheningExercisePostDTO exercise) {
    final String videoFileKey = exercise.videoFileKey ?? "";
    if (videoFileKey.isEmpty) {
      return [];
    }
    List<String> fileKeys = [];
    final repeats = math.max(exercise.exerciseRepeatCount ?? 0, 1);
    final sets = math.max(exercise.exerciseRepeatSets ?? 0, 1);
    final breakBetweenSets = exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0;
    for (int currentSet = 0; currentSet < sets; currentSet++) {
      for (int currentRepeat = 0; currentRepeat < repeats; currentRepeat++) {
        fileKeys.add(videoFileKey);
      }
      if (breakBetweenSets > 0 && currentSet < sets - 1) {
        fileKeys.add("pause:$breakBetweenSets");
      }
    }
    return fileKeys;
  }

  loadVideoSources() {
    final List<String> fileKeys = [];
    if (widget.activity.activity?.videoFileKey?.isNotEmpty ?? false) {
      if (widget.activity.type != ActivityType.STRENGTHENING && widget.activity.type != ActivityType.HYPERTROPHY) {
        fileKeys.add(widget.activity.activity!.videoFileKey!);
      } else {
        fileKeys.addAll(getFileKeysForStrengtheningAndHypertrophy(widget.activity.activity!.strengtheningExercise!));
      }
    }
    if (widget.activity.type == ActivityType.WORKOUT) {
      final videoWaitBetweenExercisesSeconds = widget.activity.activity!.workout!.videoWaitBetweenExercisesSeconds ?? 0;
      widget.activity.activity!.workout!.exercises.forEach((exercise) {
        if (videoWaitBetweenExercisesSeconds > 0) {
          fileKeys.add("pause:$videoWaitBetweenExercisesSeconds:${context.i18n.nextExercise(getTranslatedText(exercise.name, context))}");
        }
        fileKeys.addAll(getFileKeysForStrengtheningAndHypertrophy(exercise));
      });
    }

    // Separate pause entries from actual file keys
    final Set<String> uniqueFileKeys = {};
    for (int i = 0; i < fileKeys.length; i++) {
      final key = fileKeys[i];
      if (!key.toLowerCase().startsWith('pause:')) {
        uniqueFileKeys.add(key);
      }
    }

    // Fetch only unique actual file keys (pause entries don't need fetching)
    Future.wait(uniqueFileKeys
            .map((fileKey) => fileControllerApi.getFile(fileKey).catchError((err) {
                  print("Error loading file $fileKey: $err");
                  return null; // Return null for failed requests
                }))
            .toList())
        .then((files) {
      // Create a mapping from file key to URL
      final Map<String, String?> keyToUrlMap = {};
      final List<String> fetchedKeys = uniqueFileKeys.toList();

      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final fileKey = fetchedKeys[i];
        if (file != null && (file.exists ?? false)) {
          keyToUrlMap[fileKey] = file.url;
        } else {
          // Mark as unable to resolve
          keyToUrlMap[fileKey] = null;
        }
      }

      // Reconstruct the video sources list in original order, including pause entries
      final List<String> resolvedSources = [];
      for (final key in fileKeys) {
        if (key.toLowerCase().startsWith('pause:')) {
          // Keep pause entries as-is
          resolvedSources.add(key);
        } else if (keyToUrlMap.containsKey(key)) {
          final url = keyToUrlMap[key];
          if (url != null) {
            // Add the resolved URL
            resolvedSources.add(url);
          } else {
            // File failed to load or doesn't exist - skip with warning
            print("Warning: Video file key '$key' could not be resolved (failed to load or doesn't exist)");
          }
        } else {
          // This shouldn't happen, but add the key as fallback
          print("Warning: Video file key '$key' not in fetch results");
          resolvedSources.add(key);
        }
      }

      setState(() {
        videoSources = resolvedSources;
      });
    }).catchError((err) {
      print("Error loading video sources: $err");
    });
  }

  @override
  void dispose() {
    playerControllers.forEach((element) {
      element.close();
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Future<void> _fetchHealthKitActivities() async {
    if (kIsWeb) return;
    final sensorRepository = KiwiContainer().resolve<SensorRepository>();
    if (!await sensorRepository.isAuthorizedToFetchData()) return;
    if (!mounted) return;
    final activityDate = DateTime.tryParse(widget.activity.date ?? '') ?? DateTime.now();
    final activityName = getTranslatedText(widget.activity.name, context);
    final activities = await sensorRepository.fetchActivityDataList(activityDate, activityName, context);
    if (!mounted) return;
    setState(() {
      _healthKitActivities = activities;
    });
  }

  Widget _buildHealthKitSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.i18n.workouts,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: lightTextColor),
          ),
          SizedBox(height: 8),
          ..._healthKitActivities.map((data) => Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: InkWell(
              onTap: () {
                setState(() {
                  durationController.text = data.duration.toString();
                  if (data.value > 0) heartrateController.text = data.value.toString();
                  time = data.timeFrom;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: data.isRelatedWorkout ? primaryColor : datatableBorderColor,
                    width: data.isRelatedWorkout ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.activityType, style: Theme.of(context).textTheme.bodyMedium),
                        Text(
                          '${data.timeFrom} · ${data.duration} ${context.i18n.durationValueMinutes}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: lightTextColor),
                        ),
                      ],
                    ),
                    if (data.value > 0)
                      Text('${data.value} bpm',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: lightTextColor)),
                  ],
                ),
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget getActivityInfoLine(String title, String value) {
    return Row(
      children: [
        Flexible(
            child: StyledText(
          text: '<b>$title:</b> $value',
          tags: {
            'b': StyledTextTag(
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          },
        )),
      ],
    );
  }

  Widget getActivityInfoLineWithWidget(String title, Widget widget) {
    return Row(
      children: [
        Flexible(
            child: StyledText(
          text: '<b>$title:</b> <widget/>',
          tags: {
            'b': StyledTextTag(
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            'widget': StyledTextWidgetTag(widget, alignment: PlaceholderAlignment.baseline)
          },
        ))
      ],
    );
  }

  initYouTubePlayerControllers() {
    if (widget.activity.type == ActivityType.WORKOUT) {
      String youTubeId = getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.workout!.youTubeUrl, context), map: youtubeIdMapping);
      setState(() {
        playerControllers = [];
        if (youTubeId.isNotEmpty) {
          playerControllers.add(YoutubePlayerController.fromVideoId(
              videoId: youTubeId,
              // initialVideoId: youTubeId,
              params: YoutubePlayerParams(
                // autoPlay: false,
                // desktopMode: true,
                showFullscreenButton: true,
                loop: true,
                origin: 'https://www.youtube-nocookie.com',
                // playlist: [youTubeId],
              )));
        }
        playerControllers.addAll(widget.activity.activity!.workout!.exercises
            .where((element) => getYoutubeVideoIdByURL(getTranslatedText(element.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty)
            .map((e) {
          String exerciseYouTubeId = getYoutubeVideoIdByURL(getTranslatedText(e.youTubeUrl, context), map: youtubeIdMapping);
          return YoutubePlayerController.fromVideoId(
              videoId: exerciseYouTubeId,
              // initialVideoId: exerciseYouTubeId,
              params: YoutubePlayerParams(
                // autoPlay: false,
                // desktopMode: true,
                showFullscreenButton: true,
                loop: true,
                origin: 'https://www.youtube-nocookie.com',
                // playlist: [exerciseYouTubeId],
              ));
        }).toList());
      });
    } else {
      String youTubeId = "";
      switch (widget.activity.type) {
        case ActivityType.ENDURANCE:
          youTubeId =
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.enduranceExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.HYPERTROPHY:
        case ActivityType.STRENGTHENING:
          youTubeId =
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.strengtheningExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.INTERVAL:
          youTubeId =
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.intervalExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.OTHER:
          youTubeId = getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.otherExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.TASK:
          youTubeId = getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.task!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        default:
          youTubeId = "";
          break;
      }
      if (youTubeId.isNotEmpty) {
        setState(() {
          playerControllers = [
            YoutubePlayerController.fromVideoId(
                videoId: youTubeId,
                // initialVideoId: youTubeId,
                params: YoutubePlayerParams(
                  // autoPlay: false,
                  // desktopMode: true,
                  showFullscreenButton: true,
                  loop: true,
                  origin: 'https://www.youtube-nocookie.com',
                  // playlist: [youTubeId],
                ))
          ];
        });
      }
    }
  }

  getActivityHint() {
    String hint = "";
    switch (widget.activity.type) {
      case ActivityType.ENDURANCE:
        hint = getTranslatedText(widget.activity.activity!.enduranceExercise!.hint, context);
        break;
      case ActivityType.HYPERTROPHY:
      case ActivityType.STRENGTHENING:
        hint = getTranslatedText(widget.activity.activity!.strengtheningExercise!.hint, context);
        break;
      case ActivityType.INTERVAL:
        hint = getTranslatedText(widget.activity.activity!.intervalExercise!.hint, context);
        break;
      case ActivityType.WORKOUT:
        hint = getTranslatedText(widget.activity.activity!.workout!.notes, context);
        break;
      case ActivityType.OTHER:
        hint = getTranslatedText(widget.activity.activity!.otherExercise!.hint, context);
        break;
      case ActivityType.TASK:
        hint = getTranslatedText(widget.activity.activity!.task!.hint, context);
        break;
      default:
        hint = "";
        break;
    }
    if (hint.isEmpty) {
      return [];
    } else {
      return [
        getActivityInfoLineWithWidget(
          widget.activity.type != ActivityType.TASK ? context.i18n.notes : context.i18n.taskNotes,
          SelectableLinkify(
            text: hint,
            onOpen: (link) async {
              if (await canLaunchUrlString(link.url)) {
                String cleanedUrl = link.url;
                if (cleanedUrl.endsWith("!")) {
                  cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                }
                launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ),
      ];
    }
  }

  getActivityVideo() {
    if (videoSources.isEmpty) {
      return [];
    }
    return [VideoPlayerPreview(sources: videoSources)];
  }

  setActivityToDone(double? value, int? pesiValue, bool hasInitialValue) {
    if (!validateForm()) {
      return;
    }

    // when activity not set generally create it
    if (!isEdit) {
      updateActivity();
      return;
    }

    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
          category: EVENT_CATEGORY_ACTIVITY,
          name: EVENT_NAME_RATE_ACTIVITY_TIME,
          action: "Rated Activity",
          value: DateTime.now().difference(rateTime!).inSeconds),
    );

    var rating = ActivityPatientRatingPostDTO()
      ..done = true
      ..rating = value != null ? value.truncate() : null
      ..pesiRating = pesiValue
      ..durationMinutes = int.tryParse(durationController.text)
      ..heartrate = int.tryParse(heartrateController.text)
      ..note = notesController.text
      ..date = englishDateFormat.format(moveDate!)
      ..time = time
      ..endTime = endTime
      ..startLocation = location
      ..startLocationAddress = locationAddress
      ..endLocation = endLocation
      ..endLocationAddress = endLocationAddress;

    widget.activity.rating!.done = rating.done;
    widget.activity.rating!.rating = rating.rating;
    widget.activity.rating!.pesiRating = rating.pesiRating;
    activityBloc!.add(UpdateActivityRatingEvent(
        activityType: widget.activity.type!,
        rating: rating,
        id: widget.activity.activityId!,
        date: widget.activity.date!,
        patientId: widget.patient.id!,
        extraActivityName: nameController.text));
    Navigator.pop(context);

    if (!hasInitialValue) {
      checkIfActiveMinutesAchieved(MediaQuery.of(context).size.height);
    }
  }

  bool validateForm() {
    final bool startLocationInvalid =
        (widget.activity.type == ActivityType.PREDEFINED_ACTIVITY || widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) &&
            location == null;
    final bool isValid = _activityFormKey.currentState!.validate();
    setState(() {
      if (startLocationInvalid) {
        startLocationErrorText = context.i18n.validationNotEmpty;
      } else {
        startLocationErrorText = "";
      }
    });
    return !startLocationInvalid && isValid;
  }

  updateActivity() {
    if (!validateForm()) {
      return;
    }

    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
          category: EVENT_CATEGORY_ACTIVITY,
          name: EVENT_NAME_UPDATE,
          action: "Updated Activity",
          value: DateTime.now().difference(rateTime!).inSeconds),
    );

    if (!isEdit && widget.activity.type == ActivityType.EXTRA) {
      var extraActivity = ExtraActivityPostDTO(
        date: englishDateFormat.format(moveDate!),
        time: time,
        endTime: endTime,
        done: isDone,
        durationMinutes: int.tryParse(durationController.text) ?? 0,
        heartrate: int.tryParse(heartrateController.text) ?? 0,
        name: nameController.text,
        note: notesController.text,
        rating: isDone ? widget.activity.rating?.rating : null,
      );
      activityBloc!.add(AddExtraActivityEvent(
        activity: extraActivity,
        patientId: widget.patient.id!,
      ));
      widget.onSaved?.call();
      Navigator.pop(context);
      checkIfActiveMinutesAchieved(MediaQuery.of(context).size.height);
      return;
    }

    if (widget.activity.type == ActivityType.APPOINTMENT) {
      var activity = ActivityPostDTO(
          name: getTranslationObjectFromText(nameController.text, nameController.text),
          startDate: englishDateFormat.format(moveDate!),
          time: time,
          endTime: endTime,
          days: [getDayOfWeekfromDateTime(moveDate!)],
          repeatCount: 1,
          repeats: ActivityRepeat.NEVER,
          appointment: AppointmentPostDTO(
            name: nameController.text,
            useLocationCoordinates: true,
            locationCoordinates: location,
            locationAddress: locationAddress,
            details: notesController.text,
          ));
      if (isEdit) {
        activityBloc!.add(
            UpdateActivityEvent(activity: activity, id: widget.activity.activityId!, patientId: widget.patient.id!, type: ActivityType.APPOINTMENT));
      } else {
        activityBloc!.add(AddActivityEvent(activity: activity, patientId: widget.patient.id!, type: ActivityType.APPOINTMENT));
      }
      Navigator.pop(context);
      return;
    }

    if ((!isEdit || canEditWholeActivity) &&
        (widget.activity.type == ActivityType.PREDEFINED_ACTIVITY || widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY)) {
      var activity = ActivityPostDTO(
          name: getTranslationObjectFromText(nameController.text, nameController.text),
          startDate: englishDateFormat.format(moveDate!),
          time: time,
          endTime: endTime,
          days: [getDayOfWeekfromDateTime(moveDate!)],
          repeatCount: 1,
          repeats: ActivityRepeat.NEVER,
          predefinedActivity: PredefinedActivityPostDTO(
            activityType: widget.activity.type,
            name: nameController.text,
            predefinedActivityType: predefinedActivityType,
            startLocation: location,
            startLocationAddress: locationAddress,
            endLocation: endLocation,
            endLocationAddress: endLocationAddress,
            durationMinutes: int.tryParse(durationController.text) ?? 0,
          ));
      if (isEdit) {
        activityBloc!.add(
            UpdateActivityEvent(activity: activity, id: widget.activity.activityId!, patientId: widget.patient.id!, type: widget.activity.type!));
      } else {
        activityBloc!.add(AddActivityEvent(activity: activity, patientId: widget.patient.id!, type: widget.activity.type!));
      }
      Navigator.pop(context);
      return;
    }

    var rating = ActivityPatientRatingPostDTO()
      ..done = false
      ..rating = widget.activity.rating?.rating
      ..durationMinutes = int.tryParse(durationController.text)
      ..heartrate = int.tryParse(heartrateController.text)
      ..note = notesController.text
      ..date = englishDateFormat.format(moveDate!)
      ..time = time
      ..endTime = endTime
      ..startLocation = location
      ..startLocationAddress = locationAddress
      ..endLocation = endLocation
      ..endLocationAddress = endLocationAddress;

    widget.activity.rating!.done = rating.done;
    widget.activity.rating!.rating = rating.rating;
    activityBloc!.add(UpdateActivityRatingEvent(
        activityType: widget.activity.type!,
        rating: rating,
        id: widget.activity.activityId!,
        date: widget.activity.date!,
        patientId: widget.patient.id!,
        extraActivityName: nameController.text));
    Navigator.pop(context);
  }

  checkIfActiveMinutesAchieved(double height) {
    var date = DateTime.parse(widget.activity.date!).weekOfYear;
    bool isCurrentWeek = date == DateTime.now().toLocal().weekOfYear;
    bool isDone = widget.activity.rating!.done ?? false;

    // already done
    if (widget.activeMinutes.durationMinutesActive! >= widget.activeMinutes.durationMinutes!) {
      return;
    }
    var duration = int.tryParse(durationController.text) ?? 0;
    //only check if activity is in current week
    if (isDone && isCurrentWeek) {
      bool goalAchieved = (widget.activeMinutes.durationMinutesActive! + duration) >= widget.activeMinutes.durationMinutes!;
      double percentage = widget.activeMinutes.durationMinutesActive! + duration / widget.activeMinutes.durationMinutes!;
      if (goalAchieved)
        ActivityDialog.showActiveMinutesAchieved(
          context,
          percentage,
          widget.activeMinutes.durationMinutesActive! + duration,
          widget.activeMinutes.durationMinutes!,
          height,
          widget.institution.institutionFocus?.isKlimafit() == true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      return Scaffold(
        appBar: AppBar(
          elevation: 20,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!rateActivity && widget.activity.rating!.done!) getActivityRatingInfo(context),
                  ...getActivityInfos(widget.activity, context),
                  if (rateActivity) getActivityForm(context, size)
                ],
              )),
        ),
      );
    });
  }

  getActivityRatingInfo(BuildContext context) {
    Color backgroundColor = widget.activity.type!.backgroundColor;
    return Padding(
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: datatableBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    heightFactor: 0.7,
                    widthFactor: 0.7,
                    child: Icon(Icons.check, color: Colors.white, size: 24),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  context.i18n.executed,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            if (widget.activity.rating!.rating != null)
              Padding(
                padding: EdgeInsets.only(top: 22),
                child: SelectableText("(${widget.activity.rating!.rating}) ${getRatingText(context, widget.activity.rating!.rating!)}"),
              ),
            if (isKlimafitEntry && widget.activity.rating!.pesiRating != null)
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: SelectableText(
                    "(${widget.activity.rating!.pesiRating}) ${getPesiValueText(context, widget.activity.rating!.pesiRating!).toLowerCase()}"),
              ),
            SizedBox(height: 22),
            if ((widget.activity.rating!.heartrate ?? 0) > 0)
              getActivityInfoLine(context.i18n.trainingHeartFrequency, widget.activity.rating!.heartrate!.toString() + " bpm"),
            if (widget.activity.type != ActivityType.PREDEFINED_ACTIVE_MOBILITY && widget.activity.type != ActivityType.PREDEFINED_ACTIVITY)
              Padding(
                padding: EdgeInsetsGeometry.only(bottom: 22),
                child: getActivityInfoLineWithWidget(
                  context.i18n.notes,
                  SelectableLinkify(
                    text: (widget.activity.rating!.note ?? "").isNotEmpty ? widget.activity.rating!.note! : "-",
                    onOpen: (link) async {
                      if (await canLaunchUrlString(link.url)) {
                        String cleanedUrl = link.url;
                        if (cleanedUrl.endsWith("!")) {
                          cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                        }
                        launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                ),
              ),
            if ((widget.activity.plannedBy ?? "") != SYSTEM_CREATED)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    rateActivity = true;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(context.i18n.adjust.toUpperCase())],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectMoveDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: moveDate, firstDate: allowedFirstMoveDate!, lastDate: allowedLastMoveDate!);
    if (picked != null && picked != moveDate)
      setState(() {
        moveDate = picked;
        moveDateController.text = germanDateFormat.format(moveDate!);
      });
  }

  getActivityForm(BuildContext context, SizingInformation size) {
    // can change name of activity as it is planned by user
    final bool canEdit = widget.activity.type == ActivityType.EXTRA ||
        ((widget.activity.type == ActivityType.APPOINTMENT ||
                widget.activity.type == ActivityType.PREDEFINED_ACTIVITY ||
                widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) &&
            canEditWholeActivity);
    String dateLabel = isDone ? context.i18n.performedOn : context.i18n.plannedOn;
    if (widget.activity.type == ActivityType.APPOINTMENT ||
        widget.activity.type == ActivityType.PREDEFINED_ACTIVITY ||
        widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
      dateLabel = context.i18n.date;
    }
    bool canEditPredefinedActivity =
        canEdit && (widget.activity.type == ActivityType.PREDEFINED_ACTIVITY || widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY);
    return Form(
      key: _activityFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_healthKitActivities.isNotEmpty &&
              widget.activity.type != ActivityType.TASK &&
              widget.activity.type != ActivityType.APPOINTMENT &&
              widget.activity.type != ActivityType.PREDEFINED_ACTIVITY &&
              widget.activity.type != ActivityType.PREDEFINED_ACTIVE_MOBILITY)
            _buildHealthKitSection(context),
          if (canEditPredefinedActivity)
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: DropdownButtonFormField<PredefinedActivityType>(
                initialValue: predefinedActivityType,
                onChanged: (value) {
                  setState(() {
                    predefinedActivityType = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return context.i18n.validationNotEmpty;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.activity.type!.getTranslatedText(context),
                  labelText: widget.activity.type!.getTranslatedText(context) + " *",
                  border: OutlineInputBorder(),
                ),
                items: widget.activity.type!.getPredefinedActivityTypes(context),
              ),
            ),
          if (canEdit &&
              ((widget.activity.type != ActivityType.PREDEFINED_ACTIVITY && widget.activity.type != ActivityType.PREDEFINED_ACTIVE_MOBILITY) ||
                  predefinedActivityType == PredefinedActivityType.OTHER))
            BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                if (state is AutocompleteState) {
                  return FormFieldPadding(
                    child: TypeAheadField<String>(
                      controller: nameController,
                      focusNode: dropDownFocusNode,
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSelected: (suggestion) {
                        dropDownFocusNode.unfocus();
                        nameController.text = suggestion;
                      },
                      suggestionsCallback: (pattern) {
                        final toReturn =
                            state.autocomplete.suggestions.where((element) => element.toLowerCase().contains(pattern.toLowerCase())).toList();
                        return toReturn.isEmpty ? null : toReturn;
                      },
                      builder: (context, controller, focusNode) {
                        return TextFormField(
                          controller: nameController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: context.i18n.name,
                            labelText: context.i18n.name + " *",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return context.i18n.validationNotEmpty;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          if (canEdit || (widget.institution.allowRescheduleActivities ?? false))
            FormFieldPadding(
              child: TextFormField(
                controller: moveDateController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if ((value ?? "").replaceAll(".", "").length < 8) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    DateTime? date = DateTime.tryParse(germanDateFormat.parse(value!).toString());
                    if (date == null) {
                      return context.i18n.validationInvalidValue;
                    } else if (date.isBefore(allowedFirstMoveDate!) || date.isAfter(allowedLastMoveDate!)) {
                      return context.i18n.validationMoveDateWithinAWeek;
                    }
                  }
                  return null;
                },
                onChanged: (val) {
                  String valueWithoutDots = val.replaceAll(".", "");
                  if (valueWithoutDots.length == 8) {
                    moveDate = DateTime.utc(int.parse(valueWithoutDots.substring(4)), int.parse(valueWithoutDots.substring(2, 4)),
                        int.parse(valueWithoutDots.substring(0, 2)));
                  }
                },
                decoration: InputDecoration(
                  hintText: dateLabel,
                  labelText: dateLabel,
                  border: OutlineInputBorder(),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.date_range),
                    color: lightTextColor,
                    onPressed: () => _selectMoveDate(context),
                  ),
                ),
              ),
            ),
          if (widget.activity.type != ActivityType.TASK &&
              widget.activity.type != ActivityType.APPOINTMENT &&
              widget.activity.type != ActivityType.PREDEFINED_ACTIVE_MOBILITY &&
              widget.activity.type != ActivityType.PREDEFINED_ACTIVITY)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: heartrateController,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: context.i18n.trainingHeartFrequencyBpm,
                  labelText: context.i18n.trainingHeartFrequencyBpm,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.activity.type != ActivityType.TASK && !isKlimafitEntry)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: durationController,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return context.i18n.validationNotEmpty;
                  }
                  if (int.parse(value!) < 1) {
                    return context.i18n.validationInvalidValue;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: context.i18n.actualTotalDurationMin,
                  labelText: context.i18n.actualTotalDurationMin,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ),
          if (isKlimafitEntry) ...[
            SizedBox(height: 16),
            TimePickerRow(
              initialTime: time,
              requiredField: true,
              labelText: context.i18n.startTime,
              selectTime: (selectedTime) {
                time = selectedTime;
                if (endTime.isNotEmpty) {
                  setState(() {
                    durationController.text =
                        ExerciseTypeTimeData.calculateMinutesBetween(startTime: time, endTime: endTime, rating: ratingValue).toString();
                  });
                }
              },
            ),
            SizedBox(height: 16),
            TimePickerRow(
              initialTime: endTime,
              requiredField: widget.activity.type != ActivityType.APPOINTMENT,
              labelText: context.i18n.endTime,
              selectTime: (selectedTime) {
                endTime = selectedTime;
                if (time.isNotEmpty) {
                  setState(() {
                    durationController.text =
                        ExerciseTypeTimeData.calculateMinutesBetween(startTime: time, endTime: endTime, rating: ratingValue).toString();
                  });
                }
              },
            ),
            if (durationController.text.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: 2.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: lightTextColor,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    FittedBox(
                      child: SelectableText(
                        getFormattedDurationLine(
                            int.parse(durationController.text), widget.institution.institutionFocus?.isKlimafit() == true, context),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: lightTextColor,
                              letterSpacing: 1.1,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
          if (isKlimafitEntry)
            FormFieldPadding(
              child: LocationPicker(
                labelText: widget.activity.type == ActivityType.APPOINTMENT ? context.i18n.location : context.i18n.startLocation + " *",
                onLocationChanged: (location, address) {
                  setState(() {
                    this.location = location;
                    locationAddress = address;
                    if (this.location != null) {
                      startLocationErrorText = "";
                    }
                  });
                },
                errorText: startLocationErrorText,
                initialLocation: location,
                initialLocationAddress: locationAddress,
                homeLocation: widget.patient.homeLocation,
                homeLocationAddress: widget.patient.homeLocationAddress,
                workLocation: widget.patient.workLocation,
                workLocationAddress: widget.patient.workLocationAddress,
              ),
            ),
          if (isKlimafitEntry && widget.activity.type != ActivityType.APPOINTMENT)
            FormFieldPadding(
              child: LocationPicker(
                labelText: context.i18n.endLocation,
                onLocationChanged: (location, address) {
                  setState(() {
                    endLocation = location;
                    endLocationAddress = address;
                  });
                },
                initialLocation: endLocation,
                initialLocationAddress: endLocationAddress,
                homeLocation: widget.patient.homeLocation,
                homeLocationAddress: widget.patient.homeLocationAddress,
                workLocation: widget.patient.workLocation,
                workLocationAddress: widget.patient.workLocationAddress,
              ),
            ),
          if (widget.activity.type != ActivityType.PREDEFINED_ACTIVITY && widget.activity.type != ActivityType.PREDEFINED_ACTIVE_MOBILITY)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: widget.activity.type == ActivityType.APPOINTMENT ? context.i18n.details : context.i18n.note,
                  labelText: widget.activity.type == ActivityType.APPOINTMENT ? context.i18n.details : context.i18n.note,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.activity.type == ActivityType.EXTRA ||
              widget.activity.type == ActivityType.PREDEFINED_ACTIVITY ||
              widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: isDone,
                onChanged: (value) {
                  setState(() {
                    isDone = value ?? false;
                  });
                },
                title: Text(
                  context.i18n.executed,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: lightTextColor,
                      ),
                ),
              ),
            ),
          if (widget.activity.type != ActivityType.TASK && widget.activity.type != ActivityType.APPOINTMENT && isDone)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: DoneSlider(
                activity: widget.activity,
                patientId: widget.patient.id!,
                activeMinutes: widget.activeMinutes,
                rateActivity: setActivityToDone,
                size: size,
                isKlimafit: isKlimafitEntry,
                onValueChanged: (value) => setState(() {
                  ratingValue = value;
                  if (time.isNotEmpty && endTime.isNotEmpty) {
                    durationController.text =
                        ExerciseTypeTimeData.calculateMinutesBetween(startTime: time, endTime: endTime, rating: ratingValue).toString();
                  }
                }),
              ),
            ),
          if ((widget.activity.type != ActivityType.TASK && !isDone) || widget.activity.type == ActivityType.APPOINTMENT)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  updateActivity();
                },
                style: getElevatedButtonStyle(context),
                child: Row(
                  mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(isEdit ? context.i18n.update.toUpperCase() : context.i18n.create.toUpperCase())],
                ),
              ),
            ),
          if (widget.activity.type == ActivityType.TASK)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  setActivityToDone(null, null, true);
                },
                style: getElevatedButtonStyle(context),
                child: Row(
                  mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(context.i18n.executeTask.toUpperCase())],
                ),
              ),
            ),
          if ((widget.activity.type == ActivityType.EXTRA ||
                  widget.activity.type == ActivityType.APPOINTMENT ||
                  widget.activity.type == ActivityType.PREDEFINED_ACTIVITY ||
                  widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) &&
              canEditWholeActivity &&
              (widget.activity.activityId ?? "").isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                child: Row(
                  mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((widget.activity.type == ActivityType.EXTRA ? context.i18n.deleteActivity : context.i18n.delete).toUpperCase()),
                  ],
                ),
                onPressed: () => DeleteButton.showDeleteConfirmationDialog(
                  context,
                  widget.activity.type == ActivityType.EXTRA ? context.i18n.deleteActivity : context.i18n.delete,
                  widget.activity.type == ActivityType.EXTRA
                      ? context.i18n.deleteMessageActivity(getTranslatedText(widget.activity.name, context))
                      : context.i18n.deleteMessageThisAppointment,
                  () {
                    widget.deleteActivity(widget.activity.activityId!, widget.activity.type!);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  getActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final String timeString = getTranslatedTimeString(activity.time ?? "", activity.endTime ?? "", context);

    String typeLine = activity.type!.getTranslatedText(context);
    if (timeString.isNotEmpty) {
      typeLine += ", $timeString";
    }
    if ((activity.durationMinutes ?? 0) > 0) {
      typeLine += ", ${activity.durationMinutes} ${context.i18n.durationValueMinutes}";
    }

    String activityName = getActivityName(activity, context);
    String title = activityName;
    if (title.isEmpty) {
      if (widget.activity.type == ActivityType.EXTRA) {
        title = context.i18n.extraActivity;
      } else {
        title = widget.activity.type!.getTranslatedText(context);
      }
    }

    SelectableText textLine = SelectableText(typeLine);
    if (widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY || widget.activity.type == ActivityType.PREDEFINED_ACTIVITY) {
      textLine = SelectableText(context.i18n.activityDataCheckQuestion,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.01,
                height: 1.8,
              ));
    }

    return [
      SizedBox(height: 10),
      SelectableText(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, height: 1)),
      if (activityName.isNotEmpty) ...[
        SizedBox(height: 10),
        textLine,
      ],
      SizedBox(height: 10),
      if (activity.type == ActivityType.PREDEFINED_ACTIVITY || activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY)
        ...getPredefinedActivityInfos(activity, context),
      if (activity.type == ActivityType.EXTRA) ...getExtraActivityInfos(activity, context),
      if (activity.type == ActivityType.ENDURANCE) ...getEnduranceActivityInfos(activity, context),
      if (activity.type == ActivityType.INTERVAL) ...getIntervalActivityInfos(activity, context),
      if (activity.type == ActivityType.HYPERTROPHY || activity.type == ActivityType.STRENGTHENING)
        ...getStrengtheningActivityInfos(activity.activity!.strengtheningExercise!, context, false),
      if (activity.type == ActivityType.OTHER) ...getOtherActivityInfos(activity, context),
      ...getActivityHint(),
      if ((activity.type != ActivityType.WORKOUT && playerControllers.length > 0) ||
          (activity.type == ActivityType.WORKOUT &&
              playerControllers.length > 0 &&
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.workout!.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty))
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: getYouTubeWidget(0),
        ),
      ...getActivityVideo(),
      if (activity.type == ActivityType.WORKOUT) ...getWorkoutActivityInfos(activity, context),
      if (activity.type == ActivityType.APPOINTMENT) ...getAppointmentActivityInfos(activity, context),
    ];
  }

  getPredefinedActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final PredefinedActivityPostDTO? predefinedActivity = activity.activity?.predefinedActivity;
    if (predefinedActivity == null) {
      return [];
    }
    return [SizedBox(height: 10), ...getExtraActivityInfos(activity, context)];
  }

  getExtraActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    if (!(activity.rating?.done ?? false) && !rateActivity && (activity.plannedBy ?? "") != SYSTEM_CREATED) {
      return [
        ElevatedButton(
          onPressed: () {
            setState(() {
              rateActivity = true;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(context.i18n.adjust.toUpperCase())],
          ),
        ),
      ];
    }
    return [];
  }

  getEnduranceActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final EnduranceExercisePostDTO enduranceExercise = activity.activity!.enduranceExercise!;
    if ((enduranceExercise.exerciseTrainingHeartRateLowerLimit ?? 0) <= 0 || (enduranceExercise.exerciseTrainingHeartRateUpperLimit ?? 0) <= 0) {
      return [];
    }

    return [
      getActivityInfoLine(context.i18n.trainingHeartFrequency,
          "${enduranceExercise.exerciseTrainingHeartRateLowerLimit} - ${enduranceExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
    ];
  }

  getOtherActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final OtherExercisePostDTO otherExercise = activity.activity!.otherExercise!;
    if ((otherExercise.exerciseTrainingHeartRateLowerLimit ?? 0) <= 0 || (otherExercise.exerciseTrainingHeartRateUpperLimit ?? 0) <= 0) {
      return [];
    }

    return [
      getActivityInfoLine(context.i18n.trainingHeartFrequency,
          "${otherExercise.exerciseTrainingHeartRateLowerLimit} - ${otherExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
    ];
  }

  getIntervalActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final IntervalExercisePostDTO intervalExercise = activity.activity!.intervalExercise!;
    final toReturn = [];
    final double gapHeight = MediaQuery.of(context).size.height * 0.02;
    toReturn.add(SizedBox(height: gapHeight));
    toReturn.add(
      SelectableText(context.i18n.exerciseIntensityPhase + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    if (((intervalExercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0) && ((intervalExercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0)) {
      toReturn.add(
        getActivityInfoLine(context.i18n.trainingHeartFrequency,
            "${intervalExercise.exerciseTrainingHeartRateLowerLimit} - ${intervalExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
      );
    }
    toReturn.add(
      getActivityInfoLine(
        context.i18n.duration,
        " ${intervalExercise.selectedExerciseSeconds ?? false ? intervalExercise.exerciseDurationSeconds.toString() + ' ${context.i18n.durationValueSeconds}' : Duration(seconds: intervalExercise.exerciseDurationSeconds!).inMinutes.toString() + ' ${context.i18n.durationValueMinutes}'}",
      ),
    );
    toReturn.add(SizedBox(height: gapHeight));
    toReturn.add(
      SelectableText(context.i18n.exerciseRecoveryPhase + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    if ((intervalExercise.recoveryTrainingHeartRateLowerLimit ?? 0) > 0 && (intervalExercise.recoveryTrainingHeartRateUpperLimit ?? 0) > 0) {
      toReturn.add(
        getActivityInfoLine(context.i18n.trainingHeartFrequency,
            "${intervalExercise.recoveryTrainingHeartRateLowerLimit} - ${intervalExercise.recoveryTrainingHeartRateUpperLimit} bpm"),
      );
    }
    toReturn.add(
      getActivityInfoLine(
        context.i18n.duration,
        " ${intervalExercise.selectedRecoverySeconds ?? false ? intervalExercise.recoveryDurationSeconds.toString() + ' ${context.i18n.durationValueSeconds}' : Duration(seconds: intervalExercise.recoveryDurationSeconds!).inMinutes.toString() + ' ${context.i18n.durationValueMinutes}'}",
      ),
    );
    toReturn.add(SizedBox(height: gapHeight));
    toReturn.add(
      getActivityInfoLine(context.i18n.intervals, "${intervalExercise.intervalCount}"),
    );
    return toReturn;
  }

  getStrengtheningActivityInfos(StrengtheningExercisePostDTO strengtheningExercise, BuildContext context, bool isWorkout) {
    return [
      if ((strengtheningExercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0 &&
          (strengtheningExercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0 &&
          !isWorkout)
        getActivityInfoLine(context.i18n.trainingHeartFrequency,
            "${strengtheningExercise.exerciseTrainingHeartRateLowerLimit} - ${strengtheningExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
      if (!isWorkout) getActivityInfoLine(context.i18n.execution, getStrengtheningExecutionString(strengtheningExercise, context)),
      getActivityInfoLine(
          context.i18n.muscleGroups,
          strengtheningExercise.muscleGroups.isNotEmpty
              ? strengtheningExercise.muscleGroups.map((entry) => entry.getTranslatedText(context)).join(", ")
              : "-"),
      getActivityInfoLine(context.i18n.exerciseNeedsEquipment, (strengtheningExercise.needsEquipment ?? false) ? context.i18n.yes : context.i18n.no),
      if ((strengtheningExercise.weight ?? 0) > 0)
        getActivityInfoLine(context.i18n.weight, "${strengtheningExercise.weight ?? "-"} ${context.i18n.kg}"),
    ];
  }

  List<Widget> getWorkoutActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    if (activity.activity!.workout!.exercises.isEmpty) {
      return [];
    }
    List<Widget> workoutWidgets = [];
    int youTubeCount =
        getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.workout!.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty ? 1 : 0;
    for (int currentIndex = 0; currentIndex < activity.activity!.workout!.exercises.length; ++currentIndex) {
      for (int pastIndex = 0; pastIndex < currentIndex; ++pastIndex) {
        if (getYoutubeVideoIdByURL(getTranslatedText(activity.activity!.workout!.exercises[pastIndex].youTubeUrl, context), map: youtubeIdMapping)
            .isNotEmpty) {
          ++youTubeCount;
        }
      }
      StrengtheningExercisePostDTO exercise = activity.activity!.workout!.exercises[currentIndex];
      bool showHint = workoutShowHints[currentIndex];
      String hintText = getTranslatedText(exercise.hint, context);
      String activityDescription =
          "<b>${getTranslatedText(exercise.name, context)}</b>\n<b>${context.i18n.execution}:</b> ${getStrengtheningExecutionString(exercise, context)}";
      if (exercise.exerciseTrainingHeartRateLowerLimit != null && exercise.exerciseTrainingHeartRateUpperLimit != null) {
        activityDescription +=
            "\n<b>${context.i18n.trainingHeartFrequency}:</b> ${exercise.exerciseTrainingHeartRateLowerLimit} - ${exercise.exerciseTrainingHeartRateUpperLimit} bpm";
      }
      Widget innerText = Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: datatableBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: StyledText(
                    text: activityDescription,
                    tags: {
                      'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
                    },
                  ),
                ),
                Transform.rotate(
                  angle: math.pi / 2,
                  child: Icon(showHint ? Icons.chevron_left : Icons.chevron_right),
                ),
              ],
            ),
            if (showHint)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...getStrengtheningActivityInfos(exercise, context, true),
                  if (hintText.isNotEmpty)
                    getActivityInfoLineWithWidget(
                      context.i18n.notes,
                      SelectableLinkify(
                        text: hintText,
                        onOpen: (link) async {
                          if (await canLaunchUrlString(link.url)) {
                            String cleanedUrl = link.url;
                            if (cleanedUrl.endsWith("!")) {
                              cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                            }
                            launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                    ),
                  if (getYoutubeVideoIdByURL(getTranslatedText(exercise.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty &&
                      youTubeCount < playerControllers.length)
                    getYouTubeWidget(youTubeCount)
                ],
              ),
          ],
        ),
      );
      workoutWidgets.add(Padding(
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: InkWell(
          child: innerText,
          onTap: () {
            setState(() {
              workoutShowHints[currentIndex] = !workoutShowHints[currentIndex];
            });
          },
        ),
      ));
    }
    return workoutWidgets;
  }

  getAppointmentActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final AppointmentPostDTO? appointment = activity.activity?.appointment;
    if (appointment == null || rateActivity) {
      return [];
    }
    return [
      if ((appointment.location ?? "").isNotEmpty && !(appointment.useLocationCoordinates ?? false))
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: getActivityInfoLine(context.i18n.location, appointment.location!),
        ),
      if ((appointment.locationAddress ?? "").isNotEmpty && (appointment.useLocationCoordinates ?? false))
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: getActivityInfoLine(context.i18n.location, appointment.locationAddress!),
        ),
      if ((appointment.details ?? "").isNotEmpty)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(context.i18n.details + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
            Flexible(
              child: SelectableLinkify(
                text: appointment.details!,
                onOpen: (link) async {
                  if (await canLaunchUrlString(link.url)) {
                    String cleanedUrl = link.url;
                    if (cleanedUrl.endsWith("!")) {
                      cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                    }
                    launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ),
          ],
        ),
      if ((userRepository.userRole != UserRole.PATIENT || (widget.activity.plannedBy ?? "") == (userRepository.user!.patient!.id ?? "")) &&
          (widget.activity.plannedBy ?? "") != SYSTEM_CREATED)
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                rateActivity = true;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(context.i18n.adjust.toUpperCase())],
            ),
          ),
        ),
    ];
  }

  Widget getYouTubeWidget(int index) {
    // String? youTubeUrl = youtubeIdMapping[playerControllers[index].initialVideoId];
    String? youTubeUrl = youtubeIdMapping[playerControllers[index].videoUrl];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if ((youTubeUrl ?? "").isNotEmpty && !kIsWeb)
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                launchUrlString(youTubeUrl!, mode: LaunchMode.externalApplication);
              },
              child: Text(
                "Fullscreen: YouTube-Link >",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
            ),
          ),
        Container(
          width: math.min(MediaQuery.of(context).size.width, 600),
          padding: EdgeInsets.only(top: 4),
          child: YoutubePlayer(
            controller: playerControllers[index],
            gestureRecognizers: [
              Factory<OneSequenceGestureRecognizer>(
                () => VideoDragGestureRecognizer(),
              ),
            ].toSet(),
          ),
        ),
      ],
    );
  }
}
