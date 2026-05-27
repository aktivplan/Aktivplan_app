//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StatusFileDTO {
  /// Returns a new [StatusFileDTO] instance.
  StatusFileDTO({
    this.id,
    this.fileType,
    this.statusText,
    this.file,
    this.ageInMinutes,
    this.seenByUser,
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
  StatusFileType? fileType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? statusText;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileGetDTO? file;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? ageInMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? seenByUser;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusFileDTO &&
          other.id == id &&
          other.fileType == fileType &&
          other.statusText == statusText &&
          other.file == file &&
          other.ageInMinutes == ageInMinutes &&
          other.seenByUser == seenByUser;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (fileType == null ? 0 : fileType!.hashCode) +
      (statusText == null ? 0 : statusText!.hashCode) +
      (file == null ? 0 : file!.hashCode) +
      (ageInMinutes == null ? 0 : ageInMinutes!.hashCode) +
      (seenByUser == null ? 0 : seenByUser!.hashCode);

  @override
  String toString() =>
      'StatusFileDTO[id=$id, fileType=$fileType, statusText=$statusText, file=$file, ageInMinutes=$ageInMinutes, seenByUser=$seenByUser]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.fileType != null) {
      json[r'fileType'] = this.fileType;
    } else {
      json[r'fileType'] = null;
    }
    if (this.statusText != null) {
      json[r'statusText'] = this.statusText;
    } else {
      json[r'statusText'] = null;
    }
    if (this.file != null) {
      json[r'file'] = this.file;
    } else {
      json[r'file'] = null;
    }
    if (this.ageInMinutes != null) {
      json[r'ageInMinutes'] = this.ageInMinutes;
    } else {
      json[r'ageInMinutes'] = null;
    }
    if (this.seenByUser != null) {
      json[r'seenByUser'] = this.seenByUser;
    } else {
      json[r'seenByUser'] = null;
    }
    return json;
  }

  /// Returns a new [StatusFileDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StatusFileDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "StatusFileDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "StatusFileDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StatusFileDTO(
        id: mapValueOfType<String>(json, r'id'),
        fileType: StatusFileType.fromJson(json[r'fileType']),
        statusText: mapValueOfType<String>(json, r'statusText'),
        file: FileGetDTO.fromJson(json[r'file']),
        ageInMinutes: mapValueOfType<int>(json, r'ageInMinutes'),
        seenByUser: mapValueOfType<bool>(json, r'seenByUser'),
      );
    }
    return null;
  }

  static List<StatusFileDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <StatusFileDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StatusFileDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StatusFileDTO> mapFromJson(dynamic json) {
    final map = <String, StatusFileDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StatusFileDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StatusFileDTO-objects as value to a dart map
  static Map<String, List<StatusFileDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<StatusFileDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StatusFileDTO.listFromJson(
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
