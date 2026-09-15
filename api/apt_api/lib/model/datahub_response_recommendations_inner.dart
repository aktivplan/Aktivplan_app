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

class DatahubResponseRecommendationsInner {
  /// Returns a new [DatahubResponseRecommendationsInner] instance.
  DatahubResponseRecommendationsInner({
    this.type,
    this.level,
    this.reason,
    this.reasonDetail,
    this.description,
    this.activityType,
    this.predefinedActivity,
    this.activity,
    this.action,
    this.timeFrom,
    this.timeUntil,
    this.originActivityID,
    this.destinationActivityID,
    this.route,
    this.changeType,
    this.activityID,
    this.location,
    this.locationAddr,
    this.timeStart,
    this.timeEnd,
    this.referenceActivityID,
    this.referenceActivityDate,
    this.proposedRoute,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RecommendationType? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RecommendationLevel? level;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RecoomendationReason? reason;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? reasonDetail;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

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
  PredefinedActivityType? predefinedActivity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? activity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? action;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? timeFrom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? timeUntil;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? originActivityID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? destinationActivityID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RouteProposal? route;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SpaceTimeRecommendationChangeType? changeType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? activityID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LocationDTO? location;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? locationAddr;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? timeStart;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? timeEnd;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? referenceActivityID;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? referenceActivityDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RouteProposal? proposedRoute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatahubResponseRecommendationsInner &&
          other.type == type &&
          other.level == level &&
          other.reason == reason &&
          other.reasonDetail == reasonDetail &&
          other.description == description &&
          other.activityType == activityType &&
          other.predefinedActivity == predefinedActivity &&
          other.activity == activity &&
          other.action == action &&
          other.timeFrom == timeFrom &&
          other.timeUntil == timeUntil &&
          other.originActivityID == originActivityID &&
          other.destinationActivityID == destinationActivityID &&
          other.route == route &&
          other.changeType == changeType &&
          other.activityID == activityID &&
          other.location == location &&
          other.locationAddr == locationAddr &&
          other.timeStart == timeStart &&
          other.timeEnd == timeEnd &&
          other.referenceActivityID == referenceActivityID &&
          other.referenceActivityDate == referenceActivityDate &&
          other.proposedRoute == proposedRoute;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (type == null ? 0 : type!.hashCode) +
      (level == null ? 0 : level!.hashCode) +
      (reason == null ? 0 : reason!.hashCode) +
      (reasonDetail == null ? 0 : reasonDetail!.hashCode) +
      (description == null ? 0 : description!.hashCode) +
      (activityType == null ? 0 : activityType!.hashCode) +
      (predefinedActivity == null ? 0 : predefinedActivity!.hashCode) +
      (activity == null ? 0 : activity!.hashCode) +
      (action == null ? 0 : action!.hashCode) +
      (timeFrom == null ? 0 : timeFrom!.hashCode) +
      (timeUntil == null ? 0 : timeUntil!.hashCode) +
      (originActivityID == null ? 0 : originActivityID!.hashCode) +
      (destinationActivityID == null ? 0 : destinationActivityID!.hashCode) +
      (route == null ? 0 : route!.hashCode) +
      (changeType == null ? 0 : changeType!.hashCode) +
      (activityID == null ? 0 : activityID!.hashCode) +
      (location == null ? 0 : location!.hashCode) +
      (locationAddr == null ? 0 : locationAddr!.hashCode) +
      (timeStart == null ? 0 : timeStart!.hashCode) +
      (timeEnd == null ? 0 : timeEnd!.hashCode) +
      (referenceActivityID == null ? 0 : referenceActivityID!.hashCode) +
      (referenceActivityDate == null ? 0 : referenceActivityDate!.hashCode) +
      (proposedRoute == null ? 0 : proposedRoute!.hashCode);

  @override
  String toString() =>
      'DatahubResponseRecommendationsInner[type=$type, level=$level, reason=$reason, reasonDetail=$reasonDetail, description=$description, activityType=$activityType, predefinedActivity=$predefinedActivity, activity=$activity, action=$action, timeFrom=$timeFrom, timeUntil=$timeUntil, originActivityID=$originActivityID, destinationActivityID=$destinationActivityID, route=$route, changeType=$changeType, activityID=$activityID, location=$location, locationAddr=$locationAddr, timeStart=$timeStart, timeEnd=$timeEnd, referenceActivityID=$referenceActivityID, referenceActivityDate=$referenceActivityDate, proposedRoute=$proposedRoute]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.level != null) {
      json[r'level'] = this.level;
    } else {
      json[r'level'] = null;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    if (this.reasonDetail != null) {
      json[r'reason_detail'] = this.reasonDetail;
    } else {
      json[r'reason_detail'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.activityType != null) {
      json[r'activity_type'] = this.activityType;
    } else {
      json[r'activity_type'] = null;
    }
    if (this.predefinedActivity != null) {
      json[r'predefined_activity'] = this.predefinedActivity;
    } else {
      json[r'predefined_activity'] = null;
    }
    if (this.activity != null) {
      json[r'activity'] = this.activity;
    } else {
      json[r'activity'] = null;
    }
    if (this.action != null) {
      json[r'action'] = this.action;
    } else {
      json[r'action'] = null;
    }
    if (this.timeFrom != null) {
      json[r'time_from'] = this.timeFrom!.toUtc().toIso8601String();
    } else {
      json[r'time_from'] = null;
    }
    if (this.timeUntil != null) {
      json[r'time_until'] = this.timeUntil!.toUtc().toIso8601String();
    } else {
      json[r'time_until'] = null;
    }
    if (this.originActivityID != null) {
      json[r'origin_activityID'] = this.originActivityID;
    } else {
      json[r'origin_activityID'] = null;
    }
    if (this.destinationActivityID != null) {
      json[r'destination_activityID'] = this.destinationActivityID;
    } else {
      json[r'destination_activityID'] = null;
    }
    if (this.route != null) {
      json[r'route'] = this.route;
    } else {
      json[r'route'] = null;
    }
    if (this.changeType != null) {
      json[r'change_type'] = this.changeType;
    } else {
      json[r'change_type'] = null;
    }
    if (this.activityID != null) {
      json[r'activityID'] = this.activityID;
    } else {
      json[r'activityID'] = null;
    }
    if (this.location != null) {
      json[r'location'] = this.location;
    } else {
      json[r'location'] = null;
    }
    if (this.locationAddr != null) {
      json[r'location_addr'] = this.locationAddr;
    } else {
      json[r'location_addr'] = null;
    }
    if (this.timeStart != null) {
      json[r'time_start'] = this.timeStart!.toUtc().toIso8601String();
    } else {
      json[r'time_start'] = null;
    }
    if (this.timeEnd != null) {
      json[r'time_end'] = this.timeEnd!.toUtc().toIso8601String();
    } else {
      json[r'time_end'] = null;
    }
    if (this.referenceActivityID != null) {
      json[r'reference_activityID'] = this.referenceActivityID;
    } else {
      json[r'reference_activityID'] = null;
    }
    if (this.referenceActivityDate != null) {
      json[r'reference_activityDate'] = this.referenceActivityDate;
    } else {
      json[r'reference_activityDate'] = null;
    }
    if (this.proposedRoute != null) {
      json[r'proposed_route'] = this.proposedRoute;
    } else {
      json[r'proposed_route'] = null;
    }
    return json;
  }

  /// Returns a new [DatahubResponseRecommendationsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DatahubResponseRecommendationsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "DatahubResponseRecommendationsInner[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "DatahubResponseRecommendationsInner[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DatahubResponseRecommendationsInner(
        type: RecommendationType.fromJson(json[r'type']),
        level: RecommendationLevel.fromJson(json[r'level']),
        reason: RecoomendationReason.fromJson(json[r'reason']),
        reasonDetail: mapValueOfType<String>(json, r'reason_detail'),
        description: mapValueOfType<String>(json, r'description'),
        activityType: ActivityType.fromJson(json[r'activity_type']),
        predefinedActivity:
            PredefinedActivityType.fromJson(json[r'predefined_activity']),
        activity: mapValueOfType<String>(json, r'activity'),
        action: mapValueOfType<String>(json, r'action'),
        timeFrom: mapDateTime(json, r'time_from', r''),
        timeUntil: mapDateTime(json, r'time_until', r''),
        originActivityID: mapValueOfType<String>(json, r'origin_activityID'),
        destinationActivityID:
            mapValueOfType<String>(json, r'destination_activityID'),
        route: RouteProposal.fromJson(json[r'route']),
        changeType:
            SpaceTimeRecommendationChangeType.fromJson(json[r'change_type']),
        activityID: mapValueOfType<String>(json, r'activityID'),
        location: LocationDTO.fromJson(json[r'location']),
        locationAddr: mapValueOfType<String>(json, r'location_addr'),
        timeStart: mapDateTime(json, r'time_start', r''),
        timeEnd: mapDateTime(json, r'time_end', r''),
        referenceActivityID:
            mapValueOfType<String>(json, r'reference_activityID'),
        referenceActivityDate:
            mapValueOfType<String>(json, r'reference_activityDate'),
        proposedRoute: RouteProposal.fromJson(json[r'proposed_route']),
      );
    }
    return null;
  }

  static List<DatahubResponseRecommendationsInner> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DatahubResponseRecommendationsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DatahubResponseRecommendationsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DatahubResponseRecommendationsInner> mapFromJson(
      dynamic json) {
    final map = <String, DatahubResponseRecommendationsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DatahubResponseRecommendationsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DatahubResponseRecommendationsInner-objects as value to a dart map
  static Map<String, List<DatahubResponseRecommendationsInner>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<DatahubResponseRecommendationsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DatahubResponseRecommendationsInner.listFromJson(
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
