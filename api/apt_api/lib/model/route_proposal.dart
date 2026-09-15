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

class RouteProposal {
  /// Returns a new [RouteProposal] instance.
  RouteProposal({
    this.locOrigin,
    this.locOriginAddr,
    this.locDestination,
    this.locDestinationAddr,
    this.mode,
    this.routeGeoJSON,
    this.routeGPX,
    this.lengthM,
    this.startTimestamp,
    this.durationMins,
    this.elevationUpM,
    this.elevationDownM,
    this.statShareShade,
    this.statShareGreen,
    this.statShareBlue,
    this.statShareSuitabilityLow,
    this.statShareSuitabilityMed,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? locOrigin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? locOriginAddr;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? locDestination;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? locDestinationAddr;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RoutingMode? mode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? routeGeoJSON;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? routeGPX;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lengthM;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startTimestamp;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? durationMins;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? elevationUpM;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? elevationDownM;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? statShareShade;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? statShareGreen;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? statShareBlue;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? statShareSuitabilityLow;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? statShareSuitabilityMed;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteProposal &&
          other.locOrigin == locOrigin &&
          other.locOriginAddr == locOriginAddr &&
          other.locDestination == locDestination &&
          other.locDestinationAddr == locDestinationAddr &&
          other.mode == mode &&
          other.routeGeoJSON == routeGeoJSON &&
          other.routeGPX == routeGPX &&
          other.lengthM == lengthM &&
          other.startTimestamp == startTimestamp &&
          other.durationMins == durationMins &&
          other.elevationUpM == elevationUpM &&
          other.elevationDownM == elevationDownM &&
          other.statShareShade == statShareShade &&
          other.statShareGreen == statShareGreen &&
          other.statShareBlue == statShareBlue &&
          other.statShareSuitabilityLow == statShareSuitabilityLow &&
          other.statShareSuitabilityMed == statShareSuitabilityMed;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (locOrigin == null ? 0 : locOrigin!.hashCode) +
      (locOriginAddr == null ? 0 : locOriginAddr!.hashCode) +
      (locDestination == null ? 0 : locDestination!.hashCode) +
      (locDestinationAddr == null ? 0 : locDestinationAddr!.hashCode) +
      (mode == null ? 0 : mode!.hashCode) +
      (routeGeoJSON == null ? 0 : routeGeoJSON!.hashCode) +
      (routeGPX == null ? 0 : routeGPX!.hashCode) +
      (lengthM == null ? 0 : lengthM!.hashCode) +
      (startTimestamp == null ? 0 : startTimestamp!.hashCode) +
      (durationMins == null ? 0 : durationMins!.hashCode) +
      (elevationUpM == null ? 0 : elevationUpM!.hashCode) +
      (elevationDownM == null ? 0 : elevationDownM!.hashCode) +
      (statShareShade == null ? 0 : statShareShade!.hashCode) +
      (statShareGreen == null ? 0 : statShareGreen!.hashCode) +
      (statShareBlue == null ? 0 : statShareBlue!.hashCode) +
      (statShareSuitabilityLow == null
          ? 0
          : statShareSuitabilityLow!.hashCode) +
      (statShareSuitabilityMed == null ? 0 : statShareSuitabilityMed!.hashCode);

  @override
  String toString() =>
      'RouteProposal[locOrigin=$locOrigin, locOriginAddr=$locOriginAddr, locDestination=$locDestination, locDestinationAddr=$locDestinationAddr, mode=$mode, routeGeoJSON=$routeGeoJSON, routeGPX=$routeGPX, lengthM=$lengthM, startTimestamp=$startTimestamp, durationMins=$durationMins, elevationUpM=$elevationUpM, elevationDownM=$elevationDownM, statShareShade=$statShareShade, statShareGreen=$statShareGreen, statShareBlue=$statShareBlue, statShareSuitabilityLow=$statShareSuitabilityLow, statShareSuitabilityMed=$statShareSuitabilityMed]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.locOrigin != null) {
      json[r'loc_origin'] = this.locOrigin;
    } else {
      json[r'loc_origin'] = null;
    }
    if (this.locOriginAddr != null) {
      json[r'loc_origin_addr'] = this.locOriginAddr;
    } else {
      json[r'loc_origin_addr'] = null;
    }
    if (this.locDestination != null) {
      json[r'loc_destination'] = this.locDestination;
    } else {
      json[r'loc_destination'] = null;
    }
    if (this.locDestinationAddr != null) {
      json[r'loc_destination_addr'] = this.locDestinationAddr;
    } else {
      json[r'loc_destination_addr'] = null;
    }
    if (this.mode != null) {
      json[r'mode'] = this.mode;
    } else {
      json[r'mode'] = null;
    }
    if (this.routeGeoJSON != null) {
      json[r'route_geoJSON'] = this.routeGeoJSON;
    } else {
      json[r'route_geoJSON'] = null;
    }
    if (this.routeGPX != null) {
      json[r'route_GPX'] = this.routeGPX;
    } else {
      json[r'route_GPX'] = null;
    }
    if (this.lengthM != null) {
      json[r'length_m'] = this.lengthM;
    } else {
      json[r'length_m'] = null;
    }
    if (this.startTimestamp != null) {
      json[r'start_timestamp'] = this.startTimestamp!.toUtc().toIso8601String();
    } else {
      json[r'start_timestamp'] = null;
    }
    if (this.durationMins != null) {
      json[r'duration_mins'] = this.durationMins;
    } else {
      json[r'duration_mins'] = null;
    }
    if (this.elevationUpM != null) {
      json[r'elevation_up_m'] = this.elevationUpM;
    } else {
      json[r'elevation_up_m'] = null;
    }
    if (this.elevationDownM != null) {
      json[r'elevation_down_m'] = this.elevationDownM;
    } else {
      json[r'elevation_down_m'] = null;
    }
    if (this.statShareShade != null) {
      json[r'stat_share_shade'] = this.statShareShade;
    } else {
      json[r'stat_share_shade'] = null;
    }
    if (this.statShareGreen != null) {
      json[r'stat_share_green'] = this.statShareGreen;
    } else {
      json[r'stat_share_green'] = null;
    }
    if (this.statShareBlue != null) {
      json[r'stat_share_blue'] = this.statShareBlue;
    } else {
      json[r'stat_share_blue'] = null;
    }
    if (this.statShareSuitabilityLow != null) {
      json[r'stat_share_suitability_low'] = this.statShareSuitabilityLow;
    } else {
      json[r'stat_share_suitability_low'] = null;
    }
    if (this.statShareSuitabilityMed != null) {
      json[r'stat_share_suitability_med'] = this.statShareSuitabilityMed;
    } else {
      json[r'stat_share_suitability_med'] = null;
    }
    return json;
  }

