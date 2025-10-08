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

class ConsentType {
  /// Instantiate a new enum with the provided [value].
  const ConsentType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const TERMS_AND_CONDITIONS = ConsentType._(r'TERMS_AND_CONDITIONS');
  static const PRIVACY_POLICY = ConsentType._(r'PRIVACY_POLICY');
  static const PROCESSING_OF_DATA_FOR_SERVICE =
      ConsentType._(r'PROCESSING_OF_DATA_FOR_SERVICE');
  static const PROCESSING_OF_DATA_FOR_RESEARCH_PURPOSES =
      ConsentType._(r'PROCESSING_OF_DATA_FOR_RESEARCH_PURPOSES');
  static const TRACKING = ConsentType._(r'TRACKING');

  /// List of all possible values in this [enum][ConsentType].
  static const values = <ConsentType>[
    TERMS_AND_CONDITIONS,
    PRIVACY_POLICY,
    PROCESSING_OF_DATA_FOR_SERVICE,
    PROCESSING_OF_DATA_FOR_RESEARCH_PURPOSES,
    TRACKING,
  ];

  static ConsentType? fromJson(dynamic value) =>
      ConsentTypeTypeTransformer().decode(value);

  static List<ConsentType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ConsentType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConsentType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ConsentType] to String,
/// and [decode] dynamic data back to [ConsentType].
class ConsentTypeTypeTransformer {
  factory ConsentTypeTypeTransformer() =>
      _instance ??= const ConsentTypeTypeTransformer._();

  const ConsentTypeTypeTransformer._();

  String encode(ConsentType data) => data.value;

  /// Decodes a [dynamic value][data] to a ConsentType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ConsentType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'TERMS_AND_CONDITIONS':
          return ConsentType.TERMS_AND_CONDITIONS;
        case r'PRIVACY_POLICY':
          return ConsentType.PRIVACY_POLICY;
        case r'PROCESSING_OF_DATA_FOR_SERVICE':
          return ConsentType.PROCESSING_OF_DATA_FOR_SERVICE;
        case r'PROCESSING_OF_DATA_FOR_RESEARCH_PURPOSES':
          return ConsentType.PROCESSING_OF_DATA_FOR_RESEARCH_PURPOSES;
        case r'TRACKING':
          return ConsentType.TRACKING;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ConsentTypeTypeTransformer] instance.
  static ConsentTypeTypeTransformer? _instance;
}
