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

class ConsentErrorCause {
  /// Instantiate a new enum with the provided [value].
  const ConsentErrorCause._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NONE = ConsentErrorCause._(r'NONE');
  static const RESET_TOKEN_NOT_FOUND =
      ConsentErrorCause._(r'RESET_TOKEN_NOT_FOUND');
  static const RESET_TOKEN_EXPIRED =
      ConsentErrorCause._(r'RESET_TOKEN_EXPIRED');

  /// List of all possible values in this [enum][ConsentErrorCause].
  static const values = <ConsentErrorCause>[
    NONE,
    RESET_TOKEN_NOT_FOUND,
    RESET_TOKEN_EXPIRED,
  ];

  static ConsentErrorCause? fromJson(dynamic value) =>
      ConsentErrorCauseTypeTransformer().decode(value);

  static List<ConsentErrorCause> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ConsentErrorCause>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConsentErrorCause.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ConsentErrorCause] to String,
/// and [decode] dynamic data back to [ConsentErrorCause].
class ConsentErrorCauseTypeTransformer {
  factory ConsentErrorCauseTypeTransformer() =>
      _instance ??= const ConsentErrorCauseTypeTransformer._();

  const ConsentErrorCauseTypeTransformer._();

  String encode(ConsentErrorCause data) => data.value;

  /// Decodes a [dynamic value][data] to a ConsentErrorCause.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ConsentErrorCause? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NONE':
          return ConsentErrorCause.NONE;
        case r'RESET_TOKEN_NOT_FOUND':
          return ConsentErrorCause.RESET_TOKEN_NOT_FOUND;
        case r'RESET_TOKEN_EXPIRED':
          return ConsentErrorCause.RESET_TOKEN_EXPIRED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ConsentErrorCauseTypeTransformer] instance.
  static ConsentErrorCauseTypeTransformer? _instance;
}
