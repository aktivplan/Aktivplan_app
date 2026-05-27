//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CurrentUserDTO {
  /// Returns a new [CurrentUserDTO] instance.
  CurrentUserDTO({
    required this.userRole,
    required this.acceptedTracking,
    required this.language,
    this.administrator,
    this.institutionAdministrator,
    this.healthcareProfessional,
    this.patient,
    this.institution,
    this.registerDate,
    this.hasExternalApps,
  });

  UserRole userRole;

  bool acceptedTracking;

  TranslationLanguage language;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AdministratorGetDTO? administrator;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  InstitutionAdministratorGetDTO? institutionAdministrator;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  HealthcareProfessionalGetDTO? healthcareProfessional;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PatientGetDTO? patient;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  InstitutionDTO? institution;

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
  bool? hasExternalApps;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentUserDTO &&
          other.userRole == userRole &&
          other.acceptedTracking == acceptedTracking &&
          other.language == language &&
          other.administrator == administrator &&
          other.institutionAdministrator == institutionAdministrator &&
          other.healthcareProfessional == healthcareProfessional &&
          other.patient == patient &&
          other.institution == institution &&
          other.registerDate == registerDate &&
          other.hasExternalApps == hasExternalApps;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (userRole.hashCode) +
      (acceptedTracking.hashCode) +
      (language.hashCode) +
      (administrator == null ? 0 : administrator!.hashCode) +
      (institutionAdministrator == null
          ? 0
          : institutionAdministrator!.hashCode) +
      (healthcareProfessional == null ? 0 : healthcareProfessional!.hashCode) +
      (patient == null ? 0 : patient!.hashCode) +
      (institution == null ? 0 : institution!.hashCode) +
      (registerDate == null ? 0 : registerDate!.hashCode) +
      (hasExternalApps == null ? 0 : hasExternalApps!.hashCode);

  @override
  String toString() =>
      'CurrentUserDTO[userRole=$userRole, acceptedTracking=$acceptedTracking, language=$language, administrator=$administrator, institutionAdministrator=$institutionAdministrator, healthcareProfessional=$healthcareProfessional, patient=$patient, institution=$institution, registerDate=$registerDate, hasExternalApps=$hasExternalApps]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'userRole'] = this.userRole;
    json[r'acceptedTracking'] = this.acceptedTracking;
    json[r'language'] = this.language;
    if (this.administrator != null) {
      json[r'administrator'] = this.administrator;
    } else {
      json[r'administrator'] = null;
    }
    if (this.institutionAdministrator != null) {
      json[r'institutionAdministrator'] = this.institutionAdministrator;
    } else {
      json[r'institutionAdministrator'] = null;
    }
    if (this.healthcareProfessional != null) {
      json[r'healthcareProfessional'] = this.healthcareProfessional;
    } else {
      json[r'healthcareProfessional'] = null;
    }
    if (this.patient != null) {
      json[r'patient'] = this.patient;
    } else {
      json[r'patient'] = null;
    }
    if (this.institution != null) {
      json[r'institution'] = this.institution;
    } else {
      json[r'institution'] = null;
    }
    if (this.registerDate != null) {
      json[r'registerDate'] = this.registerDate;
    } else {
      json[r'registerDate'] = null;
    }
    if (this.hasExternalApps != null) {
      json[r'hasExternalApps'] = this.hasExternalApps;
    } else {
      json[r'hasExternalApps'] = null;
    }
    return json;
  }

  /// Returns a new [CurrentUserDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CurrentUserDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "CurrentUserDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "CurrentUserDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CurrentUserDTO(
        userRole: UserRole.fromJson(json[r'userRole'])!,
        acceptedTracking: mapValueOfType<bool>(json, r'acceptedTracking')!,
        language: TranslationLanguage.fromJson(json[r'language'])!,
        administrator: AdministratorGetDTO.fromJson(json[r'administrator']),
        institutionAdministrator: InstitutionAdministratorGetDTO.fromJson(
            json[r'institutionAdministrator']),
        healthcareProfessional: HealthcareProfessionalGetDTO.fromJson(
            json[r'healthcareProfessional']),
        patient: PatientGetDTO.fromJson(json[r'patient']),
        institution: InstitutionDTO.fromJson(json[r'institution']),
        registerDate: mapValueOfType<String>(json, r'registerDate'),
        hasExternalApps: mapValueOfType<bool>(json, r'hasExternalApps'),
      );
    }
    return null;
  }

  static List<CurrentUserDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <CurrentUserDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CurrentUserDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CurrentUserDTO> mapFromJson(dynamic json) {
    final map = <String, CurrentUserDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CurrentUserDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CurrentUserDTO-objects as value to a dart map
  static Map<String, List<CurrentUserDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<CurrentUserDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CurrentUserDTO.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'userRole',
    'acceptedTracking',
    'language',
  };
}
