// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/bloc/message_repository.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/patient/activity_dialog.dart';
import 'package:aptapp/patient/onboarding_page.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar_mobile.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar_web.dart';
import 'package:aptapp/patient/patient_calendar/personal_goals_card.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../activity/bloc/activity_repository.dart';
import '../stats/activity_stats.dart';

class PatientCalendarPage extends StatefulWidget {
  final String patientId;

  PatientCalendarPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _PatientCalendarPageState createState() => _PatientCalendarPageState();
}

class _PatientCalendarPageState extends State<PatientCalendarPage> with TraceablePageMixin {
  ActivityBloc? activityBloc;
  FetchedPatientActivitiesState? lastFetchedState;
  FetchedPatientDatahubRecommendationsState? lastFetchedDatahubState;
  double? width;
  double? height;
  DateTime? focusedDay;
  CalendarFormat calendarFormat = CalendarFormat.week;
  final userRepository = KiwiContainer().resolve<UserRepository>();

  @override
  void initState() {
    super.initState();
    focusedDay = DateTime.now();
    if (userRepository.user != null) {
      initActivityBloc();
    }
    if (userRepository.userRole == UserRole.PATIENT) {
      SharedPreferences.getInstance().then((preferences) {
        if (preferences.getBool("onboardingShown") == null || !preferences.getBool("onboardingShown")!) {
          OnboardingPage.showOnboardingDialog(context, isKlimafit: userRepository.user?.institution?.institutionFocus?.isKlimafit() ?? false);
          preferences.setBool("onboardingShown", true);
        }
      });
    }
  }

  initActivityBloc() {
    activityBloc = BlocProvider.of<ActivityBloc>(context)
      ..add(ResetActivityEvent())
      ..add(
        FetchPatientActivitiesEvent(patientId: widget.patientId, date: DateTime.now()),
      );
  }

  deleteActivity(ActivityOverviewDTO activity) {
    // in klimafit patient can delete appointments planned by hp, so only delete the entry of the current day
    if (activity.type == ActivityType.APPOINTMENT &&
        userRepository.userRole == UserRole.PATIENT &&
        activity.plannedBy != userRepository.user?.patient!.id) {
      activityBloc!.add(HideActivityEvent(
          currentDate: focusedDay!,
          patientId: lastFetchedState!.patient.user!.id!,
          hideActivity: HideActivityPostDTO(
            activityId: activity.activityId!,
            hideDate: activity.date!,
            hideAll: false,
          )));
    } else {
      activityBloc!.add(DeleteActivityEvent(
        id: activity.activityId!,
        patientId: lastFetchedState!.patient.user!.id!,
        activityDate: focusedDay!,
        type: activity.type!,
      ));
    }
  }

  moveActivity(MoveActivityPostDTO moveActivity) {
    activityBloc!.add(MoveActivityEvent(moveActivity: moveActivity));
  }

  movePersonalGoal(MovePersonalGoalPostDTO movePersonalGoal) {
    activityBloc!.add(MovePersonalGoalEvent(movePersonalGoal: movePersonalGoal));
  }

  void handleSnackbar(UserState state, bool isMobile, BuildContext context) {
    var snackBar;
    if (state is AddedPatientState) {
      snackBar = getSnackbar(context.i18n.addedPatient, isMobile, context);
    } else if (state is UpdatedPatientState) {
      snackBar = getSnackbar(context.i18n.updatedPatient, isMobile, context);
    } else if (state is DeletedPatientState) {
      snackBar = getSnackbar(context.i18n.deletedPatient, isMobile, context);
    } else if (state is UserAlreadPresetState) {
      snackBar = getSnackbar(
        context.i18n.validationDuplicateEmail,
        isMobile,
        context,
        error: true,
      );
    } else if (state is UsersErrorState) {
      snackBar = getSnackbar(
        context.i18n.error,
        isMobile,
        context,
        error: true,
      );
    }

    if (snackBar != null) {
      snackBar.show(context);
      snackBar = null;
    }
  }

