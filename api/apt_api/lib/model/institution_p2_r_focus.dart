//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InstitutionP2RFocus {
  /// Instantiate a new enum with the provided [value].
  const InstitutionP2RFocus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ORTHO_BV = InstitutionP2RFocus._(r'ORTHO_BV');
  static const ONKO_SALK = InstitutionP2RFocus._(r'ONKO_SALK');
  static const KARDIO_MUW = InstitutionP2RFocus._(r'KARDIO_MUW');
  static const GENERAL = InstitutionP2RFocus._(r'GENERAL');

  /// List of all possible values in this [enum][InstitutionP2RFocus].
  static const values = <InstitutionP2RFocus>[
    ORTHO_BV,
    ONKO_SALK,
    KARDIO_MUW,
    GENERAL,
  ];

  static InstitutionP2RFocus? fromJson(dynamic value) =>
      InstitutionP2RFocusTypeTransformer().decode(value);

  static List<InstitutionP2RFocus> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InstitutionP2RFocus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InstitutionP2RFocus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InstitutionP2RFocus] to String,
/// and [decode] dynamic data back to [InstitutionP2RFocus].
class InstitutionP2RFocusTypeTransformer {
  factory InstitutionP2RFocusTypeTransformer() =>
      _instance ??= const InstitutionP2RFocusTypeTransformer._();

  const InstitutionP2RFocusTypeTransformer._();

  String encode(InstitutionP2RFocus data) => data.value;

  /// Decodes a [dynamic value][data] to a InstitutionP2RFocus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InstitutionP2RFocus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ORTHO_BV':
          return InstitutionP2RFocus.ORTHO_BV;
        case r'ONKO_SALK':
          return InstitutionP2RFocus.ONKO_SALK;
        case r'KARDIO_MUW':
          return InstitutionP2RFocus.KARDIO_MUW;
        case r'GENERAL':
          return InstitutionP2RFocus.GENERAL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InstitutionP2RFocusTypeTransformer] instance.
  static InstitutionP2RFocusTypeTransformer? _instance;
}
