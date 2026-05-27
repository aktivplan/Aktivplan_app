//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class HealthDataPostDTO {
  /// Returns a new [HealthDataPostDTO] instance.
  HealthDataPostDTO({
    this.patientId,
    this.jsonData,
  });

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
  Object? jsonData;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthDataPostDTO &&
          other.patientId == patientId &&
          other.jsonData == jsonData;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (patientId == null ? 0 : patientId!.hashCode) +
      (jsonData == null ? 0 : jsonData!.hashCode);

  @override
  String toString() =>
      'HealthDataPostDTO[patientId=$patientId, jsonData=$jsonData]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.patientId != null) {
      json[r'patientId'] = this.patientId;
    } else {
      json[r'patientId'] = null;
    }
    if (this.jsonData != null) {
      json[r'jsonData'] = this.jsonData;
    } else {
      json[r'jsonData'] = null;
    }
    return json;
  }

  /// Returns a new [HealthDataPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static HealthDataPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "HealthDataPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "HealthDataPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return HealthDataPostDTO(
        patientId: mapValueOfType<String>(json, r'patientId'),
        jsonData: mapValueOfType<Object>(json, r'jsonData'),
      );
    }
    return null;
  }

  static List<HealthDataPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <HealthDataPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HealthDataPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, HealthDataPostDTO> mapFromJson(dynamic json) {
    final map = <String, HealthDataPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = HealthDataPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of HealthDataPostDTO-objects as value to a dart map
  static Map<String, List<HealthDataPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<HealthDataPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = HealthDataPostDTO.listFromJson(
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
