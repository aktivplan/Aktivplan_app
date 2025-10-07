//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class HealthcareProfessionalProfileDTO {
  /// Returns a new [HealthcareProfessionalProfileDTO] instance.
  HealthcareProfessionalProfileDTO({
    this.userPicture,
    this.name,
    this.jobName,
    this.activities = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileGetDTO? userPicture;

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
  String? jobName;

  List<ActivityProfileDTO> activities;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthcareProfessionalProfileDTO &&
          other.userPicture == userPicture &&
          other.name == name &&
          other.jobName == jobName &&
          _deepEquality.equals(other.activities, activities);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (userPicture == null ? 0 : userPicture!.hashCode) +
      (name == null ? 0 : name!.hashCode) +
      (jobName == null ? 0 : jobName!.hashCode) +
      (activities.hashCode);

  @override
  String toString() =>
      'HealthcareProfessionalProfileDTO[userPicture=$userPicture, name=$name, jobName=$jobName, activities=$activities]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.userPicture != null) {
      json[r'userPicture'] = this.userPicture;
    } else {
      json[r'userPicture'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.jobName != null) {
      json[r'jobName'] = this.jobName;
    } else {
      json[r'jobName'] = null;
    }
    json[r'activities'] = this.activities;
    return json;
  }

  /// Returns a new [HealthcareProfessionalProfileDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static HealthcareProfessionalProfileDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "HealthcareProfessionalProfileDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "HealthcareProfessionalProfileDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return HealthcareProfessionalProfileDTO(
        userPicture: FileGetDTO.fromJson(json[r'userPicture']),
        name: mapValueOfType<String>(json, r'name'),
        jobName: mapValueOfType<String>(json, r'jobName'),
        activities: ActivityProfileDTO.listFromJson(json[r'activities']),
      );
    }
    return null;
  }

  static List<HealthcareProfessionalProfileDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <HealthcareProfessionalProfileDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HealthcareProfessionalProfileDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, HealthcareProfessionalProfileDTO> mapFromJson(
      dynamic json) {
    final map = <String, HealthcareProfessionalProfileDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = HealthcareProfessionalProfileDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of HealthcareProfessionalProfileDTO-objects as value to a dart map
  static Map<String, List<HealthcareProfessionalProfileDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<HealthcareProfessionalProfileDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = HealthcareProfessionalProfileDTO.listFromJson(
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
