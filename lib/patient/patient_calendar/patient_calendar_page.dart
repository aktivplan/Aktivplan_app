import 'dart:io';

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
import 'package:aptapp/utils/debug_tools.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/sensors/sensor_repository.dart';
import 'package:health/health.dart' show HealthWorkoutActivityType;
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
  bool _healthKitAuthorized = false;
  String? _pendingHealthKitUuid;
  Map<String, ActivityData> _autoMatchedWorkouts = {};

  @override
  void initState() {
    super.initState();
    focusedDay = DateTime.now();
    _sensorRepository = KiwiContainer().resolve<SensorRepository>();
    _sensorRepository!.isAuthorizedToGoogleHealthConnectAppleHealth().then((v) {
      if (mounted) setState(() => _healthKitAuthorized = v);
      if (v && mounted) _tryAutoMatchWorkouts(focusedDay ?? DateTime.now());
    });
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
                      : Icon(_healthKitAuthorized ? Icons.health_and_safety : Icons.health_and_safety_outlined, color: Colors.white),
                  label: Text(dialogContext.i18n.importWorkout.toUpperCase()),
                ),
              ),
              // DEBUG ONLY: writes sample workouts into Apple Health / Health
              // Connect so the import and matching flows can be exercised on a
              // device. showDebugTools keeps it out of release builds entirely.
              if (showDebugTools)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      _showDebugWorkoutPicker(day);
                    },
                    icon: Icon(Icons.bug_report),
                    label: Text('DEBUG: ADD WORKOUT TO HEALTH'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // DEBUG ONLY - sample workouts
  //
  // Writes workouts into Apple Health / Health Connect for the selected day so
  // the import and matching flows can be tested without recording anything for
  // real. Reachable only from the showDebugTools button above.
  // ---------------------------------------------------------------------------

  static const _debugWorkoutTypes = <String, HealthWorkoutActivityType>{
    'Walking': HealthWorkoutActivityType.WALKING,
    'Running': HealthWorkoutActivityType.RUNNING,
    'Cycling (BIKING)': HealthWorkoutActivityType.BIKING,
    'Swimming': HealthWorkoutActivityType.SWIMMING,
    'HIIT': HealthWorkoutActivityType.HIGH_INTENSITY_INTERVAL_TRAINING,
    'Strength': HealthWorkoutActivityType.TRADITIONAL_STRENGTH_TRAINING,
    'Indoor bike - in no set': HealthWorkoutActivityType.BIKING_STATIONARY,
    'Golf - matches nothing': HealthWorkoutActivityType.GOLF,
  };

  /// Three walks of very different lengths: whichever sits closest to the
  /// activity's planned duration should win the tie-break.
  static const _debugDurationSpread = <({HealthWorkoutActivityType type, int hour, int minutes})>[
    (type: HealthWorkoutActivityType.WALKING, hour: 7, minutes: 15),
    (type: HealthWorkoutActivityType.WALKING, hour: 12, minutes: 45),
    (type: HealthWorkoutActivityType.WALKING, hour: 17, minutes: 90),
  ];

  /// Three different cardio types, so one ENDURANCE activity has three
  /// competing candidates and the name/duration ordering is visible in the log.
  static const _debugCardioSpread = <({HealthWorkoutActivityType type, int hour, int minutes})>[
    (type: HealthWorkoutActivityType.BIKING, hour: 8, minutes: 110),
    (type: HealthWorkoutActivityType.RUNNING, hour: 13, minutes: 42),
    (type: HealthWorkoutActivityType.SWIMMING, hour: 18, minutes: 25),
  ];

  Future<void> _showDebugWorkoutPicker(DateTime day) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text('Add debug workout', style: Theme.of(sheetContext).textTheme.titleMedium),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text('Written to ${germanDateFormat.format(day)}',
                    style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(color: lightTextColor)),
              ),
              ListTile(
                leading: Icon(Icons.playlist_add),
                title: Text('One of each type'),
                subtitle: Text('${_debugWorkoutTypes.length} workouts, hourly from 05:00, 30 min each'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  final types = _debugWorkoutTypes.values.toList();
                  _addDebugScenario(day, [
                    for (var i = 0; i < types.length; i++) (type: types[i], hour: 5 + i, minutes: 30),
                  ]);
                },
              ),
              ListTile(
                leading: Icon(Icons.timer_outlined),
                title: Text('Duration spread - 3x Walking'),
                subtitle: Text('15 / 45 / 90 min - checks the closest-duration tie-break'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _addDebugScenario(day, _debugDurationSpread);
                },
              ),
              ListTile(
                leading: Icon(Icons.compare_arrows),
                title: Text('Cardio spread - Biking / Running / Swimming'),
                subtitle: Text('110 / 42 / 25 min - three candidates for one endurance activity'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _addDebugScenario(day, _debugCardioSpread);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('Remove workouts written for this day'),
                subtitle: Text('Deletes only what this app wrote - your own workouts stay'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _removeDebugWorkouts(day);
                },
              ),
              Divider(height: 1),
              ..._debugWorkoutTypes.entries.map((e) => ListTile(
                    dense: true,
                    leading: Icon(Icons.fitness_center),
                    title: Text(e.key),
                    subtitle: Text('${e.value.name} - 10:00, 30 min'),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      _addDebugScenario(day, [(type: e.value, hour: 10, minutes: 30)]);
                    },
                  )),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _removeDebugWorkouts(DateTime day) async {
    if (_sensorRepository == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Remove written workouts?'),
        content: Text('Deletes the workouts and heart rate samples this app wrote for '
            '${germanDateFormat.format(day)}. Workouts recorded by your watch or other apps are not touched.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(dialogContext.i18n.cancel)),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text('Remove')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final removed = await _sensorRepository!.deleteDebugWorkouts(day);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(removed ? 'Removed workouts written for this day' : 'Could not remove - check health write permission'),
    ));
    await _tryAutoMatchWorkouts(day);
  }

  Future<void> _addDebugScenario(
    DateTime day,
    List<({HealthWorkoutActivityType type, int hour, int minutes})> scenario,
  ) async {
    if (_sensorRepository == null) return;
    var added = 0;
    for (final step in scenario) {
      final start = DateTime(day.year, day.month, day.day, step.hour, 0);
      final written = await _sensorRepository!.writeDebugWorkout(
        activityType: step.type,
        start: start,
        end: start.add(Duration(minutes: step.minutes)),
      );
      if (written) added++;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(added == scenario.length
          ? 'Wrote $added workout(s) to health data'
          : 'Wrote $added of ${scenario.length} - check health write permission'),
    ));
    // Re-run matching straight away so the result (and the [hkit-match] log)
    // reflects what was just written.
    await _tryAutoMatchWorkouts(day);
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
        if (Platform.isAndroid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.i18n.connectToGoogleHealthConnect),
              action: SnackBarAction(
                label: context.i18n.privacySettings,
                onPressed: () async {
                  try { await _sensorRepository?.installHealthConnect(); } catch (_) {}
                },
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.i18n.connectToAppleHealth),
              action: SnackBarAction(label: context.i18n.privacySettings, onPressed: () => openAppSettings()),
            ),
          );
        }
        return;
      }
      setState(() => _healthKitAuthorized = true);
      final importedUuids = await _loadImportedUuids();
      final allActivities = await _sensorRepository!.fetchWorkoutsForImport(date, context);
      final activities = allActivities.where((a) => !importedUuids.contains(a.uuid)).toList();
      if (!mounted) return;
      final matches = {for (final a in activities) a: _findMatchingPlannedActivity(a, date)};
      final result = await showDialog<(ActivityData, ActivityOverviewDTO?)>(
        context: context,
        builder: (dialogContext) {
          if (activities.isEmpty) {
            return AlertDialog(
              content: Text(context.i18n.noWorkouts),
              actions: [TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: Text(context.i18n.close))],
            );
          }
          return AlertDialog(
            title: Text(context.i18n.workouts),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: activities.map((data) {
                  final matchedActivity = matches[data];
                  final isMatched = matchedActivity != null;
                  return ListTile(
                    title: Text(data.activityType),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.timeFrom} · ${data.duration} ${context.i18n.durationValueMinutes}${data.value > 0 ? ' · ${data.value} bpm' : ''}'),
                        if (isMatched)
                          Text('→ ${getTranslatedText(matchedActivity.name, context)}',
                              style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    isThreeLine: isMatched,
                    onTap: () => Navigator.of(dialogContext).pop((data, matchedActivity)),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: Text(context.i18n.cancel)),
            ],
          );
        },
      );
      if (result == null || !mounted) return;
      final (selectedData, matchedActivity) = result;
      if (matchedActivity != null) {
        _openPlannedActivityWithHealthKit(matchedActivity, selectedData);
      } else {
        _openWorkoutActivity(date, selectedData);
      }
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
    if (uuid.isEmpty) return;
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

  Future<void> _tryAutoMatchWorkouts(DateTime date) async {
    if (_sensorRepository == null || !_healthKitAuthorized) return;
    final workouts = await _sensorRepository!.fetchWorkoutsForImport(date, context);
    if (!mounted) return;
    final importedUuids = await _loadImportedUuids();
    final fresh = workouts.where((w) => !importedUuids.contains(w.uuid)).toList();
    final dateStr = englishDateFormat.format(date);
    final matched = <String, ActivityData>{};
    if (showDebugTools) {
      debugPrint('[hkit-match] === auto-match $dateStr: ${fresh.length} fresh of ${workouts.length} workout(s), '
          '${importedUuids.length} already imported ===');
    }
    if (lastFetchedState != null) {
      for (final activity in lastFetchedState!.activities.where((a) => a.date == dateStr)) {
        if (activity.activityId == null) continue;
        if (activity.rating?.done == true) {
          if (showDebugTools) {
            debugPrint('[hkit-match] skip "${activity.name['DE'] ?? activity.name['EN'] ?? ''}" - already rated done');
          }
          continue;
        }
        final name = activity.name['DE'] ?? activity.name['EN'] ?? '';
        // Of everything that matches, take the closest name and then the closest
        // duration, rather than whichever workout the health store listed first.
        final best = _sensorRepository!.bestMatchingWorkout(
          fresh,
          name,
          predefinedType: activity.activity?.predefinedActivity?.predefinedActivityType,
          activityType: activity.type,
          plannedDurationMinutes: SensorRepository.plannedMinutesOf(activity),
        );
        if (best != null) matched[activity.activityId!] = best;
        if (showDebugTools && best == null) {
          debugPrint('[hkit-match] "$name" left unmatched (type=${activity.type?.value ?? "-"}, '
              'predefined=${activity.activity?.predefinedActivity?.predefinedActivityType?.value ?? "-"})');
        }
      }
    }
    if (mounted) setState(() => _autoMatchedWorkouts = matched);
  }

  ActivityOverviewDTO? _findMatchingPlannedActivity(ActivityData workout, DateTime date) {
    if (lastFetchedState == null || _sensorRepository == null) return null;
    final dateStr = englishDateFormat.format(date);
    // Same ordering as the auto-match, in the other direction: the planned
    // activity whose name fits best, then whose length fits best.
    final scored = <({ActivityOverviewDTO planned, int similarity, int durationDelta})>[];
    for (final planned in lastFetchedState!.activities) {
      if (planned.date != dateStr) continue;
      if (planned.rating?.done == true) continue;
      final name = planned.name['DE'] ?? planned.name['EN'] ?? '';
      final predefinedType = planned.activity?.predefinedActivity?.predefinedActivityType;
      final matches = _sensorRepository!.doesWorkoutMatchActivity(workout, name, predefinedType);
      if (showDebugTools) {
        // Note: this path deliberately omits the activity type, so rules 1-3 never fire here.
        debugPrint('[hkit-match] workout-first ${matches ? "PASS  " : "REJECT"} '
            '${workout.workoutActivityType.name} vs "$name" (type=${planned.type?.value ?? "-"}, '
            'predefined=${predefinedType?.value ?? "-"}) - '
            '${_sensorRepository!.explainMatch(workout, name, predefinedType)}');
      }
      if (!matches) continue;
      scored.add((
        planned: planned,
        similarity: SensorRepository.similarityBucket(_sensorRepository!.workoutNameSimilarity(workout, name)),
        durationDelta: SensorRepository.durationDelta(workout.duration, SensorRepository.plannedMinutesOf(planned)),
      ));
    }
    if (scored.isEmpty) return null;
    scored.sort((a, b) {
      final byName = b.similarity.compareTo(a.similarity);
      return byName != 0 ? byName : a.durationDelta.compareTo(b.durationDelta);
    });
    return scored.first.planned;
  }

  Future<void> _openPlannedActivityWithHealthKit(ActivityOverviewDTO planned, ActivityData hkitData) async {
    final activityName = getTranslatedText(planned.name, context);
    final bpmText = hkitData.value > 0 ? ' · ${hkitData.value} bpm' : '';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(activityName),
        content: Text('${hkitData.timeFrom} · ${hkitData.duration} min$bpmText'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.i18n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.i18n.importWorkout),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    String? endTime;
    if (hkitData.timeFrom.contains(':')) {
      try {
        final parts = hkitData.timeFrom.split(':');
        final startTotal = int.parse(parts[0]) * 60 + int.parse(parts[1]);
        final endTotal = startTotal + hkitData.duration;
        endTime = '${((endTotal ~/ 60) % 24).toString().padLeft(2, '0')}:${(endTotal % 60).toString().padLeft(2, '0')}';
      } catch (_) {}
    }

    final rating = ActivityPatientRatingPostDTO()
      ..done = true
      ..heartrate = hkitData.value > 0 ? hkitData.value : null
      ..durationMinutes = hkitData.duration
      ..date = planned.date!
      ..time = hkitData.timeFrom
      ..endTime = endTime
      ..startLocation = planned.activity?.predefinedActivity?.startLocation
      ..startLocationAddress = planned.activity?.predefinedActivity?.startLocationAddress ?? '';

    activityBloc!.add(UpdateActivityRatingEvent(
      activityType: planned.type!,
      rating: rating,
      id: planned.activityId!,
      date: planned.date!,
      patientId: lastFetchedState!.patient.user!.id!,
      extraActivityName: activityName,
    ));

    _saveImportedUuid(hkitData.uuid);
    if (planned.activityId != null) {
      _storeActivityIdMapping(planned.activityId!, hkitData.uuid);
    }
  }

  void _openWorkoutActivity(DateTime date, ActivityData data) {
    showDialog(
      context: context,
      builder: (context) => ActivityDialog(
        patient: lastFetchedState!.patient.user!,
        activity: ActivityOverviewDTO(
          type: ActivityType.EXTRA,
          date: englishDateFormat.format(date),
          durationMinutes: data.duration,
          rating: ActivityPatientRatingPostDTO(
            done: false,
            durationMinutes: data.duration,
            heartrate: data.value > 0 ? data.value : null,
            time: data.timeFrom,
          ),
        ),
        prefilledName: data.activityType,
        preselectedWorkout: data,
        activeMinutes: lastFetchedState!.activeMinutes,
        rateActivity: true,
        deleteActivity: deleteActivity,
        institution: lastFetchedState!.patient.institution!,
        onSaved: (selectedWorkoutUuid) async {
          // Null when the workout was unpicked in the dialog: nothing was
          // imported, so the workout must stay available. The uuid comes from the
          // dialog rather than from `data` so switching workouts there is honoured.
          if (selectedWorkoutUuid == null || selectedWorkoutUuid.isEmpty) return;
          _pendingHealthKitUuid = selectedWorkoutUuid;
          await _saveImportedUuid(selectedWorkoutUuid);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('healthkit_pending_extra_uuid', selectedWorkoutUuid);
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
            listener: (context, state) async {
              if (state is ExtraActivityCreatedState) {
                String? uuid = _pendingHealthKitUuid;
                if (uuid == null || uuid.isEmpty) {
                  final prefs = await SharedPreferences.getInstance();
                  uuid = prefs.getString('healthkit_pending_extra_uuid');
                }
                if (uuid != null && uuid.isNotEmpty) {
                  await _storeActivityIdMapping(state.activityId, uuid);
                  _pendingHealthKitUuid = null;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('healthkit_pending_extra_uuid');
                }
              }
              if (state is FetchedPatientActivitiesState) {
                lastFetchedState = state;
                if (mounted) setState(() => _autoMatchedWorkouts = {});
                _tryAutoMatchWorkouts(focusedDay ?? DateTime.now());
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
          changeDay: (date) {
            setState(() {
              focusedDay = date;
              _autoMatchedWorkouts = {};
            });
            _tryAutoMatchWorkouts(date);
          },
          focusedDay: focusedDay!,
          currentFormat: calendarFormat,
          changeFormat: (format) => setState(() => calendarFormat = format),
          autoMatchedWorkouts: _autoMatchedWorkouts,
          onTapMatchedActivity: (activity, workout) {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) => ActivityDialog(
                patient: lastFetchedState!.patient.user!,
                activity: activity,
                activeMinutes: lastFetchedState!.activeMinutes,
                rateActivity: true,
                deleteActivity: deleteActivity,
                institution: lastFetchedState!.patient.institution!,
                preselectedWorkout: workout,
              ),
            );
          },
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
              lastFetchedState!.patient.institution!, deleteActivity, onUndoRating: () {
            // Undoing execution must free the imported workout so it can be
            // imported / auto-matched again.
            if (activity.activityId != null) {
              _removeHealthKitUuidForActivity(activity.activityId!);
            }
          });
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
