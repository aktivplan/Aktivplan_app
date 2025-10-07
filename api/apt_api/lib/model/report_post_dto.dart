//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReportPostDTO {
  /// Returns a new [ReportPostDTO] instance.
  ReportPostDTO({
    this.title,
    this.patientId,
    this.startDate,
    this.endDate,
    this.signOption,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? patientId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? startDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ExportSignOption? signOption;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportPostDTO &&
          other.title == title &&
          other.patientId == patientId &&
          other.startDate == startDate &&
          other.endDate == endDate &&
          other.signOption == signOption;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (title == null ? 0 : title!.hashCode) +
      (patientId == null ? 0 : patientId!.hashCode) +
      (startDate == null ? 0 : startDate!.hashCode) +
      (endDate == null ? 0 : endDate!.hashCode) +
      (signOption == null ? 0 : signOption!.hashCode);

  @override
  String toString() =>
      'ReportPostDTO[title=$title, patientId=$patientId, startDate=$startDate, endDate=$endDate, signOption=$signOption]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.patientId != null) {
      json[r'patientId'] = this.patientId;
    } else {
      json[r'patientId'] = null;
    }
    if (this.startDate != null) {
      json[r'startDate'] = this.startDate;
    } else {
      json[r'startDate'] = null;
    }
    if (this.endDate != null) {
      json[r'endDate'] = this.endDate;
    } else {
      json[r'endDate'] = null;
    }
    if (this.signOption != null) {
      json[r'signOption'] = this.signOption;
    } else {
      json[r'signOption'] = null;
    }
    return json;
  }

  /// Returns a new [ReportPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReportPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ReportPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ReportPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReportPostDTO(
        title: mapValueOfType<String>(json, r'title'),
        patientId: mapValueOfType<String>(json, r'patientId'),
        startDate: mapValueOfType<String>(json, r'startDate'),
        endDate: mapValueOfType<String>(json, r'endDate'),
        signOption: ExportSignOption.fromJson(json[r'signOption']),
      );
    }
    return null;
  }

  static List<ReportPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ReportPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReportPostDTO> mapFromJson(dynamic json) {
    final map = <String, ReportPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReportPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReportPostDTO-objects as value to a dart map
  static Map<String, List<ReportPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ReportPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReportPostDTO.listFromJson(
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
