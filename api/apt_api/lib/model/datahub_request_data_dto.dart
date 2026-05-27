//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DatahubRequestDataDTO {
  /// Returns a new [DatahubRequestDataDTO] instance.
  DatahubRequestDataDTO({
    this.userData,
    this.remainingMinuteScoreOfCurrentWeek,
    this.futureActivities = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  KlimafitUserDataDTO? userData;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? remainingMinuteScoreOfCurrentWeek;

  List<ActivityOverviewDTO> futureActivities;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatahubRequestDataDTO &&
          other.userData == userData &&
          other.remainingMinuteScoreOfCurrentWeek ==
              remainingMinuteScoreOfCurrentWeek &&
          _deepEquality.equals(other.futureActivities, futureActivities);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (userData == null ? 0 : userData!.hashCode) +
      (remainingMinuteScoreOfCurrentWeek == null
          ? 0
          : remainingMinuteScoreOfCurrentWeek!.hashCode) +
      (futureActivities.hashCode);

  @override
  String toString() =>
      'DatahubRequestDataDTO[userData=$userData, remainingMinuteScoreOfCurrentWeek=$remainingMinuteScoreOfCurrentWeek, futureActivities=$futureActivities]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.userData != null) {
      json[r'userData'] = this.userData;
    } else {
      json[r'userData'] = null;
    }
    if (this.remainingMinuteScoreOfCurrentWeek != null) {
      json[r'remainingMinuteScoreOfCurrentWeek'] =
          this.remainingMinuteScoreOfCurrentWeek;
    } else {
      json[r'remainingMinuteScoreOfCurrentWeek'] = null;
    }
    json[r'futureActivities'] = this.futureActivities;
    return json;
  }

  /// Returns a new [DatahubRequestDataDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DatahubRequestDataDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "DatahubRequestDataDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "DatahubRequestDataDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DatahubRequestDataDTO(
        userData: KlimafitUserDataDTO.fromJson(json[r'userData']),
        remainingMinuteScoreOfCurrentWeek:
            mapValueOfType<int>(json, r'remainingMinuteScoreOfCurrentWeek'),
        futureActivities:
            ActivityOverviewDTO.listFromJson(json[r'futureActivities']),
      );
    }
    return null;
  }

  static List<DatahubRequestDataDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DatahubRequestDataDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DatahubRequestDataDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DatahubRequestDataDTO> mapFromJson(dynamic json) {
    final map = <String, DatahubRequestDataDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DatahubRequestDataDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DatahubRequestDataDTO-objects as value to a dart map
  static Map<String, List<DatahubRequestDataDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<DatahubRequestDataDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DatahubRequestDataDTO.listFromJson(
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
