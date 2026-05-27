//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class HeatTolerance {
  /// Instantiate a new enum with the provided [value].
  const HeatTolerance._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const GOOD = HeatTolerance._(r'GOOD');
  static const AVERAGE = HeatTolerance._(r'AVERAGE');
  static const POOR = HeatTolerance._(r'POOR');

  /// List of all possible values in this [enum][HeatTolerance].
  static const values = <HeatTolerance>[
    GOOD,
    AVERAGE,
    POOR,
  ];

  static HeatTolerance? fromJson(dynamic value) =>
      HeatToleranceTypeTransformer().decode(value);

  static List<HeatTolerance> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <HeatTolerance>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HeatTolerance.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [HeatTolerance] to String,
/// and [decode] dynamic data back to [HeatTolerance].
class HeatToleranceTypeTransformer {
  factory HeatToleranceTypeTransformer() =>
      _instance ??= const HeatToleranceTypeTransformer._();

  const HeatToleranceTypeTransformer._();

  String encode(HeatTolerance data) => data.value;

  /// Decodes a [dynamic value][data] to a HeatTolerance.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  HeatTolerance? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'GOOD':
          return HeatTolerance.GOOD;
        case r'AVERAGE':
          return HeatTolerance.AVERAGE;
        case r'POOR':
          return HeatTolerance.POOR;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [HeatToleranceTypeTransformer] instance.
  static HeatToleranceTypeTransformer? _instance;
}
