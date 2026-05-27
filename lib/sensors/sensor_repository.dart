import 'dart:async';
import 'dart:io';
import 'package:aptapp/utils/constants.dart';
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
    "crosstrainer": [HealthWorkoutActivityType.CROSS_TRAINING],
    "schwimmen": [HealthWorkoutActivityType.SWIMMING, HealthWorkoutActivityType.SWIMMING_OPEN_WATER, HealthWorkoutActivityType.SWIMMING_POOL],
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
    var activityType = (workout.value as WorkoutHealthValue).workoutActivityType.getTranslatedActivity(context);
    final isRelated = _isWorkoutRelatedToActivity(activityName, workout);
    var dayPeriod = workout.dateFrom.hour < 12
        ? context.i18n.morninig
        : workout.dateFrom.hour < 17
            ? context.i18n.afternoon
            : context.i18n.evening;
    var timeFrom = timeFormat.format(workout.dateFrom);
    var duration = workout.dateTo.difference(workout.dateFrom).inMinutes;
    return ActivityData(id++, activityType, dayPeriod, timeFrom, avg.toInt(), duration, isRelated, workout.uuid);
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
    if (!await isAuthorizedToFetchData()) return result;
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
    final types = [HealthDataType.HEART_RATE, HealthDataType.WORKOUT];
    final permissions = [HealthDataAccess.READ, HealthDataAccess.READ];
    bool isAuthorize = false;
    try {
      isAuthorize = await Health().requestAuthorization(types, permissions: permissions);
    } catch (error) {
      debugPrint("Exception in requestHealthKitAuthorization: $error");
    }
    await _setAuthorizationKey(isAuthorize);
    if (isAuthorize) _setAuthorizationFirstDate();
    return isAuthorize;
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
  ActivityData(this.id, this.activityType, this.dayPeriod, this.timeFrom, this.value, this.duration, this.isRelatedWorkout, this.uuid);
}
