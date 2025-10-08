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

class PatientPostDTO {
  /// Returns a new [PatientPostDTO] instance.
  PatientPostDTO({
    this.email,
    this.institutionId,
    this.healthcareProfessionalId,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.height,
    this.weight,
    this.activityClass,
    this.maximumHeartRate,
    this.maximumBloodPressure,
    this.maximumPerformance,
    this.maximumOxygenConsumption,
    this.diseases,
    this.medication,
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
  String? healthcareProfessionalId;

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
  String? birthDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? height;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? weight;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activityClass;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? maximumHeartRate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? maximumBloodPressure;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? maximumPerformance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? maximumOxygenConsumption;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? diseases;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? medication;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientPostDTO &&
          other.email == email &&
          other.institutionId == institutionId &&
          other.healthcareProfessionalId == healthcareProfessionalId &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.birthDate == birthDate &&
          other.height == height &&
          other.weight == weight &&
          other.activityClass == activityClass &&
          other.maximumHeartRate == maximumHeartRate &&
          other.maximumBloodPressure == maximumBloodPressure &&
          other.maximumPerformance == maximumPerformance &&
          other.maximumOxygenConsumption == maximumOxygenConsumption &&
          other.diseases == diseases &&
          other.medication == medication;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (email == null ? 0 : email!.hashCode) +
      (institutionId == null ? 0 : institutionId!.hashCode) +
      (healthcareProfessionalId == null
          ? 0
          : healthcareProfessionalId!.hashCode) +
      (firstName == null ? 0 : firstName!.hashCode) +
      (lastName == null ? 0 : lastName!.hashCode) +
      (birthDate == null ? 0 : birthDate!.hashCode) +
      (height == null ? 0 : height!.hashCode) +
      (weight == null ? 0 : weight!.hashCode) +
      (activityClass == null ? 0 : activityClass!.hashCode) +
      (maximumHeartRate == null ? 0 : maximumHeartRate!.hashCode) +
      (maximumBloodPressure == null ? 0 : maximumBloodPressure!.hashCode) +
      (maximumPerformance == null ? 0 : maximumPerformance!.hashCode) +
      (maximumOxygenConsumption == null
          ? 0
          : maximumOxygenConsumption!.hashCode) +
      (diseases == null ? 0 : diseases!.hashCode) +
      (medication == null ? 0 : medication!.hashCode);

  @override
  String toString() =>
      'PatientPostDTO[email=$email, institutionId=$institutionId, healthcareProfessionalId=$healthcareProfessionalId, firstName=$firstName, lastName=$lastName, birthDate=$birthDate, height=$height, weight=$weight, activityClass=$activityClass, maximumHeartRate=$maximumHeartRate, maximumBloodPressure=$maximumBloodPressure, maximumPerformance=$maximumPerformance, maximumOxygenConsumption=$maximumOxygenConsumption, diseases=$diseases, medication=$medication]';

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
    if (this.healthcareProfessionalId != null) {
      json[r'healthcareProfessionalId'] = this.healthcareProfessionalId;
    } else {
      json[r'healthcareProfessionalId'] = null;
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
    if (this.birthDate != null) {
      json[r'birthDate'] = this.birthDate;
    } else {
      json[r'birthDate'] = null;
    }
    if (this.height != null) {
      json[r'height'] = this.height;
    } else {
      json[r'height'] = null;
    }
    if (this.weight != null) {
      json[r'weight'] = this.weight;
    } else {
      json[r'weight'] = null;
    }
    if (this.activityClass != null) {
      json[r'activityClass'] = this.activityClass;
    } else {
      json[r'activityClass'] = null;
    }
    if (this.maximumHeartRate != null) {
      json[r'maximumHeartRate'] = this.maximumHeartRate;
    } else {
      json[r'maximumHeartRate'] = null;
    }
    if (this.maximumBloodPressure != null) {
      json[r'maximumBloodPressure'] = this.maximumBloodPressure;
    } else {
      json[r'maximumBloodPressure'] = null;
    }
    if (this.maximumPerformance != null) {
      json[r'maximumPerformance'] = this.maximumPerformance;
    } else {
      json[r'maximumPerformance'] = null;
    }
    if (this.maximumOxygenConsumption != null) {
      json[r'maximumOxygenConsumption'] = this.maximumOxygenConsumption;
    } else {
      json[r'maximumOxygenConsumption'] = null;
    }
    if (this.diseases != null) {
      json[r'diseases'] = this.diseases;
    } else {
      json[r'diseases'] = null;
    }
    if (this.medication != null) {
      json[r'medication'] = this.medication;
    } else {
      json[r'medication'] = null;
    }
    return json;
  }

  /// Returns a new [PatientPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PatientPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PatientPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PatientPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PatientPostDTO(
        email: mapValueOfType<String>(json, r'email'),
        institutionId: mapValueOfType<String>(json, r'institutionId'),
        healthcareProfessionalId:
            mapValueOfType<String>(json, r'healthcareProfessionalId'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        birthDate: mapValueOfType<String>(json, r'birthDate'),
        height: mapValueOfType<int>(json, r'height'),
        weight: mapValueOfType<int>(json, r'weight'),
        activityClass: mapValueOfType<int>(json, r'activityClass'),
        maximumHeartRate: mapValueOfType<int>(json, r'maximumHeartRate'),
        maximumBloodPressure:
            mapValueOfType<String>(json, r'maximumBloodPressure'),
        maximumPerformance: mapValueOfType<double>(json, r'maximumPerformance'),
        maximumOxygenConsumption:
            mapValueOfType<double>(json, r'maximumOxygenConsumption'),
        diseases: mapValueOfType<String>(json, r'diseases'),
        medication: mapValueOfType<String>(json, r'medication'),
      );
    }
    return null;
  }

  static List<PatientPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatientPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatientPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PatientPostDTO> mapFromJson(dynamic json) {
    final map = <String, PatientPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PatientPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PatientPostDTO-objects as value to a dart map
  static Map<String, List<PatientPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PatientPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PatientPostDTO.listFromJson(
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
