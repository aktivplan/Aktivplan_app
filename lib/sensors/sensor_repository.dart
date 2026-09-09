import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:apt_api/api.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/debug_tools.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:intl/intl.dart';

class SensorRepository {
  static final _authorizationKey = "googleHealthConnectAppleHealth_authorization";
  static final _authorizationFirstDateKey = "googleHealthConnectAppleHealth_AuthorizationFirstDate";
  static final int chunkDataByHour = 1;
  List<RecordingMethod> recordingMethodsToFilter = [];
  int id = 0;

  SensorRepository() {
    Health().configure();
    Health().getHealthConnectSdkStatus();
  }

  final _mapGermanActivityWithHealthWorkoutActivityType = <String, List<HealthWorkoutActivityType>>{
    "gehen": [HealthWorkoutActivityType.WALKING, HealthWorkoutActivityType.WALKING_TREADMILL],
    "laufen": [HealthWorkoutActivityType.RUNNING, HealthWorkoutActivityType.RUNNING_TREADMILL],
    "wandern": [HealthWorkoutActivityType.HIKING],
    "radfahren": [HealthWorkoutActivityType.BIKING],
    "radergometer": [HealthWorkoutActivityType.BIKING],
    "e-bike": [HealthWorkoutActivityType.BIKING],
    "crosstrainer": [HealthWorkoutActivityType.CROSS_TRAINING],
    "schwimmen": [HealthWorkoutActivityType.SWIMMING, HealthWorkoutActivityType.SWIMMING_OPEN_WATER, HealthWorkoutActivityType.SWIMMING_POOL],
  };

  final _mapPredefinedTypeToHealthWorkoutActivityType = <PredefinedActivityType, List<HealthWorkoutActivityType>>{
    PredefinedActivityType.CYCLING: [HealthWorkoutActivityType.BIKING],
    PredefinedActivityType.E_BIKING: [HealthWorkoutActivityType.BIKING],
    PredefinedActivityType.WALKING: [HealthWorkoutActivityType.WALKING, HealthWorkoutActivityType.WALKING_TREADMILL],
    PredefinedActivityType.FAST_WALKING: [HealthWorkoutActivityType.WALKING, HealthWorkoutActivityType.WALKING_TREADMILL],
    PredefinedActivityType.NORDIC_WALKING: [HealthWorkoutActivityType.WALKING, HealthWorkoutActivityType.WALKING_TREADMILL],
    PredefinedActivityType.HIKING: [HealthWorkoutActivityType.HIKING],
    PredefinedActivityType.RUNNING: [HealthWorkoutActivityType.RUNNING, HealthWorkoutActivityType.RUNNING_TREADMILL],
    PredefinedActivityType.SWIMMING: [HealthWorkoutActivityType.SWIMMING, HealthWorkoutActivityType.SWIMMING_OPEN_WATER, HealthWorkoutActivityType.SWIMMING_POOL],
  };

  List<HealthDataType> get _allHealthDataTypeKeys {
    if (Platform.isIOS)
      return [
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.AUDIOGRAM,
        HealthDataType.BASAL_ENERGY_BURNED,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.BLOOD_OXYGEN,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        HealthDataType.BODY_FAT_PERCENTAGE,
        HealthDataType.BODY_MASS_INDEX,
        HealthDataType.BODY_TEMPERATURE,
        HealthDataType.DIETARY_CARBS_CONSUMED,
        HealthDataType.DIETARY_ENERGY_CONSUMED,
        HealthDataType.DIETARY_FATS_CONSUMED,
        HealthDataType.DIETARY_PROTEIN_CONSUMED,
        HealthDataType.ELECTRODERMAL_ACTIVITY,
        HealthDataType.FORCED_EXPIRATORY_VOLUME,
        HealthDataType.HEART_RATE,
        HealthDataType.HEART_RATE_VARIABILITY_SDNN,
        HealthDataType.HEIGHT,
        HealthDataType.HIGH_HEART_RATE_EVENT,
        HealthDataType.IRREGULAR_HEART_RATE_EVENT,
        HealthDataType.LOW_HEART_RATE_EVENT,
        HealthDataType.RESTING_HEART_RATE,
        HealthDataType.STEPS,
        HealthDataType.WAIST_CIRCUMFERENCE,
        HealthDataType.WALKING_HEART_RATE,
        HealthDataType.WEIGHT,
        HealthDataType.FLIGHTS_CLIMBED,
        HealthDataType.DISTANCE_WALKING_RUNNING,
        HealthDataType.MINDFULNESS,
        HealthDataType.SLEEP_IN_BED,
        HealthDataType.SLEEP_AWAKE,
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.WATER,
        HealthDataType.EXERCISE_TIME,
        HealthDataType.WORKOUT,
        HealthDataType.HEADACHE_NOT_PRESENT,
        HealthDataType.HEADACHE_MILD,
        HealthDataType.HEADACHE_MODERATE,
        HealthDataType.HEADACHE_SEVERE,
        HealthDataType.HEADACHE_UNSPECIFIED,
      ];
    return [
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.HEART_RATE,
      HealthDataType.STEPS,
      HealthDataType.SLEEP_AWAKE,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.WORKOUT,
    ];
  }

