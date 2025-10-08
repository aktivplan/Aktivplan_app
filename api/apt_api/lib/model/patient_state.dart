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

class PatientState {
  /// Instantiate a new enum with the provided [value].
  const PatientState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ON_VACATION = PatientState._(r'ON_VACATION');
  static const SICK = PatientState._(r'SICK');
  static const INAPPROPRIATE_TRAINING_PLAN =
      PatientState._(r'INAPPROPRIATE_TRAINING_PLAN');
  static const NO_STATE = PatientState._(r'NO_STATE');

  /// List of all possible values in this [enum][PatientState].
  static const values = <PatientState>[
    ON_VACATION,
    SICK,
    INAPPROPRIATE_TRAINING_PLAN,
    NO_STATE,
  ];

  static PatientState? fromJson(dynamic value) =>
      PatientStateTypeTransformer().decode(value);

  static List<PatientState> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PatientState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatientState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatientState] to String,
/// and [decode] dynamic data back to [PatientState].
class PatientStateTypeTransformer {
  factory PatientStateTypeTransformer() =>
      _instance ??= const PatientStateTypeTransformer._();

  const PatientStateTypeTransformer._();

  String encode(PatientState data) => data.value;

  /// Decodes a [dynamic value][data] to a PatientState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatientState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ON_VACATION':
          return PatientState.ON_VACATION;
        case r'SICK':
          return PatientState.SICK;
        case r'INAPPROPRIATE_TRAINING_PLAN':
          return PatientState.INAPPROPRIATE_TRAINING_PLAN;
        case r'NO_STATE':
          return PatientState.NO_STATE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatientStateTypeTransformer] instance.
  static PatientStateTypeTransformer? _instance;
}
