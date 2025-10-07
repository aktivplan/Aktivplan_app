//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChangePasswordDTO {
  /// Returns a new [ChangePasswordDTO] instance.
  ChangePasswordDTO({
    this.oldPassword,
    this.newPassword,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? oldPassword;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? newPassword;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangePasswordDTO &&
          other.oldPassword == oldPassword &&
          other.newPassword == newPassword;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (oldPassword == null ? 0 : oldPassword!.hashCode) +
      (newPassword == null ? 0 : newPassword!.hashCode);

  @override
  String toString() =>
      'ChangePasswordDTO[oldPassword=$oldPassword, newPassword=$newPassword]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.oldPassword != null) {
      json[r'oldPassword'] = this.oldPassword;
    } else {
      json[r'oldPassword'] = null;
    }
    if (this.newPassword != null) {
      json[r'newPassword'] = this.newPassword;
    } else {
      json[r'newPassword'] = null;
    }
    return json;
  }

  /// Returns a new [ChangePasswordDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChangePasswordDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ChangePasswordDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ChangePasswordDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChangePasswordDTO(
        oldPassword: mapValueOfType<String>(json, r'oldPassword'),
        newPassword: mapValueOfType<String>(json, r'newPassword'),
      );
    }
    return null;
  }

  static List<ChangePasswordDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ChangePasswordDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChangePasswordDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChangePasswordDTO> mapFromJson(dynamic json) {
    final map = <String, ChangePasswordDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChangePasswordDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChangePasswordDTO-objects as value to a dart map
  static Map<String, List<ChangePasswordDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ChangePasswordDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChangePasswordDTO.listFromJson(
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
