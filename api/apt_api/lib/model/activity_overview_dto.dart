//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActivityOverviewDTO {
  /// Returns a new [ActivityOverviewDTO] instance.
  ActivityOverviewDTO({
    this.activityId,
    this.date,
    this.time,
    this.endTime,
    this.name = const {},
    this.durationMinutes,
    this.plannedDurationMinutes,
    this.type,
    this.repeats,
    this.healthcareProfessionalName,
    this.plannedBy,
    this.rating,
    this.activity,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? activityId;

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
  String? time;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endTime;

  Map<String, String> name;

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
  int? plannedDurationMinutes;

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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? healthcareProfessionalName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? plannedBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ActivityPatientRatingPostDTO? rating;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ActivityPostDTO? activity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityOverviewDTO &&
          other.activityId == activityId &&
          other.date == date &&
          other.time == time &&
          other.endTime == endTime &&
          _deepEquality.equals(other.name, name) &&
          other.durationMinutes == durationMinutes &&
          other.plannedDurationMinutes == plannedDurationMinutes &&
          other.type == type &&
          other.repeats == repeats &&
          other.healthcareProfessionalName == healthcareProfessionalName &&
          other.plannedBy == plannedBy &&
          other.rating == rating &&
          other.activity == activity;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (activityId == null ? 0 : activityId!.hashCode) +
      (date == null ? 0 : date!.hashCode) +
      (time == null ? 0 : time!.hashCode) +
      (endTime == null ? 0 : endTime!.hashCode) +
      (name.hashCode) +
      (durationMinutes == null ? 0 : durationMinutes!.hashCode) +
      (plannedDurationMinutes == null ? 0 : plannedDurationMinutes!.hashCode) +
      (type == null ? 0 : type!.hashCode) +
      (repeats == null ? 0 : repeats!.hashCode) +
      (healthcareProfessionalName == null
          ? 0
          : healthcareProfessionalName!.hashCode) +
      (plannedBy == null ? 0 : plannedBy!.hashCode) +
      (rating == null ? 0 : rating!.hashCode) +
      (activity == null ? 0 : activity!.hashCode);

  @override
  String toString() =>
      'ActivityOverviewDTO[activityId=$activityId, date=$date, time=$time, endTime=$endTime, name=$name, durationMinutes=$durationMinutes, plannedDurationMinutes=$plannedDurationMinutes, type=$type, repeats=$repeats, healthcareProfessionalName=$healthcareProfessionalName, plannedBy=$plannedBy, rating=$rating, activity=$activity]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.activityId != null) {
      json[r'activityId'] = this.activityId;
    } else {
      json[r'activityId'] = null;
    }
    if (this.date != null) {
      json[r'date'] = this.date;
    } else {
      json[r'date'] = null;
    }
    if (this.time != null) {
      json[r'time'] = this.time;
    } else {
      json[r'time'] = null;
    }
    if (this.endTime != null) {
      json[r'endTime'] = this.endTime;
    } else {
      json[r'endTime'] = null;
    }
    json[r'name'] = this.name;
    if (this.durationMinutes != null) {
      json[r'durationMinutes'] = this.durationMinutes;
    } else {
      json[r'durationMinutes'] = null;
    }
    if (this.plannedDurationMinutes != null) {
      json[r'plannedDurationMinutes'] = this.plannedDurationMinutes;
    } else {
      json[r'plannedDurationMinutes'] = null;
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
    if (this.healthcareProfessionalName != null) {
      json[r'healthcareProfessionalName'] = this.healthcareProfessionalName;
    } else {
      json[r'healthcareProfessionalName'] = null;
    }
    if (this.plannedBy != null) {
      json[r'plannedBy'] = this.plannedBy;
    } else {
      json[r'plannedBy'] = null;
    }
    if (this.rating != null) {
      json[r'rating'] = this.rating;
    } else {
      json[r'rating'] = null;
    }
    if (this.activity != null) {
      json[r'activity'] = this.activity;
    } else {
      json[r'activity'] = null;
    }
    return json;
  }

  /// Returns a new [ActivityOverviewDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActivityOverviewDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActivityOverviewDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActivityOverviewDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActivityOverviewDTO(
        activityId: mapValueOfType<String>(json, r'activityId'),
        date: mapValueOfType<String>(json, r'date'),
        time: mapValueOfType<String>(json, r'time'),
        endTime: mapValueOfType<String>(json, r'endTime'),
        name: mapCastOfType<String, String>(json, r'name') ?? const {},
        durationMinutes: mapValueOfType<int>(json, r'durationMinutes'),
        plannedDurationMinutes:
            mapValueOfType<int>(json, r'plannedDurationMinutes'),
        type: ActivityType.fromJson(json[r'type']),
        repeats: ActivityRepeat.fromJson(json[r'repeats']),
        healthcareProfessionalName:
            mapValueOfType<String>(json, r'healthcareProfessionalName'),
        plannedBy: mapValueOfType<String>(json, r'plannedBy'),
        rating: ActivityPatientRatingPostDTO.fromJson(json[r'rating']),
        activity: ActivityPostDTO.fromJson(json[r'activity']),
      );
    }
    return null;
  }

  static List<ActivityOverviewDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityOverviewDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityOverviewDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActivityOverviewDTO> mapFromJson(dynamic json) {
    final map = <String, ActivityOverviewDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActivityOverviewDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActivityOverviewDTO-objects as value to a dart map
  static Map<String, List<ActivityOverviewDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActivityOverviewDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActivityOverviewDTO.listFromJson(
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
