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

class EnduranceExercisePostDTO {
  /// Returns a new [EnduranceExercisePostDTO] instance.
  EnduranceExercisePostDTO({
    this.hint = const {},
    this.name = const {},
    this.youTubeUrl = const {},
    this.type,
    this.exerciseIntensityPercentageStart,
    this.exerciseIntensityPercentageEnd,
    this.exerciseTrainingHeartRateLowerLimit,
    this.exerciseTrainingHeartRateUpperLimit,
    this.exerciseDurationSeconds,
  });

  Map<String, String> hint;

  Map<String, String> name;

  Map<String, String> youTubeUrl;

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
  int? exerciseIntensityPercentageStart;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? exerciseIntensityPercentageEnd;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? exerciseTrainingHeartRateLowerLimit;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? exerciseTrainingHeartRateUpperLimit;

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
      other is EnduranceExercisePostDTO &&
          _deepEquality.equals(other.hint, hint) &&
          _deepEquality.equals(other.name, name) &&
          _deepEquality.equals(other.youTubeUrl, youTubeUrl) &&
          other.type == type &&
          other.exerciseIntensityPercentageStart ==
              exerciseIntensityPercentageStart &&
          other.exerciseIntensityPercentageEnd ==
              exerciseIntensityPercentageEnd &&
          other.exerciseTrainingHeartRateLowerLimit ==
              exerciseTrainingHeartRateLowerLimit &&
          other.exerciseTrainingHeartRateUpperLimit ==
              exerciseTrainingHeartRateUpperLimit &&
          other.exerciseDurationSeconds == exerciseDurationSeconds;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (hint.hashCode) +
      (name.hashCode) +
      (youTubeUrl.hashCode) +
      (type == null ? 0 : type!.hashCode) +
      (exerciseIntensityPercentageStart == null
          ? 0
          : exerciseIntensityPercentageStart!.hashCode) +
      (exerciseIntensityPercentageEnd == null
          ? 0
          : exerciseIntensityPercentageEnd!.hashCode) +
      (exerciseTrainingHeartRateLowerLimit == null
          ? 0
          : exerciseTrainingHeartRateLowerLimit!.hashCode) +
      (exerciseTrainingHeartRateUpperLimit == null
          ? 0
          : exerciseTrainingHeartRateUpperLimit!.hashCode) +
      (exerciseDurationSeconds == null ? 0 : exerciseDurationSeconds!.hashCode);

  @override
  String toString() =>
      'EnduranceExercisePostDTO[hint=$hint, name=$name, youTubeUrl=$youTubeUrl, type=$type, exerciseIntensityPercentageStart=$exerciseIntensityPercentageStart, exerciseIntensityPercentageEnd=$exerciseIntensityPercentageEnd, exerciseTrainingHeartRateLowerLimit=$exerciseTrainingHeartRateLowerLimit, exerciseTrainingHeartRateUpperLimit=$exerciseTrainingHeartRateUpperLimit, exerciseDurationSeconds=$exerciseDurationSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'hint'] = this.hint;
    json[r'name'] = this.name;
    json[r'youTubeUrl'] = this.youTubeUrl;
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.exerciseIntensityPercentageStart != null) {
      json[r'exerciseIntensityPercentageStart'] =
          this.exerciseIntensityPercentageStart;
    } else {
      json[r'exerciseIntensityPercentageStart'] = null;
    }
    if (this.exerciseIntensityPercentageEnd != null) {
      json[r'exerciseIntensityPercentageEnd'] =
          this.exerciseIntensityPercentageEnd;
    } else {
      json[r'exerciseIntensityPercentageEnd'] = null;
    }
    if (this.exerciseTrainingHeartRateLowerLimit != null) {
      json[r'exerciseTrainingHeartRateLowerLimit'] =
          this.exerciseTrainingHeartRateLowerLimit;
    } else {
      json[r'exerciseTrainingHeartRateLowerLimit'] = null;
    }
    if (this.exerciseTrainingHeartRateUpperLimit != null) {
      json[r'exerciseTrainingHeartRateUpperLimit'] =
          this.exerciseTrainingHeartRateUpperLimit;
    } else {
      json[r'exerciseTrainingHeartRateUpperLimit'] = null;
    }
    if (this.exerciseDurationSeconds != null) {
      json[r'exerciseDurationSeconds'] = this.exerciseDurationSeconds;
    } else {
      json[r'exerciseDurationSeconds'] = null;
    }
    return json;
  }

  /// Returns a new [EnduranceExercisePostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EnduranceExercisePostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "EnduranceExercisePostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "EnduranceExercisePostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EnduranceExercisePostDTO(
        hint: mapCastOfType<String, String>(json, r'hint') ?? const {},
        name: mapCastOfType<String, String>(json, r'name') ?? const {},
        youTubeUrl:
            mapCastOfType<String, String>(json, r'youTubeUrl') ?? const {},
        type: ExerciseType.fromJson(json[r'type']),
        exerciseIntensityPercentageStart:
            mapValueOfType<int>(json, r'exerciseIntensityPercentageStart'),
        exerciseIntensityPercentageEnd:
            mapValueOfType<int>(json, r'exerciseIntensityPercentageEnd'),
        exerciseTrainingHeartRateLowerLimit:
            mapValueOfType<int>(json, r'exerciseTrainingHeartRateLowerLimit'),
        exerciseTrainingHeartRateUpperLimit:
            mapValueOfType<int>(json, r'exerciseTrainingHeartRateUpperLimit'),
        exerciseDurationSeconds:
            mapValueOfType<int>(json, r'exerciseDurationSeconds'),
      );
    }
    return null;
  }

  static List<EnduranceExercisePostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <EnduranceExercisePostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EnduranceExercisePostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EnduranceExercisePostDTO> mapFromJson(dynamic json) {
    final map = <String, EnduranceExercisePostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EnduranceExercisePostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EnduranceExercisePostDTO-objects as value to a dart map
  static Map<String, List<EnduranceExercisePostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<EnduranceExercisePostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EnduranceExercisePostDTO.listFromJson(
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
