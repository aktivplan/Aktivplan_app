// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class FetchMessageCountEvent extends MessageEvent {
  FetchMessageCountEvent();

  @override
  List<Object> get props => [];
}

class FetchMessagesEvent extends MessageEvent {
  FetchMessagesEvent();

  @override
  List<Object> get props => [];
}

class MarkMessagesReadEvent extends MessageEvent {
  MarkMessagesReadEvent();

  @override
  List<Object> get props => [];
}

class ResetMessageBlocEvent extends MessageEvent {
  ResetMessageBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchMessageTemplatesEvent extends MessageEvent {
  FetchMessageTemplatesEvent();

  @override
  List<Object> get props => [];
}

class AddMessageTemplateEvent extends MessageEvent {
  final MessageTemplatePostDTO message;
  final MultipartFile? picture;
  final MultipartFile? pictureEnglish;

  AddMessageTemplateEvent({required this.message, this.picture, this.pictureEnglish});

  @override
  List<Object> get props => [message];
}

class UpdateMessageTemplateEvent extends MessageEvent {
  final String id;
  final MessageTemplatePostDTO message;
  final MultipartFile? picture;
  final MultipartFile? pictureEnglish;
  final String deletePictureId;
  final String deletePictureEnglishId;

  UpdateMessageTemplateEvent(
      {required this.id, required this.message, this.picture, this.pictureEnglish, this.deletePictureId = "", this.deletePictureEnglishId = ""});

  @override
  List<Object> get props => [id, message];
}

class DeleteMessageTemplateEvent extends MessageEvent {
  final String id;

  DeleteMessageTemplateEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchMessageHistoryEvent extends MessageEvent {
  final String patientId;

  FetchMessageHistoryEvent({this.patientId = ""});

  @override
  List<Object> get props => [patientId];
}

class CancelMessageEditEvent extends MessageEvent {
  CancelMessageEditEvent();

  @override
  List<Object> get props => [];
}

class ShowEditSentMessageEvent extends MessageEvent {
  final MessageGetDTO message;

  ShowEditSentMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateSentMessageEvent extends MessageEvent {
  final String patientId;
  final MessagePutDTO message;
  final MultipartFile? picture;
  final String deletePictureId;

  UpdateSentMessageEvent({required this.patientId, required this.message, this.picture, this.deletePictureId = ""});

  @override
  List<Object> get props => [patientId, message];
}

class ShowEditScheduledMessageEvent extends MessageEvent {
  final MessageScheduleGetDTO message;

  ShowEditScheduledMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class AddScheduledMessageEvent extends MessageEvent {
  final String patientId;
  final MessageSchedulePostDTO message;
  final MultipartFile? picture;
  final MultipartFile? pictureEnglish;

  AddScheduledMessageEvent({required this.patientId, required this.message, this.picture, this.pictureEnglish});

  @override
  List<Object> get props => [patientId, message];
}

class UpdateScheduledMessageEvent extends MessageEvent {
  final String patientId;
  final MessageSchedulePutDTO message;
  final MultipartFile? picture;
  final MultipartFile? pictureEnglish;
  final String deletePictureId;
  final String deletePictureEnglishId;

  UpdateScheduledMessageEvent(
      {required this.patientId,
      required this.message,
      this.picture,
      this.pictureEnglish,
      this.deletePictureId = "",
      this.deletePictureEnglishId = ""});

  @override
  List<Object> get props => [patientId, message];
}

class DeleteScheduledMessageEvent extends MessageEvent {
  final String patientId;
  final String messageId;
  final bool deleteAll;

  DeleteScheduledMessageEvent({required this.patientId, required this.messageId, required this.deleteAll});

  @override
  List<Object> get props => [patientId, messageId, deleteAll];
}

class CopyScheduledMessageEvent extends MessageEvent {
  final MessageScheduleGetDTO message;
  final FileGetDTO? pictureDE;
  final FileGetDTO? pictureEN;

  CopyScheduledMessageEvent({required this.message, this.pictureDE, this.pictureEN});

  @override
  List<Object> get props => [message];
}
