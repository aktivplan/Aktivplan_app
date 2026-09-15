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

class RoutingMode {
  /// Instantiate a new enum with the provided [value].
  const RoutingMode._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const bike = RoutingMode._(r'bike');
  static const walk = RoutingMode._(r'walk');

  /// List of all possible values in this [enum][RoutingMode].
  static const values = <RoutingMode>[
    bike,
    walk,
  ];

  static RoutingMode? fromJson(dynamic value) =>
      RoutingModeTypeTransformer().decode(value);

  static List<RoutingMode> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RoutingMode>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RoutingMode.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RoutingMode] to String,
/// and [decode] dynamic data back to [RoutingMode].
class RoutingModeTypeTransformer {
  factory RoutingModeTypeTransformer() =>
      _instance ??= const RoutingModeTypeTransformer._();

  const RoutingModeTypeTransformer._();

  String encode(RoutingMode data) => data.value;

  /// Decodes a [dynamic value][data] to a RoutingMode.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RoutingMode? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'bike':
          return RoutingMode.bike;
        case r'walk':
          return RoutingMode.walk;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [RoutingModeTypeTransformer] instance.
  static RoutingModeTypeTransformer? _instance;
}
