//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActivityContext {
  /// Returns a new [ActivityContext] instance.
  ActivityContext({
    this.activityId,
    this.weather,
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
  Weather? weather;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityContext &&
          other.activityId == activityId &&
          other.weather == weather;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (activityId == null ? 0 : activityId!.hashCode) +
      (weather == null ? 0 : weather!.hashCode);

  @override
  String toString() =>
      'ActivityContext[activityId=$activityId, weather=$weather]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.activityId != null) {
      json[r'activityId'] = this.activityId;
    } else {
      json[r'activityId'] = null;
    }
    if (this.weather != null) {
      json[r'weather'] = this.weather;
    } else {
      json[r'weather'] = null;
    }
    return json;
  }

  /// Returns a new [ActivityContext] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActivityContext? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActivityContext[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActivityContext[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActivityContext(
        activityId: mapValueOfType<String>(json, r'activityId'),
        weather: Weather.fromJson(json[r'weather']),
      );
    }
    return null;
  }

  static List<ActivityContext> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityContext>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityContext.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActivityContext> mapFromJson(dynamic json) {
    final map = <String, ActivityContext>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActivityContext.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActivityContext-objects as value to a dart map
  static Map<String, List<ActivityContext>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActivityContext>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActivityContext.listFromJson(
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
