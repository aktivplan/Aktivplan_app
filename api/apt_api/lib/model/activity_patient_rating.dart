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

class ActivityPatientRating {
  /// Returns a new [ActivityPatientRating] instance.
  ActivityPatientRating({
    this.intensityPercentage,
    this.heartrate,
    this.durationMinutes,
    this.done,
    this.note,
    this.rating,
    this.date,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? intensityPercentage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? heartrate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? durationMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? done;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? note;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? rating;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? date;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityPatientRating &&
          other.intensityPercentage == intensityPercentage &&
          other.heartrate == heartrate &&
          other.durationMinutes == durationMinutes &&
          other.done == done &&
          other.note == note &&
          other.rating == rating &&
          other.date == date;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (intensityPercentage == null ? 0 : intensityPercentage!.hashCode) +
      (heartrate == null ? 0 : heartrate!.hashCode) +
      (durationMinutes == null ? 0 : durationMinutes!.hashCode) +
      (done == null ? 0 : done!.hashCode) +
      (note == null ? 0 : note!.hashCode) +
      (rating == null ? 0 : rating!.hashCode) +
      (date == null ? 0 : date!.hashCode);

  @override
  String toString() =>
      'ActivityPatientRating[intensityPercentage=$intensityPercentage, heartrate=$heartrate, durationMinutes=$durationMinutes, done=$done, note=$note, rating=$rating, date=$date]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.intensityPercentage != null) {
      json[r'intensityPercentage'] = this.intensityPercentage;
    } else {
      json[r'intensityPercentage'] = null;
    }
    if (this.heartrate != null) {
      json[r'heartrate'] = this.heartrate;
    } else {
      json[r'heartrate'] = null;
    }
    if (this.durationMinutes != null) {
      json[r'durationMinutes'] = this.durationMinutes;
    } else {
      json[r'durationMinutes'] = null;
    }
    if (this.done != null) {
      json[r'done'] = this.done;
    } else {
      json[r'done'] = null;
    }
    if (this.note != null) {
      json[r'note'] = this.note;
    } else {
      json[r'note'] = null;
    }
    if (this.rating != null) {
      json[r'rating'] = this.rating;
    } else {
      json[r'rating'] = null;
    }
    if (this.date != null) {
      json[r'date'] = this.date;
    } else {
      json[r'date'] = null;
    }
    return json;
  }

  /// Returns a new [ActivityPatientRating] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActivityPatientRating? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActivityPatientRating[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActivityPatientRating[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActivityPatientRating(
        intensityPercentage: mapValueOfType<int>(json, r'intensityPercentage'),
        heartrate: mapValueOfType<int>(json, r'heartrate'),
        durationMinutes: mapValueOfType<int>(json, r'durationMinutes'),
        done: mapValueOfType<bool>(json, r'done'),
        note: mapValueOfType<String>(json, r'note'),
        rating: mapValueOfType<int>(json, r'rating'),
        date: mapValueOfType<String>(json, r'date'),
      );
    }
    return null;
  }

  static List<ActivityPatientRating> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityPatientRating>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityPatientRating.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActivityPatientRating> mapFromJson(dynamic json) {
    final map = <String, ActivityPatientRating>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActivityPatientRating.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActivityPatientRating-objects as value to a dart map
  static Map<String, List<ActivityPatientRating>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActivityPatientRating>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActivityPatientRating.listFromJson(
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
