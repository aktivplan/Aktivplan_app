//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageType {
  /// Instantiate a new enum with the provided [value].
  const MessageType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const REMIND_ACTIVITY = MessageType._(r'REMIND_ACTIVITY');
  static const REMIND_GOAL = MessageType._(r'REMIND_GOAL');
  static const REMIND_GOAL_MULTIPLE = MessageType._(r'REMIND_GOAL_MULTIPLE');
  static const ACHIEVED_GOAL = MessageType._(r'ACHIEVED_GOAL');
  static const ACHIEVED_REMAINING_ACTIVE_MINUTES =
      MessageType._(r'ACHIEVED_REMAINING_ACTIVE_MINUTES');
  static const ACHIEVED_ACTIVE_MINUTES =
      MessageType._(r'ACHIEVED_ACTIVE_MINUTES');
  static const FUTURE_REMAINING_ACTIVE_MINUTES =
      MessageType._(r'FUTURE_REMAINING_ACTIVE_MINUTES');
  static const INFORMATION = MessageType._(r'INFORMATION');
  static const PERSONAL = MessageType._(r'PERSONAL');
  static const SOCIAL = MessageType._(r'SOCIAL');

  /// List of all possible values in this [enum][MessageType].
  static const values = <MessageType>[
    REMIND_ACTIVITY,
    REMIND_GOAL,
    REMIND_GOAL_MULTIPLE,
    ACHIEVED_GOAL,
    ACHIEVED_REMAINING_ACTIVE_MINUTES,
    ACHIEVED_ACTIVE_MINUTES,
    FUTURE_REMAINING_ACTIVE_MINUTES,
    INFORMATION,
    PERSONAL,
    SOCIAL,
  ];

  static MessageType? fromJson(dynamic value) =>
      MessageTypeTypeTransformer().decode(value);

  static List<MessageType> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MessageType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MessageType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MessageType] to String,
/// and [decode] dynamic data back to [MessageType].
class MessageTypeTypeTransformer {
  factory MessageTypeTypeTransformer() =>
      _instance ??= const MessageTypeTypeTransformer._();

  const MessageTypeTypeTransformer._();

  String encode(MessageType data) => data.value;

  /// Decodes a [dynamic value][data] to a MessageType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MessageType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'REMIND_ACTIVITY':
          return MessageType.REMIND_ACTIVITY;
        case r'REMIND_GOAL':
          return MessageType.REMIND_GOAL;
        case r'REMIND_GOAL_MULTIPLE':
          return MessageType.REMIND_GOAL_MULTIPLE;
        case r'ACHIEVED_GOAL':
          return MessageType.ACHIEVED_GOAL;
        case r'ACHIEVED_REMAINING_ACTIVE_MINUTES':
          return MessageType.ACHIEVED_REMAINING_ACTIVE_MINUTES;
        case r'ACHIEVED_ACTIVE_MINUTES':
          return MessageType.ACHIEVED_ACTIVE_MINUTES;
        case r'FUTURE_REMAINING_ACTIVE_MINUTES':
          return MessageType.FUTURE_REMAINING_ACTIVE_MINUTES;
        case r'INFORMATION':
          return MessageType.INFORMATION;
        case r'PERSONAL':
          return MessageType.PERSONAL;
        case r'SOCIAL':
          return MessageType.SOCIAL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MessageTypeTypeTransformer] instance.
  static MessageTypeTypeTransformer? _instance;
}
