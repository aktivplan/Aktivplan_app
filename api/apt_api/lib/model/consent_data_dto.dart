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

class ConsentDataDTO {
  /// Returns a new [ConsentDataDTO] instance.
  ConsentDataDTO({
    required this.errorCause,
    this.userName,
    this.consents = const [],
    this.userEnabled,
  });

  ConsentErrorCause errorCause;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userName;

  List<ConsentGetDTO> consents;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? userEnabled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentDataDTO &&
          other.errorCause == errorCause &&
          other.userName == userName &&
          _deepEquality.equals(other.consents, consents) &&
          other.userEnabled == userEnabled;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (errorCause.hashCode) +
      (userName == null ? 0 : userName!.hashCode) +
      (consents.hashCode) +
      (userEnabled == null ? 0 : userEnabled!.hashCode);

  @override
  String toString() =>
      'ConsentDataDTO[errorCause=$errorCause, userName=$userName, consents=$consents, userEnabled=$userEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'errorCause'] = this.errorCause;
    if (this.userName != null) {
      json[r'userName'] = this.userName;
    } else {
      json[r'userName'] = null;
    }
    json[r'consents'] = this.consents;
    if (this.userEnabled != null) {
      json[r'userEnabled'] = this.userEnabled;
    } else {
      json[r'userEnabled'] = null;
    }
    return json;
  }

  /// Returns a new [ConsentDataDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConsentDataDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ConsentDataDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ConsentDataDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConsentDataDTO(
        errorCause: ConsentErrorCause.fromJson(json[r'errorCause'])!,
        userName: mapValueOfType<String>(json, r'userName'),
        consents: ConsentGetDTO.listFromJson(json[r'consents']),
        userEnabled: mapValueOfType<bool>(json, r'userEnabled'),
      );
    }
    return null;
  }

  static List<ConsentDataDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ConsentDataDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConsentDataDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConsentDataDTO> mapFromJson(dynamic json) {
    final map = <String, ConsentDataDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConsentDataDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConsentDataDTO-objects as value to a dart map
  static Map<String, List<ConsentDataDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ConsentDataDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConsentDataDTO.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'errorCause',
  };
}
