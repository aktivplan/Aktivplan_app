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
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VideoTemplateOrderingDTO {
  /// Returns a new [VideoTemplateOrderingDTO] instance.
  VideoTemplateOrderingDTO({
    this.title = const {},
    this.youTubeLink = const {},
    this.orderedIds = const [],
  });

  Map<String, String> title;

  Map<String, String> youTubeLink;

  List<String> orderedIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoTemplateOrderingDTO &&
          other.title == title &&
          other.youTubeLink == youTubeLink &&
          other.orderedIds == orderedIds;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (title.hashCode) + (youTubeLink.hashCode) + (orderedIds.hashCode);

  @override
  String toString() =>
      'VideoTemplateOrderingDTO[title=$title, youTubeLink=$youTubeLink, orderedIds=$orderedIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'title'] = this.title;
    json[r'youTubeLink'] = this.youTubeLink;
    json[r'orderedIds'] = this.orderedIds;
    return json;
  }

  /// Returns a new [VideoTemplateOrderingDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VideoTemplateOrderingDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "VideoTemplateOrderingDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "VideoTemplateOrderingDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return VideoTemplateOrderingDTO(
        title: mapCastOfType<String, String>(json, r'title') ?? const {},
        youTubeLink:
            mapCastOfType<String, String>(json, r'youTubeLink') ?? const {},
        orderedIds: json[r'orderedIds'] is List
            ? (json[r'orderedIds'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<VideoTemplateOrderingDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <VideoTemplateOrderingDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VideoTemplateOrderingDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VideoTemplateOrderingDTO> mapFromJson(dynamic json) {
    final map = <String, VideoTemplateOrderingDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VideoTemplateOrderingDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VideoTemplateOrderingDTO-objects as value to a dart map
  static Map<String, List<VideoTemplateOrderingDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<VideoTemplateOrderingDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VideoTemplateOrderingDTO.listFromJson(
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
