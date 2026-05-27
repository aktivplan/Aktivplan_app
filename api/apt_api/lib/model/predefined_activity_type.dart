//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PredefinedActivityType {
  /// Instantiate a new enum with the provided [value].
  const PredefinedActivityType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const HIKING = PredefinedActivityType._(r'HIKING');
  static const WALKING = PredefinedActivityType._(r'WALKING');
  static const FAST_WALKING = PredefinedActivityType._(r'FAST_WALKING');
  static const NORDIC_WALKING = PredefinedActivityType._(r'NORDIC_WALKING');
  static const RUNNING = PredefinedActivityType._(r'RUNNING');
  static const CYCLING = PredefinedActivityType._(r'CYCLING');
  static const E_BIKING = PredefinedActivityType._(r'E_BIKING');
  static const SWIMMING = PredefinedActivityType._(r'SWIMMING');
  static const STRENGTH_TRAINING =
      PredefinedActivityType._(r'STRENGTH_TRAINING');
  static const PUBLIC_TRANSPORT_WALKING =
      PredefinedActivityType._(r'PUBLIC_TRANSPORT_WALKING');
  static const CAR_WALKING = PredefinedActivityType._(r'CAR_WALKING');
  static const OTHER = PredefinedActivityType._(r'OTHER');

  /// List of all possible values in this [enum][PredefinedActivityType].
  static const values = <PredefinedActivityType>[
    HIKING,
    WALKING,
    FAST_WALKING,
    NORDIC_WALKING,
    RUNNING,
    CYCLING,
    E_BIKING,
    SWIMMING,
    STRENGTH_TRAINING,
    PUBLIC_TRANSPORT_WALKING,
    CAR_WALKING,
    OTHER,
  ];

  static PredefinedActivityType? fromJson(dynamic value) =>
      PredefinedActivityTypeTypeTransformer().decode(value);

  static List<PredefinedActivityType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PredefinedActivityType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PredefinedActivityType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PredefinedActivityType] to String,
/// and [decode] dynamic data back to [PredefinedActivityType].
class PredefinedActivityTypeTypeTransformer {
  factory PredefinedActivityTypeTypeTransformer() =>
      _instance ??= const PredefinedActivityTypeTypeTransformer._();

  const PredefinedActivityTypeTypeTransformer._();

  String encode(PredefinedActivityType data) => data.value;

  /// Decodes a [dynamic value][data] to a PredefinedActivityType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PredefinedActivityType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'HIKING':
          return PredefinedActivityType.HIKING;
        case r'WALKING':
          return PredefinedActivityType.WALKING;
        case r'FAST_WALKING':
          return PredefinedActivityType.FAST_WALKING;
        case r'NORDIC_WALKING':
          return PredefinedActivityType.NORDIC_WALKING;
        case r'RUNNING':
          return PredefinedActivityType.RUNNING;
        case r'CYCLING':
          return PredefinedActivityType.CYCLING;
        case r'E_BIKING':
          return PredefinedActivityType.E_BIKING;
        case r'SWIMMING':
          return PredefinedActivityType.SWIMMING;
        case r'STRENGTH_TRAINING':
          return PredefinedActivityType.STRENGTH_TRAINING;
        case r'PUBLIC_TRANSPORT_WALKING':
          return PredefinedActivityType.PUBLIC_TRANSPORT_WALKING;
        case r'CAR_WALKING':
          return PredefinedActivityType.CAR_WALKING;
        case r'OTHER':
          return PredefinedActivityType.OTHER;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PredefinedActivityTypeTypeTransformer] instance.
  static PredefinedActivityTypeTypeTransformer? _instance;
}
