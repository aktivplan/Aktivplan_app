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

class DayOfWeek {
  /// Instantiate a new enum with the provided [value].
  const DayOfWeek._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MONDAY = DayOfWeek._(r'MONDAY');
  static const TUESDAY = DayOfWeek._(r'TUESDAY');
  static const WEDNESDAY = DayOfWeek._(r'WEDNESDAY');
  static const THURSDAY = DayOfWeek._(r'THURSDAY');
  static const FRIDAY = DayOfWeek._(r'FRIDAY');
  static const SATURDAY = DayOfWeek._(r'SATURDAY');
  static const SUNDAY = DayOfWeek._(r'SUNDAY');

  /// List of all possible values in this [enum][DayOfWeek].
  static const values = <DayOfWeek>[
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY,
  ];

  static DayOfWeek? fromJson(dynamic value) =>
      DayOfWeekTypeTransformer().decode(value);

  static List<DayOfWeek> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DayOfWeek>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DayOfWeek.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DayOfWeek] to String,
/// and [decode] dynamic data back to [DayOfWeek].
class DayOfWeekTypeTransformer {
  factory DayOfWeekTypeTransformer() =>
      _instance ??= const DayOfWeekTypeTransformer._();

  const DayOfWeekTypeTransformer._();

  String encode(DayOfWeek data) => data.value;

  /// Decodes a [dynamic value][data] to a DayOfWeek.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DayOfWeek? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'MONDAY':
          return DayOfWeek.MONDAY;
        case r'TUESDAY':
          return DayOfWeek.TUESDAY;
        case r'WEDNESDAY':
          return DayOfWeek.WEDNESDAY;
        case r'THURSDAY':
          return DayOfWeek.THURSDAY;
        case r'FRIDAY':
          return DayOfWeek.FRIDAY;
        case r'SATURDAY':
          return DayOfWeek.SATURDAY;
        case r'SUNDAY':
          return DayOfWeek.SUNDAY;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [DayOfWeekTypeTransformer] instance.
  static DayOfWeekTypeTransformer? _instance;
}
