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

class MessageDTO {
  /// Returns a new [MessageDTO] instance.
  MessageDTO({
    this.type,
    this.sendDate,
    this.subject,
    this.text,
    this.senderId,
    this.senderName,
    this.sentToAll,
    this.pictureId,
    this.linkToProfile,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MessageType? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sendDate;

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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? senderId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? senderName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? sentToAll;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? pictureId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? linkToProfile;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageDTO &&
          other.type == type &&
          other.sendDate == sendDate &&
          other.subject == subject &&
          other.text == text &&
          other.senderId == senderId &&
          other.senderName == senderName &&
          other.sentToAll == sentToAll &&
          other.pictureId == pictureId &&
          other.linkToProfile == linkToProfile;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (type == null ? 0 : type!.hashCode) +
      (sendDate == null ? 0 : sendDate!.hashCode) +
      (subject == null ? 0 : subject!.hashCode) +
      (text == null ? 0 : text!.hashCode) +
      (senderId == null ? 0 : senderId!.hashCode) +
      (senderName == null ? 0 : senderName!.hashCode) +
      (sentToAll == null ? 0 : sentToAll!.hashCode) +
      (pictureId == null ? 0 : pictureId!.hashCode) +
      (linkToProfile == null ? 0 : linkToProfile!.hashCode);

  @override
  String toString() =>
      'MessageDTO[type=$type, sendDate=$sendDate, subject=$subject, text=$text, senderId=$senderId, senderName=$senderName, sentToAll=$sentToAll, pictureId=$pictureId, linkToProfile=$linkToProfile]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.sendDate != null) {
      json[r'sendDate'] = this.sendDate;
    } else {
      json[r'sendDate'] = null;
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
    if (this.senderId != null) {
      json[r'senderId'] = this.senderId;
    } else {
      json[r'senderId'] = null;
    }
    if (this.senderName != null) {
      json[r'senderName'] = this.senderName;
    } else {
      json[r'senderName'] = null;
    }
    if (this.sentToAll != null) {
      json[r'sentToAll'] = this.sentToAll;
    } else {
      json[r'sentToAll'] = null;
    }
    if (this.pictureId != null) {
      json[r'pictureId'] = this.pictureId;
    } else {
      json[r'pictureId'] = null;
    }
    if (this.linkToProfile != null) {
      json[r'linkToProfile'] = this.linkToProfile;
    } else {
      json[r'linkToProfile'] = null;
    }
    return json;
  }

  /// Returns a new [MessageDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MessageDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MessageDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MessageDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MessageDTO(
        type: MessageType.fromJson(json[r'type']),
        sendDate: mapValueOfType<String>(json, r'sendDate'),
        subject: mapValueOfType<String>(json, r'subject'),
        text: mapValueOfType<String>(json, r'text'),
        senderId: mapValueOfType<String>(json, r'senderId'),
        senderName: mapValueOfType<String>(json, r'senderName'),
        sentToAll: mapValueOfType<bool>(json, r'sentToAll'),
        pictureId: mapValueOfType<String>(json, r'pictureId'),
        linkToProfile: mapValueOfType<bool>(json, r'linkToProfile'),
      );
    }
    return null;
  }

  static List<MessageDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MessageDTO> mapFromJson(dynamic json) {
    final map = <String, MessageDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MessageDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MessageDTO-objects as value to a dart map
  static Map<String, List<MessageDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MessageDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MessageDTO.listFromJson(
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
