//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IntervalExercisePostDTO {
  /// Returns a new [IntervalExercisePostDTO] instance.
  IntervalExercisePostDTO({
    this.hint = const {},
    this.name = const {},
    this.youTubeUrl = const {},
    this.type,
    this.exerciseIntensityPercentageStart,
    this.exerciseIntensityPercentageEnd,
    this.exerciseTrainingHeartRateLowerLimit,
    this.exerciseTrainingHeartRateUpperLimit,
    this.exerciseDurationSeconds,
    this.recoveryIntensityPercentageStart,
    this.recoveryIntensityPercentageEnd,
    this.recoveryTrainingHeartRateLowerLimit,
    this.recoveryTrainingHeartRateUpperLimit,
    this.recoveryDurationSeconds,
    this.intervalCount,
    this.selectedRecoverySeconds,
    this.selectedExerciseSeconds,
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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? recoveryIntensityPercentageStart;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? recoveryIntensityPercentageEnd;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? recoveryTrainingHeartRateLowerLimit;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? recoveryTrainingHeartRateUpperLimit;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? recoveryDurationSeconds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? intervalCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? selectedRecoverySeconds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? selectedExerciseSeconds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntervalExercisePostDTO &&
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
          other.exerciseDurationSeconds == exerciseDurationSeconds &&
          other.recoveryIntensityPercentageStart ==
              recoveryIntensityPercentageStart &&
          other.recoveryIntensityPercentageEnd ==
              recoveryIntensityPercentageEnd &&
          other.recoveryTrainingHeartRateLowerLimit ==
              recoveryTrainingHeartRateLowerLimit &&
          other.recoveryTrainingHeartRateUpperLimit ==
              recoveryTrainingHeartRateUpperLimit &&
          other.recoveryDurationSeconds == recoveryDurationSeconds &&
          other.intervalCount == intervalCount &&
          other.selectedRecoverySeconds == selectedRecoverySeconds &&
          other.selectedExerciseSeconds == selectedExerciseSeconds;

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
      (exerciseDurationSeconds == null
          ? 0
          : exerciseDurationSeconds!.hashCode) +
      (recoveryIntensityPercentageStart == null
          ? 0
          : recoveryIntensityPercentageStart!.hashCode) +
      (recoveryIntensityPercentageEnd == null
          ? 0
          : recoveryIntensityPercentageEnd!.hashCode) +
      (recoveryTrainingHeartRateLowerLimit == null
          ? 0
          : recoveryTrainingHeartRateLowerLimit!.hashCode) +
      (recoveryTrainingHeartRateUpperLimit == null
          ? 0
          : recoveryTrainingHeartRateUpperLimit!.hashCode) +
      (recoveryDurationSeconds == null
          ? 0
          : recoveryDurationSeconds!.hashCode) +
      (intervalCount == null ? 0 : intervalCount!.hashCode) +
      (selectedRecoverySeconds == null
          ? 0
          : selectedRecoverySeconds!.hashCode) +
      (selectedExerciseSeconds == null ? 0 : selectedExerciseSeconds!.hashCode);

  @override
  String toString() =>
      'IntervalExercisePostDTO[hint=$hint, name=$name, youTubeUrl=$youTubeUrl, type=$type, exerciseIntensityPercentageStart=$exerciseIntensityPercentageStart, exerciseIntensityPercentageEnd=$exerciseIntensityPercentageEnd, exerciseTrainingHeartRateLowerLimit=$exerciseTrainingHeartRateLowerLimit, exerciseTrainingHeartRateUpperLimit=$exerciseTrainingHeartRateUpperLimit, exerciseDurationSeconds=$exerciseDurationSeconds, recoveryIntensityPercentageStart=$recoveryIntensityPercentageStart, recoveryIntensityPercentageEnd=$recoveryIntensityPercentageEnd, recoveryTrainingHeartRateLowerLimit=$recoveryTrainingHeartRateLowerLimit, recoveryTrainingHeartRateUpperLimit=$recoveryTrainingHeartRateUpperLimit, recoveryDurationSeconds=$recoveryDurationSeconds, intervalCount=$intervalCount, selectedRecoverySeconds=$selectedRecoverySeconds, selectedExerciseSeconds=$selectedExerciseSeconds]';

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
    if (this.recoveryIntensityPercentageStart != null) {
      json[r'recoveryIntensityPercentageStart'] =
          this.recoveryIntensityPercentageStart;
    } else {
      json[r'recoveryIntensityPercentageStart'] = null;
    }
    if (this.recoveryIntensityPercentageEnd != null) {
      json[r'recoveryIntensityPercentageEnd'] =
          this.recoveryIntensityPercentageEnd;
    } else {
      json[r'recoveryIntensityPercentageEnd'] = null;
    }
    if (this.recoveryTrainingHeartRateLowerLimit != null) {
      json[r'recoveryTrainingHeartRateLowerLimit'] =
          this.recoveryTrainingHeartRateLowerLimit;
    } else {
      json[r'recoveryTrainingHeartRateLowerLimit'] = null;
    }
    if (this.recoveryTrainingHeartRateUpperLimit != null) {
      json[r'recoveryTrainingHeartRateUpperLimit'] =
          this.recoveryTrainingHeartRateUpperLimit;
    } else {
      json[r'recoveryTrainingHeartRateUpperLimit'] = null;
    }
    if (this.recoveryDurationSeconds != null) {
      json[r'recoveryDurationSeconds'] = this.recoveryDurationSeconds;
    } else {
      json[r'recoveryDurationSeconds'] = null;
    }
    if (this.intervalCount != null) {
      json[r'intervalCount'] = this.intervalCount;
    } else {
      json[r'intervalCount'] = null;
    }
    if (this.selectedRecoverySeconds != null) {
      json[r'selectedRecoverySeconds'] = this.selectedRecoverySeconds;
    } else {
      json[r'selectedRecoverySeconds'] = null;
    }
    if (this.selectedExerciseSeconds != null) {
      json[r'selectedExerciseSeconds'] = this.selectedExerciseSeconds;
    } else {
      json[r'selectedExerciseSeconds'] = null;
    }
    return json;
  }

  /// Returns a new [IntervalExercisePostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IntervalExercisePostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "IntervalExercisePostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "IntervalExercisePostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IntervalExercisePostDTO(
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
        recoveryIntensityPercentageStart:
            mapValueOfType<int>(json, r'recoveryIntensityPercentageStart'),
        recoveryIntensityPercentageEnd:
            mapValueOfType<int>(json, r'recoveryIntensityPercentageEnd'),
        recoveryTrainingHeartRateLowerLimit:
            mapValueOfType<int>(json, r'recoveryTrainingHeartRateLowerLimit'),
        recoveryTrainingHeartRateUpperLimit:
            mapValueOfType<int>(json, r'recoveryTrainingHeartRateUpperLimit'),
        recoveryDurationSeconds:
            mapValueOfType<int>(json, r'recoveryDurationSeconds'),
        intervalCount: mapValueOfType<int>(json, r'intervalCount'),
        selectedRecoverySeconds:
            mapValueOfType<bool>(json, r'selectedRecoverySeconds'),
        selectedExerciseSeconds:
            mapValueOfType<bool>(json, r'selectedExerciseSeconds'),
      );
    }
    return null;
  }

  static List<IntervalExercisePostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <IntervalExercisePostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IntervalExercisePostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IntervalExercisePostDTO> mapFromJson(dynamic json) {
    final map = <String, IntervalExercisePostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IntervalExercisePostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IntervalExercisePostDTO-objects as value to a dart map
  static Map<String, List<IntervalExercisePostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<IntervalExercisePostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IntervalExercisePostDTO.listFromJson(
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
