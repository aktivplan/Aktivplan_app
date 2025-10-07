//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageSchedulePostDTO {
  /// Returns a new [MessageSchedulePostDTO] instance.
  MessageSchedulePostDTO({
    this.recipientIds = const [],
    this.recipientsOfHealthcareProfessionalId,
    this.recipientsOfInstitutionId,
    this.subject = const {},
    this.text = const {},
    this.scheduleDateTime,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageSchedulePostDTO &&
          _deepEquality.equals(other.recipientIds, recipientIds) &&
          other.recipientsOfHealthcareProfessionalId ==
              recipientsOfHealthcareProfessionalId &&
          other.recipientsOfInstitutionId == recipientsOfInstitutionId &&
          _deepEquality.equals(other.subject, subject) &&
          _deepEquality.equals(other.text, text) &&
          other.scheduleDateTime == scheduleDateTime;

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
      (scheduleDateTime == null ? 0 : scheduleDateTime!.hashCode);

  @override
  String toString() =>
      'MessageSchedulePostDTO[recipientIds=$recipientIds, recipientsOfHealthcareProfessionalId=$recipientsOfHealthcareProfessionalId, recipientsOfInstitutionId=$recipientsOfInstitutionId, subject=$subject, text=$text, scheduleDateTime=$scheduleDateTime]';

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
    return json;
  }

  /// Returns a new [MessageSchedulePostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MessageSchedulePostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "MessageSchedulePostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "MessageSchedulePostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MessageSchedulePostDTO(
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
      );
    }
    return null;
  }

  static List<MessageSchedulePostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageSchedulePostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageSchedulePostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MessageSchedulePostDTO> mapFromJson(dynamic json) {
    final map = <String, MessageSchedulePostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MessageSchedulePostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MessageSchedulePostDTO-objects as value to a dart map
  static Map<String, List<MessageSchedulePostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MessageSchedulePostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MessageSchedulePostDTO.listFromJson(
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
