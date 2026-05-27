//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserContactOverviewDTO {
  /// Returns a new [UserContactOverviewDTO] instance.
  UserContactOverviewDTO({
    this.profilePicture,
    this.storyPictureThumbnail,
    this.statusFilesCount,
    this.seenStatusFilesCount,
    this.contacts = const [],
  });

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

  List<UserContactDTO> contacts;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserContactOverviewDTO &&
          other.profilePicture == profilePicture &&
          other.storyPictureThumbnail == storyPictureThumbnail &&
          other.statusFilesCount == statusFilesCount &&
          other.seenStatusFilesCount == seenStatusFilesCount &&
          _deepEquality.equals(other.contacts, contacts);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (profilePicture == null ? 0 : profilePicture!.hashCode) +
      (storyPictureThumbnail == null ? 0 : storyPictureThumbnail!.hashCode) +
      (statusFilesCount == null ? 0 : statusFilesCount!.hashCode) +
      (seenStatusFilesCount == null ? 0 : seenStatusFilesCount!.hashCode) +
      (contacts.hashCode);

  @override
  String toString() =>
      'UserContactOverviewDTO[profilePicture=$profilePicture, storyPictureThumbnail=$storyPictureThumbnail, statusFilesCount=$statusFilesCount, seenStatusFilesCount=$seenStatusFilesCount, contacts=$contacts]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
    json[r'contacts'] = this.contacts;
    return json;
  }

  /// Returns a new [UserContactOverviewDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserContactOverviewDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "UserContactOverviewDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "UserContactOverviewDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserContactOverviewDTO(
        profilePicture: FileGetDTO.fromJson(json[r'profilePicture']),
        storyPictureThumbnail:
            FileGetDTO.fromJson(json[r'storyPictureThumbnail']),
        statusFilesCount: mapValueOfType<int>(json, r'statusFilesCount'),
        seenStatusFilesCount:
            mapValueOfType<int>(json, r'seenStatusFilesCount'),
        contacts: UserContactDTO.listFromJson(json[r'contacts']),
      );
    }
    return null;
  }

  static List<UserContactOverviewDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <UserContactOverviewDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserContactOverviewDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserContactOverviewDTO> mapFromJson(dynamic json) {
    final map = <String, UserContactOverviewDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserContactOverviewDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserContactOverviewDTO-objects as value to a dart map
  static Map<String, List<UserContactOverviewDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<UserContactOverviewDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserContactOverviewDTO.listFromJson(
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
