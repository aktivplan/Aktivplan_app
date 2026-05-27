//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageScheduleGetDTO {
  /// Returns a new [MessageScheduleGetDTO] instance.
  MessageScheduleGetDTO({
    required this.sendToType,
    this.recipientIds = const [],
    this.recipientsOfHealthcareProfessionalId,
    this.recipientsOfInstitutionId,
    this.subject = const {},
    this.text = const {},
    this.scheduleDateTime,
    this.id,
    this.senderId,
    this.senderName,
    this.pictureId = const {},
  });

  MessageSendToType sendToType;

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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? senderName;

  Map<String, String> pictureId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageScheduleGetDTO &&
          other.sendToType == sendToType &&
          _deepEquality.equals(other.recipientIds, recipientIds) &&
          other.recipientsOfHealthcareProfessionalId ==
              recipientsOfHealthcareProfessionalId &&
          other.recipientsOfInstitutionId == recipientsOfInstitutionId &&
          _deepEquality.equals(other.subject, subject) &&
          _deepEquality.equals(other.text, text) &&
          other.scheduleDateTime == scheduleDateTime &&
          other.id == id &&
          other.senderId == senderId &&
          other.senderName == senderName &&
          _deepEquality.equals(other.pictureId, pictureId);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (sendToType.hashCode) +
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
      (senderName == null ? 0 : senderName!.hashCode) +
      (pictureId.hashCode);

  @override
  String toString() =>
      'MessageScheduleGetDTO[sendToType=$sendToType, recipientIds=$recipientIds, recipientsOfHealthcareProfessionalId=$recipientsOfHealthcareProfessionalId, recipientsOfInstitutionId=$recipientsOfInstitutionId, subject=$subject, text=$text, scheduleDateTime=$scheduleDateTime, id=$id, senderId=$senderId, senderName=$senderName, pictureId=$pictureId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'sendToType'] = this.sendToType;
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
    if (this.senderName != null) {
      json[r'senderName'] = this.senderName;
    } else {
      json[r'senderName'] = null;
    }
    json[r'pictureId'] = this.pictureId;
    return json;
  }

  /// Returns a new [MessageScheduleGetDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MessageScheduleGetDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MessageScheduleGetDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MessageScheduleGetDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MessageScheduleGetDTO(
        sendToType: MessageSendToType.fromJson(json[r'sendToType'])!,
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
        senderName: mapValueOfType<String>(json, r'senderName'),
        pictureId:
            mapCastOfType<String, String>(json, r'pictureId') ?? const {},
      );
    }
    return null;
  }

  static List<MessageScheduleGetDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageScheduleGetDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageScheduleGetDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MessageScheduleGetDTO> mapFromJson(dynamic json) {
    final map = <String, MessageScheduleGetDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MessageScheduleGetDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MessageScheduleGetDTO-objects as value to a dart map
  static Map<String, List<MessageScheduleGetDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MessageScheduleGetDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MessageScheduleGetDTO.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sendToType',
  };
}
