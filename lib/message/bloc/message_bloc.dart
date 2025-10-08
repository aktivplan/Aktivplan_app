// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:async';

import 'package:apt_api/api.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

import 'message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  Future<MultipartFile> createMultipartFileFromObject(FileGetDTO picture) async {
    // Download the file from the URL
    final response = await get(Uri.parse(picture.url!));
    if (response.statusCode == 200) {
      // Create a MultipartFile from the downloaded file
      return MultipartFile.fromBytes(
        'pictureFile',
        response.bodyBytes,
        filename: picture.filename,
      );
    } else {
      throw Exception('Failed to download file from URL');
    }
  }

  MessageBloc({
    required this.messageRepository,
  }) : super(MessageInitial()) {
    on<FetchMessageCountEvent>((event, emit) async {
      MessageCountDTO? count = await messageRepository.getMessageCount();
      emit(FetchedMessageCountState(count: count!));
    });
    on<FetchMessagesEvent>((event, emit) async {
      MessageOverviewDTO? messages = await messageRepository.getMessages();
      emit(FetchedMessagesState(messages: messages!));
    });
    on<MarkMessagesReadEvent>((event, emit) async {
      await messageRepository.markMessagesRead();
      final MessageCountDTO count = new MessageCountDTO();
      count.unreadMessages = 0;
      emit(FetchedMessageCountState(count: count));
    });
    on<ResetMessageBlocEvent>((event, emit) async {
      emit(MessageInitial());
    });
    on<FetchMessageTemplatesEvent>((event, emit) async {
      emit(FetchedMessageTemplatesState(messages: (await messageRepository.getMessageTemplates())!));
    });
    on<AddMessageTemplateEvent>((event, emit) async {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_MESSAGE_TEMPLATE,
          name: EVENT_NAME_CREATE,
          action: "Created Message Template",
        ),
      );
      final MessageTemplate? newMessage = await messageRepository.addMessageTemplate(event.message);
      if (event.picture != null) {
        await messageRepository.uploadMessageTemplatePicture(event.picture!, newMessage!.id!, TranslationLanguage.DE);
      }
      if (event.pictureEnglish != null) {
        await messageRepository.uploadMessageTemplatePicture(event.pictureEnglish!, newMessage!.id!, TranslationLanguage.EN);
      }
      emit(AddedMessageTemplateState());
      add(FetchMessageTemplatesEvent());
    });
    on<UpdateMessageTemplateEvent>((event, emit) async {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_MESSAGE_TEMPLATE,
          name: EVENT_NAME_UPDATE,
          action: "Updated Message Template",
        ),
      );
      await messageRepository.updateMessageTemplate(event.id, event.message);
      if (event.picture != null) {
        await messageRepository.uploadMessageTemplatePicture(event.picture!, event.id, TranslationLanguage.DE);
      } else if (event.deletePictureId.isNotEmpty) {
        await messageRepository.deleteMessagePicture(MessageType.INFORMATION, event.id, event.deletePictureId);
      }
      if (event.pictureEnglish != null) {
        await messageRepository.uploadMessageTemplatePicture(event.pictureEnglish!, event.id, TranslationLanguage.EN);
      } else if (event.deletePictureEnglishId.isNotEmpty) {
        await messageRepository.deleteMessagePicture(MessageType.INFORMATION, event.id, event.deletePictureEnglishId);
      }
      emit(UpdatedMessageTemplateState());
      add(FetchMessageTemplatesEvent());
    });
    on<DeleteMessageTemplateEvent>((event, emit) async {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_MESSAGE_TEMPLATE,
          name: EVENT_NAME_DELETE,
          action: "Deleted Message Template",
        ),
      );
      await messageRepository.deleteMessageTemplate(event.id);
      emit(DeletedMessageTemplateState());
      add(FetchMessageTemplatesEvent());
    });
    on<FetchMessageHistoryEvent>((event, emit) async {
      emit(FetchedMessageHistoryState(
          history: (await messageRepository.getMessageHistory(event.patientId))!,
          receiverNames: (await messageRepository.getMessageReceiverNames())!));
    });
    on<CancelMessageEditEvent>((event, emit) async {
      emit(CanceledMessageEditState());
    });
    on<ShowEditSentMessageEvent>((event, emit) async {
      emit(EditSentMessageState(message: event.message));
    });
    on<UpdateSentMessageEvent>((event, emit) async {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_PATIENT_MESSAGE,
          name: EVENT_NAME_UPDATE,
          action: "Updated Sent Message",
        ),
      );
      await messageRepository.updateSentMessage(event.message);
      if (event.picture != null) {
        await messageRepository.uploadSentMessagePicture(event.message.id!, event.picture!);
      } else if (event.deletePictureId.isNotEmpty) {
        await messageRepository.deleteMessagePicture(MessageType.PERSONAL, event.message.id!, event.deletePictureId);
      }
      emit(UpdatedSentMessageState());
      add(FetchMessageHistoryEvent(patientId: event.patientId));
    });
    on<ShowEditScheduledMessageEvent>((event, emit) async {
      emit(EditScheduledMessageState(message: event.message));
    });
    on<AddScheduledMessageEvent>((event, emit) async {
      bool isSentNow = (event.message.scheduleDateTime ?? "").isEmpty;
      MessageSchedulePostDTO messageToCreate = event.message;
      if (isSentNow && (event.picture != null || event.pictureEnglish != null)) {
        // put schedule date in the future to make a connection to picture before sending
        messageToCreate.scheduleDateTime = DateFormat('yyyy-MM-ddTHH:mm').format(DateTime.now().add(Duration(hours: 12)));
      }

      final MessageSchedule? scheduledMessage = await messageRepository.scheduleMessage(event.message);
      if (event.picture != null) {
        await messageRepository.uploadScheduledMessagePicture(scheduledMessage!.id!, TranslationLanguage.DE, event.picture!);
      }
      if (event.pictureEnglish != null) {
        await messageRepository.uploadScheduledMessagePicture(scheduledMessage!.id!, TranslationLanguage.EN, event.pictureEnglish!);
      }
      if (isSentNow && (event.picture != null || event.pictureEnglish != null)) {
        await messageRepository.sendScheduledMessage(scheduledMessage!.id!);
      }

      if (isSentNow) {
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT_MESSAGE, name: EVENT_NAME_SENT_PATIENT_MESSAGE, action: "Sent Patient Message"),
        );
        emit(SentScheduledMessageState());
      } else {
        MatomoTracker.instance.trackEvent(
          eventInfo:
              EventInfo(category: EVENT_CATEGORY_PATIENT_MESSAGE, name: EVENT_NAME_SCHEDULED_PATIENT_MESSAGE, action: "Scheduled Patient Message"),
        );
        emit(AddedScheduledMessageState());
      }
      add(FetchMessageHistoryEvent(patientId: event.patientId));
    });
    on<UpdateScheduledMessageEvent>((event, emit) async {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_PATIENT_SCHEDULE_MESSAGE,
          name: EVENT_NAME_UPDATE,
          action: "Updated Scheduled Message",
        ),
      );
      await messageRepository.updateScheduledMessage(event.message);
      if (event.picture != null) {
        await messageRepository.uploadScheduledMessagePicture(event.message.id!, TranslationLanguage.DE, event.picture!);
      } else if (event.deletePictureId.isNotEmpty) {
        await messageRepository.deleteMessagePicture(MessageType.PERSONAL, event.message.id!, event.deletePictureId);
      }
      if (event.pictureEnglish != null) {
        await messageRepository.uploadScheduledMessagePicture(event.message.id!, TranslationLanguage.EN, event.pictureEnglish!);
      } else if (event.deletePictureEnglishId.isNotEmpty) {
        await messageRepository.deleteMessagePicture(MessageType.PERSONAL, event.message.id!, event.deletePictureEnglishId);
      }
      emit(UpdatedScheduledMessageState());
      add(FetchMessageHistoryEvent(patientId: event.patientId));
    });
    on<DeleteScheduledMessageEvent>((event, emit) async {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_PATIENT_SCHEDULE_MESSAGE,
          name: EVENT_NAME_DELETE,
          action: "Deleted Scheduled Message",
        ),
      );
      await messageRepository.deleteScheduledMessage(event.messageId, event.deleteAll ? "" : event.patientId);
      emit(DeletedScheduledMessageState());
      add(FetchMessageHistoryEvent(patientId: event.patientId));
    });
    on<CopyScheduledMessageEvent>((event, emit) async {
      MultipartFile? copiedGermanPicture;
      MultipartFile? copiedEnglishPicture;
      if (event.pictureDE != null) {
        copiedGermanPicture = await createMultipartFileFromObject(event.pictureDE!);
      }
      if (event.pictureEN != null) {
        copiedEnglishPicture = await createMultipartFileFromObject(event.pictureEN!);
      }
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_PATIENT_MESSAGE,
          name: EVENT_NAME_COPY,
          action: "Copy Message",
        ),
      );
      emit(CopyScheduledMessageState(message: event.message, pictureFileDE: copiedGermanPicture, pictureFileEN: copiedEnglishPicture));
    });
  }

  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    try {} catch (e) {
      yield MessageErrorState(message: e.toString());
    }
  }
}
