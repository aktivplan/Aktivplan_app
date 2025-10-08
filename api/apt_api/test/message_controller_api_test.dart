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
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:apt_api/api.dart';
import 'package:test/test.dart';

/// tests for MessageControllerApi
void main() {
  // final instance = MessageControllerApi();

  group('tests for MessageControllerApi', () {
    // createInformationTemplate
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<MessageTemplate> createInformationTemplate(MessageTemplatePostDTO messageTemplatePostDTO) async
    test('test createInformationTemplate', () async {
      // TODO
    });

    // deleteInformationTemplate
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future deleteInformationTemplate(String id) async
    test('test deleteInformationTemplate', () async {
      // TODO
    });

    // deleteScheduledMessage
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future deleteScheduledMessage(String id, { String patientId }) async
    test('test deleteScheduledMessage', () async {
      // TODO
    });

    // deleteSentMessage
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future deleteSentMessage(String messageId, { bool deleteAll }) async
    test('test deleteSentMessage', () async {
      // TODO
    });

    //Future<MessageTemplateDTO> getInformationTemplateById(String id) async
    test('test getInformationTemplateById', () async {
      // TODO
    });

    //Future<List<MessageTemplateDTO>> getInformationTemplates() async
    test('test getInformationTemplates', () async {
      // TODO
    });

    // getMessageCount
    //
    // PATIENT
    //
    //Future<MessageCountDTO> getMessageCount() async
    test('test getMessageCount', () async {
      // TODO
    });

    // getMessageHistory
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<MessageHistoryDTO> getMessageHistory(String patientId) async
    test('test getMessageHistory', () async {
      // TODO
    });

    // getMessageReceiverNames
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<List<MessageReceiverNameDTO>> getMessageReceiverNames(String messageId, { bool isSchedule }) async
    test('test getMessageReceiverNames', () async {
      // TODO
    });

    // getMessages
    //
    // PATIENT
    //
    //Future<MessageOverviewDTO> getMessages({ int page, int size }) async
    test('test getMessages', () async {
      // TODO
    });

    //Future<bool> hasMessageHistory(String patientId) async
    test('test hasMessageHistory', () async {
      // TODO
    });

    // markMessagesRead
    //
    // PATIENT
    //
    //Future markMessagesRead() async
    test('test markMessagesRead', () async {
      // TODO
    });

    // schedulePersonalMessage
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<MessageSchedule> schedulePersonalMessage(MessageSchedulePostDTO messageSchedulePostDTO) async
    test('test schedulePersonalMessage', () async {
      // TODO
    });

    // updateInformationTemplate
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future<MessageTemplate> updateInformationTemplate(String id, MessageTemplatePostDTO messageTemplatePostDTO) async
    test('test updateInformationTemplate', () async {
      // TODO
    });

    // updateScheduledMessage
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future updateScheduledMessage(MessageSchedulePutDTO messageSchedulePutDTO) async
    test('test updateScheduledMessage', () async {
      // TODO
    });

    // updateSentMessage
    //
    // ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
    //
    //Future updateSentMessage(MessagePutDTO messagePutDTO) async
    test('test updateSentMessage', () async {
      // TODO
    });
  });
}
