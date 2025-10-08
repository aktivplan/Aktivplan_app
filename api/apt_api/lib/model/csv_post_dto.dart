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

class CSVPostDTO {
  /// Returns a new [CSVPostDTO] instance.
  CSVPostDTO({
    this.filename,
    this.patientId,
    this.startDate,
    this.endDate,
    this.patientIdentificator,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? filename;

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
  ExportPatientIdentificator? patientIdentificator;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CSVPostDTO &&
          other.filename == filename &&
          other.patientId == patientId &&
          other.startDate == startDate &&
          other.endDate == endDate &&
          other.patientIdentificator == patientIdentificator;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (filename == null ? 0 : filename!.hashCode) +
      (patientId == null ? 0 : patientId!.hashCode) +
      (startDate == null ? 0 : startDate!.hashCode) +
      (endDate == null ? 0 : endDate!.hashCode) +
      (patientIdentificator == null ? 0 : patientIdentificator!.hashCode);

  @override
  String toString() =>
      'CSVPostDTO[filename=$filename, patientId=$patientId, startDate=$startDate, endDate=$endDate, patientIdentificator=$patientIdentificator]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.filename != null) {
      json[r'filename'] = this.filename;
    } else {
      json[r'filename'] = null;
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
    if (this.patientIdentificator != null) {
      json[r'patientIdentificator'] = this.patientIdentificator;
    } else {
      json[r'patientIdentificator'] = null;
    }
    return json;
  }

  /// Returns a new [CSVPostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CSVPostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "CSVPostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "CSVPostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CSVPostDTO(
        filename: mapValueOfType<String>(json, r'filename'),
        patientId: mapValueOfType<String>(json, r'patientId'),
        startDate: mapValueOfType<String>(json, r'startDate'),
        endDate: mapValueOfType<String>(json, r'endDate'),
        patientIdentificator:
            ExportPatientIdentificator.fromJson(json[r'patientIdentificator']),
      );
    }
    return null;
  }

  static List<CSVPostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <CSVPostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CSVPostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CSVPostDTO> mapFromJson(dynamic json) {
    final map = <String, CSVPostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CSVPostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CSVPostDTO-objects as value to a dart map
  static Map<String, List<CSVPostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<CSVPostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CSVPostDTO.listFromJson(
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