  Future<List<HealthDataPoint>> _fetchChunckData(
    DateTime startDate,
    DateTime endDate,
    List<HealthDataType> healthDataTypeList,
  ) async {
    List<HealthDataPoint> result = [];
    var dateFrom = startDate;
    var dateTo = endDate;
    do {
      var tmp = dateFrom.add(Duration(hours: chunkDataByHour));
      dateTo = endDate.compareTo(tmp) > 0 ? tmp : endDate;
      result.addAll(await fetchData(dateFrom, dateTo, healthDataTypeList));
      dateFrom = dateTo.add((Duration(milliseconds: 1)));
    } while (endDate.compareTo(dateTo) != 0);
    return result;
  }

  bool _isWorkoutRelatedToActivity(String activityName, HealthDataPoint workout) {
    final activitySplitedList = activityName.toLowerCase().split(' ');
    bool isRelated = false;
    for (var element in HealthWorkoutActivityType.values) {
      if (activitySplitedList.contains(element.name.toLowerCase())) {
        isRelated = true;
        return isRelated;
      }
    }
    _mapGermanActivityWithHealthWorkoutActivityType.forEach((key, values) {
      if (activitySplitedList.contains(key) && values.contains((workout.value as WorkoutHealthValue).workoutActivityType)) isRelated = true;
    });
    return isRelated;
  }

  Future<ActivityData> _getActivityData(String activityName, HealthDataPoint workout, BuildContext context) async {
    var dateFrom = workout.dateFrom;
    var dateTo = workout.dateTo;
    final List<HealthDataPoint> heartRateDataPointList = await _fetchChunckData(dateFrom, dateTo, [HealthDataType.HEART_RATE]);
    final DateFormat timeFormat = DateFormat("HH:mm");
    var avg = heartRateDataPointList.isNotEmpty
        ? heartRateDataPointList.fold<double>(0.0, (sum, item) {
              var value = (item.value as NumericHealthValue).numericValue;
              return sum + value;
            }) /
            heartRateDataPointList.length
        : 0.0;
    final hkitType = (workout.value as WorkoutHealthValue).workoutActivityType;
    var activityType = hkitType.getTranslatedActivity(context);
    final isRelated = _isWorkoutRelatedToActivity(activityName, workout);
    var dayPeriod = workout.dateFrom.hour < 12
        ? context.i18n.morninig
        : workout.dateFrom.hour < 17
            ? context.i18n.afternoon
            : context.i18n.evening;
    var timeFrom = timeFormat.format(workout.dateFrom);
    var duration = workout.dateTo.difference(workout.dateFrom).inMinutes;
    return ActivityData(id++, activityType, dayPeriod, timeFrom, avg.toInt(), duration, isRelated, workout.uuid, hkitType);
  }