  /// Returns a new [RouteProposal] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RouteProposal? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "RouteProposal[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "RouteProposal[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RouteProposal(
        locOrigin: LocationDTO.fromJson(json[r'loc_origin']),
        locOriginAddr: mapValueOfType<String>(json, r'loc_origin_addr'),
        locDestination: LocationDTO.fromJson(json[r'loc_destination']),
        locDestinationAddr:
            mapValueOfType<String>(json, r'loc_destination_addr'),
        mode: RoutingMode.fromJson(json[r'mode']),
        routeGeoJSON: mapValueOfType<String>(json, r'route_geoJSON'),
        routeGPX: mapValueOfType<String>(json, r'route_GPX'),
        lengthM: mapValueOfType<int>(json, r'length_m'),
        startTimestamp: mapDateTime(json, r'start_timestamp', r''),
        durationMins: mapValueOfType<int>(json, r'duration_mins'),
        elevationUpM: mapValueOfType<int>(json, r'elevation_up_m'),
        elevationDownM: mapValueOfType<int>(json, r'elevation_down_m'),
        statShareShade: num.parse('${json[r'stat_share_shade']}'),
        statShareGreen: num.parse('${json[r'stat_share_green']}'),
        statShareBlue: num.parse('${json[r'stat_share_blue']}'),
        statShareSuitabilityLow:
            num.parse('${json[r'stat_share_suitability_low']}'),
        statShareSuitabilityMed:
            num.parse('${json[r'stat_share_suitability_med']}'),
      );
    }
    return null;
  }

  static List<RouteProposal> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RouteProposal>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RouteProposal.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RouteProposal> mapFromJson(dynamic json) {
    final map = <String, RouteProposal>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RouteProposal.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RouteProposal-objects as value to a dart map
  static Map<String, List<RouteProposal>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<RouteProposal>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RouteProposal.listFromJson(
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
