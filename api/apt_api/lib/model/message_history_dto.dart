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

class MessageHistoryDTO {
  /// Returns a new [MessageHistoryDTO] instance.
  MessageHistoryDTO({
    this.sentMessages = const [],
    this.scheduledMessages = const [],
  });

  List<MessageGetDTO> sentMessages;

  List<MessageScheduleGetDTO> scheduledMessages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageHistoryDTO &&
          _deepEquality.equals(other.sentMessages, sentMessages) &&
          _deepEquality.equals(other.scheduledMessages, scheduledMessages);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (sentMessages.hashCode) + (scheduledMessages.hashCode);

  @override
  String toString() =>
      'MessageHistoryDTO[sentMessages=$sentMessages, scheduledMessages=$scheduledMessages]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'sentMessages'] = this.sentMessages;
    json[r'scheduledMessages'] = this.scheduledMessages;
    return json;
  }

  /// Returns a new [MessageHistoryDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MessageHistoryDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MessageHistoryDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MessageHistoryDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MessageHistoryDTO(
        sentMessages: MessageGetDTO.listFromJson(json[r'sentMessages']),
        scheduledMessages:
            MessageScheduleGetDTO.listFromJson(json[r'scheduledMessages']),
      );
    }
    return null;
  }

  static List<MessageHistoryDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageHistoryDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageHistoryDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MessageHistoryDTO> mapFromJson(dynamic json) {
    final map = <String, MessageHistoryDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MessageHistoryDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MessageHistoryDTO-objects as value to a dart map
  static Map<String, List<MessageHistoryDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MessageHistoryDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MessageHistoryDTO.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sentMessages',
    'scheduledMessages',
  };
}