  static final _hypertrophyWorkoutTypes = {
    HealthWorkoutActivityType.WEIGHTLIFTING,
    HealthWorkoutActivityType.TRADITIONAL_STRENGTH_TRAINING,
    HealthWorkoutActivityType.FUNCTIONAL_STRENGTH_TRAINING,
    HealthWorkoutActivityType.STRENGTH_TRAINING,
  };

static final _cardioWorkoutTypes = {
    HealthWorkoutActivityType.WALKING,
    HealthWorkoutActivityType.WALKING_TREADMILL,
    HealthWorkoutActivityType.RUNNING,
    HealthWorkoutActivityType.RUNNING_TREADMILL,
    HealthWorkoutActivityType.HIKING,
    HealthWorkoutActivityType.BIKING,
    HealthWorkoutActivityType.CROSS_TRAINING,
    HealthWorkoutActivityType.SWIMMING,
    HealthWorkoutActivityType.SWIMMING_OPEN_WATER,
    HealthWorkoutActivityType.SWIMMING_POOL,
    HealthWorkoutActivityType.ELLIPTICAL,
    HealthWorkoutActivityType.ROWING,
    HealthWorkoutActivityType.ROWING_MACHINE,
    HealthWorkoutActivityType.STAIR_CLIMBING,
    HealthWorkoutActivityType.STAIR_CLIMBING_MACHINE,
    HealthWorkoutActivityType.STAIRS,
    HealthWorkoutActivityType.JUMP_ROPE,
    HealthWorkoutActivityType.CLIMBING,
    HealthWorkoutActivityType.ROCK_CLIMBING,
    HealthWorkoutActivityType.CROSS_COUNTRY_SKIING,
    HealthWorkoutActivityType.HAND_CYCLING,
    HealthWorkoutActivityType.CARDIO_DANCE,
    HealthWorkoutActivityType.DANCING,
    HealthWorkoutActivityType.SOCIAL_DANCE,
  };

  bool doesWorkoutMatchActivity(ActivityData workout, String activityName, [PredefinedActivityType? predefinedType, ActivityType? activityType]) {
    if (activityType == ActivityType.ENDURANCE) {
      return _cardioWorkoutTypes.contains(workout.workoutActivityType);
    }
    if (activityType == ActivityType.INTERVAL) {
      return workout.workoutActivityType == HealthWorkoutActivityType.HIGH_INTENSITY_INTERVAL_TRAINING;
    }
    if (activityType == ActivityType.STRENGTHENING || activityType == ActivityType.HYPERTROPHY) {
      return _hypertrophyWorkoutTypes.contains(workout.workoutActivityType);
    }
    if (predefinedType != null) {
      final types = _mapPredefinedTypeToHealthWorkoutActivityType[predefinedType];
      if (types != null && types.contains(workout.workoutActivityType)) return true;
    }
    if (activityName.isEmpty) return false;
    final nameWords = activityName.toLowerCase().split(RegExp(r'\s+'));
    for (final entry in _mapGermanActivityWithHealthWorkoutActivityType.entries) {
      if (nameWords.contains(entry.key) && entry.value.contains(workout.workoutActivityType)) {
        return true;
      }
    }
    return false;
  }

  /// Similarity between an activity's name and a workout's label, 0.0 - 1.0.
  ///
  /// An entry in the German keyword map is a deliberate mapping and scores 1.0;
  /// everything else falls back to how much the two labels actually look alike,
  /// so "Nordic Walking" prefers a WALKING workout over a RUNNING one even
  /// though the existing rules accept both.
  double workoutNameSimilarity(ActivityData workout, String activityName) {
    if (activityName.isEmpty) return 0.0;

    final nameWords = activityName.toLowerCase().split(RegExp(r'\s+'));
    for (final entry in _mapGermanActivityWithHealthWorkoutActivityType.entries) {
      if (nameWords.contains(entry.key) && entry.value.contains(workout.workoutActivityType)) return 1.0;
    }

    final name = _normalizeForSimilarity(activityName);
    if (name.isEmpty) return 0.0;

    var best = 0.0;
    // The translated label is what the patient sees; the enum name catches
    // English names typed into an extra activity.
    for (final label in [workout.activityType, workout.workoutActivityType.name.replaceAll('_', ' ')]) {
      final candidate = _normalizeForSimilarity(label);
      if (candidate.isEmpty) continue;
      // One label containing the other ("walking" inside "nordic walking") is a
      // stronger signal than bigram overlap alone reflects.
      if (name.contains(candidate) || candidate.contains(name)) best = max(best, 0.85);
      best = max(best, _diceCoefficient(name, candidate));
    }
    return best;
  }

