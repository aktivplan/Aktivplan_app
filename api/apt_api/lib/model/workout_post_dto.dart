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

class WorkoutPostDTO {
  /// Returns a new [WorkoutPostDTO] instance.
  WorkoutPostDTO({
    this.name = const {},
    this.notes = const {},
    this.exercises = const [],
    this.youTubeUrl = const {},
    this.exerciseDurationSeconds,
  });

  Map<String, String> name;

  Map<String, String> notes;

  List<StrengtheningExercisePostDTO> exercises;

  Map<String, String> youTubeUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? exerciseDurationSeconds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutPostDTO &&
          _deepEquality.equals(other.name, name) &&
          _deepEquality.equals(other.notes, notes) &&
          _deepEquality.equals(other.exercises, exercises) &&
          _deepEquality.equals(other.youTubeUrl, youTubeUrl) &&
          other.exerciseDurationSeconds == exerciseDurationSeconds;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name.hashCode) +
      (notes.hashCode) +
      (exercises.hashCode) +
      (youTubeUrl.hashCode) +
      (exerciseDurationSeconds == null ? 0 : exerciseDurationSeconds!.hashCode);

  @override
  String toString() =>
      'WorkoutPostDTO[name=$name, notes=$notes, exercises=$exercises, youTubeUrl=$youTubeUrl, exerciseDurationSeconds=$exerciseDurationSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'name'] = this.name;
    json[r'notes'] = this.notes;
    json[r'exercises'] = this.exercises;
    json[r'youTubeUrl'] = this.youTubeUrl;
    if (this.exerciseDurationSeconds != null) {
      json[r'exerciseDurationSeconds'] = this.exerciseDurationSeconds;
    } else {
      json[r'exerciseDurationSeconds'] = null;
    }
    return json;
  }

  /// Returns a new [WorkoutPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WorkoutPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "WorkoutPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "WorkoutPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WorkoutPostDTO(
        name: mapCastOfType<String, String>(json, r'name') ?? const {},
        notes: mapCastOfType<String, String>(json, r'notes') ?? const {},
        exercises:
            StrengtheningExercisePostDTO.listFromJson(json[r'exercises']),
        youTubeUrl:
            mapCastOfType<String, String>(json, r'youTubeUrl') ?? const {},
        exerciseDurationSeconds:
            mapValueOfType<int>(json, r'exerciseDurationSeconds'),
      );
    }
    return null;
  }

  static List<WorkoutPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WorkoutPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WorkoutPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WorkoutPostDTO> mapFromJson(dynamic json) {
    final map = <String, WorkoutPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WorkoutPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WorkoutPostDTO-objects as value to a dart map
  static Map<String, List<WorkoutPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<WorkoutPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WorkoutPostDTO.listFromJson(
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
