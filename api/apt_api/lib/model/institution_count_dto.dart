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

class InstitutionCountDTO {
  /// Returns a new [InstitutionCountDTO] instance.
  InstitutionCountDTO({
    this.healthcareProfessionalCount,
    this.patientCount,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? healthcareProfessionalCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? patientCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstitutionCountDTO &&
          other.healthcareProfessionalCount == healthcareProfessionalCount &&
          other.patientCount == patientCount;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (healthcareProfessionalCount == null
          ? 0
          : healthcareProfessionalCount!.hashCode) +
      (patientCount == null ? 0 : patientCount!.hashCode);

  @override
  String toString() =>
      'InstitutionCountDTO[healthcareProfessionalCount=$healthcareProfessionalCount, patientCount=$patientCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.healthcareProfessionalCount != null) {
      json[r'healthcareProfessionalCount'] = this.healthcareProfessionalCount;
    } else {
      json[r'healthcareProfessionalCount'] = null;
    }
    if (this.patientCount != null) {
      json[r'patientCount'] = this.patientCount;
    } else {
      json[r'patientCount'] = null;
    }
    return json;
  }

  /// Returns a new [InstitutionCountDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InstitutionCountDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "InstitutionCountDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "InstitutionCountDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InstitutionCountDTO(
        healthcareProfessionalCount:
            mapValueOfType<int>(json, r'healthcareProfessionalCount'),
        patientCount: mapValueOfType<int>(json, r'patientCount'),
      );
    }
    return null;
  }

  static List<InstitutionCountDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InstitutionCountDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InstitutionCountDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InstitutionCountDTO> mapFromJson(dynamic json) {
    final map = <String, InstitutionCountDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InstitutionCountDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InstitutionCountDTO-objects as value to a dart map
  static Map<String, List<InstitutionCountDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<InstitutionCountDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InstitutionCountDTO.listFromJson(
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
