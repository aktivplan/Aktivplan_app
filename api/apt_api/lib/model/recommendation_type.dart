//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RecommendationType {
  /// Instantiate a new enum with the provided [value].
  const RecommendationType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const GENERIC_CONTEXT = RecommendationType._(r'GENERIC_CONTEXT');
  static const SPACE_TIME = RecommendationType._(r'SPACE_TIME');
  static const ACTIVITY = RecommendationType._(r'ACTIVITY');
  static const MOBILITY = RecommendationType._(r'MOBILITY');

  /// List of all possible values in this [enum][RecommendationType].
  static const values = <RecommendationType>[
    GENERIC_CONTEXT,
    SPACE_TIME,
    ACTIVITY,
    MOBILITY,
  ];

  static RecommendationType? fromJson(dynamic value) =>
      RecommendationTypeTypeTransformer().decode(value);

  static List<RecommendationType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RecommendationType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RecommendationType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RecommendationType] to String,
/// and [decode] dynamic data back to [RecommendationType].
class RecommendationTypeTypeTransformer {
  factory RecommendationTypeTypeTransformer() =>
      _instance ??= const RecommendationTypeTypeTransformer._();

  const RecommendationTypeTypeTransformer._();

  String encode(RecommendationType data) => data.value;

  /// Decodes a [dynamic value][data] to a RecommendationType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RecommendationType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'GENERIC_CONTEXT':
          return RecommendationType.GENERIC_CONTEXT;
        case r'SPACE_TIME':
          return RecommendationType.SPACE_TIME;
        case r'ACTIVITY':
          return RecommendationType.ACTIVITY;
        case r'MOBILITY':
          return RecommendationType.MOBILITY;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [RecommendationTypeTypeTransformer] instance.
  static RecommendationTypeTypeTransformer? _instance;
}
