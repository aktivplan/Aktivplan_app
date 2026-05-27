//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActiveMinutesDTO {
  /// Returns a new [ActiveMinutesDTO] instance.
  ActiveMinutesDTO({
    this.durationMinutes,
    this.durationMinutesExtra,
    this.activityPointsPredefinedActivity,
    this.activityPointsActiveMobility,
  });

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
  int? durationMinutesExtra;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activityPointsPredefinedActivity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activityPointsActiveMobility;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveMinutesDTO &&
          other.durationMinutes == durationMinutes &&
          other.durationMinutesExtra == durationMinutesExtra &&
          other.activityPointsPredefinedActivity ==
              activityPointsPredefinedActivity &&
          other.activityPointsActiveMobility == activityPointsActiveMobility;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (durationMinutes == null ? 0 : durationMinutes!.hashCode) +
      (durationMinutesExtra == null ? 0 : durationMinutesExtra!.hashCode) +
      (activityPointsPredefinedActivity == null
          ? 0
          : activityPointsPredefinedActivity!.hashCode) +
      (activityPointsActiveMobility == null
          ? 0
          : activityPointsActiveMobility!.hashCode);

  @override
  String toString() =>
      'ActiveMinutesDTO[durationMinutes=$durationMinutes, durationMinutesExtra=$durationMinutesExtra, activityPointsPredefinedActivity=$activityPointsPredefinedActivity, activityPointsActiveMobility=$activityPointsActiveMobility]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.durationMinutes != null) {
      json[r'durationMinutes'] = this.durationMinutes;
    } else {
      json[r'durationMinutes'] = null;
    }
    if (this.durationMinutesExtra != null) {
      json[r'durationMinutesExtra'] = this.durationMinutesExtra;
    } else {
      json[r'durationMinutesExtra'] = null;
    }
    if (this.activityPointsPredefinedActivity != null) {
      json[r'activityPointsPredefinedActivity'] =
          this.activityPointsPredefinedActivity;
    } else {
      json[r'activityPointsPredefinedActivity'] = null;
    }
    if (this.activityPointsActiveMobility != null) {
      json[r'activityPointsActiveMobility'] = this.activityPointsActiveMobility;
    } else {
      json[r'activityPointsActiveMobility'] = null;
    }
    return json;
  }

  /// Returns a new [ActiveMinutesDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActiveMinutesDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActiveMinutesDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActiveMinutesDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActiveMinutesDTO(
        durationMinutes: mapValueOfType<int>(json, r'durationMinutes'),
        durationMinutesExtra:
            mapValueOfType<int>(json, r'durationMinutesExtra'),
        activityPointsPredefinedActivity:
            mapValueOfType<int>(json, r'activityPointsPredefinedActivity'),
        activityPointsActiveMobility:
            mapValueOfType<int>(json, r'activityPointsActiveMobility'),
      );
    }
    return null;
  }

  static List<ActiveMinutesDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActiveMinutesDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActiveMinutesDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActiveMinutesDTO> mapFromJson(dynamic json) {
    final map = <String, ActiveMinutesDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActiveMinutesDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActiveMinutesDTO-objects as value to a dart map
  static Map<String, List<ActiveMinutesDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActiveMinutesDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActiveMinutesDTO.listFromJson(
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
