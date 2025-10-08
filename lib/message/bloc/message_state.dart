// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class FetchedMessageCountState extends MessageState {
  final MessageCountDTO count;
  FetchedMessageCountState({required this.count});

  @override
  List<Object> get props => [count];
}

class FetchedMessagesState extends MessageState {
  final MessageOverviewDTO messages;
  FetchedMessagesState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessageErrorState extends MessageState {
  final String message;
  MessageErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchedMessageTemplatesState extends MessageState {
  final List<MessageTemplateDTO> messages;
  FetchedMessageTemplatesState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class AddedMessageTemplateState extends MessageState {
  AddedMessageTemplateState();

  @override
  List<Object> get props => [];
}

class UpdatedMessageTemplateState extends MessageState {
  UpdatedMessageTemplateState();

  @override
  List<Object> get props => [];
}

class DeletedMessageTemplateState extends MessageState {
  DeletedMessageTemplateState();

  @override
  List<Object> get props => [];
}

class EditSentMessageState extends MessageState {
  final MessageGetDTO message;
  EditSentMessageState({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchedMessageHistoryState extends MessageState {
  final MessageHistoryDTO history;
  final List<MessageReceiverNameDTO> receiverNames;
  FetchedMessageHistoryState({required this.history, required this.receiverNames});

  @override
  List<Object> get props => [history];
}

class CanceledMessageEditState extends MessageState {
  CanceledMessageEditState();

  @override
  List<Object> get props => [];
}

class UpdatedSentMessageState extends MessageState {
  UpdatedSentMessageState();

  @override
  List<Object> get props => [];
}

class DeletedSentMessageState extends MessageState {
  DeletedSentMessageState();

  @override
  List<Object> get props => [];
}

class EditScheduledMessageState extends MessageState {
  final MessageScheduleGetDTO message;
  EditScheduledMessageState({required this.message});

  @override
  List<Object> get props => [message];
}

class SentScheduledMessageState extends MessageState {
  SentScheduledMessageState();

  @override
  List<Object> get props => [];
}

class AddedScheduledMessageState extends MessageState {
  AddedScheduledMessageState();

  @override
  List<Object> get props => [];
}

class UpdatedScheduledMessageState extends MessageState {
  UpdatedScheduledMessageState();

  @override
  List<Object> get props => [];
}

class DeletedScheduledMessageState extends MessageState {
  DeletedScheduledMessageState();

  @override
  List<Object> get props => [];
}

class CopyScheduledMessageState extends MessageState {
  final MessageScheduleGetDTO message;
  final MultipartFile? pictureFileDE;
  final MultipartFile? pictureFileEN;
  CopyScheduledMessageState({required this.message, this.pictureFileDE, this.pictureFileEN});

  @override
  List<Object> get props => [message];
}