  createActivityByType(DateTime date, ActivityType? type) {
    if (type == null) {
      _showAddActivityDialog(date);
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        final activity = ActivityOverviewDTO(type: type, date: englishDateFormat.format(date), rating: ActivityPatientRatingPostDTO(done: false));
        return ActivityDialog(
            patient: lastFetchedState!.patient.user!,
            activity: activity,
            activeMinutes: lastFetchedState!.activeMinutes,
            rateActivity: true,
            deleteActivity: () => deleteActivity(activity),
            institution: lastFetchedState!.patient.institution!);
      },
    );
  }

  createActivityByRecommendation(DatahubResponseRecommendationsInner recommendation) {
    ActivityType activityType = recommendation.activityType ??
        (recommendation.type == RecommendationType.ACTIVITY ? ActivityType.PREDEFINED_ACTIVITY : ActivityType.PREDEFINED_ACTIVE_MOBILITY);
    final route = recommendation.route ?? recommendation.proposedRoute;
    DateTime date = DateTime.now();
    String? time;
    String? endTime;
    if (route != null && route.startTimestamp != null) {
      date = route.startTimestamp!;
      final timeFormat = DateFormat('HH:mm');
      time = timeFormat.format(route.startTimestamp!);
      if (route.durationMins != null) {
        final endTimeStamp = route.startTimestamp!.add(Duration(minutes: route.durationMins!));
        endTime = timeFormat.format(endTimeStamp);
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        final activity = ActivityOverviewDTO(
          type: activityType,
          date: englishDateFormat.format(date),
          rating: ActivityPatientRatingPostDTO(done: false),
          time: time,
          endTime: endTime,
        );
        return ActivityDialog(
          patient: lastFetchedState!.patient.user!,
          activity: activity,
          activeMinutes: lastFetchedState!.activeMinutes,
          rateActivity: true,
          deleteActivity: () => deleteActivity(activity),
          institution: lastFetchedState!.patient.institution!,
          recommendation: recommendation,
        );
      },
    );
  }

  void _showAddActivityDialog(DateTime day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.i18n.addActivity),
          titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ActivityType.PREDEFINED_ACTIVITY, ActivityType.PREDEFINED_ACTIVE_MOBILITY, ActivityType.APPOINTMENT].map((activityType) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton.icon(
                  style: getElevatedButtonStyle(
                    context,
                    backgroundColor: activityType.backgroundColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    createActivityByType(day, activityType);
                  },
                  icon: Icon(activityType.iconData, color: Colors.white),
                  label: Text(
                    activityType.getTranslatedText(context).toUpperCase(),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  createActivity(DateTime date) {
    context.beamToNamed(
      '/patients/${lastFetchedState!.patient.user!.id!}/calendar/add-activity',
      data: {
        "patient": lastFetchedState!.patient.user!,
        "chosenDate": date,
      },
      beamBackOnPop: true,
    );
  }

  changeMonth(DateTime date) {
    setState(() {
      focusedDay = date;
    });
    activityBloc!.add(
      FetchPatientActivitiesEvent(patientId: lastFetchedState!.patient.user!.id!, date: date),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: userRepository.userRole != UserRole.PATIENT,
      child: ResponsiveBuilder(
        builder: (context, size) {
          return BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              return BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  bool isMobile = !(size.isTablet || size.isDesktop);
                  handleSnackbar(state, isMobile, context);
                },
                child: renderCalendar(state, size),
              );
            },
          );
        },
      ),
    );
  }

  Widget renderCalendar(ActivityState state, SizingInformation size) {
    if (state is FetchedPatientActivitiesState) {
      lastFetchedState = state;
      if (state.date != null) {
        focusedDay = state.date;
      }
    } else if (state is FetchedPatientDatahubRecommendationsState) {
      lastFetchedDatahubState = state;
    }
    if (lastFetchedState != null) {
      if (size.isMobile) {
        return PatientCalendarMobile(
            state: lastFetchedState!,
            datahubState: lastFetchedDatahubState,
            addActivityByType: createActivityByType,
            addActivityByRecommendation: createActivityByRecommendation,
            markAsDone: markActivityAsDone,
            addActivity: createActivity,
            deleteActivity: deleteActivity,
            changeMonth: changeMonth,
            changeDay: (date) => setState(() => focusedDay = date),
            focusedDay: focusedDay!,
            currentFormat: calendarFormat,
            changeFormat: (format) => setState(() => calendarFormat = format),
            refetchDatahub: () {
              activityBloc!.add(FetchPatientDatahubRecommendationsEvent(patientId: lastFetchedState!.patient.user!.id!, date: focusedDay!));
            });
      } else {
        return PatientCalendarWeb(
          state: lastFetchedState!,
          datahubState: lastFetchedDatahubState,
          isDesktop: size.isDesktop,
          isTablet: size.isTablet,
          addActivity: createActivity,
          addActivityByType: createActivityByType,
          addActivityByRecommendation: createActivityByRecommendation,
          markAsDone: markActivityAsDone,
          deleteActivity: deleteActivity,
          changeMonth: changeMonth,
          focusedDay: focusedDay!,
          moveActivity: moveActivity,
          movePersonalGoal: movePersonalGoal,
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> markActivityAsDone(dynamic activity) async {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    if (userRepository.userRole == UserRole.PATIENT) {
      if (activity is ActivityOverviewDTO) {
        if (activity.rating!.done ?? false) {
          ActivityDialog.showUndoRatingDialog(context, lastFetchedState!.patient.user!, activity, lastFetchedState!.activeMinutes, true,
              lastFetchedState!.patient.institution!, () => deleteActivity(activity));
        } else {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ActivityDialog(
                patient: lastFetchedState!.patient.user!,
                activity: activity,
                activeMinutes: lastFetchedState!.activeMinutes,
                rateActivity: true,
                deleteActivity: () => deleteActivity(activity),
                institution: lastFetchedState!.patient.institution!,
              );
            },
          );
        }
      } else {
        final goal = activity as PersonalGoal;
        if (goal.done ?? false) {
          var updateGoal = PersonalGoalPostDTO()
            ..description = goal.description
            ..done = false
            ..endDate = englishDateFormat.format(DateTime.parse(goal.endDate!))
            ..patientId = lastFetchedState!.patient.user!.id;
          MatomoTracker.instance.trackEvent(
            eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_UNDONE, action: "Set Personal Goal to Undone"),
          );
          activityBloc!.add(UpdatePersonalGoalEvent(id: goal.id!, goal: updateGoal, patientId: lastFetchedState!.patient.user!.id!));
        } else {
          var updateGoal = PersonalGoalPostDTO()
            ..description = goal.description
            ..done = true
            ..endDate = englishDateFormat.format(DateTime.parse(goal.endDate!))
            ..patientId = lastFetchedState!.patient.user!.id;
          ;

          await PersonalGoalsCard.showGoalAchieved(context, goal);
          MatomoTracker.instance.trackEvent(
            eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_DONE, action: "Set Personal Goal to Done"),
          );
          activityBloc!.add(UpdatePersonalGoalEvent(id: goal.id!, goal: updateGoal, patientId: lastFetchedState!.patient.user!.id!));
        }
      }
    } else {
      if (activity is ActivityOverviewDTO) {
        showPlannedActivity(activity, lastFetchedState!.patient.user!);
      } else {
        context.beamToNamed(
          "/patients/${widget.patientId}/goal-setting",
          data: {"editGoal": activity},
        );
      }
    }
  }

  Future<void> showPlannedActivity(ActivityOverviewDTO activity, PatientGetDTO patient) async {
    double width = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ResponsiveBuilder(
          builder: (context, size) {
            double alertSizePadding = size.isMobile
                ? width * 0.02
                : size.isDesktop
                    ? width * 0.34
                    : width * 0.2;
            double containerWidth = size.isMobile ? width * 0.94 : 400;
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: alertSizePadding,
              ),
              contentPadding: EdgeInsets.only(top: 15.0, bottom: 8, left: 20, right: 20),
              title: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.close,
                            size: 24,
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.type != ActivityType.APPOINTMENT
                                ? (activity.type == ActivityType.EXTRA ? context.i18n.extraActivity : context.i18n.plannedActivity)
                                : context.i18n.activity_APPOINTMENT,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                width: containerWidth,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      BlocProvider(
                        create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ActivityStats(
                              activity: activity,
                              patient: patient,
                              activityBloc: activityBloc!,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String get traceablePageName => "Patient Calendar Page";
}
