//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Workout {
  /// Returns a new [Workout] instance.
  Workout({
    this.name = const {},
    this.notes = const {},
    this.exercises = const [],
    this.youTubeUrl = const {},
    this.videoFileKey,
    this.videoWaitBetweenExercisesSeconds,
    this.exerciseDurationSeconds,
    this.id,
    this.institutionId,
    this.importId,
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
  String? videoFileKey;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? videoWaitBetweenExercisesSeconds;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workout &&
          _deepEquality.equals(other.name, name) &&
          _deepEquality.equals(other.notes, notes) &&
          _deepEquality.equals(other.exercises, exercises) &&
          _deepEquality.equals(other.youTubeUrl, youTubeUrl) &&
          other.videoFileKey == videoFileKey &&
          other.videoWaitBetweenExercisesSeconds ==
              videoWaitBetweenExercisesSeconds &&
          other.exerciseDurationSeconds == exerciseDurationSeconds &&
          other.id == id &&
          other.institutionId == institutionId &&
          other.importId == importId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name.hashCode) +
      (notes.hashCode) +
      (exercises.hashCode) +
      (youTubeUrl.hashCode) +
      (videoFileKey == null ? 0 : videoFileKey!.hashCode) +
      (videoWaitBetweenExercisesSeconds == null
          ? 0
          : videoWaitBetweenExercisesSeconds!.hashCode) +
      (exerciseDurationSeconds == null
          ? 0
          : exerciseDurationSeconds!.hashCode) +
      (id == null ? 0 : id!.hashCode) +
      (institutionId == null ? 0 : institutionId!.hashCode) +
      (importId == null ? 0 : importId!.hashCode);

  @override
  String toString() =>
      'Workout[name=$name, notes=$notes, exercises=$exercises, youTubeUrl=$youTubeUrl, videoFileKey=$videoFileKey, videoWaitBetweenExercisesSeconds=$videoWaitBetweenExercisesSeconds, exerciseDurationSeconds=$exerciseDurationSeconds, id=$id, institutionId=$institutionId, importId=$importId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'name'] = this.name;
    json[r'notes'] = this.notes;
    json[r'exercises'] = this.exercises;
    json[r'youTubeUrl'] = this.youTubeUrl;
    if (this.videoFileKey != null) {
      json[r'videoFileKey'] = this.videoFileKey;
    } else {
      json[r'videoFileKey'] = null;
    }
    if (this.videoWaitBetweenExercisesSeconds != null) {
      json[r'videoWaitBetweenExercisesSeconds'] =
          this.videoWaitBetweenExercisesSeconds;
    } else {
      json[r'videoWaitBetweenExercisesSeconds'] = null;
    }
    if (this.exerciseDurationSeconds != null) {
      json[r'exerciseDurationSeconds'] = this.exerciseDurationSeconds;
    } else {
      json[r'exerciseDurationSeconds'] = null;
    }
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
    return json;
  }

  /// Returns a new [Workout] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Workout? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Workout[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Workout[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Workout(
        name: mapCastOfType<String, String>(json, r'name') ?? const {},
        notes: mapCastOfType<String, String>(json, r'notes') ?? const {},
        exercises:
            StrengtheningExercisePostDTO.listFromJson(json[r'exercises']),
        youTubeUrl:
            mapCastOfType<String, String>(json, r'youTubeUrl') ?? const {},
        videoFileKey: mapValueOfType<String>(json, r'videoFileKey'),
        videoWaitBetweenExercisesSeconds:
            mapValueOfType<int>(json, r'videoWaitBetweenExercisesSeconds'),
        exerciseDurationSeconds:
            mapValueOfType<int>(json, r'exerciseDurationSeconds'),
        id: mapValueOfType<String>(json, r'id'),
        institutionId: mapValueOfType<String>(json, r'institutionId'),
        importId: mapValueOfType<String>(json, r'importId'),
      );
    }
    return null;
  }

  static List<Workout> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Workout>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Workout.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Workout> mapFromJson(dynamic json) {
    final map = <String, Workout>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Workout.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Workout-objects as value to a dart map
  static Map<String, List<Workout>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Workout>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Workout.listFromJson(
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
