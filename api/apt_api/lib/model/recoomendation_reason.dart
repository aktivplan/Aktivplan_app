//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RecoomendationReason {
  /// Instantiate a new enum with the provided [value].
  const RecoomendationReason._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const HEAT = RecoomendationReason._(r'HEAT');
  static const PRECIPITATION = RecoomendationReason._(r'PRECIPITATION');
  static const SEVERE_WEATHER = RecoomendationReason._(r'SEVERE_WEATHER');
  static const ACTIVITY_LEVEL = RecoomendationReason._(r'ACTIVITY_LEVEL');
  static const ADDITIONAL_OPPORTUNITY =
      RecoomendationReason._(r'ADDITIONAL_OPPORTUNITY');
  static const ACTIVE_MOBILITY_UNFEASIBLE =
      RecoomendationReason._(r'ACTIVE_MOBILITY_UNFEASIBLE');

  /// List of all possible values in this [enum][RecoomendationReason].
  static const values = <RecoomendationReason>[
    HEAT,
    PRECIPITATION,
    SEVERE_WEATHER,
    ACTIVITY_LEVEL,
    ADDITIONAL_OPPORTUNITY,
    ACTIVE_MOBILITY_UNFEASIBLE,
  ];

  static RecoomendationReason? fromJson(dynamic value) =>
      RecoomendationReasonTypeTransformer().decode(value);

  static List<RecoomendationReason> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RecoomendationReason>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RecoomendationReason.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RecoomendationReason] to String,
/// and [decode] dynamic data back to [RecoomendationReason].
class RecoomendationReasonTypeTransformer {
  factory RecoomendationReasonTypeTransformer() =>
      _instance ??= const RecoomendationReasonTypeTransformer._();

  const RecoomendationReasonTypeTransformer._();

  String encode(RecoomendationReason data) => data.value;

  /// Decodes a [dynamic value][data] to a RecoomendationReason.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RecoomendationReason? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'HEAT':
          return RecoomendationReason.HEAT;
        case r'PRECIPITATION':
          return RecoomendationReason.PRECIPITATION;
        case r'SEVERE_WEATHER':
          return RecoomendationReason.SEVERE_WEATHER;
        case r'ACTIVITY_LEVEL':
          return RecoomendationReason.ACTIVITY_LEVEL;
        case r'ADDITIONAL_OPPORTUNITY':
          return RecoomendationReason.ADDITIONAL_OPPORTUNITY;
        case r'ACTIVE_MOBILITY_UNFEASIBLE':
          return RecoomendationReason.ACTIVE_MOBILITY_UNFEASIBLE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [RecoomendationReasonTypeTransformer] instance.
  static RecoomendationReasonTypeTransformer? _instance;
}
