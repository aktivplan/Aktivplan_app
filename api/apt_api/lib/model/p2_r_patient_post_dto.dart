//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class P2RPatientPostDTO {
  /// Returns a new [P2RPatientPostDTO] instance.
  P2RPatientPostDTO({
    this.homeLocation,
    this.homeLocationAddress,
    this.workLocation,
    this.workLocationAddress,
    this.heatTolerance,
    this.mobilityPreferences = const [],
    this.dislikedMobilityPreferences = const [],
    this.preferredActivities = const [],
    this.dislikedActivities = const [],
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
    this.participantId,
    this.surgeryDate,
    this.surgeryTime,
    this.caatsId,
    this.institutionP2RFocus,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? homeLocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? homeLocationAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? workLocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? workLocationAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  HeatTolerance? heatTolerance;

  List<MobilityPreference> mobilityPreferences;

  List<MobilityPreference> dislikedMobilityPreferences;

  List<PredefinedActivityType> preferredActivities;

  List<PredefinedActivityType> dislikedActivities;

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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? participantId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? surgeryDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? surgeryTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? caatsId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  InstitutionP2RFocus? institutionP2RFocus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is P2RPatientPostDTO &&
          other.homeLocation == homeLocation &&
          other.homeLocationAddress == homeLocationAddress &&
          other.workLocation == workLocation &&
          other.workLocationAddress == workLocationAddress &&
          other.heatTolerance == heatTolerance &&
          _deepEquality.equals(
              other.mobilityPreferences, mobilityPreferences) &&
          _deepEquality.equals(
              other.dislikedMobilityPreferences, dislikedMobilityPreferences) &&
          _deepEquality.equals(
              other.preferredActivities, preferredActivities) &&
          _deepEquality.equals(other.dislikedActivities, dislikedActivities) &&
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
          other.medication == medication &&
          other.participantId == participantId &&
          other.surgeryDate == surgeryDate &&
          other.surgeryTime == surgeryTime &&
          other.caatsId == caatsId &&
          other.institutionP2RFocus == institutionP2RFocus;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (homeLocation == null ? 0 : homeLocation!.hashCode) +
      (homeLocationAddress == null ? 0 : homeLocationAddress!.hashCode) +
      (workLocation == null ? 0 : workLocation!.hashCode) +
      (workLocationAddress == null ? 0 : workLocationAddress!.hashCode) +
      (heatTolerance == null ? 0 : heatTolerance!.hashCode) +
      (mobilityPreferences.hashCode) +
      (dislikedMobilityPreferences.hashCode) +
      (preferredActivities.hashCode) +
      (dislikedActivities.hashCode) +
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
      (medication == null ? 0 : medication!.hashCode) +
      (participantId == null ? 0 : participantId!.hashCode) +
      (surgeryDate == null ? 0 : surgeryDate!.hashCode) +
      (surgeryTime == null ? 0 : surgeryTime!.hashCode) +
      (caatsId == null ? 0 : caatsId!.hashCode) +
      (institutionP2RFocus == null ? 0 : institutionP2RFocus!.hashCode);

  @override
  String toString() =>
      'P2RPatientPostDTO[homeLocation=$homeLocation, homeLocationAddress=$homeLocationAddress, workLocation=$workLocation, workLocationAddress=$workLocationAddress, heatTolerance=$heatTolerance, mobilityPreferences=$mobilityPreferences, dislikedMobilityPreferences=$dislikedMobilityPreferences, preferredActivities=$preferredActivities, dislikedActivities=$dislikedActivities, email=$email, institutionId=$institutionId, healthcareProfessionalId=$healthcareProfessionalId, firstName=$firstName, lastName=$lastName, birthDate=$birthDate, height=$height, weight=$weight, activityClass=$activityClass, maximumHeartRate=$maximumHeartRate, maximumBloodPressure=$maximumBloodPressure, maximumPerformance=$maximumPerformance, maximumOxygenConsumption=$maximumOxygenConsumption, diseases=$diseases, medication=$medication, participantId=$participantId, surgeryDate=$surgeryDate, surgeryTime=$surgeryTime, caatsId=$caatsId, institutionP2RFocus=$institutionP2RFocus]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.homeLocation != null) {
      json[r'homeLocation'] = this.homeLocation;
    } else {
      json[r'homeLocation'] = null;
    }
    if (this.homeLocationAddress != null) {
      json[r'homeLocationAddress'] = this.homeLocationAddress;
    } else {
      json[r'homeLocationAddress'] = null;
    }
    if (this.workLocation != null) {
      json[r'workLocation'] = this.workLocation;
    } else {
      json[r'workLocation'] = null;
    }
    if (this.workLocationAddress != null) {
      json[r'workLocationAddress'] = this.workLocationAddress;
    } else {
      json[r'workLocationAddress'] = null;
    }
    if (this.heatTolerance != null) {
      json[r'heatTolerance'] = this.heatTolerance;
    } else {
      json[r'heatTolerance'] = null;
    }
    json[r'mobilityPreferences'] = this.mobilityPreferences;
    json[r'dislikedMobilityPreferences'] = this.dislikedMobilityPreferences;
    json[r'preferredActivities'] = this.preferredActivities;
    json[r'dislikedActivities'] = this.dislikedActivities;
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
    if (this.participantId != null) {
      json[r'participantId'] = this.participantId;
    } else {
      json[r'participantId'] = null;
    }
    if (this.surgeryDate != null) {
      json[r'surgeryDate'] = this.surgeryDate;
    } else {
      json[r'surgeryDate'] = null;
    }
    if (this.surgeryTime != null) {
      json[r'surgeryTime'] = this.surgeryTime;
    } else {
      json[r'surgeryTime'] = null;
    }
    if (this.caatsId != null) {
      json[r'caatsId'] = this.caatsId;
    } else {
      json[r'caatsId'] = null;
    }
    if (this.institutionP2RFocus != null) {
      json[r'institutionP2RFocus'] = this.institutionP2RFocus;
    } else {
      json[r'institutionP2RFocus'] = null;
    }
    return json;
  }

  /// Returns a new [P2RPatientPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static P2RPatientPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "P2RPatientPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "P2RPatientPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return P2RPatientPostDTO(
        homeLocation: LocationDTO.fromJson(json[r'homeLocation']),
        homeLocationAddress:
            mapValueOfType<String>(json, r'homeLocationAddress'),
        workLocation: LocationDTO.fromJson(json[r'workLocation']),
        workLocationAddress:
            mapValueOfType<String>(json, r'workLocationAddress'),
        heatTolerance: HeatTolerance.fromJson(json[r'heatTolerance']),
        mobilityPreferences:
            MobilityPreference.listFromJson(json[r'mobilityPreferences']),
        dislikedMobilityPreferences: MobilityPreference.listFromJson(
            json[r'dislikedMobilityPreferences']),
        preferredActivities:
            PredefinedActivityType.listFromJson(json[r'preferredActivities']),
        dislikedActivities:
            PredefinedActivityType.listFromJson(json[r'dislikedActivities']),
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
        participantId: mapValueOfType<String>(json, r'participantId'),
        surgeryDate: mapValueOfType<String>(json, r'surgeryDate'),
        surgeryTime: mapValueOfType<String>(json, r'surgeryTime'),
        caatsId: mapValueOfType<String>(json, r'caatsId'),
        institutionP2RFocus:
            InstitutionP2RFocus.fromJson(json[r'institutionP2RFocus']),
      );
    }
    return null;
  }

  static List<P2RPatientPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <P2RPatientPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = P2RPatientPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, P2RPatientPostDTO> mapFromJson(dynamic json) {
    final map = <String, P2RPatientPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = P2RPatientPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of P2RPatientPostDTO-objects as value to a dart map
  static Map<String, List<P2RPatientPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<P2RPatientPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = P2RPatientPostDTO.listFromJson(
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
