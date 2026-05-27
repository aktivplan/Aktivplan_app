//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InstitutionFocus {
  /// Instantiate a new enum with the provided [value].
  const InstitutionFocus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CARDIOVASCULAR_REHABILITATION =
      InstitutionFocus._(r'CARDIOVASCULAR_REHABILITATION');
  static const PROMOTING_A_HEALTHY_LIFESTYLE =
      InstitutionFocus._(r'PROMOTING_A_HEALTHY_LIFESTYLE');
  static const KLIMAFIT = InstitutionFocus._(r'KLIMAFIT');
  static const KLIMAFIT_LIGHT = InstitutionFocus._(r'KLIMAFIT_LIGHT');
  static const PREHAB_TO_REHAB = InstitutionFocus._(r'PREHAB_TO_REHAB');

  /// List of all possible values in this [enum][InstitutionFocus].
  static const values = <InstitutionFocus>[
    CARDIOVASCULAR_REHABILITATION,
    PROMOTING_A_HEALTHY_LIFESTYLE,
    KLIMAFIT,
    KLIMAFIT_LIGHT,
    PREHAB_TO_REHAB,
  ];

  static InstitutionFocus? fromJson(dynamic value) =>
      InstitutionFocusTypeTransformer().decode(value);

  static List<InstitutionFocus> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InstitutionFocus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InstitutionFocus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InstitutionFocus] to String,
/// and [decode] dynamic data back to [InstitutionFocus].
class InstitutionFocusTypeTransformer {
  factory InstitutionFocusTypeTransformer() =>
      _instance ??= const InstitutionFocusTypeTransformer._();

  const InstitutionFocusTypeTransformer._();

  String encode(InstitutionFocus data) => data.value;

  /// Decodes a [dynamic value][data] to a InstitutionFocus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InstitutionFocus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CARDIOVASCULAR_REHABILITATION':
          return InstitutionFocus.CARDIOVASCULAR_REHABILITATION;
        case r'PROMOTING_A_HEALTHY_LIFESTYLE':
          return InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE;
        case r'KLIMAFIT':
          return InstitutionFocus.KLIMAFIT;
        case r'KLIMAFIT_LIGHT':
          return InstitutionFocus.KLIMAFIT_LIGHT;
        case r'PREHAB_TO_REHAB':
          return InstitutionFocus.PREHAB_TO_REHAB;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InstitutionFocusTypeTransformer] instance.
  static InstitutionFocusTypeTransformer? _instance;
}
