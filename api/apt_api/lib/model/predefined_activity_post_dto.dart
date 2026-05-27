//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PredefinedActivityPostDTO {
  /// Returns a new [PredefinedActivityPostDTO] instance.
  PredefinedActivityPostDTO({
    this.activityType,
    this.predefinedActivityType,
    this.name,
    this.startLocation,
    this.startLocationAddress,
    this.endLocation,
    this.endLocationAddress,
    this.durationMinutes,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ActivityType? activityType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  PredefinedActivityType? predefinedActivityType;

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
  LocationDTO? startLocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? startLocationAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? endLocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endLocationAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? durationMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PredefinedActivityPostDTO &&
          other.activityType == activityType &&
          other.predefinedActivityType == predefinedActivityType &&
          other.name == name &&
          other.startLocation == startLocation &&
          other.startLocationAddress == startLocationAddress &&
          other.endLocation == endLocation &&
          other.endLocationAddress == endLocationAddress &&
          other.durationMinutes == durationMinutes;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (activityType == null ? 0 : activityType!.hashCode) +
      (predefinedActivityType == null ? 0 : predefinedActivityType!.hashCode) +
      (name == null ? 0 : name!.hashCode) +
      (startLocation == null ? 0 : startLocation!.hashCode) +
      (startLocationAddress == null ? 0 : startLocationAddress!.hashCode) +
      (endLocation == null ? 0 : endLocation!.hashCode) +
      (endLocationAddress == null ? 0 : endLocationAddress!.hashCode) +
      (durationMinutes == null ? 0 : durationMinutes!.hashCode);

  @override
  String toString() =>
      'PredefinedActivityPostDTO[activityType=$activityType, predefinedActivityType=$predefinedActivityType, name=$name, startLocation=$startLocation, startLocationAddress=$startLocationAddress, endLocation=$endLocation, endLocationAddress=$endLocationAddress, durationMinutes=$durationMinutes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.activityType != null) {
      json[r'activityType'] = this.activityType;
    } else {
      json[r'activityType'] = null;
    }
    if (this.predefinedActivityType != null) {
      json[r'predefinedActivityType'] = this.predefinedActivityType;
    } else {
      json[r'predefinedActivityType'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.startLocation != null) {
      json[r'startLocation'] = this.startLocation;
    } else {
      json[r'startLocation'] = null;
    }
    if (this.startLocationAddress != null) {
      json[r'startLocationAddress'] = this.startLocationAddress;
    } else {
      json[r'startLocationAddress'] = null;
    }
    if (this.endLocation != null) {
      json[r'endLocation'] = this.endLocation;
    } else {
      json[r'endLocation'] = null;
    }
    if (this.endLocationAddress != null) {
      json[r'endLocationAddress'] = this.endLocationAddress;
    } else {
      json[r'endLocationAddress'] = null;
    }
    if (this.durationMinutes != null) {
      json[r'durationMinutes'] = this.durationMinutes;
    } else {
      json[r'durationMinutes'] = null;
    }
    return json;
  }

  /// Returns a new [PredefinedActivityPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PredefinedActivityPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "PredefinedActivityPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "PredefinedActivityPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PredefinedActivityPostDTO(
        activityType: ActivityType.fromJson(json[r'activityType']),
        predefinedActivityType:
            PredefinedActivityType.fromJson(json[r'predefinedActivityType']),
        name: mapValueOfType<String>(json, r'name'),
        startLocation: LocationDTO.fromJson(json[r'startLocation']),
        startLocationAddress:
            mapValueOfType<String>(json, r'startLocationAddress'),
        endLocation: LocationDTO.fromJson(json[r'endLocation']),
        endLocationAddress: mapValueOfType<String>(json, r'endLocationAddress'),
        durationMinutes: mapValueOfType<int>(json, r'durationMinutes'),
      );
    }
    return null;
  }

  static List<PredefinedActivityPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PredefinedActivityPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PredefinedActivityPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PredefinedActivityPostDTO> mapFromJson(dynamic json) {
    final map = <String, PredefinedActivityPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PredefinedActivityPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PredefinedActivityPostDTO-objects as value to a dart map
  static Map<String, List<PredefinedActivityPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PredefinedActivityPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PredefinedActivityPostDTO.listFromJson(
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
