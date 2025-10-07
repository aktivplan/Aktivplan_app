//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StrengtheningExerciseMuscleGroup {
  /// Instantiate a new enum with the provided [value].
  const StrengtheningExerciseMuscleGroup._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CHEST = StrengtheningExerciseMuscleGroup._(r'CHEST');
  static const BACK = StrengtheningExerciseMuscleGroup._(r'BACK');
  static const ARMS = StrengtheningExerciseMuscleGroup._(r'ARMS');
  static const SHOULDERS = StrengtheningExerciseMuscleGroup._(r'SHOULDERS');
  static const LEGS = StrengtheningExerciseMuscleGroup._(r'LEGS');
  static const ABDOMINAL = StrengtheningExerciseMuscleGroup._(r'ABDOMINAL');

  /// List of all possible values in this [enum][StrengtheningExerciseMuscleGroup].
  static const values = <StrengtheningExerciseMuscleGroup>[
    CHEST,
    BACK,
    ARMS,
    SHOULDERS,
    LEGS,
    ABDOMINAL,
  ];

  static StrengtheningExerciseMuscleGroup? fromJson(dynamic value) =>
      StrengtheningExerciseMuscleGroupTypeTransformer().decode(value);

  static List<StrengtheningExerciseMuscleGroup> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <StrengtheningExerciseMuscleGroup>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StrengtheningExerciseMuscleGroup.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StrengtheningExerciseMuscleGroup] to String,
/// and [decode] dynamic data back to [StrengtheningExerciseMuscleGroup].
class StrengtheningExerciseMuscleGroupTypeTransformer {
  factory StrengtheningExerciseMuscleGroupTypeTransformer() =>
      _instance ??= const StrengtheningExerciseMuscleGroupTypeTransformer._();

  const StrengtheningExerciseMuscleGroupTypeTransformer._();

  String encode(StrengtheningExerciseMuscleGroup data) => data.value;

  /// Decodes a [dynamic value][data] to a StrengtheningExerciseMuscleGroup.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StrengtheningExerciseMuscleGroup? decode(dynamic data,
      {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CHEST':
          return StrengtheningExerciseMuscleGroup.CHEST;
        case r'BACK':
          return StrengtheningExerciseMuscleGroup.BACK;
        case r'ARMS':
          return StrengtheningExerciseMuscleGroup.ARMS;
        case r'SHOULDERS':
          return StrengtheningExerciseMuscleGroup.SHOULDERS;
        case r'LEGS':
          return StrengtheningExerciseMuscleGroup.LEGS;
        case r'ABDOMINAL':
          return StrengtheningExerciseMuscleGroup.ABDOMINAL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StrengtheningExerciseMuscleGroupTypeTransformer] instance.
  static StrengtheningExerciseMuscleGroupTypeTransformer? _instance;
}
