//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MobilityPreference {
  /// Instantiate a new enum with the provided [value].
  const MobilityPreference._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const FOOT = MobilityPreference._(r'FOOT');
  static const BIKE = MobilityPreference._(r'BIKE');
  static const PUBLIC_TRANSPORT = MobilityPreference._(r'PUBLIC_TRANSPORT');
  static const CAR = MobilityPreference._(r'CAR');

  /// List of all possible values in this [enum][MobilityPreference].
  static const values = <MobilityPreference>[
    FOOT,
    BIKE,
    PUBLIC_TRANSPORT,
    CAR,
  ];

  static MobilityPreference? fromJson(dynamic value) =>
      MobilityPreferenceTypeTransformer().decode(value);

  static List<MobilityPreference> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MobilityPreference>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MobilityPreference.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MobilityPreference] to String,
/// and [decode] dynamic data back to [MobilityPreference].
class MobilityPreferenceTypeTransformer {
  factory MobilityPreferenceTypeTransformer() =>
      _instance ??= const MobilityPreferenceTypeTransformer._();

  const MobilityPreferenceTypeTransformer._();

  String encode(MobilityPreference data) => data.value;

  /// Decodes a [dynamic value][data] to a MobilityPreference.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MobilityPreference? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'FOOT':
          return MobilityPreference.FOOT;
        case r'BIKE':
          return MobilityPreference.BIKE;
        case r'PUBLIC_TRANSPORT':
          return MobilityPreference.PUBLIC_TRANSPORT;
        case r'CAR':
          return MobilityPreference.CAR;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MobilityPreferenceTypeTransformer] instance.
  static MobilityPreferenceTypeTransformer? _instance;
}
