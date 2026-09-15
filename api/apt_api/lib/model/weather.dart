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

class Weather {
  /// Returns a new [Weather] instance.
  Weather({
    this.placeName,
    this.time,
    this.lat,
    this.lon,
    this.temperature,
    this.precipitation,
    this.windspeed,
    this.wbgt,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? placeName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? time;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? lat;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? lon;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? temperature;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? precipitation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? windspeed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? wbgt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          other.placeName == placeName &&
          other.time == time &&
          other.lat == lat &&
          other.lon == lon &&
          other.temperature == temperature &&
          other.precipitation == precipitation &&
          other.windspeed == windspeed &&
          other.wbgt == wbgt;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (placeName == null ? 0 : placeName!.hashCode) +
      (time == null ? 0 : time!.hashCode) +
      (lat == null ? 0 : lat!.hashCode) +
      (lon == null ? 0 : lon!.hashCode) +
      (temperature == null ? 0 : temperature!.hashCode) +
      (precipitation == null ? 0 : precipitation!.hashCode) +
      (windspeed == null ? 0 : windspeed!.hashCode) +
      (wbgt == null ? 0 : wbgt!.hashCode);

  @override
  String toString() =>
      'Weather[placeName=$placeName, time=$time, lat=$lat, lon=$lon, temperature=$temperature, precipitation=$precipitation, windspeed=$windspeed, wbgt=$wbgt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.placeName != null) {
      json[r'place_name'] = this.placeName;
    } else {
      json[r'place_name'] = null;
    }
    if (this.time != null) {
      json[r'time'] = this.time!.toUtc().toIso8601String();
    } else {
      json[r'time'] = null;
    }
    if (this.lat != null) {
      json[r'lat'] = this.lat;
    } else {
      json[r'lat'] = null;
    }
    if (this.lon != null) {
      json[r'lon'] = this.lon;
    } else {
      json[r'lon'] = null;
    }
    if (this.temperature != null) {
      json[r'temperature'] = this.temperature;
    } else {
      json[r'temperature'] = null;
    }
    if (this.precipitation != null) {
      json[r'precipitation'] = this.precipitation;
    } else {
      json[r'precipitation'] = null;
    }
    if (this.windspeed != null) {
      json[r'windspeed'] = this.windspeed;
    } else {
      json[r'windspeed'] = null;
    }
    if (this.wbgt != null) {
      json[r'wbgt'] = this.wbgt;
    } else {
      json[r'wbgt'] = null;
    }
    return json;
  }

  /// Returns a new [Weather] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Weather? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Weather[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Weather[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Weather(
        placeName: mapValueOfType<String>(json, r'place_name'),
        time: mapDateTime(json, r'time', r''),
        lat: num.parse('${json[r'lat']}'),
        lon: num.parse('${json[r'lon']}'),
        temperature: num.parse('${json[r'temperature']}'),
        precipitation: num.parse('${json[r'precipitation']}'),
        windspeed: num.parse('${json[r'windspeed']}'),
        wbgt: num.parse('${json[r'wbgt']}'),
      );
    }
    return null;
  }

  static List<Weather> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Weather>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Weather.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Weather> mapFromJson(dynamic json) {
    final map = <String, Weather>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Weather.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Weather-objects as value to a dart map
  static Map<String, List<Weather>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Weather>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Weather.listFromJson(
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
