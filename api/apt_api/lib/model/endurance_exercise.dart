//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EnduranceExercise {
  /// Returns a new [EnduranceExercise] instance.
  EnduranceExercise({
    this.id,
    this.institutionId,
    this.importId,
    this.type,
    this.hint = const {},
    this.name = const {},
    this.youTubeUrl = const {},
    this.exerciseIntensityPercentageStart,
    this.exerciseIntensityPercentageEnd,
    this.exerciseTrainingHeartRateLowerLimit,
    this.exerciseTrainingHeartRateUpperLimit,
    this.exerciseDurationSeconds,
  });

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
  String? institutionId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? importId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ExerciseType? type;

  Map<String, String> hint;

  Map<String, String> name;

  Map<String, String> youTubeUrl;

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
      other is EnduranceExercise &&
          other.id == id &&
          other.institutionId == institutionId &&
          other.importId == importId &&
          other.type == type &&
          _deepEquality.equals(other.hint, hint) &&
          _deepEquality.equals(other.name, name) &&
          _deepEquality.equals(other.youTubeUrl, youTubeUrl) &&
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
      (id == null ? 0 : id!.hashCode) +
      (institutionId == null ? 0 : institutionId!.hashCode) +
      (importId == null ? 0 : importId!.hashCode) +
      (type == null ? 0 : type!.hashCode) +
      (hint.hashCode) +
      (name.hashCode) +
      (youTubeUrl.hashCode) +
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
      'EnduranceExercise[id=$id, institutionId=$institutionId, importId=$importId, type=$type, hint=$hint, name=$name, youTubeUrl=$youTubeUrl, exerciseIntensityPercentageStart=$exerciseIntensityPercentageStart, exerciseIntensityPercentageEnd=$exerciseIntensityPercentageEnd, exerciseTrainingHeartRateLowerLimit=$exerciseTrainingHeartRateLowerLimit, exerciseTrainingHeartRateUpperLimit=$exerciseTrainingHeartRateUpperLimit, exerciseDurationSeconds=$exerciseDurationSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.institutionId != null) {
      json[r'institutionId'] = this.institutionId;
    } else {
      json[r'institutionId'] = null;
    }
    if (this.importId != null) {
      json[r'importId'] = this.importId;
    } else {
      json[r'importId'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    json[r'hint'] = this.hint;
    json[r'name'] = this.name;
    json[r'youTubeUrl'] = this.youTubeUrl;
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

  /// Returns a new [EnduranceExercise] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EnduranceExercise? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "EnduranceExercise[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "EnduranceExercise[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EnduranceExercise(
        id: mapValueOfType<String>(json, r'id'),
        institutionId: mapValueOfType<String>(json, r'institutionId'),
        importId: mapValueOfType<String>(json, r'importId'),
        type: ExerciseType.fromJson(json[r'type']),
        hint: mapCastOfType<String, String>(json, r'hint') ?? const {},
        name: mapCastOfType<String, String>(json, r'name') ?? const {},
        youTubeUrl:
            mapCastOfType<String, String>(json, r'youTubeUrl') ?? const {},
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

  static List<EnduranceExercise> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <EnduranceExercise>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EnduranceExercise.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EnduranceExercise> mapFromJson(dynamic json) {
    final map = <String, EnduranceExercise>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EnduranceExercise.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EnduranceExercise-objects as value to a dart map
  static Map<String, List<EnduranceExercise>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<EnduranceExercise>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EnduranceExercise.listFromJson(
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
