//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GeoJsonPoint {
  /// Returns a new [GeoJsonPoint] instance.
  GeoJsonPoint({
    this.x,
    this.y,
    this.type,
    this.coordinates = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? x;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? y;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  List<double> coordinates;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoJsonPoint &&
          other.x == x &&
          other.y == y &&
          other.type == type &&
          _deepEquality.equals(other.coordinates, coordinates);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (x == null ? 0 : x!.hashCode) +
      (y == null ? 0 : y!.hashCode) +
      (type == null ? 0 : type!.hashCode) +
      (coordinates.hashCode);

  @override
  String toString() =>
      'GeoJsonPoint[x=$x, y=$y, type=$type, coordinates=$coordinates]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.x != null) {
      json[r'x'] = this.x;
    } else {
      json[r'x'] = null;
    }
    if (this.y != null) {
      json[r'y'] = this.y;
    } else {
      json[r'y'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    json[r'coordinates'] = this.coordinates;
    return json;
  }

  /// Returns a new [GeoJsonPoint] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GeoJsonPoint? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "GeoJsonPoint[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "GeoJsonPoint[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GeoJsonPoint(
        x: mapValueOfType<double>(json, r'x'),
        y: mapValueOfType<double>(json, r'y'),
        type: mapValueOfType<String>(json, r'type'),
        coordinates: json[r'coordinates'] is Iterable
            ? (json[r'coordinates'] as Iterable)
                .cast<double>()
                .toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<GeoJsonPoint> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <GeoJsonPoint>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GeoJsonPoint.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GeoJsonPoint> mapFromJson(dynamic json) {
    final map = <String, GeoJsonPoint>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GeoJsonPoint.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GeoJsonPoint-objects as value to a dart map
  static Map<String, List<GeoJsonPoint>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<GeoJsonPoint>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GeoJsonPoint.listFromJson(
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
