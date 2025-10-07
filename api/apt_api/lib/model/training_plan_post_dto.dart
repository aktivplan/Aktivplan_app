//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TrainingPlanPostDTO {
  /// Returns a new [TrainingPlanPostDTO] instance.
  TrainingPlanPostDTO({
    this.name,
    this.description,
    this.hint,
    this.exercises = const [],
    this.numberOfWeeks,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hint;

  List<TrainingPlanExercisePostDTO> exercises;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? numberOfWeeks;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingPlanPostDTO &&
          other.name == name &&
          other.description == description &&
          other.hint == hint &&
          _deepEquality.equals(other.exercises, exercises) &&
          other.numberOfWeeks == numberOfWeeks;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name == null ? 0 : name!.hashCode) +
      (description == null ? 0 : description!.hashCode) +
      (hint == null ? 0 : hint!.hashCode) +
      (exercises.hashCode) +
      (numberOfWeeks == null ? 0 : numberOfWeeks!.hashCode);

  @override
  String toString() =>
      'TrainingPlanPostDTO[name=$name, description=$description, hint=$hint, exercises=$exercises, numberOfWeeks=$numberOfWeeks]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.hint != null) {
      json[r'hint'] = this.hint;
    } else {
      json[r'hint'] = null;
    }
    json[r'exercises'] = this.exercises;
    if (this.numberOfWeeks != null) {
      json[r'numberOfWeeks'] = this.numberOfWeeks;
    } else {
      json[r'numberOfWeeks'] = null;
    }
    return json;
  }

  /// Returns a new [TrainingPlanPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TrainingPlanPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "TrainingPlanPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "TrainingPlanPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TrainingPlanPostDTO(
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        hint: mapValueOfType<String>(json, r'hint'),
        exercises: TrainingPlanExercisePostDTO.listFromJson(json[r'exercises']),
        numberOfWeeks: mapValueOfType<int>(json, r'numberOfWeeks'),
      );
    }
    return null;
  }

  static List<TrainingPlanPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TrainingPlanPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TrainingPlanPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TrainingPlanPostDTO> mapFromJson(dynamic json) {
    final map = <String, TrainingPlanPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TrainingPlanPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TrainingPlanPostDTO-objects as value to a dart map
  static Map<String, List<TrainingPlanPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<TrainingPlanPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TrainingPlanPostDTO.listFromJson(
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