  /// Of the workouts that already satisfy the matching rules, the one whose name
  /// resembles the activity most closely; ties on name are settled by whichever
  /// duration sits nearest [plannedDurationMinutes]. Null when none match.
  ActivityData? bestMatchingWorkout(
    Iterable<ActivityData> workouts,
    String activityName, {
    PredefinedActivityType? predefinedType,
    ActivityType? activityType,
    int? plannedDurationMinutes,
  }) {
    if (showDebugTools) {
      debugPrint('[hkit-match] activity="$activityName" type=${activityType?.value ?? "-"} '
          'predefined=${predefinedType?.value ?? "-"} plannedMin=${plannedDurationMinutes ?? "-"} '
          'against ${workouts.length} workout(s)');
    }
    final scored = <({ActivityData workout, int similarity, int durationDelta})>[];
    for (final workout in workouts) {
      final matched = doesWorkoutMatchActivity(workout, activityName, predefinedType, activityType);
      if (showDebugTools) {
        final detail = matched
            ? 'similarity=${workoutNameSimilarity(workout, activityName).toStringAsFixed(2)} '
                'durationDelta=${durationDelta(workout.duration, plannedDurationMinutes)}'
            : '';
        debugPrint('[hkit-match]   ${matched ? "PASS  " : "REJECT"} ${workout.workoutActivityType.name} '
            '(${workout.duration}min) - ${explainMatch(workout, activityName, predefinedType, activityType)} $detail');
      }
      if (!matched) continue;
      scored.add((
        workout: workout,
        similarity: similarityBucket(workoutNameSimilarity(workout, activityName)),
        durationDelta: durationDelta(workout.duration, plannedDurationMinutes),
      ));
    }
    if (scored.isEmpty) {
      if (showDebugTools) debugPrint('[hkit-match]   => no match for "$activityName"');
      return null;
    }
    scored.sort((a, b) {
      final byName = b.similarity.compareTo(a.similarity);
      return byName != 0 ? byName : a.durationDelta.compareTo(b.durationDelta);
    });
    if (showDebugTools) {
      debugPrint('[hkit-match]   => chose ${scored.first.workout.workoutActivityType.name} '
          '(${scored.first.workout.duration}min) for "$activityName"');
    }
    return scored.first.workout;
  }

  /// Debug aid: which rule of [doesWorkoutMatchActivity] decided this pair, and
  /// why. Mirrors that function's order exactly - keep the two in step.
  String explainMatch(
    ActivityData workout,
    String activityName, [
    PredefinedActivityType? predefinedType,
    ActivityType? activityType,
  ]) {
    final type = workout.workoutActivityType;
    if (activityType == ActivityType.ENDURANCE) {
      return _cardioWorkoutTypes.contains(type) ? 'rule1 cardio set' : 'rule1 cardio set has no ${type.name}';
    }
    if (activityType == ActivityType.INTERVAL) {
      return type == HealthWorkoutActivityType.HIGH_INTENSITY_INTERVAL_TRAINING ? 'rule2 HIIT' : 'rule2 wants HIIT, got ${type.name}';
    }
    if (activityType == ActivityType.STRENGTHENING || activityType == ActivityType.HYPERTROPHY) {
      return _hypertrophyWorkoutTypes.contains(type) ? 'rule3 strength set' : 'rule3 strength set has no ${type.name}';
    }
    final buffer = StringBuffer();
    if (predefinedType != null) {
      final allowed = _mapPredefinedTypeToHealthWorkoutActivityType[predefinedType];
      if (allowed == null) {
        buffer.write('rule4 no map entry for ${predefinedType.value}; ');
      } else if (allowed.contains(type)) {
        return 'rule4 predefined ${predefinedType.value}';
      } else {
        buffer.write('rule4 ${predefinedType.value} allows ${allowed.map((t) => t.name).join("/")}, got ${type.name}; ');
      }
    } else {
      buffer.write('rule4 skipped (no predefined type); ');
    }
    if (activityName.isEmpty) return '${buffer}rule5 name is empty';
    final words = activityName.toLowerCase().split(RegExp(r'\s+'));
    final keywords = _mapGermanActivityWithHealthWorkoutActivityType.entries.where((e) => words.contains(e.key)).toList();
    if (keywords.isEmpty) {
      return '${buffer}rule5 no keyword among [${words.join(", ")}]';
    }
    final hit = keywords.where((e) => e.value.contains(type)).map((e) => e.key).toList();
    if (hit.isNotEmpty) return '${buffer}rule5 keyword "${hit.first}"';
    return '${buffer}rule5 keyword(s) ${keywords.map((e) => '"${e.key}"->${e.value.map((t) => t.name).join("/")}').join(", ")} do not cover ${type.name}';
  }

