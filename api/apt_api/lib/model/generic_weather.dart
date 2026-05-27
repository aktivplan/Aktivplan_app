//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GenericWeather {
  /// Returns a new [GenericWeather] instance.
  GenericWeather({
    this.places = const [],
    this.warnings = const [],
  });

  List<Weather> places;

  List<WeatherWarning> warnings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenericWeather &&
          _deepEquality.equals(other.places, places) &&
          _deepEquality.equals(other.warnings, warnings);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (places.hashCode) + (warnings.hashCode);

  @override
  String toString() => 'GenericWeather[places=$places, warnings=$warnings]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'places'] = this.places;
    json[r'warnings'] = this.warnings;
    return json;
  }

  /// Returns a new [GenericWeather] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GenericWeather? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "GenericWeather[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "GenericWeather[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GenericWeather(
        places: Weather.listFromJson(json[r'places']),
        warnings: WeatherWarning.listFromJson(json[r'warnings']),
      );
    }
    return null;
  }

  static List<GenericWeather> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <GenericWeather>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GenericWeather.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GenericWeather> mapFromJson(dynamic json) {
    final map = <String, GenericWeather>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GenericWeather.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GenericWeather-objects as value to a dart map
  static Map<String, List<GenericWeather>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<GenericWeather>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GenericWeather.listFromJson(
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
