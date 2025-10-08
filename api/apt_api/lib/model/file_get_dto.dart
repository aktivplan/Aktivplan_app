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

class FileGetDTO {
  /// Returns a new [FileGetDTO] instance.
  FileGetDTO({
    this.exists,
    this.url,
    this.filename,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? exists;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? url;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? filename;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileGetDTO &&
          other.exists == exists &&
          other.url == url &&
          other.filename == filename;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (exists == null ? 0 : exists!.hashCode) +
      (url == null ? 0 : url!.hashCode) +
      (filename == null ? 0 : filename!.hashCode);

  @override
  String toString() =>
      'FileGetDTO[exists=$exists, url=$url, filename=$filename]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.exists != null) {
      json[r'exists'] = this.exists;
    } else {
      json[r'exists'] = null;
    }
    if (this.url != null) {
      json[r'url'] = this.url;
    } else {
      json[r'url'] = null;
    }
    if (this.filename != null) {
      json[r'filename'] = this.filename;
    } else {
      json[r'filename'] = null;
    }
    return json;
  }

  /// Returns a new [FileGetDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FileGetDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "FileGetDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "FileGetDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FileGetDTO(
        exists: mapValueOfType<bool>(json, r'exists'),
        url: mapValueOfType<String>(json, r'url'),
        filename: mapValueOfType<String>(json, r'filename'),
      );
    }
    return null;
  }

  static List<FileGetDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <FileGetDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileGetDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FileGetDTO> mapFromJson(dynamic json) {
    final map = <String, FileGetDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FileGetDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FileGetDTO-objects as value to a dart map
  static Map<String, List<FileGetDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<FileGetDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FileGetDTO.listFromJson(
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
