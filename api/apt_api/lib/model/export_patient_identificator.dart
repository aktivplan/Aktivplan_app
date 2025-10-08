// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ExportPatientIdentificator {
  /// Instantiate a new enum with the provided [value].
  const ExportPatientIdentificator._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NO_IDENTIFICATOR =
      ExportPatientIdentificator._(r'NO_IDENTIFICATOR');
  static const ID = ExportPatientIdentificator._(r'ID');
  static const NAME = ExportPatientIdentificator._(r'NAME');

  /// List of all possible values in this [enum][ExportPatientIdentificator].
  static const values = <ExportPatientIdentificator>[
    NO_IDENTIFICATOR,
    ID,
    NAME,
  ];

  static ExportPatientIdentificator? fromJson(dynamic value) =>
      ExportPatientIdentificatorTypeTransformer().decode(value);

  static List<ExportPatientIdentificator> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ExportPatientIdentificator>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExportPatientIdentificator.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ExportPatientIdentificator] to String,
/// and [decode] dynamic data back to [ExportPatientIdentificator].
class ExportPatientIdentificatorTypeTransformer {
  factory ExportPatientIdentificatorTypeTransformer() =>
      _instance ??= const ExportPatientIdentificatorTypeTransformer._();

  const ExportPatientIdentificatorTypeTransformer._();

  String encode(ExportPatientIdentificator data) => data.value;

  /// Decodes a [dynamic value][data] to a ExportPatientIdentificator.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ExportPatientIdentificator? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NO_IDENTIFICATOR':
          return ExportPatientIdentificator.NO_IDENTIFICATOR;
        case r'ID':
          return ExportPatientIdentificator.ID;
        case r'NAME':
          return ExportPatientIdentificator.NAME;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ExportPatientIdentificatorTypeTransformer] instance.
  static ExportPatientIdentificatorTypeTransformer? _instance;
}
