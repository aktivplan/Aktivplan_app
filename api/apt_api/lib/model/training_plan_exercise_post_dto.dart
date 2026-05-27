//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TrainingPlanExercisePostDTO {
  /// Returns a new [TrainingPlanExercisePostDTO] instance.
  TrainingPlanExercisePostDTO({
    this.type,
    this.enduranceExercise,
    this.intervalExercise,
    this.strengtheningExercise,
    this.otherExercise,
    this.workout,
    this.appointment,
    this.task,
    this.days = const [],
    this.time,
    this.repeats,
    this.repeatCount,
    this.startingWeek,
    this.datesToHide = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ActivityType? type;

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
  WorkoutPostDTO? workout;

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
  TaskPostDTO? task;

  List<DayOfWeek> days;

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
  ActivityRepeat? repeats;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? repeatCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? startingWeek;

  List<String> datesToHide;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingPlanExercisePostDTO &&
          other.type == type &&
          other.enduranceExercise == enduranceExercise &&
          other.intervalExercise == intervalExercise &&
          other.strengtheningExercise == strengtheningExercise &&
          other.otherExercise == otherExercise &&
          other.workout == workout &&
          other.appointment == appointment &&
          other.task == task &&
          _deepEquality.equals(other.days, days) &&
          other.time == time &&
          other.repeats == repeats &&
          other.repeatCount == repeatCount &&
          other.startingWeek == startingWeek &&
          _deepEquality.equals(other.datesToHide, datesToHide);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (type == null ? 0 : type!.hashCode) +
      (enduranceExercise == null ? 0 : enduranceExercise!.hashCode) +
      (intervalExercise == null ? 0 : intervalExercise!.hashCode) +
      (strengtheningExercise == null ? 0 : strengtheningExercise!.hashCode) +
      (otherExercise == null ? 0 : otherExercise!.hashCode) +
      (workout == null ? 0 : workout!.hashCode) +
      (appointment == null ? 0 : appointment!.hashCode) +
      (task == null ? 0 : task!.hashCode) +
      (days.hashCode) +
      (time == null ? 0 : time!.hashCode) +
      (repeats == null ? 0 : repeats!.hashCode) +
      (repeatCount == null ? 0 : repeatCount!.hashCode) +
      (startingWeek == null ? 0 : startingWeek!.hashCode) +
      (datesToHide.hashCode);

  @override
  String toString() =>
      'TrainingPlanExercisePostDTO[type=$type, enduranceExercise=$enduranceExercise, intervalExercise=$intervalExercise, strengtheningExercise=$strengtheningExercise, otherExercise=$otherExercise, workout=$workout, appointment=$appointment, task=$task, days=$days, time=$time, repeats=$repeats, repeatCount=$repeatCount, startingWeek=$startingWeek, datesToHide=$datesToHide]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
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
    if (this.workout != null) {
      json[r'workout'] = this.workout;
    } else {
      json[r'workout'] = null;
    }
    if (this.appointment != null) {
      json[r'appointment'] = this.appointment;
    } else {
      json[r'appointment'] = null;
    }
    if (this.task != null) {
      json[r'task'] = this.task;
    } else {
      json[r'task'] = null;
    }
    json[r'days'] = this.days;
    if (this.time != null) {
      json[r'time'] = this.time;
    } else {
      json[r'time'] = null;
    }
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
    if (this.startingWeek != null) {
      json[r'startingWeek'] = this.startingWeek;
    } else {
      json[r'startingWeek'] = null;
    }
    json[r'datesToHide'] = this.datesToHide;
    return json;
  }

  /// Returns a new [TrainingPlanExercisePostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TrainingPlanExercisePostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "TrainingPlanExercisePostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "TrainingPlanExercisePostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TrainingPlanExercisePostDTO(
        type: ActivityType.fromJson(json[r'type']),
        enduranceExercise:
            EnduranceExercisePostDTO.fromJson(json[r'enduranceExercise']),
        intervalExercise:
            IntervalExercisePostDTO.fromJson(json[r'intervalExercise']),
        strengtheningExercise: StrengtheningExercisePostDTO.fromJson(
            json[r'strengtheningExercise']),
        otherExercise: OtherExercisePostDTO.fromJson(json[r'otherExercise']),
        workout: WorkoutPostDTO.fromJson(json[r'workout']),
        appointment: AppointmentPostDTO.fromJson(json[r'appointment']),
        task: TaskPostDTO.fromJson(json[r'task']),
        days: DayOfWeek.listFromJson(json[r'days']),
        time: mapValueOfType<String>(json, r'time'),
        repeats: ActivityRepeat.fromJson(json[r'repeats']),
        repeatCount: mapValueOfType<int>(json, r'repeatCount'),
        startingWeek: mapValueOfType<int>(json, r'startingWeek'),
        datesToHide: json[r'datesToHide'] is Iterable
            ? (json[r'datesToHide'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<TrainingPlanExercisePostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TrainingPlanExercisePostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TrainingPlanExercisePostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TrainingPlanExercisePostDTO> mapFromJson(dynamic json) {
    final map = <String, TrainingPlanExercisePostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TrainingPlanExercisePostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TrainingPlanExercisePostDTO-objects as value to a dart map
  static Map<String, List<TrainingPlanExercisePostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<TrainingPlanExercisePostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TrainingPlanExercisePostDTO.listFromJson(
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
