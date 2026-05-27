//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InstitutionImportType {
  /// Instantiate a new enum with the provided [value].
  const InstitutionImportType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const EXERCISES = InstitutionImportType._(r'EXERCISES');
  static const MESSAGES = InstitutionImportType._(r'MESSAGES');
  static const VIDEOS = InstitutionImportType._(r'VIDEOS');
  static const EXTERNAL_APPS = InstitutionImportType._(r'EXTERNAL_APPS');

  /// List of all possible values in this [enum][InstitutionImportType].
  static const values = <InstitutionImportType>[
    EXERCISES,
    MESSAGES,
    VIDEOS,
    EXTERNAL_APPS,
  ];

  static InstitutionImportType? fromJson(dynamic value) =>
      InstitutionImportTypeTypeTransformer().decode(value);

  static List<InstitutionImportType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InstitutionImportType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InstitutionImportType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InstitutionImportType] to String,
/// and [decode] dynamic data back to [InstitutionImportType].
class InstitutionImportTypeTypeTransformer {
  factory InstitutionImportTypeTypeTransformer() =>
      _instance ??= const InstitutionImportTypeTypeTransformer._();

  const InstitutionImportTypeTypeTransformer._();

  String encode(InstitutionImportType data) => data.value;

  /// Decodes a [dynamic value][data] to a InstitutionImportType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InstitutionImportType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'EXERCISES':
          return InstitutionImportType.EXERCISES;
        case r'MESSAGES':
          return InstitutionImportType.MESSAGES;
        case r'VIDEOS':
          return InstitutionImportType.VIDEOS;
        case r'EXTERNAL_APPS':
          return InstitutionImportType.EXTERNAL_APPS;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InstitutionImportTypeTypeTransformer] instance.
  static InstitutionImportTypeTypeTransformer? _instance;
}
