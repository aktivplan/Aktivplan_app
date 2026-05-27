//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ShareActivityDataPostDTO {
  /// Returns a new [ShareActivityDataPostDTO] instance.
  ShareActivityDataPostDTO({
    this.shareAcitivityData,
    this.shareActiveMinutes,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? shareAcitivityData;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? shareActiveMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShareActivityDataPostDTO &&
          other.shareAcitivityData == shareAcitivityData &&
          other.shareActiveMinutes == shareActiveMinutes;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (shareAcitivityData == null ? 0 : shareAcitivityData!.hashCode) +
      (shareActiveMinutes == null ? 0 : shareActiveMinutes!.hashCode);

  @override
  String toString() =>
      'ShareActivityDataPostDTO[shareAcitivityData=$shareAcitivityData, shareActiveMinutes=$shareActiveMinutes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.shareAcitivityData != null) {
      json[r'shareAcitivityData'] = this.shareAcitivityData;
    } else {
      json[r'shareAcitivityData'] = null;
    }
    if (this.shareActiveMinutes != null) {
      json[r'shareActiveMinutes'] = this.shareActiveMinutes;
    } else {
      json[r'shareActiveMinutes'] = null;
    }
    return json;
  }

  /// Returns a new [ShareActivityDataPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ShareActivityDataPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ShareActivityDataPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ShareActivityDataPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ShareActivityDataPostDTO(
        shareAcitivityData: mapValueOfType<bool>(json, r'shareAcitivityData'),
        shareActiveMinutes: mapValueOfType<bool>(json, r'shareActiveMinutes'),
      );
    }
    return null;
  }

  static List<ShareActivityDataPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ShareActivityDataPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ShareActivityDataPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ShareActivityDataPostDTO> mapFromJson(dynamic json) {
    final map = <String, ShareActivityDataPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ShareActivityDataPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ShareActivityDataPostDTO-objects as value to a dart map
  static Map<String, List<ShareActivityDataPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ShareActivityDataPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ShareActivityDataPostDTO.listFromJson(
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