  /// Similarity rounded into 0.05-wide buckets. Comparing buckets rather than
  /// raw doubles keeps the ordering a proper total order and stops
  /// floating-point noise from deciding a match the duration should settle.
  static int similarityBucket(double similarity) => (similarity * 20).round();

  /// Absolute gap in minutes, or a value that sorts last when nothing is planned.
  static int durationDelta(int workoutMinutes, int? plannedMinutes) =>
      plannedMinutes == null || plannedMinutes <= 0 ? 1 << 30 : (workoutMinutes - plannedMinutes).abs();

  /// The activity's intended length: an explicit planned duration, else the
  /// entered duration, else the gap between start and end time (wrapping at
  /// midnight). Null when the activity says nothing about its length.
  static int? plannedMinutesOf(ActivityOverviewDTO activity) {
    final planned = activity.plannedDurationMinutes ?? activity.durationMinutes;
    if (planned != null && planned > 0) return planned;
    final start = _minutesOfDay(activity.time);
    final end = _minutesOfDay(activity.endTime);
    if (start == null || end == null) return null;
    final diff = end - start;
    return diff >= 0 ? diff : diff + 1440;
  }

  static int? _minutesOfDay(String? time) {
    if (time == null) return null;
    final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(time.trim());
    if (match == null) return null;
    final hours = int.parse(match.group(1)!);
    final minutes = int.parse(match.group(2)!);
    if (hours > 23 || minutes > 59) return null;
    return hours * 60 + minutes;
  }

  static String _normalizeForSimilarity(String value) => value
      .toLowerCase()
      .replaceAll('ä', 'a')
      .replaceAll('ö', 'o')
      .replaceAll('ü', 'u')
      .replaceAll('ß', 'ss')
      .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
      .trim();

  /// Sorensen-Dice coefficient over character bigrams: tolerant of the endings
  /// and compounding German names pick up ("Schwimmen" vs "Schwimmtraining").
  static double _diceCoefficient(String a, String b) {
    if (a == b) return 1.0;
    if (a.length < 2 || b.length < 2) return 0.0;
    final bCounts = <String, int>{};
    for (var i = 0; i < b.length - 1; i++) {
      final gram = b.substring(i, i + 2);
      bCounts[gram] = (bCounts[gram] ?? 0) + 1;
    }
    var hits = 0;
    for (var i = 0; i < a.length - 1; i++) {
      final gram = a.substring(i, i + 2);
      final remaining = bCounts[gram] ?? 0;
      if (remaining > 0) {
        bCounts[gram] = remaining - 1;
        hits++;
      }
    }
    return (2 * hits) / ((a.length - 1) + (b.length - 1));
  }

