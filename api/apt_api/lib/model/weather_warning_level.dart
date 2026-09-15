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

class WeatherWarningLevel {
  /// Instantiate a new enum with the provided [value].
  const WeatherWarningLevel._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const n1 = WeatherWarningLevel._(r'1');
  static const n2 = WeatherWarningLevel._(r'2');
  static const n3 = WeatherWarningLevel._(r'3');

  /// List of all possible values in this [enum][WeatherWarningLevel].
  static const values = <WeatherWarningLevel>[
    n1,
    n2,
    n3,
  ];

  static WeatherWarningLevel? fromJson(dynamic value) =>
      WeatherWarningLevelTypeTransformer().decode(value);

  static List<WeatherWarningLevel> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WeatherWarningLevel>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WeatherWarningLevel.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WeatherWarningLevel] to String,
/// and [decode] dynamic data back to [WeatherWarningLevel].
class WeatherWarningLevelTypeTransformer {
  factory WeatherWarningLevelTypeTransformer() =>
      _instance ??= const WeatherWarningLevelTypeTransformer._();

  const WeatherWarningLevelTypeTransformer._();

  String encode(WeatherWarningLevel data) => data.value;

  /// Decodes a [dynamic value][data] to a WeatherWarningLevel.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WeatherWarningLevel? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'1':
          return WeatherWarningLevel.n1;
        case r'2':
          return WeatherWarningLevel.n2;
        case r'3':
          return WeatherWarningLevel.n3;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WeatherWarningLevelTypeTransformer] instance.
  static WeatherWarningLevelTypeTransformer? _instance;
}
