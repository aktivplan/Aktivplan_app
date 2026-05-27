//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KlimafitUserDataDTO {
  /// Returns a new [KlimafitUserDataDTO] instance.
  KlimafitUserDataDTO({
    this.homeLocation,
    this.homeLocationAddress,
    this.workLocation,
    this.workLocationAddress,
    this.heatTolerance,
    this.mobilityPreferences = const [],
    this.dislikedMobilityPreferences = const [],
    this.preferredActivities = const [],
    this.dislikedActivities = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? homeLocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? homeLocationAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? workLocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? workLocationAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  HeatTolerance? heatTolerance;

  List<MobilityPreference> mobilityPreferences;

  List<MobilityPreference> dislikedMobilityPreferences;

  List<PredefinedActivityType> preferredActivities;

  List<PredefinedActivityType> dislikedActivities;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KlimafitUserDataDTO &&
          other.homeLocation == homeLocation &&
          other.homeLocationAddress == homeLocationAddress &&
          other.workLocation == workLocation &&
          other.workLocationAddress == workLocationAddress &&
          other.heatTolerance == heatTolerance &&
          _deepEquality.equals(
              other.mobilityPreferences, mobilityPreferences) &&
          _deepEquality.equals(
              other.dislikedMobilityPreferences, dislikedMobilityPreferences) &&
          _deepEquality.equals(
              other.preferredActivities, preferredActivities) &&
          _deepEquality.equals(other.dislikedActivities, dislikedActivities);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (homeLocation == null ? 0 : homeLocation!.hashCode) +
      (homeLocationAddress == null ? 0 : homeLocationAddress!.hashCode) +
      (workLocation == null ? 0 : workLocation!.hashCode) +
      (workLocationAddress == null ? 0 : workLocationAddress!.hashCode) +
      (heatTolerance == null ? 0 : heatTolerance!.hashCode) +
      (mobilityPreferences.hashCode) +
      (dislikedMobilityPreferences.hashCode) +
      (preferredActivities.hashCode) +
      (dislikedActivities.hashCode);

  @override
  String toString() =>
      'KlimafitUserDataDTO[homeLocation=$homeLocation, homeLocationAddress=$homeLocationAddress, workLocation=$workLocation, workLocationAddress=$workLocationAddress, heatTolerance=$heatTolerance, mobilityPreferences=$mobilityPreferences, dislikedMobilityPreferences=$dislikedMobilityPreferences, preferredActivities=$preferredActivities, dislikedActivities=$dislikedActivities]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.homeLocation != null) {
      json[r'homeLocation'] = this.homeLocation;
    } else {
      json[r'homeLocation'] = null;
    }
    if (this.homeLocationAddress != null) {
      json[r'homeLocationAddress'] = this.homeLocationAddress;
    } else {
      json[r'homeLocationAddress'] = null;
    }
    if (this.workLocation != null) {
      json[r'workLocation'] = this.workLocation;
    } else {
      json[r'workLocation'] = null;
    }
    if (this.workLocationAddress != null) {
      json[r'workLocationAddress'] = this.workLocationAddress;
    } else {
      json[r'workLocationAddress'] = null;
    }
    if (this.heatTolerance != null) {
      json[r'heatTolerance'] = this.heatTolerance;
    } else {
      json[r'heatTolerance'] = null;
    }
    json[r'mobilityPreferences'] = this.mobilityPreferences;
    json[r'dislikedMobilityPreferences'] = this.dislikedMobilityPreferences;
    json[r'preferredActivities'] = this.preferredActivities;
    json[r'dislikedActivities'] = this.dislikedActivities;
    return json;
  }

  /// Returns a new [KlimafitUserDataDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static KlimafitUserDataDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "KlimafitUserDataDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "KlimafitUserDataDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return KlimafitUserDataDTO(
        homeLocation: LocationDTO.fromJson(json[r'homeLocation']),
        homeLocationAddress:
            mapValueOfType<String>(json, r'homeLocationAddress'),
        workLocation: LocationDTO.fromJson(json[r'workLocation']),
        workLocationAddress:
            mapValueOfType<String>(json, r'workLocationAddress'),
        heatTolerance: HeatTolerance.fromJson(json[r'heatTolerance']),
        mobilityPreferences:
            MobilityPreference.listFromJson(json[r'mobilityPreferences']),
        dislikedMobilityPreferences: MobilityPreference.listFromJson(
            json[r'dislikedMobilityPreferences']),
        preferredActivities:
            PredefinedActivityType.listFromJson(json[r'preferredActivities']),
        dislikedActivities:
            PredefinedActivityType.listFromJson(json[r'dislikedActivities']),
      );
    }
    return null;
  }

  static List<KlimafitUserDataDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <KlimafitUserDataDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KlimafitUserDataDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, KlimafitUserDataDTO> mapFromJson(dynamic json) {
    final map = <String, KlimafitUserDataDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KlimafitUserDataDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of KlimafitUserDataDTO-objects as value to a dart map
  static Map<String, List<KlimafitUserDataDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<KlimafitUserDataDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = KlimafitUserDataDTO.listFromJson(
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
