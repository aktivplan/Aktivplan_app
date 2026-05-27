//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WeatherWarning {
  /// Returns a new [WeatherWarning] instance.
  WeatherWarning({
    this.type,
    this.message,
    this.geoScope,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? geoScope;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherWarning &&
          other.type == type &&
          other.message == message &&
          other.geoScope == geoScope;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (type == null ? 0 : type!.hashCode) +
      (message == null ? 0 : message!.hashCode) +
      (geoScope == null ? 0 : geoScope!.hashCode);

  @override
  String toString() =>
      'WeatherWarning[type=$type, message=$message, geoScope=$geoScope]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.message != null) {
      json[r'message'] = this.message;
    } else {
      json[r'message'] = null;
    }
    if (this.geoScope != null) {
      json[r'geo_scope'] = this.geoScope;
    } else {
      json[r'geo_scope'] = null;
    }
    return json;
  }

  /// Returns a new [WeatherWarning] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WeatherWarning? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "WeatherWarning[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "WeatherWarning[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WeatherWarning(
        type: mapValueOfType<String>(json, r'type'),
        message: mapValueOfType<String>(json, r'message'),
        geoScope: mapValueOfType<String>(json, r'geo_scope'),
      );
    }
    return null;
  }

  static List<WeatherWarning> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WeatherWarning>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WeatherWarning.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WeatherWarning> mapFromJson(dynamic json) {
    final map = <String, WeatherWarning>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WeatherWarning.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WeatherWarning-objects as value to a dart map
  static Map<String, List<WeatherWarning>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<WeatherWarning>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WeatherWarning.listFromJson(
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
