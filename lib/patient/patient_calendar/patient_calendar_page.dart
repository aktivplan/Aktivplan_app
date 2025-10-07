import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/bloc/message_repository.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/patient/activity_dialog.dart';
import 'package:aptapp/patient/onboarding_page.dart';
import 'package:aptapp/patient/patient_calendar/add_extra_activity.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar_mobile.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar_web.dart';
import 'package:aptapp/patient/patient_calendar/personal_goal_activity_card.dart';
import 'package:aptapp/patient/patient_calendar/personal_goals_card.dart';
import 'package:aptapp/patient/patient_calendar/planned_activity_card.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/utils/constants.dart';
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
  PatientGetDTO? patient;
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
          OnboardingPage.showOnboardingDialog(context);
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

  deleteActivity(String id, ActivityType type) {
    activityBloc!.add(DeleteActivityEvent(id: id, patientId: patient!.id!, activityDate: focusedDay!, type: type));
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

  createExtraActivity(DateTime date, ActivityOverviewDTO? activity, ActiveMinutesOverviewDTO activeMinutes) {
    showDialog(
      context: context,
      builder: (context) {
        return AddExtraActivity(
          patient: patient!,
          chosenDate: date,
          plannedActivity: activity,
          activeMinutes: activeMinutes,
        );
      },
    );
  }

  createActivity(date) {
    context.beamToNamed(
      '/patients/${patient!.id!}/calendar/add-activity',
      data: {
        "patient": patient,
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
      FetchPatientActivitiesEvent(patientId: patient!.id!, date: date),
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
      patient = state.patient.user;
      if (state.date != null) {
        focusedDay = state.date;
      }
      if (size.isMobile) {
        return PatientCalendarMobile(
          patientOverview: state.patient,
          patient: patient!,
          addExtraActivity: createExtraActivity,
          patientActivities: state.activities,
          activeMinutes: state.activeMinutes,
          personalGoals: state.personalGoals,
          markAsDone: markActivityAsDone,
          addActivity: createActivity,
          deleteActivity: deleteActivity,
          changeMonth: changeMonth,
          changeDay: (date) => setState(() => focusedDay = date),
          userPicture: state.userPicture,
          focusedDay: focusedDay!,
          currentFormat: calendarFormat,
          changeFormat: (format) => setState(() => calendarFormat = format),
        );
      } else {
        return PatientCalendarWeb(
          isDesktop: size.isDesktop,
          isTablet: size.isTablet,
          patientOverview: state.patient,
          patient: patient!,
          addActivity: createActivity,
          patientActivities: state.activities,
          activeMinutes: state.activeMinutes,
          personalGoals: state.personalGoals,
          addExtraActivity: createExtraActivity,
          showEvents: showEventsOfDay,
          markAsDone: markActivityAsDone,
          deleteActivity: deleteActivity,
          changeMonth: changeMonth,
          focusedDay: focusedDay!,
          userPicture: state.userPicture,
          moveActivity: moveActivity,
          movePersonalGoal: movePersonalGoal,
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> showEventsOfDay(
      DateTime day, List events, activeMinutes, PatientGetDTO patient, Function deleteActivity, Function showActiveMinutes) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        double width = MediaQuery.of(dialogContext).size.width;
        return ResponsiveBuilder(
          builder: (context, size) {
            double horizontalPadding = size.isDesktop
                ? width * 0.38
                : size.isTablet
                    ? width * 0.1
                    : width * 0.05;
            return AlertDialog(
              insetPadding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: 12,
                bottom: 12,
              ),
              contentPadding: EdgeInsets.only(top: 20.0, bottom: 35, left: 8, right: 8),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  FittedBox(
                    fit: BoxFit.contain,
                    child: SelectableText(
                      '${DateFormat('EEEE, dd.MMMM yyyy', 'de').format(day)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
              ),
              content: Container(
                width: width * 0.94,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      for (var event in events)
                        event is ActivityOverviewDTO
                            ? PlannedActivityCard(
                                activity: event,
                                markAsDone: markActivityAsDone,
                                addExtraActivity: createExtraActivity,
                                onShowEvents: true,
                                activeMinutes: activeMinutes,
                                patient: patient,
                                deleteActivity: deleteActivity,
                                activityBloc: activityBloc!,
                              )
                            : PersonalGoalActivityCard(goal: event),
                      SizedBox(
                        height: 18,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            if (userRepository.userRole == UserRole.PATIENT) {
                              createExtraActivity(day, null, activeMinutes);
                            } else {
                              createActivity(day);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.i18n.addActivity.toUpperCase()),
                            ],
                          ))
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

  Future<void> markActivityAsDone(dynamic activity, ActiveMinutesOverviewDTO activeMinutes, bool allowRescheduleActivities) async {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    if (userRepository.userRole == UserRole.PATIENT) {
      if (activity is ActivityOverviewDTO) {
        if (activity.rating!.done ?? false) {
          ActivityDialog.showUndoRatingDialog(context, patient!, activity, activeMinutes, true, allowRescheduleActivities, deleteActivity);
        } else {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ActivityDialog(
                patient: patient!,
                activity: activity,
                activeMinutes: activeMinutes,
                rateActivity: true,
                deleteActivity: deleteActivity,
                allowRescheduleActivities: allowRescheduleActivities,
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
            ..patientId = patient!.id;
          MatomoTracker.instance.trackEvent(
            eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_UNDONE, action: "Set Personal Goal to Undone"),
          );
          activityBloc!.add(UpdatePersonalGoalEvent(id: goal.id!, goal: updateGoal, patientId: patient!.id!));
        } else {
          var updateGoal = PersonalGoalPostDTO()
            ..description = goal.description
            ..done = true
            ..endDate = englishDateFormat.format(DateTime.parse(goal.endDate!))
            ..patientId = patient!.id;

          await PersonalGoalsCard.showGoalAchieved(context, goal);
          MatomoTracker.instance.trackEvent(
            eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_DONE, action: "Set Personal Goal to Done"),
          );
          activityBloc!.add(UpdatePersonalGoalEvent(id: goal.id!, goal: updateGoal, patientId: patient!.id!));
        }
      }
    } else {
      if (activity is ActivityOverviewDTO) {
        showPlannedActivity(activity, patient!);
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
