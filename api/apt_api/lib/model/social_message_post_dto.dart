//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SocialMessagePostDTO {
  /// Returns a new [SocialMessagePostDTO] instance.
  SocialMessagePostDTO({
    this.recipientId,
    this.subject,
    this.text,
    this.hasPicture,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? recipientId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? subject;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? text;

  /// when picture is set, wait for picture upload before sending message
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? hasPicture;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialMessagePostDTO &&
          other.recipientId == recipientId &&
          other.subject == subject &&
          other.text == text &&
          other.hasPicture == hasPicture;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (recipientId == null ? 0 : recipientId!.hashCode) +
      (subject == null ? 0 : subject!.hashCode) +
      (text == null ? 0 : text!.hashCode) +
      (hasPicture == null ? 0 : hasPicture!.hashCode);

  @override
  String toString() =>
      'SocialMessagePostDTO[recipientId=$recipientId, subject=$subject, text=$text, hasPicture=$hasPicture]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.recipientId != null) {
      json[r'recipientId'] = this.recipientId;
    } else {
      json[r'recipientId'] = null;
    }
    if (this.subject != null) {
      json[r'subject'] = this.subject;
    } else {
      json[r'subject'] = null;
    }
    if (this.text != null) {
      json[r'text'] = this.text;
    } else {
      json[r'text'] = null;
    }
    if (this.hasPicture != null) {
      json[r'hasPicture'] = this.hasPicture;
    } else {
      json[r'hasPicture'] = null;
    }
    return json;
  }

  /// Returns a new [SocialMessagePostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SocialMessagePostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "SocialMessagePostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "SocialMessagePostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SocialMessagePostDTO(
        recipientId: mapValueOfType<String>(json, r'recipientId'),
        subject: mapValueOfType<String>(json, r'subject'),
        text: mapValueOfType<String>(json, r'text'),
        hasPicture: mapValueOfType<bool>(json, r'hasPicture'),
      );
    }
    return null;
  }

  static List<SocialMessagePostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <SocialMessagePostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SocialMessagePostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SocialMessagePostDTO> mapFromJson(dynamic json) {
    final map = <String, SocialMessagePostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SocialMessagePostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SocialMessagePostDTO-objects as value to a dart map
  static Map<String, List<SocialMessagePostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<SocialMessagePostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SocialMessagePostDTO.listFromJson(
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
