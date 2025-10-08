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

class PersonalGoalPostDTO {
  /// Returns a new [PersonalGoalPostDTO] instance.
  PersonalGoalPostDTO({
    this.patientId,
    this.description,
    this.details,
    this.endDate,
    this.done,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? patientId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? details;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? done;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalGoalPostDTO &&
          other.patientId == patientId &&
          other.description == description &&
          other.details == details &&
          other.endDate == endDate &&
          other.done == done;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (patientId == null ? 0 : patientId!.hashCode) +
      (description == null ? 0 : description!.hashCode) +
      (details == null ? 0 : details!.hashCode) +
      (endDate == null ? 0 : endDate!.hashCode) +
      (done == null ? 0 : done!.hashCode);

  @override
  String toString() =>
      'PersonalGoalPostDTO[patientId=$patientId, description=$description, details=$details, endDate=$endDate, done=$done]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.patientId != null) {
      json[r'patientId'] = this.patientId;
    } else {
      json[r'patientId'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.details != null) {
      json[r'details'] = this.details;
    } else {
      json[r'details'] = null;
    }
    if (this.endDate != null) {
      json[r'endDate'] = this.endDate;
    } else {
      json[r'endDate'] = null;
    }
    if (this.done != null) {
      json[r'done'] = this.done;
    } else {
      json[r'done'] = null;
    }
    return json;
  }

  /// Returns a new [PersonalGoalPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PersonalGoalPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PersonalGoalPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PersonalGoalPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PersonalGoalPostDTO(
        patientId: mapValueOfType<String>(json, r'patientId'),
        description: mapValueOfType<String>(json, r'description'),
        details: mapValueOfType<String>(json, r'details'),
        endDate: mapValueOfType<String>(json, r'endDate'),
        done: mapValueOfType<bool>(json, r'done'),
      );
    }
    return null;
  }

  static List<PersonalGoalPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PersonalGoalPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PersonalGoalPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PersonalGoalPostDTO> mapFromJson(dynamic json) {
    final map = <String, PersonalGoalPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PersonalGoalPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PersonalGoalPostDTO-objects as value to a dart map
  static Map<String, List<PersonalGoalPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PersonalGoalPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PersonalGoalPostDTO.listFromJson(
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
