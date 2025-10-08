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

class InstitutionAdministratorGetDTO {
  /// Returns a new [InstitutionAdministratorGetDTO] instance.
  InstitutionAdministratorGetDTO({
    this.email,
    this.institutionId,
    this.firstName,
    this.lastName,
    this.id,
    this.registerDate,
    this.lastActiveDate,
    this.institutionName,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

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
  String? firstName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastName;

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
  String? registerDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastActiveDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? institutionName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstitutionAdministratorGetDTO &&
          other.email == email &&
          other.institutionId == institutionId &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.id == id &&
          other.registerDate == registerDate &&
          other.lastActiveDate == lastActiveDate &&
          other.institutionName == institutionName;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (email == null ? 0 : email!.hashCode) +
      (institutionId == null ? 0 : institutionId!.hashCode) +
      (firstName == null ? 0 : firstName!.hashCode) +
      (lastName == null ? 0 : lastName!.hashCode) +
      (id == null ? 0 : id!.hashCode) +
      (registerDate == null ? 0 : registerDate!.hashCode) +
      (lastActiveDate == null ? 0 : lastActiveDate!.hashCode) +
      (institutionName == null ? 0 : institutionName!.hashCode);

  @override
  String toString() =>
      'InstitutionAdministratorGetDTO[email=$email, institutionId=$institutionId, firstName=$firstName, lastName=$lastName, id=$id, registerDate=$registerDate, lastActiveDate=$lastActiveDate, institutionName=$institutionName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.institutionId != null) {
      json[r'institutionId'] = this.institutionId;
    } else {
      json[r'institutionId'] = null;
    }
    if (this.firstName != null) {
      json[r'firstName'] = this.firstName;
    } else {
      json[r'firstName'] = null;
    }
    if (this.lastName != null) {
      json[r'lastName'] = this.lastName;
    } else {
      json[r'lastName'] = null;
    }
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.registerDate != null) {
      json[r'registerDate'] = this.registerDate;
    } else {
      json[r'registerDate'] = null;
    }
    if (this.lastActiveDate != null) {
      json[r'lastActiveDate'] = this.lastActiveDate;
    } else {
      json[r'lastActiveDate'] = null;
    }
    if (this.institutionName != null) {
      json[r'institutionName'] = this.institutionName;
    } else {
      json[r'institutionName'] = null;
    }
    return json;
  }

  /// Returns a new [InstitutionAdministratorGetDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InstitutionAdministratorGetDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "InstitutionAdministratorGetDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "InstitutionAdministratorGetDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InstitutionAdministratorGetDTO(
        email: mapValueOfType<String>(json, r'email'),
        institutionId: mapValueOfType<String>(json, r'institutionId'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        id: mapValueOfType<String>(json, r'id'),
        registerDate: mapValueOfType<String>(json, r'registerDate'),
        lastActiveDate: mapValueOfType<String>(json, r'lastActiveDate'),
        institutionName: mapValueOfType<String>(json, r'institutionName'),
      );
    }
    return null;
  }

  static List<InstitutionAdministratorGetDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InstitutionAdministratorGetDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InstitutionAdministratorGetDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InstitutionAdministratorGetDTO> mapFromJson(dynamic json) {
    final map = <String, InstitutionAdministratorGetDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InstitutionAdministratorGetDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InstitutionAdministratorGetDTO-objects as value to a dart map
  static Map<String, List<InstitutionAdministratorGetDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<InstitutionAdministratorGetDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InstitutionAdministratorGetDTO.listFromJson(
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
