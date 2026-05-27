//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreatePatientConsentDTO {
  /// Returns a new [CreatePatientConsentDTO] instance.
  CreatePatientConsentDTO({
    this.description,
    this.longDescription,
  });

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
  String? longDescription;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatePatientConsentDTO &&
          other.description == description &&
          other.longDescription == longDescription;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (description == null ? 0 : description!.hashCode) +
      (longDescription == null ? 0 : longDescription!.hashCode);

  @override
  String toString() =>
      'CreatePatientConsentDTO[description=$description, longDescription=$longDescription]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.longDescription != null) {
      json[r'longDescription'] = this.longDescription;
    } else {
      json[r'longDescription'] = null;
    }
    return json;
  }

  /// Returns a new [CreatePatientConsentDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreatePatientConsentDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "CreatePatientConsentDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "CreatePatientConsentDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreatePatientConsentDTO(
        description: mapValueOfType<String>(json, r'description'),
        longDescription: mapValueOfType<String>(json, r'longDescription'),
      );
    }
    return null;
  }

  static List<CreatePatientConsentDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <CreatePatientConsentDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreatePatientConsentDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreatePatientConsentDTO> mapFromJson(dynamic json) {
    final map = <String, CreatePatientConsentDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreatePatientConsentDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreatePatientConsentDTO-objects as value to a dart map
  static Map<String, List<CreatePatientConsentDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<CreatePatientConsentDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreatePatientConsentDTO.listFromJson(
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
