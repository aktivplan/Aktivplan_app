//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PatientOverviewDTO {
  /// Returns a new [PatientOverviewDTO] instance.
  PatientOverviewDTO({
    this.institution,
    this.healthcareProfessional,
    this.user,
    this.activityPercentageGraphData = const [],
  });

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
  HealthcareProfessionalGetDTO? healthcareProfessional;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PatientGetDTO? user;

  List<ActivityGraphDTO> activityPercentageGraphData;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientOverviewDTO &&
          other.institution == institution &&
          other.healthcareProfessional == healthcareProfessional &&
          other.user == user &&
          _deepEquality.equals(
              other.activityPercentageGraphData, activityPercentageGraphData);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (institution == null ? 0 : institution!.hashCode) +
      (healthcareProfessional == null ? 0 : healthcareProfessional!.hashCode) +
      (user == null ? 0 : user!.hashCode) +
      (activityPercentageGraphData.hashCode);

  @override
  String toString() =>
      'PatientOverviewDTO[institution=$institution, healthcareProfessional=$healthcareProfessional, user=$user, activityPercentageGraphData=$activityPercentageGraphData]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.institution != null) {
      json[r'institution'] = this.institution;
    } else {
      json[r'institution'] = null;
    }
    if (this.healthcareProfessional != null) {
      json[r'healthcareProfessional'] = this.healthcareProfessional;
    } else {
      json[r'healthcareProfessional'] = null;
    }
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
    json[r'activityPercentageGraphData'] = this.activityPercentageGraphData;
    return json;
  }

  /// Returns a new [PatientOverviewDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PatientOverviewDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PatientOverviewDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PatientOverviewDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PatientOverviewDTO(
        institution: InstitutionDTO.fromJson(json[r'institution']),
        healthcareProfessional: HealthcareProfessionalGetDTO.fromJson(
            json[r'healthcareProfessional']),
        user: PatientGetDTO.fromJson(json[r'user']),
        activityPercentageGraphData:
            ActivityGraphDTO.listFromJson(json[r'activityPercentageGraphData']),
      );
    }
    return null;
  }

  static List<PatientOverviewDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatientOverviewDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatientOverviewDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PatientOverviewDTO> mapFromJson(dynamic json) {
    final map = <String, PatientOverviewDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PatientOverviewDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PatientOverviewDTO-objects as value to a dart map
  static Map<String, List<PatientOverviewDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PatientOverviewDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PatientOverviewDTO.listFromJson(
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
