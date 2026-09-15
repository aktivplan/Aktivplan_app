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

class SpaceTimeRecommendationChangeType {
  /// Instantiate a new enum with the provided [value].
  const SpaceTimeRecommendationChangeType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const SPACE = SpaceTimeRecommendationChangeType._(r'SPACE');
  static const TIME = SpaceTimeRecommendationChangeType._(r'TIME');
  static const NO_CHANGE = SpaceTimeRecommendationChangeType._(r'NO_CHANGE');

  /// List of all possible values in this [enum][SpaceTimeRecommendationChangeType].
  static const values = <SpaceTimeRecommendationChangeType>[
    SPACE,
    TIME,
    NO_CHANGE,
  ];

  static SpaceTimeRecommendationChangeType? fromJson(dynamic value) =>
      SpaceTimeRecommendationChangeTypeTypeTransformer().decode(value);

  static List<SpaceTimeRecommendationChangeType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <SpaceTimeRecommendationChangeType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SpaceTimeRecommendationChangeType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SpaceTimeRecommendationChangeType] to String,
/// and [decode] dynamic data back to [SpaceTimeRecommendationChangeType].
class SpaceTimeRecommendationChangeTypeTypeTransformer {
  factory SpaceTimeRecommendationChangeTypeTypeTransformer() =>
      _instance ??= const SpaceTimeRecommendationChangeTypeTypeTransformer._();

  const SpaceTimeRecommendationChangeTypeTypeTransformer._();

  String encode(SpaceTimeRecommendationChangeType data) => data.value;

  /// Decodes a [dynamic value][data] to a SpaceTimeRecommendationChangeType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SpaceTimeRecommendationChangeType? decode(dynamic data,
      {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'SPACE':
          return SpaceTimeRecommendationChangeType.SPACE;
        case r'TIME':
          return SpaceTimeRecommendationChangeType.TIME;
        case r'NO_CHANGE':
          return SpaceTimeRecommendationChangeType.NO_CHANGE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SpaceTimeRecommendationChangeTypeTypeTransformer] instance.
  static SpaceTimeRecommendationChangeTypeTypeTransformer? _instance;
}
