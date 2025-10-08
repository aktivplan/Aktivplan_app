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

class ExtraActivityPostDTO {
  /// Returns a new [ExtraActivityPostDTO] instance.
  ExtraActivityPostDTO({
    this.date,
    this.name,
    this.heartrate,
    this.durationMinutes,
    this.done,
    this.note,
    this.rating,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? date;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtraActivityPostDTO &&
          other.date == date &&
          other.name == name &&
          other.heartrate == heartrate &&
          other.durationMinutes == durationMinutes &&
          other.done == done &&
          other.note == note &&
          other.rating == rating;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (date == null ? 0 : date!.hashCode) +
      (name == null ? 0 : name!.hashCode) +
      (heartrate == null ? 0 : heartrate!.hashCode) +
      (durationMinutes == null ? 0 : durationMinutes!.hashCode) +
      (done == null ? 0 : done!.hashCode) +
      (note == null ? 0 : note!.hashCode) +
      (rating == null ? 0 : rating!.hashCode);

  @override
  String toString() =>
      'ExtraActivityPostDTO[date=$date, name=$name, heartrate=$heartrate, durationMinutes=$durationMinutes, done=$done, note=$note, rating=$rating]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.date != null) {
      json[r'date'] = this.date;
    } else {
      json[r'date'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
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
    return json;
  }

  /// Returns a new [ExtraActivityPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExtraActivityPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ExtraActivityPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ExtraActivityPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExtraActivityPostDTO(
        date: mapValueOfType<String>(json, r'date'),
        name: mapValueOfType<String>(json, r'name'),
        heartrate: mapValueOfType<int>(json, r'heartrate'),
        durationMinutes: mapValueOfType<int>(json, r'durationMinutes'),
        done: mapValueOfType<bool>(json, r'done'),
        note: mapValueOfType<String>(json, r'note'),
        rating: mapValueOfType<int>(json, r'rating'),
      );
    }
    return null;
  }

  static List<ExtraActivityPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ExtraActivityPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExtraActivityPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExtraActivityPostDTO> mapFromJson(dynamic json) {
    final map = <String, ExtraActivityPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExtraActivityPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExtraActivityPostDTO-objects as value to a dart map
  static Map<String, List<ExtraActivityPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ExtraActivityPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExtraActivityPostDTO.listFromJson(
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