  Future<void> _setAuthorizationKey(bool isAuthorize) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_authorizationKey, isAuthorize);
  }

  Future<List<HealthDataPoint>> fetchData(
    DateTime fromDate,
    DateTime toDate,
    List<HealthDataType> healthDataTypeList,
  ) async {
    List<HealthDataPoint> healthData = List.empty();
    final List<HealthDataAccess> permissions = [];
    healthDataTypeList.forEach((x) => permissions.add(HealthDataAccess.READ_WRITE));
    try {
      healthData = await Health().getHealthDataFromTypes(
          types: healthDataTypeList, startTime: fromDate, endTime: toDate, recordingMethodsToFilter: recordingMethodsToFilter);
      healthData.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
    return healthData;
  }

  Future<List<ActivityData>> fetchActivityDataList(DateTime activityDate, String activityName, BuildContext context) async {
    final startDate = DateTime(activityDate.year, activityDate.month, activityDate.day, 0, 0, 0);
    final endDate = DateTime(activityDate.year, activityDate.month, activityDate.day, 23, 59, 59);
    final List<ActivityData> result = [];
    if (!await isAuthorizedToGoogleHealthConnectAppleHealth()) return result;
    final List<HealthDataPoint> workoutList = await fetchData(startDate, endDate, [HealthDataType.WORKOUT]);
    if (workoutList.length < 1) return result;

    for (var workout in workoutList) {
      result.add(await _getActivityData(activityName, workout, context));
    }

    return result;
  }

  Future<bool> isAuthorizedToFetchData() async {
    return await isAuthorizedToGoogleHealthConnectAppleHealth() &&
        await isGrantedActivityRecognitionPermission() &&
        await isGrantedLocationPermission();
  }

  Future<bool> connectToGoogleHealthConnectAppleHealth(List<HealthDataType> healthDataTypeList) async {
    final healthConnectSdkStatus = await Health().getHealthConnectSdkStatus();
    if (healthConnectSdkStatus != HealthConnectSdkStatus.sdkAvailable) {
      await Health().installHealthConnect();
    }

    final List<HealthDataAccess> permissions = [];
    healthDataTypeList.forEach((x) => permissions.add(HealthDataAccess.READ));
    // bool? hasPermissions = await Health().hasPermissions(healthDataTypeList, permissions: permissions);

    bool isAuthorize = false;
    try {
      isAuthorize = await Health().requestAuthorization(healthDataTypeList, permissions: permissions);
    } catch (error) {
      debugPrint("Exception in authorize: $error");
    }
    await _setAuthorizationKey(isAuthorize);
    print("request authorization: ${isAuthorize.toString()}");
    if (!isAuthorize) return false;
    _setAuthorizationFirstDate();

    // If we are trying to read Step Count, Workout, Sleep or other data that requires
    // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
    // This requires a special request authorization call.
    //
    // The location permission is requested for Workouts using the Distance information.
    final activityRecognitionPermissionStatus = await requestActivityRecognitionPermission();
    final locationPermissionStatus = await requestLocationPermission();
    return isAuthorize && activityRecognitionPermissionStatus && locationPermissionStatus;
  }

  Future<bool> requestHealthKitAuthorization() async {
    if (Platform.isAndroid) {
      final sdkStatus = await Health().getHealthConnectSdkStatus();
      if (sdkStatus == HealthConnectSdkStatus.sdkUnavailable) {
        // Device/Android version too old — do nothing, caller shows a message.
        return false;
      }
      if (sdkStatus == HealthConnectSdkStatus.sdkUnavailableProviderUpdateRequired) {
        await Health().installHealthConnect();
        return false;
      }
    }
    final types = [HealthDataType.HEART_RATE, HealthDataType.WORKOUT];
    final permissions = [HealthDataAccess.READ, HealthDataAccess.READ];
    bool isAuthorize = false;
    try {
      isAuthorize = await Health().requestAuthorization(types, permissions: permissions);
    } catch (error) {
      debugPrint("Exception in requestHealthKitAuthorization: $error");
    }
    // Launcher may fail on older Health Connect versions — check if permissions
    // were already granted through the Health Connect app directly.
    if (!isAuthorize) {
      try {
        isAuthorize = await Health().hasPermissions(types, permissions: permissions) ?? false;
      } catch (_) {}
    }
    await _setAuthorizationKey(isAuthorize);
    if (isAuthorize) _setAuthorizationFirstDate();
    return isAuthorize;
  }

  Future<void> installHealthConnect() async {
    await Health().installHealthConnect();
  }

  /// DEBUG ONLY: writes a sample workout together with a few heart rate samples
  /// to Apple Health / Google Health Connect so the import flow can be tested
  /// without recording a real workout.
  Future<bool> writeDebugWorkout({
    required HealthWorkoutActivityType activityType,
    required DateTime start,
    required DateTime end,
    int heartRate = 120,
  }) async {
    final types = [HealthDataType.WORKOUT, HealthDataType.HEART_RATE];
    final permissions = [HealthDataAccess.READ_WRITE, HealthDataAccess.READ_WRITE];
    bool authorized = false;
    try {
      authorized = await Health().requestAuthorization(types, permissions: permissions);
    } catch (error) {
      debugPrint("Exception in writeDebugWorkout authorization: $error");
    }
    if (!authorized) return false;

    bool success = await Health().writeWorkoutData(
      activityType: activityType,
      start: start,
      end: end,
      totalEnergyBurned: 200,
      title: 'Debug ${activityType.name}',
    );

    // Add heart rate samples inside the workout window so the import can
    // compute an average heart rate.
    final int minutes = end.difference(start).inMinutes;
    for (int i = 0; i <= minutes; i += 5) {
      final DateTime sampleTime = start.add(Duration(minutes: i));
      if (sampleTime.isAfter(end)) break;
      final bool written = await Health().writeHealthData(
        value: heartRate.toDouble(),
        type: HealthDataType.HEART_RATE,
        startTime: sampleTime,
        endTime: sampleTime,
        recordingMethod: RecordingMethod.manual,
      );
      success = success && written;
    }
    return success;
  }

  /// DEBUG ONLY: removes the workouts and heart rate samples written for [day].
  ///
  /// Both HealthKit and Health Connect scope deletion to records the calling app
  /// authored, so a tester's own recorded workouts are not affected - but that is
  /// a platform guarantee worth confirming on device before handing this to
  /// anyone testing on a phone that holds real health data.
  Future<bool> deleteDebugWorkouts(DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = DateTime(day.year, day.month, day.day, 23, 59, 59);
    try {
      final workoutsRemoved = await Health().delete(type: HealthDataType.WORKOUT, startTime: start, endTime: end);
      final heartRateRemoved = await Health().delete(type: HealthDataType.HEART_RATE, startTime: start, endTime: end);
      return workoutsRemoved && heartRateRemoved;
    } catch (error) {
      debugPrint("Exception in deleteDebugWorkouts: $error");
      return false;
    }
  }

  Future<List<ActivityData>> fetchWorkoutsForImport(DateTime date, BuildContext context) async {
    if (!await isAuthorizedToGoogleHealthConnectAppleHealth()) return [];
    final startDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
    final List<HealthDataPoint> workoutList = await fetchData(startDate, endDate, [HealthDataType.WORKOUT]);
    final List<ActivityData> result = [];
    for (var workout in workoutList) {
      result.add(await _getActivityData('', workout, context));
    }
    if (showDebugTools) {
      debugPrint('[hkit-match] fetched ${result.length} workout(s) for ${englishDateFormat.format(date)}');
      for (final r in result) {
        debugPrint('[hkit-match]   type=${r.workoutActivityType.name} label="${r.activityType}" ${r.timeFrom} ${r.duration}min uuid=${r.uuid}');
      }
    }
    return result;
  }

  Future<void> _setAuthorizationFirstDate() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains(_authorizationFirstDateKey)) return;
    prefs.setString(_authorizationFirstDateKey, englishDateFormat.format(DateTime.now()));
  }

  Future<void> revokePermissions() async {
    await _setAuthorizationKey(false);
    await Health().revokePermissions();
  }

  Future<bool> isAuthorizedToGoogleHealthConnectAppleHealth() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains(_authorizationKey)) return prefs.getBool(_authorizationKey)!;
    return false;
  }

  Future<bool> requestActivityRecognitionPermission() async {
    if (Platform.isIOS) return await Permission.sensors.request().isGranted;
    return await Permission.activityRecognition.request().isGranted;
  }

  Future<bool> isGrantedActivityRecognitionPermission() async {
    return Platform.isIOS ? await Permission.sensors.status.isGranted : await Permission.activityRecognition.status.isGranted;
  }

  Future<bool> requestLocationPermission() async {
    return await Permission.location.request().isGranted;
  }

  Future<bool> isGrantedLocationPermission() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }
}

class ActivityData {
  final int id;
  final String activityType;
  final String dayPeriod;
  final String timeFrom;
  final int value;
  final int duration;
  final bool isRelatedWorkout;
  final String uuid;
  final HealthWorkoutActivityType workoutActivityType;
  ActivityData(this.id, this.activityType, this.dayPeriod, this.timeFrom, this.value, this.duration, this.isRelatedWorkout, this.uuid, this.workoutActivityType);
}
