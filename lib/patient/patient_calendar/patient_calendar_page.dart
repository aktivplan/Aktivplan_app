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
import 'package:aptapp/colors.dart';
import 'package:aptapp/sensors/sensor_repository.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:permission_handler/permission_handler.dart';
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
  double? width;
  double? height;
  DateTime? focusedDay;
  CalendarFormat calendarFormat = CalendarFormat.week;
  final userRepository = KiwiContainer().resolve<UserRepository>();
  SensorRepository? _sensorRepository;
  bool _healthKitLoading = false;
  String? _pendingHealthKitUuid;

  @override
  void initState() {
    super.initState();
    focusedDay = DateTime.now();
    _sensorRepository = KiwiContainer().resolve<SensorRepository>();
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

  deleteActivity(String id, ActivityType type) {
    _removeHealthKitUuidForActivity(id);
    activityBloc!.add(DeleteActivityEvent(id: id, patientId: lastFetchedState!.patient.user!.id!, activityDate: focusedDay!, type: type));
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
        return ActivityDialog(
            patient: lastFetchedState!.patient.user!,
            activity: ActivityOverviewDTO(type: type, date: englishDateFormat.format(date), rating: ActivityPatientRatingPostDTO(done: false)),
            activeMinutes: lastFetchedState!.activeMinutes,
            rateActivity: true,
            deleteActivity: deleteActivity,
            institution: lastFetchedState!.patient.institution!);
      },
    );
  }

  void _showAddActivityDialog(DateTime day) {
    final isKlimafit = lastFetchedState?.patient.institution?.institutionFocus?.isKlimafit() ?? false;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(dialogContext.i18n.addActivity),
          titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isKlimafit)
                ...[ActivityType.PREDEFINED_ACTIVITY, ActivityType.PREDEFINED_ACTIVE_MOBILITY, ActivityType.APPOINTMENT].map((activityType) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: ElevatedButton.icon(
                      style: getElevatedButtonStyle(dialogContext, backgroundColor: activityType.backgroundColor),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        createActivityByType(day, activityType);
                      },
                      icon: Icon(activityType.iconData, color: Colors.white),
                      label: Text(activityType.getTranslatedText(dialogContext).toUpperCase()),
                    ),
                  );
                })
              else
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton.icon(
                    style: getElevatedButtonStyle(dialogContext, backgroundColor: extraActivityColor),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      createActivityByType(day, ActivityType.EXTRA);
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(dialogContext.i18n.extraActivity.toUpperCase()),
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton.icon(
                  style: getElevatedButtonStyle(dialogContext, backgroundColor: primaryColor),
                  onPressed: _healthKitLoading
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop();
                          _importWorkoutFromHealthKit(day);
                        },
                  icon: _healthKitLoading
                      ? SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Icon(Icons.health_and_safety_outlined, color: Colors.white),
                  label: Text(dialogContext.i18n.importWorkout.toUpperCase()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _importWorkoutFromHealthKit(DateTime date) async {
    if (_healthKitLoading || _sensorRepository == null) return;
    setState(() => _healthKitLoading = true);
    try {
      bool authorized = await _sensorRepository!.isAuthorizedToGoogleHealthConnectAppleHealth();
      if (!authorized) {
        authorized = await _sensorRepository!.requestHealthKitAuthorization();
      }
      if (!mounted) return;
      if (!authorized) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.i18n.connectToAppleHealth),
            action: SnackBarAction(label: context.i18n.privacySettings, onPressed: () => openAppSettings()),
          ),
        );
        return;
      }
      final importedUuids = await _loadImportedUuids();
      final allActivities = await _sensorRepository!.fetchWorkoutsForImport(date, context);
      final activities = allActivities.where((a) => !importedUuids.contains(a.uuid)).toList();
      if (!mounted) return;
      final matches = {for (final a in activities) a: _findMatchingPlannedActivity(a, date)};
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (sheetContext) {
          if (activities.isEmpty) {
            return Padding(
              padding: EdgeInsets.all(24),
              child: Text(context.i18n.noWorkouts, style: Theme.of(context).textTheme.bodyMedium),
            );
          }
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            children: [
              Text(context.i18n.workouts, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: lightTextColor)),
              SizedBox(height: 8),
              ...activities.map((data) {
                final matchedActivity = matches[data];
                final isMatched = matchedActivity != null;
                return Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      if (isMatched) {
                        _openPlannedActivityWithHealthKit(matchedActivity, data);
                      } else {
                        _openWorkoutActivity(date, data);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: isMatched ? primaryColor : datatableBorderColor, width: isMatched ? 2 : 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.activityType, style: Theme.of(context).textTheme.bodyMedium),
                              Text('${data.timeFrom} · ${data.duration} ${context.i18n.durationValueMinutes}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: lightTextColor)),
                              if (isMatched)
                                Text(
                                  '→ ${getTranslatedText(matchedActivity.name, context)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor),
                                ),
                            ],
                          ),
                          if (data.value > 0)
                            Text('${data.value} bpm', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: lightTextColor)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      );
    } finally {
      if (mounted) setState(() => _healthKitLoading = false);
    }
  }

  static const _importedWorkoutsKey = 'healthkit_imported_workout_uuids';

  Future<Set<String>> _loadImportedUuids() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_importedWorkoutsKey) ?? []).toSet();
  }

  Future<void> _saveImportedUuid(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = (prefs.getStringList(_importedWorkoutsKey) ?? []).toSet();
    existing.add(uuid);
    await prefs.setStringList(_importedWorkoutsKey, existing.toList());
  }

  Future<void> _removeImportedUuid(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = (prefs.getStringList(_importedWorkoutsKey) ?? []).toSet();
    existing.remove(uuid);
    await prefs.setStringList(_importedWorkoutsKey, existing.toList());
  }

  static const _healthKitMappingKey = 'healthkit_activityid_to_uuid';

  Future<void> _storeActivityIdMapping(String activityId, String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = (prefs.getStringList(_healthKitMappingKey) ?? [])
        .where((e) => !e.startsWith('$activityId|'))
        .toList();
    entries.add('$activityId|$uuid');
    await prefs.setStringList(_healthKitMappingKey, entries);
  }

  Future<void> _removeHealthKitUuidForActivity(String activityId) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = prefs.getStringList(_healthKitMappingKey) ?? [];
    String? uuid;
    final remaining = <String>[];
    for (final e in entries) {
      if (e.startsWith('$activityId|')) {
        uuid = e.substring(activityId.length + 1);
      } else {
        remaining.add(e);
      }
    }
    if (uuid != null) {
      await prefs.setStringList(_healthKitMappingKey, remaining);
      await _removeImportedUuid(uuid);
    }
  }

  ActivityOverviewDTO? _findMatchingPlannedActivity(ActivityData workout, DateTime date) {
    if (lastFetchedState == null || _sensorRepository == null) return null;
    final dateStr = englishDateFormat.format(date);
    for (final planned in lastFetchedState!.activities) {
      if (planned.date != dateStr) continue;
      if (planned.rating?.done == true) continue;
      final name = planned.name['DE'] ?? planned.name['EN'] ?? '';
      if (name.isNotEmpty && _sensorRepository!.doesWorkoutMatchActivity(workout, name)) {
        return planned;
      }
    }
    return null;
  }

  void _openPlannedActivityWithHealthKit(ActivityOverviewDTO planned, ActivityData hkitData) {
    final prefilled = ActivityOverviewDTO(
      activityId: planned.activityId,
      date: planned.date,
      time: planned.time,
      endTime: planned.endTime,
      name: planned.name,
      durationMinutes: planned.durationMinutes,
      plannedDurationMinutes: planned.plannedDurationMinutes,
      type: planned.type,
      repeats: planned.repeats,
      healthcareProfessionalName: planned.healthcareProfessionalName,
      plannedBy: planned.plannedBy,
      activity: planned.activity,
      rating: ActivityPatientRatingPostDTO(
        done: false,
        heartrate: hkitData.value > 0 ? hkitData.value : null,
        durationMinutes: hkitData.duration,
        time: hkitData.timeFrom,
      ),
    );
    showDialog(
      context: context,
      builder: (context) => ActivityDialog(
        patient: lastFetchedState!.patient.user!,
        activity: prefilled,
        activeMinutes: lastFetchedState!.activeMinutes,
        rateActivity: true,
        deleteActivity: deleteActivity,
        institution: lastFetchedState!.patient.institution!,
        onSaved: () {
          _saveImportedUuid(hkitData.uuid);
          if (planned.activityId != null) {
            _storeActivityIdMapping(planned.activityId!, hkitData.uuid);
          }
        },
      ),
    );
  }

  void _openWorkoutActivity(DateTime date, ActivityData data) {
    showDialog(
      context: context,
      builder: (context) => ActivityDialog(
        patient: lastFetchedState!.patient.user!,
        activity: ActivityOverviewDTO(
          type: ActivityType.EXTRA,
          date: englishDateFormat.format(date),
          name: getTranslationObjectFromText(data.activityType, data.activityType),
          durationMinutes: data.duration,
          rating: ActivityPatientRatingPostDTO(
            done: false,
            durationMinutes: data.duration,
            heartrate: data.value > 0 ? data.value : null,
            time: data.timeFrom,
          ),
        ),
        activeMinutes: lastFetchedState!.activeMinutes,
        rateActivity: true,
        deleteActivity: deleteActivity,
        institution: lastFetchedState!.patient.institution!,
        onSaved: () {
          _pendingHealthKitUuid = data.uuid;
          _saveImportedUuid(data.uuid);
        },
      ),
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
          return BlocConsumer<ActivityBloc, ActivityState>(
            listener: (context, state) {
              if (state is ExtraActivityCreatedState && _pendingHealthKitUuid != null) {
                _storeActivityIdMapping(state.activityId, _pendingHealthKitUuid!);
                _pendingHealthKitUuid = null;
              }
            },
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
    }
    if (lastFetchedState != null) {
      if (size.isMobile) {
        return PatientCalendarMobile(
          state: lastFetchedState!,
          addActivityByType: createActivityByType,
          markAsDone: markActivityAsDone,
          addActivity: createActivity,
          deleteActivity: deleteActivity,
          changeMonth: changeMonth,
          changeDay: (date) => setState(() => focusedDay = date),
          focusedDay: focusedDay!,
          currentFormat: calendarFormat,
          changeFormat: (format) => setState(() => calendarFormat = format),
        );
      } else {
        return PatientCalendarWeb(
          state: lastFetchedState!,
          isDesktop: size.isDesktop,
          isTablet: size.isTablet,
          addActivity: createActivity,
          addActivityByType: createActivityByType,
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
              lastFetchedState!.patient.institution!, deleteActivity);
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
                deleteActivity: deleteActivity,
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
