//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserContactDTO {
  /// Returns a new [UserContactDTO] instance.
  UserContactDTO({
    this.id,
    this.fullName,
    this.profilePicture,
    this.storyPictureThumbnail,
    this.statusFilesCount,
    this.seenStatusFilesCount,
    this.activityPercentageCurrentWeek,
    this.shareActivityData,
    this.statusMessage,
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
  FileGetDTO? profilePicture;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileGetDTO? storyPictureThumbnail;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? statusFilesCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? seenStatusFilesCount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activityPercentageCurrentWeek;

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
  String? statusMessage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserContactDTO &&
          other.id == id &&
          other.fullName == fullName &&
          other.profilePicture == profilePicture &&
          other.storyPictureThumbnail == storyPictureThumbnail &&
          other.statusFilesCount == statusFilesCount &&
          other.seenStatusFilesCount == seenStatusFilesCount &&
          other.activityPercentageCurrentWeek ==
              activityPercentageCurrentWeek &&
          other.shareActivityData == shareActivityData &&
          other.statusMessage == statusMessage;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (fullName == null ? 0 : fullName!.hashCode) +
      (profilePicture == null ? 0 : profilePicture!.hashCode) +
      (storyPictureThumbnail == null ? 0 : storyPictureThumbnail!.hashCode) +
      (statusFilesCount == null ? 0 : statusFilesCount!.hashCode) +
      (seenStatusFilesCount == null ? 0 : seenStatusFilesCount!.hashCode) +
      (activityPercentageCurrentWeek == null
          ? 0
          : activityPercentageCurrentWeek!.hashCode) +
      (shareActivityData == null ? 0 : shareActivityData!.hashCode) +
      (statusMessage == null ? 0 : statusMessage!.hashCode);

  @override
  String toString() =>
      'UserContactDTO[id=$id, fullName=$fullName, profilePicture=$profilePicture, storyPictureThumbnail=$storyPictureThumbnail, statusFilesCount=$statusFilesCount, seenStatusFilesCount=$seenStatusFilesCount, activityPercentageCurrentWeek=$activityPercentageCurrentWeek, shareActivityData=$shareActivityData, statusMessage=$statusMessage]';

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
    if (this.profilePicture != null) {
      json[r'profilePicture'] = this.profilePicture;
    } else {
      json[r'profilePicture'] = null;
    }
    if (this.storyPictureThumbnail != null) {
      json[r'storyPictureThumbnail'] = this.storyPictureThumbnail;
    } else {
      json[r'storyPictureThumbnail'] = null;
    }
    if (this.statusFilesCount != null) {
      json[r'statusFilesCount'] = this.statusFilesCount;
    } else {
      json[r'statusFilesCount'] = null;
    }
    if (this.seenStatusFilesCount != null) {
      json[r'seenStatusFilesCount'] = this.seenStatusFilesCount;
    } else {
      json[r'seenStatusFilesCount'] = null;
    }
    if (this.activityPercentageCurrentWeek != null) {
      json[r'activityPercentageCurrentWeek'] =
          this.activityPercentageCurrentWeek;
    } else {
      json[r'activityPercentageCurrentWeek'] = null;
    }
    if (this.shareActivityData != null) {
      json[r'shareActivityData'] = this.shareActivityData;
    } else {
      json[r'shareActivityData'] = null;
    }
    if (this.statusMessage != null) {
      json[r'statusMessage'] = this.statusMessage;
    } else {
      json[r'statusMessage'] = null;
    }
    return json;
  }

  /// Returns a new [UserContactDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserContactDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "UserContactDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "UserContactDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserContactDTO(
        id: mapValueOfType<String>(json, r'id'),
        fullName: mapValueOfType<String>(json, r'fullName'),
        profilePicture: FileGetDTO.fromJson(json[r'profilePicture']),
        storyPictureThumbnail:
            FileGetDTO.fromJson(json[r'storyPictureThumbnail']),
        statusFilesCount: mapValueOfType<int>(json, r'statusFilesCount'),
        seenStatusFilesCount:
            mapValueOfType<int>(json, r'seenStatusFilesCount'),
        activityPercentageCurrentWeek:
            mapValueOfType<int>(json, r'activityPercentageCurrentWeek'),
        shareActivityData: mapValueOfType<bool>(json, r'shareActivityData'),
        statusMessage: mapValueOfType<String>(json, r'statusMessage'),
      );
    }
    return null;
  }

  static List<UserContactDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <UserContactDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserContactDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserContactDTO> mapFromJson(dynamic json) {
    final map = <String, UserContactDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserContactDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserContactDTO-objects as value to a dart map
  static Map<String, List<UserContactDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<UserContactDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserContactDTO.listFromJson(
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
