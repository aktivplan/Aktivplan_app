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

class ExerciseType {
  /// Instantiate a new enum with the provided [value].
  const ExerciseType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ENDURANCE = ExerciseType._(r'ENDURANCE');
  static const INTERVAL = ExerciseType._(r'INTERVAL');
  static const STRENGTHENING = ExerciseType._(r'STRENGTHENING');
  static const HYPERTROPHY = ExerciseType._(r'HYPERTROPHY');
  static const OTHER = ExerciseType._(r'OTHER');
  static const TASK = ExerciseType._(r'TASK');
  static const ALL = ExerciseType._(r'ALL');

  /// List of all possible values in this [enum][ExerciseType].
  static const values = <ExerciseType>[
    ENDURANCE,
    INTERVAL,
    STRENGTHENING,
    HYPERTROPHY,
    OTHER,
    TASK,
    ALL,
  ];

  static ExerciseType? fromJson(dynamic value) =>
      ExerciseTypeTypeTransformer().decode(value);

  static List<ExerciseType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ExerciseType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExerciseType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ExerciseType] to String,
/// and [decode] dynamic data back to [ExerciseType].
class ExerciseTypeTypeTransformer {
  factory ExerciseTypeTypeTransformer() =>
      _instance ??= const ExerciseTypeTypeTransformer._();

  const ExerciseTypeTypeTransformer._();

  String encode(ExerciseType data) => data.value;

  /// Decodes a [dynamic value][data] to a ExerciseType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ExerciseType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ENDURANCE':
          return ExerciseType.ENDURANCE;
        case r'INTERVAL':
          return ExerciseType.INTERVAL;
        case r'STRENGTHENING':
          return ExerciseType.STRENGTHENING;
        case r'HYPERTROPHY':
          return ExerciseType.HYPERTROPHY;
        case r'OTHER':
          return ExerciseType.OTHER;
        case r'TASK':
          return ExerciseType.TASK;
        case r'ALL':
          return ExerciseType.ALL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ExerciseTypeTypeTransformer] instance.
  static ExerciseTypeTypeTransformer? _instance;
}
