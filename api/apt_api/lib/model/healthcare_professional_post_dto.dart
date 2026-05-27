//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class HealthcareProfessionalPostDTO {
  /// Returns a new [HealthcareProfessionalPostDTO] instance.
  HealthcareProfessionalPostDTO({
    this.email,
    this.institutionId,
    this.firstName,
    this.lastName,
    this.jobName,
    this.hasSelfSignIn,
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
  String? jobName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? hasSelfSignIn;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthcareProfessionalPostDTO &&
          other.email == email &&
          other.institutionId == institutionId &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.jobName == jobName &&
          other.hasSelfSignIn == hasSelfSignIn;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (email == null ? 0 : email!.hashCode) +
      (institutionId == null ? 0 : institutionId!.hashCode) +
      (firstName == null ? 0 : firstName!.hashCode) +
      (lastName == null ? 0 : lastName!.hashCode) +
      (jobName == null ? 0 : jobName!.hashCode) +
      (hasSelfSignIn == null ? 0 : hasSelfSignIn!.hashCode);

  @override
  String toString() =>
      'HealthcareProfessionalPostDTO[email=$email, institutionId=$institutionId, firstName=$firstName, lastName=$lastName, jobName=$jobName, hasSelfSignIn=$hasSelfSignIn]';

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
    if (this.jobName != null) {
      json[r'jobName'] = this.jobName;
    } else {
      json[r'jobName'] = null;
    }
    if (this.hasSelfSignIn != null) {
      json[r'hasSelfSignIn'] = this.hasSelfSignIn;
    } else {
      json[r'hasSelfSignIn'] = null;
    }
    return json;
  }

  /// Returns a new [HealthcareProfessionalPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static HealthcareProfessionalPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "HealthcareProfessionalPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "HealthcareProfessionalPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return HealthcareProfessionalPostDTO(
        email: mapValueOfType<String>(json, r'email'),
        institutionId: mapValueOfType<String>(json, r'institutionId'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        jobName: mapValueOfType<String>(json, r'jobName'),
        hasSelfSignIn: mapValueOfType<bool>(json, r'hasSelfSignIn'),
      );
    }
    return null;
  }

  static List<HealthcareProfessionalPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <HealthcareProfessionalPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HealthcareProfessionalPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, HealthcareProfessionalPostDTO> mapFromJson(dynamic json) {
    final map = <String, HealthcareProfessionalPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = HealthcareProfessionalPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of HealthcareProfessionalPostDTO-objects as value to a dart map
  static Map<String, List<HealthcareProfessionalPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<HealthcareProfessionalPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = HealthcareProfessionalPostDTO.listFromJson(
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
