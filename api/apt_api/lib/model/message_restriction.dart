//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageRestriction {
  /// Instantiate a new enum with the provided [value].
  const MessageRestriction._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NO_RESTRICTION = MessageRestriction._(r'NO_RESTRICTION');
  static const BEFORE_SURGERY = MessageRestriction._(r'BEFORE_SURGERY');
  static const AFTER_SURGERY = MessageRestriction._(r'AFTER_SURGERY');

  /// List of all possible values in this [enum][MessageRestriction].
  static const values = <MessageRestriction>[
    NO_RESTRICTION,
    BEFORE_SURGERY,
    AFTER_SURGERY,
  ];

  static MessageRestriction? fromJson(dynamic value) =>
      MessageRestrictionTypeTransformer().decode(value);

  static List<MessageRestriction> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageRestriction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageRestriction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MessageRestriction] to String,
/// and [decode] dynamic data back to [MessageRestriction].
class MessageRestrictionTypeTransformer {
  factory MessageRestrictionTypeTransformer() =>
      _instance ??= const MessageRestrictionTypeTransformer._();

  const MessageRestrictionTypeTransformer._();

  String encode(MessageRestriction data) => data.value;

  /// Decodes a [dynamic value][data] to a MessageRestriction.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MessageRestriction? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NO_RESTRICTION':
          return MessageRestriction.NO_RESTRICTION;
        case r'BEFORE_SURGERY':
          return MessageRestriction.BEFORE_SURGERY;
        case r'AFTER_SURGERY':
          return MessageRestriction.AFTER_SURGERY;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MessageRestrictionTypeTransformer] instance.
  static MessageRestrictionTypeTransformer? _instance;
}
