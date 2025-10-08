// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Activity {
  /// Returns a new [Activity] instance.
  Activity({
    this.plannedBy,
    this.patientId,
    this.startDate,
    this.endDate,
    this.time,
    this.workout,
    this.enduranceExercise,
    this.intervalExercise,
    this.strengtheningExercise,
    this.otherExercise,
    this.task,
    this.appointment,
    this.trainingPlan,
    this.days = const [],
    this.repeats,
    this.repeatCount,
    this.name = const {},
    this.youTubeUrl = const {},
    this.datesToHide = const [],
    this.id,
    this.type,
    this.patientRatings = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? plannedBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? patientId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? startDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? time;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  WorkoutPostDTO? workout;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EnduranceExercisePostDTO? enduranceExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IntervalExercisePostDTO? intervalExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  StrengtheningExercisePostDTO? strengtheningExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  OtherExercisePostDTO? otherExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TaskPostDTO? task;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AppointmentPostDTO? appointment;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TrainingPlanPostDTO? trainingPlan;

  List<DayOfWeek> days;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ActivityRepeat? repeats;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? repeatCount;

  Map<String, String> name;

  Map<String, String> youTubeUrl;

  List<String> datesToHide;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ActivityType? type;

  List<ActivityPatientRating> patientRatings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Activity &&
          other.plannedBy == plannedBy &&
          other.patientId == patientId &&
          other.startDate == startDate &&
          other.endDate == endDate &&
          other.time == time &&
          other.workout == workout &&
          other.enduranceExercise == enduranceExercise &&
          other.intervalExercise == intervalExercise &&
          other.strengtheningExercise == strengtheningExercise &&
          other.otherExercise == otherExercise &&
          other.task == task &&
          other.appointment == appointment &&
          other.trainingPlan == trainingPlan &&
          _deepEquality.equals(other.days, days) &&
          other.repeats == repeats &&
          other.repeatCount == repeatCount &&
          _deepEquality.equals(other.name, name) &&
          _deepEquality.equals(other.youTubeUrl, youTubeUrl) &&
          _deepEquality.equals(other.datesToHide, datesToHide) &&
          other.id == id &&
          other.type == type &&
          _deepEquality.equals(other.patientRatings, patientRatings);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (plannedBy == null ? 0 : plannedBy!.hashCode) +
      (patientId == null ? 0 : patientId!.hashCode) +
      (startDate == null ? 0 : startDate!.hashCode) +
      (endDate == null ? 0 : endDate!.hashCode) +
      (time == null ? 0 : time!.hashCode) +
      (workout == null ? 0 : workout!.hashCode) +
      (enduranceExercise == null ? 0 : enduranceExercise!.hashCode) +
      (intervalExercise == null ? 0 : intervalExercise!.hashCode) +
      (strengtheningExercise == null ? 0 : strengtheningExercise!.hashCode) +
      (otherExercise == null ? 0 : otherExercise!.hashCode) +
      (task == null ? 0 : task!.hashCode) +
      (appointment == null ? 0 : appointment!.hashCode) +
      (trainingPlan == null ? 0 : trainingPlan!.hashCode) +
      (days.hashCode) +
      (repeats == null ? 0 : repeats!.hashCode) +
      (repeatCount == null ? 0 : repeatCount!.hashCode) +
      (name.hashCode) +
      (youTubeUrl.hashCode) +
      (datesToHide.hashCode) +
      (id == null ? 0 : id!.hashCode) +
      (type == null ? 0 : type!.hashCode) +
      (patientRatings.hashCode);

  @override
  String toString() =>
      'Activity[plannedBy=$plannedBy, patientId=$patientId, startDate=$startDate, endDate=$endDate, time=$time, workout=$workout, enduranceExercise=$enduranceExercise, intervalExercise=$intervalExercise, strengtheningExercise=$strengtheningExercise, otherExercise=$otherExercise, task=$task, appointment=$appointment, trainingPlan=$trainingPlan, days=$days, repeats=$repeats, repeatCount=$repeatCount, name=$name, youTubeUrl=$youTubeUrl, datesToHide=$datesToHide, id=$id, type=$type, patientRatings=$patientRatings]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.plannedBy != null) {
      json[r'plannedBy'] = this.plannedBy;
    } else {
      json[r'plannedBy'] = null;
    }
    if (this.patientId != null) {
      json[r'patientId'] = this.patientId;
    } else {
      json[r'patientId'] = null;
    }
    if (this.startDate != null) {
      json[r'startDate'] = this.startDate;
    } else {
      json[r'startDate'] = null;
    }
    if (this.endDate != null) {
      json[r'endDate'] = this.endDate;
    } else {
      json[r'endDate'] = null;
    }
    if (this.time != null) {
      json[r'time'] = this.time;
    } else {
      json[r'time'] = null;
    }
    if (this.workout != null) {
      json[r'workout'] = this.workout;
    } else {
      json[r'workout'] = null;
    }
    if (this.enduranceExercise != null) {
      json[r'enduranceExercise'] = this.enduranceExercise;
    } else {
      json[r'enduranceExercise'] = null;
    }
    if (this.intervalExercise != null) {
      json[r'intervalExercise'] = this.intervalExercise;
    } else {
      json[r'intervalExercise'] = null;
    }
    if (this.strengtheningExercise != null) {
      json[r'strengtheningExercise'] = this.strengtheningExercise;
    } else {
      json[r'strengtheningExercise'] = null;
    }
    if (this.otherExercise != null) {
      json[r'otherExercise'] = this.otherExercise;
    } else {
      json[r'otherExercise'] = null;
    }
    if (this.task != null) {
      json[r'task'] = this.task;
    } else {
      json[r'task'] = null;
    }
    if (this.appointment != null) {
      json[r'appointment'] = this.appointment;
    } else {
      json[r'appointment'] = null;
    }
    if (this.trainingPlan != null) {
      json[r'trainingPlan'] = this.trainingPlan;
    } else {
      json[r'trainingPlan'] = null;
    }
    json[r'days'] = this.days;
    if (this.repeats != null) {
      json[r'repeats'] = this.repeats;
    } else {
      json[r'repeats'] = null;
    }
    if (this.repeatCount != null) {
      json[r'repeatCount'] = this.repeatCount;
    } else {
      json[r'repeatCount'] = null;
    }
    json[r'name'] = this.name;
    json[r'youTubeUrl'] = this.youTubeUrl;
    json[r'datesToHide'] = this.datesToHide;
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    json[r'patientRatings'] = this.patientRatings;
    return json;
  }

  /// Returns a new [Activity] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Activity? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Activity[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Activity[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Activity(
        plannedBy: mapValueOfType<String>(json, r'plannedBy'),
        patientId: mapValueOfType<String>(json, r'patientId'),
        startDate: mapValueOfType<String>(json, r'startDate'),
        endDate: mapValueOfType<String>(json, r'endDate'),
        time: mapValueOfType<String>(json, r'time'),
        workout: WorkoutPostDTO.fromJson(json[r'workout']),
        enduranceExercise:
            EnduranceExercisePostDTO.fromJson(json[r'enduranceExercise']),
        intervalExercise:
            IntervalExercisePostDTO.fromJson(json[r'intervalExercise']),
        strengtheningExercise: StrengtheningExercisePostDTO.fromJson(
            json[r'strengtheningExercise']),
        otherExercise: OtherExercisePostDTO.fromJson(json[r'otherExercise']),
        task: TaskPostDTO.fromJson(json[r'task']),
        appointment: AppointmentPostDTO.fromJson(json[r'appointment']),
        trainingPlan: TrainingPlanPostDTO.fromJson(json[r'trainingPlan']),
        days: DayOfWeek.listFromJson(json[r'days']),
        repeats: ActivityRepeat.fromJson(json[r'repeats']),
        repeatCount: mapValueOfType<int>(json, r'repeatCount'),
        name: mapCastOfType<String, String>(json, r'name') ?? const {},
        youTubeUrl:
            mapCastOfType<String, String>(json, r'youTubeUrl') ?? const {},
        datesToHide: json[r'datesToHide'] is Iterable
            ? (json[r'datesToHide'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
        id: mapValueOfType<String>(json, r'id'),
        type: ActivityType.fromJson(json[r'type']),
        patientRatings:
            ActivityPatientRating.listFromJson(json[r'patientRatings']),
      );
    }
    return null;
  }

  static List<Activity> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Activity>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Activity.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Activity> mapFromJson(dynamic json) {
    final map = <String, Activity>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Activity.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Activity-objects as value to a dart map
  static Map<String, List<Activity>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Activity>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Activity.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}
