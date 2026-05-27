//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConsentGetDTO {
  /// Returns a new [ConsentGetDTO] instance.
  ConsentGetDTO({
    required this.type,
    required this.version,
    required this.required_,
    required this.accepted,
    this.text = const {},
    this.url = const {},
  });

  ConsentType type;

  int version;

  bool required_;

  bool accepted;

  Map<String, String> text;

  Map<String, String> url;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentGetDTO &&
          other.type == type &&
          other.version == version &&
          other.required_ == required_ &&
          other.accepted == accepted &&
          _deepEquality.equals(other.text, text) &&
          _deepEquality.equals(other.url, url);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (type.hashCode) +
      (version.hashCode) +
      (required_.hashCode) +
      (accepted.hashCode) +
      (text.hashCode) +
      (url.hashCode);

  @override
  String toString() =>
      'ConsentGetDTO[type=$type, version=$version, required_=$required_, accepted=$accepted, text=$text, url=$url]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'type'] = this.type;
    json[r'version'] = this.version;
    json[r'required'] = this.required_;
    json[r'accepted'] = this.accepted;
    json[r'text'] = this.text;
    json[r'url'] = this.url;
    return json;
  }

  /// Returns a new [ConsentGetDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConsentGetDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ConsentGetDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ConsentGetDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConsentGetDTO(
        type: ConsentType.fromJson(json[r'type'])!,
        version: mapValueOfType<int>(json, r'version')!,
        required_: mapValueOfType<bool>(json, r'required')!,
        accepted: mapValueOfType<bool>(json, r'accepted')!,
        text: mapCastOfType<String, String>(json, r'text')!,
        url: mapCastOfType<String, String>(json, r'url') ?? const {},
      );
    }
    return null;
  }

  static List<ConsentGetDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ConsentGetDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConsentGetDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConsentGetDTO> mapFromJson(dynamic json) {
    final map = <String, ConsentGetDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConsentGetDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConsentGetDTO-objects as value to a dart map
  static Map<String, List<ConsentGetDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ConsentGetDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConsentGetDTO.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
    'version',
    'required',
    'accepted',
    'text',
  };
}
