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

class WeatherWarningType {
  /// Instantiate a new enum with the provided [value].
  const WeatherWarningType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const n1 = WeatherWarningType._(r'1');
  static const n2 = WeatherWarningType._(r'2');
  static const n3 = WeatherWarningType._(r'3');
  static const n4 = WeatherWarningType._(r'4');
  static const n5 = WeatherWarningType._(r'5');
  static const n6 = WeatherWarningType._(r'6');
  static const n7 = WeatherWarningType._(r'7');

  /// List of all possible values in this [enum][WeatherWarningType].
  static const values = <WeatherWarningType>[
    n1,
    n2,
    n3,
    n4,
    n5,
    n6,
    n7,
  ];

  static WeatherWarningType? fromJson(dynamic value) =>
      WeatherWarningTypeTypeTransformer().decode(value);

  static List<WeatherWarningType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WeatherWarningType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WeatherWarningType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WeatherWarningType] to String,
/// and [decode] dynamic data back to [WeatherWarningType].
class WeatherWarningTypeTypeTransformer {
  factory WeatherWarningTypeTypeTransformer() =>
      _instance ??= const WeatherWarningTypeTypeTransformer._();

  const WeatherWarningTypeTypeTransformer._();

  String encode(WeatherWarningType data) => data.value;

  /// Decodes a [dynamic value][data] to a WeatherWarningType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WeatherWarningType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'1':
          return WeatherWarningType.n1;
        case r'2':
          return WeatherWarningType.n2;
        case r'3':
          return WeatherWarningType.n3;
        case r'4':
          return WeatherWarningType.n4;
        case r'5':
          return WeatherWarningType.n5;
        case r'6':
          return WeatherWarningType.n6;
        case r'7':
          return WeatherWarningType.n7;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WeatherWarningTypeTypeTransformer] instance.
  static WeatherWarningTypeTypeTransformer? _instance;
}
