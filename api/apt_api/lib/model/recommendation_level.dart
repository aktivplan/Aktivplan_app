//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RecommendationLevel {
  /// Instantiate a new enum with the provided [value].
  const RecommendationLevel._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NORMAL = RecommendationLevel._(r'NORMAL');
  static const WARNING = RecommendationLevel._(r'WARNING');

  /// List of all possible values in this [enum][RecommendationLevel].
  static const values = <RecommendationLevel>[
    NORMAL,
    WARNING,
  ];

  static RecommendationLevel? fromJson(dynamic value) =>
      RecommendationLevelTypeTransformer().decode(value);

  static List<RecommendationLevel> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RecommendationLevel>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RecommendationLevel.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RecommendationLevel] to String,
/// and [decode] dynamic data back to [RecommendationLevel].
class RecommendationLevelTypeTransformer {
  factory RecommendationLevelTypeTransformer() =>
      _instance ??= const RecommendationLevelTypeTransformer._();

  const RecommendationLevelTypeTransformer._();

  String encode(RecommendationLevel data) => data.value;

  /// Decodes a [dynamic value][data] to a RecommendationLevel.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RecommendationLevel? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NORMAL':
          return RecommendationLevel.NORMAL;
        case r'WARNING':
          return RecommendationLevel.WARNING;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [RecommendationLevelTypeTransformer] instance.
  static RecommendationLevelTypeTransformer? _instance;
}
