// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:core';

import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';
import 'package:http/http.dart';

class MessageRepository {
  final messageApi = new MessageControllerApi(apiClient);

  Future<MessageCountDTO?> getMessageCount() async {
    return messageApi.getMessageCount();
  }

  Future<MessageOverviewDTO?> getMessages() async {
    return messageApi.getMessages(size: 50);
  }

  Future<void> markMessagesRead() async {
    return messageApi.markMessagesRead();
  }

  Future<MessageSchedule?> scheduleMessage(MessageSchedulePostDTO message) async {
    return messageApi.schedulePersonalMessage(message);
  }

  Future<List<MessageTemplateDTO>?> getMessageTemplates() async {
    return messageApi.getInformationTemplates();
  }

  Future<MessageTemplate?> addMessageTemplate(MessageTemplatePostDTO message) async {
    return messageApi.createInformationTemplate(message);
  }

  Future<MessageTemplate?> updateMessageTemplate(String id, MessageTemplatePostDTO message) async {
    return messageApi.updateInformationTemplate(id, message);
  }

  Future deleteMessageTemplate(String id) async {
    await messageApi.deleteInformationTemplate(id);
  }

  Future uploadMessageTemplatePicture(MultipartFile file, String id, TranslationLanguage language) async {
    await messageApi.uploadInformationTemplatePictureById(id, language, file);
  }

  Future deleteMessagePicture(final MessageType type, final String id, String pictureId) async {
    await messageApi.deleteMessagePicture(type, id, pictureId);
  }

  Future<MessageHistoryDTO?> getMessageHistory(String patientId) async {
    return messageApi.getMessageHistory(patientId: patientId);
  }

  Future<List<MessageReceiverNameDTO>?> getMessageReceiverNames() async {
    return messageApi.getMessageReceiverNames();
  }

  Future<void> updateSentMessage(MessagePutDTO messagePutDTO) async {
    await messageApi.updateSentMessage(messagePutDTO);
  }

  Future<void> deleteSentMessage(String messageId, bool deleteAll) async {
    await messageApi.deleteSentMessage(messageId, deleteAll: deleteAll);
  }

  Future uploadSentMessagePicture(String messageId, MultipartFile file) async {
    await messageApi.uploadMessagePictureById(messageId, file);
  }

  Future<void> updateScheduledMessage(MessageSchedulePutDTO messagePutDTO) async {
    await messageApi.updateScheduledMessage(messagePutDTO);
  }

  Future<void> deleteScheduledMessage(String messageId, String patientId) async {
    await messageApi.deleteScheduledMessage(messageId, patientId: patientId);
  }

  Future uploadScheduledMessagePicture(String messageId, TranslationLanguage language, MultipartFile file) async {
    await messageApi.uploadScheduledMessagePictureById(messageId, language, file);
  }

  Future sendScheduledMessage(String id) async {
    await messageApi.sendScheduledMessage(id);
  }
}
