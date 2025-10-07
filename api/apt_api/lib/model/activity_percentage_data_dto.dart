//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActivityPercentageDataDTO {
  /// Returns a new [ActivityPercentageDataDTO] instance.
  ActivityPercentageDataDTO({
    this.activityPercentageLastFourWeeks,
    this.activityPercentageGraphData = const [],
    this.activityPercentageLastThreeWeeks,
    this.activityPercentageLastThreeWeeksPlanned,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activityPercentageLastFourWeeks;

  List<ActivityGraphDTO> activityPercentageGraphData;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activityPercentageLastThreeWeeks;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? activityPercentageLastThreeWeeksPlanned;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityPercentageDataDTO &&
          other.activityPercentageLastFourWeeks ==
              activityPercentageLastFourWeeks &&
          _deepEquality.equals(
              other.activityPercentageGraphData, activityPercentageGraphData) &&
          other.activityPercentageLastThreeWeeks ==
              activityPercentageLastThreeWeeks &&
          other.activityPercentageLastThreeWeeksPlanned ==
              activityPercentageLastThreeWeeksPlanned;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (activityPercentageLastFourWeeks == null
          ? 0
          : activityPercentageLastFourWeeks!.hashCode) +
      (activityPercentageGraphData.hashCode) +
      (activityPercentageLastThreeWeeks == null
          ? 0
          : activityPercentageLastThreeWeeks!.hashCode) +
      (activityPercentageLastThreeWeeksPlanned == null
          ? 0
          : activityPercentageLastThreeWeeksPlanned!.hashCode);

  @override
  String toString() =>
      'ActivityPercentageDataDTO[activityPercentageLastFourWeeks=$activityPercentageLastFourWeeks, activityPercentageGraphData=$activityPercentageGraphData, activityPercentageLastThreeWeeks=$activityPercentageLastThreeWeeks, activityPercentageLastThreeWeeksPlanned=$activityPercentageLastThreeWeeksPlanned]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.activityPercentageLastFourWeeks != null) {
      json[r'activityPercentageLastFourWeeks'] =
          this.activityPercentageLastFourWeeks;
    } else {
      json[r'activityPercentageLastFourWeeks'] = null;
    }
    json[r'activityPercentageGraphData'] = this.activityPercentageGraphData;
    if (this.activityPercentageLastThreeWeeks != null) {
      json[r'activityPercentageLastThreeWeeks'] =
          this.activityPercentageLastThreeWeeks;
    } else {
      json[r'activityPercentageLastThreeWeeks'] = null;
    }
    if (this.activityPercentageLastThreeWeeksPlanned != null) {
      json[r'activityPercentageLastThreeWeeksPlanned'] =
          this.activityPercentageLastThreeWeeksPlanned;
    } else {
      json[r'activityPercentageLastThreeWeeksPlanned'] = null;
    }
    return json;
  }

  /// Returns a new [ActivityPercentageDataDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActivityPercentageDataDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActivityPercentageDataDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActivityPercentageDataDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActivityPercentageDataDTO(
        activityPercentageLastFourWeeks:
            mapValueOfType<int>(json, r'activityPercentageLastFourWeeks'),
        activityPercentageGraphData:
            ActivityGraphDTO.listFromJson(json[r'activityPercentageGraphData']),
        activityPercentageLastThreeWeeks:
            mapValueOfType<int>(json, r'activityPercentageLastThreeWeeks'),
        activityPercentageLastThreeWeeksPlanned: mapValueOfType<int>(
            json, r'activityPercentageLastThreeWeeksPlanned'),
      );
    }
    return null;
  }

  static List<ActivityPercentageDataDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityPercentageDataDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityPercentageDataDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActivityPercentageDataDTO> mapFromJson(dynamic json) {
    final map = <String, ActivityPercentageDataDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActivityPercentageDataDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActivityPercentageDataDTO-objects as value to a dart map
  static Map<String, List<ActivityPercentageDataDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActivityPercentageDataDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActivityPercentageDataDTO.listFromJson(
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
