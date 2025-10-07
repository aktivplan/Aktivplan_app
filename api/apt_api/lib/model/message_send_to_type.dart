//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageSendToType {
  /// Instantiate a new enum with the provided [value].
  const MessageSendToType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ALL = MessageSendToType._(r'ALL');
  static const SOME = MessageSendToType._(r'SOME');
  static const ONE = MessageSendToType._(r'ONE');

  /// List of all possible values in this [enum][MessageSendToType].
  static const values = <MessageSendToType>[
    ALL,
    SOME,
    ONE,
  ];

  static MessageSendToType? fromJson(dynamic value) =>
      MessageSendToTypeTypeTransformer().decode(value);

  static List<MessageSendToType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageSendToType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageSendToType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MessageSendToType] to String,
/// and [decode] dynamic data back to [MessageSendToType].
class MessageSendToTypeTypeTransformer {
  factory MessageSendToTypeTypeTransformer() =>
      _instance ??= const MessageSendToTypeTypeTransformer._();

  const MessageSendToTypeTypeTransformer._();

  String encode(MessageSendToType data) => data.value;

  /// Decodes a [dynamic value][data] to a MessageSendToType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MessageSendToType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ALL':
          return MessageSendToType.ALL;
        case r'SOME':
          return MessageSendToType.SOME;
        case r'ONE':
          return MessageSendToType.ONE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MessageSendToTypeTypeTransformer] instance.
  static MessageSendToTypeTypeTransformer? _instance;
}
