//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VideoTemplatePostDTO {
  /// Returns a new [VideoTemplatePostDTO] instance.
  VideoTemplatePostDTO({
    this.title = const {},
    this.youTubeLink = const {},
  });

  Map<String, String> title;

  Map<String, String> youTubeLink;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoTemplatePostDTO &&
          _deepEquality.equals(other.title, title) &&
          _deepEquality.equals(other.youTubeLink, youTubeLink);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (title.hashCode) + (youTubeLink.hashCode);

  @override
  String toString() =>
      'VideoTemplatePostDTO[title=$title, youTubeLink=$youTubeLink]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'title'] = this.title;
    json[r'youTubeLink'] = this.youTubeLink;
    return json;
  }

  /// Returns a new [VideoTemplatePostDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VideoTemplatePostDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "VideoTemplatePostDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "VideoTemplatePostDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return VideoTemplatePostDTO(
        title: mapCastOfType<String, String>(json, r'title') ?? const {},
        youTubeLink:
            mapCastOfType<String, String>(json, r'youTubeLink') ?? const {},
      );
    }
    return null;
  }

  static List<VideoTemplatePostDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <VideoTemplatePostDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VideoTemplatePostDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VideoTemplatePostDTO> mapFromJson(dynamic json) {
    final map = <String, VideoTemplatePostDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VideoTemplatePostDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VideoTemplatePostDTO-objects as value to a dart map
  static Map<String, List<VideoTemplatePostDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<VideoTemplatePostDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VideoTemplatePostDTO.listFromJson(
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
