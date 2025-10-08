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

class ActivityProfileDTO {
  /// Returns a new [ActivityProfileDTO] instance.
  ActivityProfileDTO({
    this.name,
    this.type,
    this.repeats,
    this.days = const [],
  });

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
  ActivityType? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ActivityRepeat? repeats;

  List<DayOfWeek> days;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityProfileDTO &&
          other.name == name &&
          other.type == type &&
          other.repeats == repeats &&
          _deepEquality.equals(other.days, days);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name == null ? 0 : name!.hashCode) +
      (type == null ? 0 : type!.hashCode) +
      (repeats == null ? 0 : repeats!.hashCode) +
      (days.hashCode);

  @override
  String toString() =>
      'ActivityProfileDTO[name=$name, type=$type, repeats=$repeats, days=$days]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.repeats != null) {
      json[r'repeats'] = this.repeats;
    } else {
      json[r'repeats'] = null;
    }
    json[r'days'] = this.days;
    return json;
  }

  /// Returns a new [ActivityProfileDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActivityProfileDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActivityProfileDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActivityProfileDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActivityProfileDTO(
        name: mapValueOfType<String>(json, r'name'),
        type: ActivityType.fromJson(json[r'type']),
        repeats: ActivityRepeat.fromJson(json[r'repeats']),
        days: DayOfWeek.listFromJson(json[r'days']),
      );
    }
    return null;
  }

  static List<ActivityProfileDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityProfileDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityProfileDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActivityProfileDTO> mapFromJson(dynamic json) {
    final map = <String, ActivityProfileDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActivityProfileDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActivityProfileDTO-objects as value to a dart map
  static Map<String, List<ActivityProfileDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActivityProfileDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActivityProfileDTO.listFromJson(
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
