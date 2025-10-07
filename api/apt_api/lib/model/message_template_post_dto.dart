//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageTemplatePostDTO {
  /// Returns a new [MessageTemplatePostDTO] instance.
  MessageTemplatePostDTO({
    this.title = const {},
    this.text = const {},
  });

  Map<String, String> title;

  Map<String, String> text;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageTemplatePostDTO &&
          _deepEquality.equals(other.title, title) &&
          _deepEquality.equals(other.text, text);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (title.hashCode) + (text.hashCode);

  @override
  String toString() => 'MessageTemplatePostDTO[title=$title, text=$text]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'title'] = this.title;
    json[r'text'] = this.text;
    return json;
  }

  /// Returns a new [MessageTemplatePostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MessageTemplatePostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MessageTemplatePostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MessageTemplatePostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MessageTemplatePostDTO(
        title: mapCastOfType<String, String>(json, r'title') ?? const {},
        text: mapCastOfType<String, String>(json, r'text') ?? const {},
      );
    }
    return null;
  }

  static List<MessageTemplatePostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageTemplatePostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageTemplatePostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MessageTemplatePostDTO> mapFromJson(dynamic json) {
    final map = <String, MessageTemplatePostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MessageTemplatePostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MessageTemplatePostDTO-objects as value to a dart map
  static Map<String, List<MessageTemplatePostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MessageTemplatePostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MessageTemplatePostDTO.listFromJson(
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
