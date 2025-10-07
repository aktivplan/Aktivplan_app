//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TranslationLanguage {
  /// Instantiate a new enum with the provided [value].
  const TranslationLanguage._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const DE = TranslationLanguage._(r'DE');
  static const EN = TranslationLanguage._(r'EN');

  /// List of all possible values in this [enum][TranslationLanguage].
  static const values = <TranslationLanguage>[
    DE,
    EN,
  ];

  static TranslationLanguage? fromJson(dynamic value) =>
      TranslationLanguageTypeTransformer().decode(value);

  static List<TranslationLanguage> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TranslationLanguage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TranslationLanguage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TranslationLanguage] to String,
/// and [decode] dynamic data back to [TranslationLanguage].
class TranslationLanguageTypeTransformer {
  factory TranslationLanguageTypeTransformer() =>
      _instance ??= const TranslationLanguageTypeTransformer._();

  const TranslationLanguageTypeTransformer._();

  String encode(TranslationLanguage data) => data.value;

  /// Decodes a [dynamic value][data] to a TranslationLanguage.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TranslationLanguage? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'DE':
          return TranslationLanguage.DE;
        case r'EN':
          return TranslationLanguage.EN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TranslationLanguageTypeTransformer] instance.
  static TranslationLanguageTypeTransformer? _instance;
}
