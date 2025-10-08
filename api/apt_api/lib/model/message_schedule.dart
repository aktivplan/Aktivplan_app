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

class MessageSchedule {
  /// Returns a new [MessageSchedule] instance.
  MessageSchedule({
    this.recipientIds = const [],
    this.recipientsOfHealthcareProfessionalId,
    this.recipientsOfInstitutionId,
    this.subject = const {},
    this.text = const {},
    this.scheduleDateTime,
    this.id,
    this.senderId,
    this.pictureId = const {},
  });

  List<String> recipientIds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? recipientsOfHealthcareProfessionalId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? recipientsOfInstitutionId;

  Map<String, String> subject;

  Map<String, String> text;

  /// time to schedule in YYYY-MM-DDTHH:mm in UTC
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? scheduleDateTime;

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
  String? senderId;

  Map<String, String> pictureId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageSchedule &&
          _deepEquality.equals(other.recipientIds, recipientIds) &&
          other.recipientsOfHealthcareProfessionalId ==
              recipientsOfHealthcareProfessionalId &&
          other.recipientsOfInstitutionId == recipientsOfInstitutionId &&
          _deepEquality.equals(other.subject, subject) &&
          _deepEquality.equals(other.text, text) &&
          other.scheduleDateTime == scheduleDateTime &&
          other.id == id &&
          other.senderId == senderId &&
          _deepEquality.equals(other.pictureId, pictureId);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (recipientIds.hashCode) +
      (recipientsOfHealthcareProfessionalId == null
          ? 0
          : recipientsOfHealthcareProfessionalId!.hashCode) +
      (recipientsOfInstitutionId == null
          ? 0
          : recipientsOfInstitutionId!.hashCode) +
      (subject.hashCode) +
      (text.hashCode) +
      (scheduleDateTime == null ? 0 : scheduleDateTime!.hashCode) +
      (id == null ? 0 : id!.hashCode) +
      (senderId == null ? 0 : senderId!.hashCode) +
      (pictureId.hashCode);

  @override
  String toString() =>
      'MessageSchedule[recipientIds=$recipientIds, recipientsOfHealthcareProfessionalId=$recipientsOfHealthcareProfessionalId, recipientsOfInstitutionId=$recipientsOfInstitutionId, subject=$subject, text=$text, scheduleDateTime=$scheduleDateTime, id=$id, senderId=$senderId, pictureId=$pictureId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'recipientIds'] = this.recipientIds;
    if (this.recipientsOfHealthcareProfessionalId != null) {
      json[r'recipientsOfHealthcareProfessionalId'] =
          this.recipientsOfHealthcareProfessionalId;
    } else {
      json[r'recipientsOfHealthcareProfessionalId'] = null;
    }
    if (this.recipientsOfInstitutionId != null) {
      json[r'recipientsOfInstitutionId'] = this.recipientsOfInstitutionId;
    } else {
      json[r'recipientsOfInstitutionId'] = null;
    }
    json[r'subject'] = this.subject;
    json[r'text'] = this.text;
    if (this.scheduleDateTime != null) {
      json[r'scheduleDateTime'] = this.scheduleDateTime;
    } else {
      json[r'scheduleDateTime'] = null;
    }
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.senderId != null) {
      json[r'senderId'] = this.senderId;
    } else {
      json[r'senderId'] = null;
    }
    json[r'pictureId'] = this.pictureId;
    return json;
  }

  /// Returns a new [MessageSchedule] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MessageSchedule? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MessageSchedule[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MessageSchedule[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MessageSchedule(
        recipientIds: json[r'recipientIds'] is Iterable
            ? (json[r'recipientIds'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
        recipientsOfHealthcareProfessionalId: mapValueOfType<String>(
            json, r'recipientsOfHealthcareProfessionalId'),
        recipientsOfInstitutionId:
            mapValueOfType<String>(json, r'recipientsOfInstitutionId'),
        subject: mapCastOfType<String, String>(json, r'subject') ?? const {},
        text: mapCastOfType<String, String>(json, r'text') ?? const {},
        scheduleDateTime: mapValueOfType<String>(json, r'scheduleDateTime'),
        id: mapValueOfType<String>(json, r'id'),
        senderId: mapValueOfType<String>(json, r'senderId'),
        pictureId:
            mapCastOfType<String, String>(json, r'pictureId') ?? const {},
      );
    }
    return null;
  }

  static List<MessageSchedule> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageSchedule>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageSchedule.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MessageSchedule> mapFromJson(dynamic json) {
    final map = <String, MessageSchedule>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MessageSchedule.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MessageSchedule-objects as value to a dart map
  static Map<String, List<MessageSchedule>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MessageSchedule>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MessageSchedule.listFromJson(
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
