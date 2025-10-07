//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActiveMinutesOverviewDTO {
  /// Returns a new [ActiveMinutesOverviewDTO] instance.
  ActiveMinutesOverviewDTO({
    this.activeMinutes = const {},
    this.hasPreviousEntry,
    this.hasNextEntry,
    this.startDate,
    this.endDate,
    this.durationMinutesActive,
    this.durationMinutes,
    this.averageMinutesPerWeek,
  });

  /// WEEK: key values are DayOfWeek-Enum-Keys, MONTH: key values are calendar week numbers, ALL: key values are month numbers
  Map<String, ActiveMinutesDTO> activeMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? hasPreviousEntry;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? hasNextEntry;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? startDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? durationMinutesActive;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? durationMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? averageMinutesPerWeek;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveMinutesOverviewDTO &&
          _deepEquality.equals(other.activeMinutes, activeMinutes) &&
          other.hasPreviousEntry == hasPreviousEntry &&
          other.hasNextEntry == hasNextEntry &&
          other.startDate == startDate &&
          other.endDate == endDate &&
          other.durationMinutesActive == durationMinutesActive &&
          other.durationMinutes == durationMinutes &&
          other.averageMinutesPerWeek == averageMinutesPerWeek;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (activeMinutes.hashCode) +
      (hasPreviousEntry == null ? 0 : hasPreviousEntry!.hashCode) +
      (hasNextEntry == null ? 0 : hasNextEntry!.hashCode) +
      (startDate == null ? 0 : startDate!.hashCode) +
      (endDate == null ? 0 : endDate!.hashCode) +
      (durationMinutesActive == null ? 0 : durationMinutesActive!.hashCode) +
      (durationMinutes == null ? 0 : durationMinutes!.hashCode) +
      (averageMinutesPerWeek == null ? 0 : averageMinutesPerWeek!.hashCode);

  @override
  String toString() =>
      'ActiveMinutesOverviewDTO[activeMinutes=$activeMinutes, hasPreviousEntry=$hasPreviousEntry, hasNextEntry=$hasNextEntry, startDate=$startDate, endDate=$endDate, durationMinutesActive=$durationMinutesActive, durationMinutes=$durationMinutes, averageMinutesPerWeek=$averageMinutesPerWeek]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'activeMinutes'] = this.activeMinutes;
    if (this.hasPreviousEntry != null) {
      json[r'hasPreviousEntry'] = this.hasPreviousEntry;
    } else {
      json[r'hasPreviousEntry'] = null;
    }
    if (this.hasNextEntry != null) {
      json[r'hasNextEntry'] = this.hasNextEntry;
    } else {
      json[r'hasNextEntry'] = null;
    }
    if (this.startDate != null) {
      json[r'startDate'] = this.startDate;
    } else {
      json[r'startDate'] = null;
    }
    if (this.endDate != null) {
      json[r'endDate'] = this.endDate;
    } else {
      json[r'endDate'] = null;
    }
    if (this.durationMinutesActive != null) {
      json[r'durationMinutesActive'] = this.durationMinutesActive;
    } else {
      json[r'durationMinutesActive'] = null;
    }
    if (this.durationMinutes != null) {
      json[r'durationMinutes'] = this.durationMinutes;
    } else {
      json[r'durationMinutes'] = null;
    }
    if (this.averageMinutesPerWeek != null) {
      json[r'averageMinutesPerWeek'] = this.averageMinutesPerWeek;
    } else {
      json[r'averageMinutesPerWeek'] = null;
    }
    return json;
  }

  /// Returns a new [ActiveMinutesOverviewDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActiveMinutesOverviewDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ActiveMinutesOverviewDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ActiveMinutesOverviewDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActiveMinutesOverviewDTO(
        activeMinutes: ActiveMinutesDTO.mapFromJson(json[r'activeMinutes']),
        hasPreviousEntry: mapValueOfType<bool>(json, r'hasPreviousEntry'),
        hasNextEntry: mapValueOfType<bool>(json, r'hasNextEntry'),
        startDate: mapValueOfType<String>(json, r'startDate'),
        endDate: mapValueOfType<String>(json, r'endDate'),
        durationMinutesActive:
            mapValueOfType<int>(json, r'durationMinutesActive'),
        durationMinutes: mapValueOfType<int>(json, r'durationMinutes'),
        averageMinutesPerWeek:
            mapValueOfType<int>(json, r'averageMinutesPerWeek'),
      );
    }
    return null;
  }

  static List<ActiveMinutesOverviewDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActiveMinutesOverviewDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActiveMinutesOverviewDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActiveMinutesOverviewDTO> mapFromJson(dynamic json) {
    final map = <String, ActiveMinutesOverviewDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActiveMinutesOverviewDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActiveMinutesOverviewDTO-objects as value to a dart map
  static Map<String, List<ActiveMinutesOverviewDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ActiveMinutesOverviewDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ActiveMinutesOverviewDTO.listFromJson(
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
