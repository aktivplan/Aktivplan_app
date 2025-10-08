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

class ActivityGraphDTO {
  /// Returns a new [ActivityGraphDTO] instance.
  ActivityGraphDTO({
    this.calendarWeek,
    this.percentage,
    this.activeMinutes,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? calendarWeek;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? percentage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activeMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityGraphDTO &&
          other.calendarWeek == calendarWeek &&
          other.percentage == percentage &&
          other.activeMinutes == activeMinutes;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (calendarWeek == null ? 0 : calendarWeek!.hashCode) +
      (percentage == null ? 0 : percentage!.hashCode) +
      (activeMinutes == null ? 0 : activeMinutes!.hashCode);

  @override
  String toString() =>
      'ActivityGraphDTO[calendarWeek=$calendarWeek, percentage=$percentage, activeMinutes=$activeMinutes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.calendarWeek != null) {
      json[r'calendarWeek'] = this.calendarWeek;
    } else {
      json[r'calendarWeek'] = null;
    }
    if (this.percentage != null) {
      json[r'percentage'] = this.percentage;
    } else {
      json[r'percentage'] = null;
    }
    if (this.activeMinutes != null) {
      json[r'activeMinutes'] = this.activeMinutes;
    } else {
      json[r'activeMinutes'] = null;
    }
    return json;
  }

  /// Returns a new [ActivityGraphDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActivityGraphDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActivityGraphDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActivityGraphDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActivityGraphDTO(
        calendarWeek: mapValueOfType<int>(json, r'calendarWeek'),
        percentage: mapValueOfType<int>(json, r'percentage'),
        activeMinutes: mapValueOfType<int>(json, r'activeMinutes'),
      );
    }
    return null;
  }

  static List<ActivityGraphDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityGraphDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityGraphDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActivityGraphDTO> mapFromJson(dynamic json) {
    final map = <String, ActivityGraphDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActivityGraphDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActivityGraphDTO-objects as value to a dart map
  static Map<String, List<ActivityGraphDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActivityGraphDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActivityGraphDTO.listFromJson(
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
