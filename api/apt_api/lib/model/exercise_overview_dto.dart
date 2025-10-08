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

class ExerciseOverviewDTO {
  /// Returns a new [ExerciseOverviewDTO] instance.
  ExerciseOverviewDTO({
    this.type,
    this.enduranceExercise,
    this.intervalExercise,
    this.strengtheningExercise,
    this.otherExercise,
    this.task,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ExerciseType? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EnduranceExercise? enduranceExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IntervalExercise? intervalExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  StrengtheningExercise? strengtheningExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  OtherExercise? otherExercise;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Task? task;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseOverviewDTO &&
          other.type == type &&
          other.enduranceExercise == enduranceExercise &&
          other.intervalExercise == intervalExercise &&
          other.strengtheningExercise == strengtheningExercise &&
          other.otherExercise == otherExercise &&
          other.task == task;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (type == null ? 0 : type!.hashCode) +
      (enduranceExercise == null ? 0 : enduranceExercise!.hashCode) +
      (intervalExercise == null ? 0 : intervalExercise!.hashCode) +
      (strengtheningExercise == null ? 0 : strengtheningExercise!.hashCode) +
      (otherExercise == null ? 0 : otherExercise!.hashCode) +
      (task == null ? 0 : task!.hashCode);

  @override
  String toString() =>
      'ExerciseOverviewDTO[type=$type, enduranceExercise=$enduranceExercise, intervalExercise=$intervalExercise, strengtheningExercise=$strengtheningExercise, otherExercise=$otherExercise, task=$task]';

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
    if (this.task != null) {
      json[r'task'] = this.task;
    } else {
      json[r'task'] = null;
    }
    return json;
  }

  /// Returns a new [ExerciseOverviewDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExerciseOverviewDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ExerciseOverviewDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ExerciseOverviewDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExerciseOverviewDTO(
        type: ExerciseType.fromJson(json[r'type']),
        enduranceExercise:
            EnduranceExercise.fromJson(json[r'enduranceExercise']),
        intervalExercise: IntervalExercise.fromJson(json[r'intervalExercise']),
        strengtheningExercise:
            StrengtheningExercise.fromJson(json[r'strengtheningExercise']),
        otherExercise: OtherExercise.fromJson(json[r'otherExercise']),
        task: Task.fromJson(json[r'task']),
      );
    }
    return null;
  }

  static List<ExerciseOverviewDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ExerciseOverviewDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExerciseOverviewDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExerciseOverviewDTO> mapFromJson(dynamic json) {
    final map = <String, ExerciseOverviewDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExerciseOverviewDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExerciseOverviewDTO-objects as value to a dart map
  static Map<String, List<ExerciseOverviewDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ExerciseOverviewDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExerciseOverviewDTO.listFromJson(
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
