//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChangeHealthcareProfessionalDTO {
  /// Returns a new [ChangeHealthcareProfessionalDTO] instance.
  ChangeHealthcareProfessionalDTO({
    this.patientIds = const [],
    this.healthcareProfessionalId,
  });

  List<String> patientIds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? healthcareProfessionalId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeHealthcareProfessionalDTO &&
          _deepEquality.equals(other.patientIds, patientIds) &&
          other.healthcareProfessionalId == healthcareProfessionalId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (patientIds.hashCode) +
      (healthcareProfessionalId == null
          ? 0
          : healthcareProfessionalId!.hashCode);

  @override
  String toString() =>
      'ChangeHealthcareProfessionalDTO[patientIds=$patientIds, healthcareProfessionalId=$healthcareProfessionalId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'patientIds'] = this.patientIds;
    if (this.healthcareProfessionalId != null) {
      json[r'healthcareProfessionalId'] = this.healthcareProfessionalId;
    } else {
      json[r'healthcareProfessionalId'] = null;
    }
    return json;
  }

  /// Returns a new [ChangeHealthcareProfessionalDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChangeHealthcareProfessionalDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ChangeHealthcareProfessionalDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ChangeHealthcareProfessionalDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChangeHealthcareProfessionalDTO(
        patientIds: json[r'patientIds'] is Iterable
            ? (json[r'patientIds'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
        healthcareProfessionalId:
            mapValueOfType<String>(json, r'healthcareProfessionalId'),
      );
    }
    return null;
  }

  static List<ChangeHealthcareProfessionalDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ChangeHealthcareProfessionalDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChangeHealthcareProfessionalDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChangeHealthcareProfessionalDTO> mapFromJson(
      dynamic json) {
    final map = <String, ChangeHealthcareProfessionalDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChangeHealthcareProfessionalDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChangeHealthcareProfessionalDTO-objects as value to a dart map
  static Map<String, List<ChangeHealthcareProfessionalDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ChangeHealthcareProfessionalDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChangeHealthcareProfessionalDTO.listFromJson(
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
