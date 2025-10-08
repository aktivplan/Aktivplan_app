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

class ExternalApp {
  /// Returns a new [ExternalApp] instance.
  ExternalApp({
    this.id,
    this.institutionId,
    this.importId,
    this.orderIndex,
    this.title = const {},
    this.description = const {},
    this.webUrl,
    this.androidUrl,
    this.iosurl,
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
  int? orderIndex;

  Map<String, String> title;

  Map<String, String> description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? webUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? androidUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? iosurl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExternalApp &&
          other.id == id &&
          other.institutionId == institutionId &&
          other.importId == importId &&
          other.orderIndex == orderIndex &&
          _deepEquality.equals(other.title, title) &&
          _deepEquality.equals(other.description, description) &&
          other.webUrl == webUrl &&
          other.androidUrl == androidUrl &&
          other.iosurl == iosurl;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id == null ? 0 : id!.hashCode) +
      (institutionId == null ? 0 : institutionId!.hashCode) +
      (importId == null ? 0 : importId!.hashCode) +
      (orderIndex == null ? 0 : orderIndex!.hashCode) +
      (title.hashCode) +
      (description.hashCode) +
      (webUrl == null ? 0 : webUrl!.hashCode) +
      (androidUrl == null ? 0 : androidUrl!.hashCode) +
      (iosurl == null ? 0 : iosurl!.hashCode);

  @override
  String toString() =>
      'ExternalApp[id=$id, institutionId=$institutionId, importId=$importId, orderIndex=$orderIndex, title=$title, description=$description, webUrl=$webUrl, androidUrl=$androidUrl, iosurl=$iosurl]';

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
    if (this.orderIndex != null) {
      json[r'orderIndex'] = this.orderIndex;
    } else {
      json[r'orderIndex'] = null;
    }
    json[r'title'] = this.title;
    json[r'description'] = this.description;
    if (this.webUrl != null) {
      json[r'webUrl'] = this.webUrl;
    } else {
      json[r'webUrl'] = null;
    }
    if (this.androidUrl != null) {
      json[r'androidUrl'] = this.androidUrl;
    } else {
      json[r'androidUrl'] = null;
    }
    if (this.iosurl != null) {
      json[r'iosurl'] = this.iosurl;
    } else {
      json[r'iosurl'] = null;
    }
    return json;
  }

  /// Returns a new [ExternalApp] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExternalApp? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ExternalApp[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ExternalApp[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExternalApp(
        id: mapValueOfType<String>(json, r'id'),
        institutionId: mapValueOfType<String>(json, r'institutionId'),
        importId: mapValueOfType<String>(json, r'importId'),
        orderIndex: mapValueOfType<int>(json, r'orderIndex'),
        title: mapCastOfType<String, String>(json, r'title') ?? const {},
        description:
            mapCastOfType<String, String>(json, r'description') ?? const {},
        webUrl: mapValueOfType<String>(json, r'webUrl'),
        androidUrl: mapValueOfType<String>(json, r'androidUrl'),
        iosurl: mapValueOfType<String>(json, r'iosurl'),
      );
    }
    return null;
  }

  static List<ExternalApp> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ExternalApp>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExternalApp.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExternalApp> mapFromJson(dynamic json) {
    final map = <String, ExternalApp>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExternalApp.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExternalApp-objects as value to a dart map
  static Map<String, List<ExternalApp>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ExternalApp>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExternalApp.listFromJson(
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
