//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InstitutionDTO {
  /// Returns a new [InstitutionDTO] instance.
  InstitutionDTO({
    this.name,
    this.institutionFocus,
    this.url = const {},
    this.email,
    this.firstName,
    this.lastName,
    this.showTrainingPlans,
    this.allowRescheduleActivities,
    this.enableSocialFeatures,
    this.emailUserQueries,
    this.phoneNumberUserQueries,
    this.availabilityPhone = const {},
    this.getInTouchNotes = const {},
    this.id,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  InstitutionFocus? institutionFocus;

  Map<String, String> url;

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
  bool? showTrainingPlans;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? allowRescheduleActivities;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? enableSocialFeatures;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? emailUserQueries;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? phoneNumberUserQueries;

  Map<String, String> availabilityPhone;

  Map<String, String> getInTouchNotes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstitutionDTO &&
          other.name == name &&
          other.institutionFocus == institutionFocus &&
          _deepEquality.equals(other.url, url) &&
          other.email == email &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.showTrainingPlans == showTrainingPlans &&
          other.allowRescheduleActivities == allowRescheduleActivities &&
          other.enableSocialFeatures == enableSocialFeatures &&
          other.emailUserQueries == emailUserQueries &&
          other.phoneNumberUserQueries == phoneNumberUserQueries &&
          _deepEquality.equals(other.availabilityPhone, availabilityPhone) &&
          _deepEquality.equals(other.getInTouchNotes, getInTouchNotes) &&
          other.id == id;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name == null ? 0 : name!.hashCode) +
      (institutionFocus == null ? 0 : institutionFocus!.hashCode) +
      (url.hashCode) +
      (email == null ? 0 : email!.hashCode) +
      (firstName == null ? 0 : firstName!.hashCode) +
      (lastName == null ? 0 : lastName!.hashCode) +
      (showTrainingPlans == null ? 0 : showTrainingPlans!.hashCode) +
      (allowRescheduleActivities == null
          ? 0
          : allowRescheduleActivities!.hashCode) +
      (enableSocialFeatures == null ? 0 : enableSocialFeatures!.hashCode) +
      (emailUserQueries == null ? 0 : emailUserQueries!.hashCode) +
      (phoneNumberUserQueries == null ? 0 : phoneNumberUserQueries!.hashCode) +
      (availabilityPhone.hashCode) +
      (getInTouchNotes.hashCode) +
      (id == null ? 0 : id!.hashCode);

  @override
  String toString() =>
      'InstitutionDTO[name=$name, institutionFocus=$institutionFocus, url=$url, email=$email, firstName=$firstName, lastName=$lastName, showTrainingPlans=$showTrainingPlans, allowRescheduleActivities=$allowRescheduleActivities, enableSocialFeatures=$enableSocialFeatures, emailUserQueries=$emailUserQueries, phoneNumberUserQueries=$phoneNumberUserQueries, availabilityPhone=$availabilityPhone, getInTouchNotes=$getInTouchNotes, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.institutionFocus != null) {
      json[r'institutionFocus'] = this.institutionFocus;
    } else {
      json[r'institutionFocus'] = null;
    }
    json[r'url'] = this.url;
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
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
    if (this.showTrainingPlans != null) {
      json[r'showTrainingPlans'] = this.showTrainingPlans;
    } else {
      json[r'showTrainingPlans'] = null;
    }
    if (this.allowRescheduleActivities != null) {
      json[r'allowRescheduleActivities'] = this.allowRescheduleActivities;
    } else {
      json[r'allowRescheduleActivities'] = null;
    }
    if (this.enableSocialFeatures != null) {
      json[r'enableSocialFeatures'] = this.enableSocialFeatures;
    } else {
      json[r'enableSocialFeatures'] = null;
    }
    if (this.emailUserQueries != null) {
      json[r'emailUserQueries'] = this.emailUserQueries;
    } else {
      json[r'emailUserQueries'] = null;
    }
    if (this.phoneNumberUserQueries != null) {
      json[r'phoneNumberUserQueries'] = this.phoneNumberUserQueries;
    } else {
      json[r'phoneNumberUserQueries'] = null;
    }
    json[r'availabilityPhone'] = this.availabilityPhone;
    json[r'getInTouchNotes'] = this.getInTouchNotes;
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    return json;
  }

  /// Returns a new [InstitutionDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InstitutionDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "InstitutionDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "InstitutionDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InstitutionDTO(
        name: mapValueOfType<String>(json, r'name'),
        institutionFocus: InstitutionFocus.fromJson(json[r'institutionFocus']),
        url: mapCastOfType<String, String>(json, r'url') ?? const {},
        email: mapValueOfType<String>(json, r'email'),
        firstName: mapValueOfType<String>(json, r'firstName'),
        lastName: mapValueOfType<String>(json, r'lastName'),
        showTrainingPlans: mapValueOfType<bool>(json, r'showTrainingPlans'),
        allowRescheduleActivities:
            mapValueOfType<bool>(json, r'allowRescheduleActivities'),
        enableSocialFeatures:
            mapValueOfType<bool>(json, r'enableSocialFeatures'),
        emailUserQueries: mapValueOfType<String>(json, r'emailUserQueries'),
        phoneNumberUserQueries:
            mapValueOfType<String>(json, r'phoneNumberUserQueries'),
        availabilityPhone:
            mapCastOfType<String, String>(json, r'availabilityPhone') ??
                const {},
        getInTouchNotes:
            mapCastOfType<String, String>(json, r'getInTouchNotes') ?? const {},
        id: mapValueOfType<String>(json, r'id'),
      );
    }
    return null;
  }

  static List<InstitutionDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InstitutionDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InstitutionDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InstitutionDTO> mapFromJson(dynamic json) {
    final map = <String, InstitutionDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InstitutionDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InstitutionDTO-objects as value to a dart map
  static Map<String, List<InstitutionDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<InstitutionDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InstitutionDTO.listFromJson(
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
