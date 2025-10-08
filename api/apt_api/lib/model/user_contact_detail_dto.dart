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

class UserContactDetailDTO {
  /// Returns a new [UserContactDetailDTO] instance.
  UserContactDetailDTO({
    this.id,
    this.fullName,
    this.lastActiveDateTime,
    this.statusMessage,
    this.profilePicture,
    this.shareActivityData,
    this.shareActiveMinutes,
    this.statusFileCount,
    this.activities = const [],
    this.personalGoals = const [],
    this.patient,
    this.activeMinutes = const [],
  });

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
  String? fullName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastActiveDateTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? statusMessage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileGetDTO? profilePicture;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? shareActivityData;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? shareActiveMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? statusFileCount;

  List<ActivityOverviewDTO> activities;

  List<PersonalGoal> personalGoals;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PatientOverviewDTO? patient;

  List<ActiveMinutesOverviewDTO> activeMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserContactDetailDTO &&
          other.id == id &&
          other.fullName == fullName &&
          other.lastActiveDateTime == lastActiveDateTime &&
          other.statusMessage == statusMessage &&
          other.profilePicture == profilePicture &&
          other.shareActivityData == shareActivityData &&
          other.shareActiveMinutes == shareActiveMinutes &&
          other.statusFileCount == statusFileCount &&
          _deepEquality.equals(other.activities, activities) &&
          _deepEquality.equals(other.personalGoals, personalGoals) &&
          other.patient == patient &&
          _deepEquality.equals(other.activeMinutes, activeMinutes);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (fullName == null ? 0 : fullName!.hashCode) +
      (lastActiveDateTime == null ? 0 : lastActiveDateTime!.hashCode) +
      (statusMessage == null ? 0 : statusMessage!.hashCode) +
      (profilePicture == null ? 0 : profilePicture!.hashCode) +
      (shareActivityData == null ? 0 : shareActivityData!.hashCode) +
      (shareActiveMinutes == null ? 0 : shareActiveMinutes!.hashCode) +
      (statusFileCount == null ? 0 : statusFileCount!.hashCode) +
      (activities.hashCode) +
      (personalGoals.hashCode) +
      (patient == null ? 0 : patient!.hashCode) +
      (activeMinutes.hashCode);

  @override
  String toString() =>
      'UserContactDetailDTO[id=$id, fullName=$fullName, lastActiveDateTime=$lastActiveDateTime, statusMessage=$statusMessage, profilePicture=$profilePicture, shareActivityData=$shareActivityData, shareActiveMinutes=$shareActiveMinutes, statusFileCount=$statusFileCount, activities=$activities, personalGoals=$personalGoals, patient=$patient, activeMinutes=$activeMinutes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.fullName != null) {
      json[r'fullName'] = this.fullName;
    } else {
      json[r'fullName'] = null;
    }
    if (this.lastActiveDateTime != null) {
      json[r'lastActiveDateTime'] = this.lastActiveDateTime;
    } else {
      json[r'lastActiveDateTime'] = null;
    }
    if (this.statusMessage != null) {
      json[r'statusMessage'] = this.statusMessage;
    } else {
      json[r'statusMessage'] = null;
    }
    if (this.profilePicture != null) {
      json[r'profilePicture'] = this.profilePicture;
    } else {
      json[r'profilePicture'] = null;
    }
    if (this.shareActivityData != null) {
      json[r'shareActivityData'] = this.shareActivityData;
    } else {
      json[r'shareActivityData'] = null;
    }
    if (this.shareActiveMinutes != null) {
      json[r'shareActiveMinutes'] = this.shareActiveMinutes;
    } else {
      json[r'shareActiveMinutes'] = null;
    }
    if (this.statusFileCount != null) {
      json[r'statusFileCount'] = this.statusFileCount;
    } else {
      json[r'statusFileCount'] = null;
    }
    json[r'activities'] = this.activities;
    json[r'personalGoals'] = this.personalGoals;
    if (this.patient != null) {
      json[r'patient'] = this.patient;
    } else {
      json[r'patient'] = null;
    }
    json[r'activeMinutes'] = this.activeMinutes;
    return json;
  }

  /// Returns a new [UserContactDetailDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserContactDetailDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "UserContactDetailDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "UserContactDetailDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserContactDetailDTO(
        id: mapValueOfType<String>(json, r'id'),
        fullName: mapValueOfType<String>(json, r'fullName'),
        lastActiveDateTime: mapValueOfType<String>(json, r'lastActiveDateTime'),
        statusMessage: mapValueOfType<String>(json, r'statusMessage'),
        profilePicture: FileGetDTO.fromJson(json[r'profilePicture']),
        shareActivityData: mapValueOfType<bool>(json, r'shareActivityData'),
        shareActiveMinutes: mapValueOfType<bool>(json, r'shareActiveMinutes'),
        statusFileCount: mapValueOfType<int>(json, r'statusFileCount'),
        activities: ActivityOverviewDTO.listFromJson(json[r'activities']),
        personalGoals: PersonalGoal.listFromJson(json[r'personalGoals']),
        patient: PatientOverviewDTO.fromJson(json[r'patient']),
        activeMinutes:
            ActiveMinutesOverviewDTO.listFromJson(json[r'activeMinutes']),
      );
    }
    return null;
  }

  static List<UserContactDetailDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <UserContactDetailDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserContactDetailDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserContactDetailDTO> mapFromJson(dynamic json) {
    final map = <String, UserContactDetailDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserContactDetailDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserContactDetailDTO-objects as value to a dart map
  static Map<String, List<UserContactDetailDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<UserContactDetailDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserContactDetailDTO.listFromJson(
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
