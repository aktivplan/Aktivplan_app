//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageTemplate {
  /// Returns a new [MessageTemplate] instance.
  MessageTemplate({
    this.id,
    this.institutionId,
    this.importId,
    this.type,
    this.title = const {},
    this.text = const {},
    this.pictureId = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? institutionId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? importId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MessageType? type;

  Map<String, String> title;

  Map<String, String> text;

  Map<String, String> pictureId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageTemplate &&
          other.id == id &&
          other.institutionId == institutionId &&
          other.importId == importId &&
          other.type == type &&
          _deepEquality.equals(other.title, title) &&
          _deepEquality.equals(other.text, text) &&
          _deepEquality.equals(other.pictureId, pictureId);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (institutionId == null ? 0 : institutionId!.hashCode) +
      (importId == null ? 0 : importId!.hashCode) +
      (type == null ? 0 : type!.hashCode) +
      (title.hashCode) +
      (text.hashCode) +
      (pictureId.hashCode);

  @override
  String toString() =>
      'MessageTemplate[id=$id, institutionId=$institutionId, importId=$importId, type=$type, title=$title, text=$text, pictureId=$pictureId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.institutionId != null) {
      json[r'institutionId'] = this.institutionId;
    } else {
      json[r'institutionId'] = null;
    }
    if (this.importId != null) {
      json[r'importId'] = this.importId;
    } else {
      json[r'importId'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    json[r'title'] = this.title;
    json[r'text'] = this.text;
    json[r'pictureId'] = this.pictureId;
    return json;
  }

  /// Returns a new [MessageTemplate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MessageTemplate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MessageTemplate[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MessageTemplate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MessageTemplate(
        id: mapValueOfType<String>(json, r'id'),
        institutionId: mapValueOfType<String>(json, r'institutionId'),
        importId: mapValueOfType<String>(json, r'importId'),
        type: MessageType.fromJson(json[r'type']),
        title: mapCastOfType<String, String>(json, r'title') ?? const {},
        text: mapCastOfType<String, String>(json, r'text') ?? const {},
        pictureId:
            mapCastOfType<String, String>(json, r'pictureId') ?? const {},
      );
    }
    return null;
  }

  static List<MessageTemplate> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageTemplate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageTemplate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MessageTemplate> mapFromJson(dynamic json) {
    final map = <String, MessageTemplate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MessageTemplate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MessageTemplate-objects as value to a dart map
  static Map<String, List<MessageTemplate>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MessageTemplate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MessageTemplate.listFromJson(
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
