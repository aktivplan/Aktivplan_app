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

class ResetPasswordDTO {
  /// Returns a new [ResetPasswordDTO] instance.
  ResetPasswordDTO({
    this.resetKey,
    this.password,
    this.acceptedConsents = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? resetKey;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? password;

  Map<String, int> acceptedConsents;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResetPasswordDTO &&
          other.resetKey == resetKey &&
          other.password == password &&
          _deepEquality.equals(other.acceptedConsents, acceptedConsents);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (resetKey == null ? 0 : resetKey!.hashCode) +
      (password == null ? 0 : password!.hashCode) +
      (acceptedConsents.hashCode);

  @override
  String toString() =>
      'ResetPasswordDTO[resetKey=$resetKey, password=$password, acceptedConsents=$acceptedConsents]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.resetKey != null) {
      json[r'resetKey'] = this.resetKey;
    } else {
      json[r'resetKey'] = null;
    }
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
    json[r'acceptedConsents'] = this.acceptedConsents;
    return json;
  }

  /// Returns a new [ResetPasswordDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResetPasswordDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ResetPasswordDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ResetPasswordDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResetPasswordDTO(
        resetKey: mapValueOfType<String>(json, r'resetKey'),
        password: mapValueOfType<String>(json, r'password'),
        acceptedConsents:
            mapCastOfType<String, int>(json, r'acceptedConsents') ?? const {},
      );
    }
    return null;
  }

  static List<ResetPasswordDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ResetPasswordDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResetPasswordDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResetPasswordDTO> mapFromJson(dynamic json) {
    final map = <String, ResetPasswordDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResetPasswordDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResetPasswordDTO-objects as value to a dart map
  static Map<String, List<ResetPasswordDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ResetPasswordDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResetPasswordDTO.listFromJson(
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
