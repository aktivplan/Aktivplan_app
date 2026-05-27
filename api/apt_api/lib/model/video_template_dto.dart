//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VideoTemplateDTO {
  /// Returns a new [VideoTemplateDTO] instance.
  VideoTemplateDTO({
    this.title = const {},
    this.youTubeLink = const {},
    this.id,
  });

  Map<String, String> title;

  Map<String, String> youTubeLink;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoTemplateDTO &&
          _deepEquality.equals(other.title, title) &&
          _deepEquality.equals(other.youTubeLink, youTubeLink) &&
          other.id == id;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (title.hashCode) +
      (youTubeLink.hashCode) +
      (id == null ? 0 : id!.hashCode);

  @override
  String toString() =>
      'VideoTemplateDTO[title=$title, youTubeLink=$youTubeLink, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'title'] = this.title;
    json[r'youTubeLink'] = this.youTubeLink;
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    return json;
  }

  /// Returns a new [VideoTemplateDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VideoTemplateDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "VideoTemplateDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "VideoTemplateDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return VideoTemplateDTO(
        title: mapCastOfType<String, String>(json, r'title') ?? const {},
        youTubeLink:
            mapCastOfType<String, String>(json, r'youTubeLink') ?? const {},
        id: mapValueOfType<String>(json, r'id'),
      );
    }
    return null;
  }

  static List<VideoTemplateDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <VideoTemplateDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VideoTemplateDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VideoTemplateDTO> mapFromJson(dynamic json) {
    final map = <String, VideoTemplateDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VideoTemplateDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VideoTemplateDTO-objects as value to a dart map
  static Map<String, List<VideoTemplateDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<VideoTemplateDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VideoTemplateDTO.listFromJson(
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
