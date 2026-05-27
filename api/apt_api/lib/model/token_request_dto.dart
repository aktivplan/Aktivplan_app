//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TokenRequestDTO {
  /// Returns a new [TokenRequestDTO] instance.
  TokenRequestDTO({
    this.clientId,
    this.clientSecret,
    this.caatsToken,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? clientId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? clientSecret;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? caatsToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenRequestDTO &&
          other.clientId == clientId &&
          other.clientSecret == clientSecret &&
          other.caatsToken == caatsToken;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (clientId == null ? 0 : clientId!.hashCode) +
      (clientSecret == null ? 0 : clientSecret!.hashCode) +
      (caatsToken == null ? 0 : caatsToken!.hashCode);

  @override
  String toString() =>
      'TokenRequestDTO[clientId=$clientId, clientSecret=$clientSecret, caatsToken=$caatsToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.clientId != null) {
      json[r'clientId'] = this.clientId;
    } else {
      json[r'clientId'] = null;
    }
    if (this.clientSecret != null) {
      json[r'clientSecret'] = this.clientSecret;
    } else {
      json[r'clientSecret'] = null;
    }
    if (this.caatsToken != null) {
      json[r'caatsToken'] = this.caatsToken;
    } else {
      json[r'caatsToken'] = null;
    }
    return json;
  }

  /// Returns a new [TokenRequestDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TokenRequestDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "TokenRequestDTO[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "TokenRequestDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TokenRequestDTO(
        clientId: mapValueOfType<String>(json, r'clientId'),
        clientSecret: mapValueOfType<String>(json, r'clientSecret'),
        caatsToken: mapValueOfType<String>(json, r'caatsToken'),
      );
    }
    return null;
  }

  static List<TokenRequestDTO> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TokenRequestDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TokenRequestDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TokenRequestDTO> mapFromJson(dynamic json) {
    final map = <String, TokenRequestDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TokenRequestDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TokenRequestDTO-objects as value to a dart map
  static Map<String, List<TokenRequestDTO>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<TokenRequestDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TokenRequestDTO.listFromJson(
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
