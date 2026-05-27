//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActivityRepeat {
  /// Instantiate a new enum with the provided [value].
  const ActivityRepeat._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NEVER = ActivityRepeat._(r'NEVER');
  static const WEEKLY = ActivityRepeat._(r'WEEKLY');
  static const BIWEEKLY = ActivityRepeat._(r'BIWEEKLY');

  /// List of all possible values in this [enum][ActivityRepeat].
  static const values = <ActivityRepeat>[
    NEVER,
    WEEKLY,
    BIWEEKLY,
  ];

  static ActivityRepeat? fromJson(dynamic value) =>
      ActivityRepeatTypeTransformer().decode(value);

  static List<ActivityRepeat> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ActivityRepeat>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActivityRepeat.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ActivityRepeat] to String,
/// and [decode] dynamic data back to [ActivityRepeat].
class ActivityRepeatTypeTransformer {
  factory ActivityRepeatTypeTransformer() =>
      _instance ??= const ActivityRepeatTypeTransformer._();

  const ActivityRepeatTypeTransformer._();

  String encode(ActivityRepeat data) => data.value;

  /// Decodes a [dynamic value][data] to a ActivityRepeat.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ActivityRepeat? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NEVER':
          return ActivityRepeat.NEVER;
        case r'WEEKLY':
          return ActivityRepeat.WEEKLY;
        case r'BIWEEKLY':
          return ActivityRepeat.BIWEEKLY;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ActivityRepeatTypeTransformer] instance.
  static ActivityRepeatTypeTransformer? _instance;
}
