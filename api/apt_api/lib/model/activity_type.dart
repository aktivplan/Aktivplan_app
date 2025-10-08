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

class ActivityType {
  /// Instantiate a new enum with the provided [value].
  const ActivityType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ENDURANCE = ActivityType._(r'ENDURANCE');
  static const INTERVAL = ActivityType._(r'INTERVAL');
  static const STRENGTHENING = ActivityType._(r'STRENGTHENING');
  static const WORKOUT = ActivityType._(r'WORKOUT');
  static const EXTRA = ActivityType._(r'EXTRA');
  static const HYPERTROPHY = ActivityType._(r'HYPERTROPHY');
  static const OTHER = ActivityType._(r'OTHER');
  static const APPOINTMENT = ActivityType._(r'APPOINTMENT');
  static const TASK = ActivityType._(r'TASK');

  /// List of all possible values in this [enum][ActivityType].
  static const values = <ActivityType>[
    ENDURANCE,
    INTERVAL,
    STRENGTHENING,
    WORKOUT,
    EXTRA,
    HYPERTROPHY,
    OTHER,
    APPOINTMENT,
    TASK,
  ];

  static ActivityType? fromJson(dynamic value) =>
      ActivityTypeTypeTransformer().decode(value);

  static List<ActivityType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ActivityType] to String,
/// and [decode] dynamic data back to [ActivityType].
class ActivityTypeTypeTransformer {
  factory ActivityTypeTypeTransformer() =>
      _instance ??= const ActivityTypeTypeTransformer._();

  const ActivityTypeTypeTransformer._();

  String encode(ActivityType data) => data.value;

  /// Decodes a [dynamic value][data] to a ActivityType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ActivityType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ENDURANCE':
          return ActivityType.ENDURANCE;
        case r'INTERVAL':
          return ActivityType.INTERVAL;
        case r'STRENGTHENING':
          return ActivityType.STRENGTHENING;
        case r'WORKOUT':
          return ActivityType.WORKOUT;
        case r'EXTRA':
          return ActivityType.EXTRA;
        case r'HYPERTROPHY':
          return ActivityType.HYPERTROPHY;
        case r'OTHER':
          return ActivityType.OTHER;
        case r'APPOINTMENT':
          return ActivityType.APPOINTMENT;
        case r'TASK':
          return ActivityType.TASK;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ActivityTypeTypeTransformer] instance.
  static ActivityTypeTypeTransformer? _instance;
}
