//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MoveActivityPostDTO {
  /// Returns a new [MoveActivityPostDTO] instance.
  MoveActivityPostDTO({
    this.activityId,
    this.fromDate,
    this.toDate,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? activityId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fromDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? toDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoveActivityPostDTO &&
          other.activityId == activityId &&
          other.fromDate == fromDate &&
          other.toDate == toDate;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (activityId == null ? 0 : activityId!.hashCode) +
      (fromDate == null ? 0 : fromDate!.hashCode) +
      (toDate == null ? 0 : toDate!.hashCode);

  @override
  String toString() =>
      'MoveActivityPostDTO[activityId=$activityId, fromDate=$fromDate, toDate=$toDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.activityId != null) {
      json[r'activityId'] = this.activityId;
    } else {
      json[r'activityId'] = null;
    }
    if (this.fromDate != null) {
      json[r'fromDate'] = this.fromDate;
    } else {
      json[r'fromDate'] = null;
    }
    if (this.toDate != null) {
      json[r'toDate'] = this.toDate;
    } else {
      json[r'toDate'] = null;
    }
    return json;
  }

  /// Returns a new [MoveActivityPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MoveActivityPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MoveActivityPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MoveActivityPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MoveActivityPostDTO(
        activityId: mapValueOfType<String>(json, r'activityId'),
        fromDate: mapValueOfType<String>(json, r'fromDate'),
        toDate: mapValueOfType<String>(json, r'toDate'),
      );
    }
    return null;
  }

  static List<MoveActivityPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MoveActivityPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MoveActivityPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MoveActivityPostDTO> mapFromJson(dynamic json) {
    final map = <String, MoveActivityPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MoveActivityPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MoveActivityPostDTO-objects as value to a dart map
  static Map<String, List<MoveActivityPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MoveActivityPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MoveActivityPostDTO.listFromJson(
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
