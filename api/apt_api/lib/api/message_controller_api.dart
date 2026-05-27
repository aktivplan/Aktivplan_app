//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MessageControllerApi {
  MessageControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// createInformationTemplate
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MessageTemplatePostDTO] messageTemplatePostDTO (required):
  Future<Response> createInformationTemplateWithHttpInfo(
    MessageTemplatePostDTO messageTemplatePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/templates/INFORMATION';

    // ignore: prefer_final_locals
    Object? postBody = messageTemplatePostDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// createInformationTemplate
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [MessageTemplatePostDTO] messageTemplatePostDTO (required):
  Future<MessageTemplate?> createInformationTemplate(
    MessageTemplatePostDTO messageTemplatePostDTO,
  ) async {
    final response = await createInformationTemplateWithHttpInfo(
      messageTemplatePostDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageTemplate',
      ) as MessageTemplate;
    }
    return null;
  }

  /// deleteInformationTemplate
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteInformationTemplateWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/templates/INFORMATION/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// deleteInformationTemplate
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteInformationTemplate(
    String id,
  ) async {
    final response = await deleteInformationTemplateWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// deleteMessagePicture
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MessageType] type (required):
  ///
  /// * [String] id (required):
  ///
  /// * [String] pictureId (required):
  Future<Response> deleteMessagePictureWithHttpInfo(
    MessageType type,
    String id,
    String pictureId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/schedule/{type}/{id}/picture'
        .replaceAll('{type}', type.toString())
        .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'pictureId', pictureId));

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// deleteMessagePicture
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [MessageType] type (required):
  ///
  /// * [String] id (required):
  ///
  /// * [String] pictureId (required):
  Future<bool?> deleteMessagePicture(
    MessageType type,
    String id,
    String pictureId,
  ) async {
    final response = await deleteMessagePictureWithHttpInfo(
      type,
      id,
      pictureId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'bool',
      ) as bool;
    }
    return null;
  }

  /// deleteScheduledMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] patientId:
  Future<Response> deleteScheduledMessageWithHttpInfo(
    String id, {
    String? patientId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/schedule/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (patientId != null) {
      queryParams.addAll(_queryParams('', 'patientId', patientId));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// deleteScheduledMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] patientId:
  Future<void> deleteScheduledMessage(
    String id, {
    String? patientId,
  }) async {
    final response = await deleteScheduledMessageWithHttpInfo(
      id,
      patientId: patientId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// deleteSentMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] messageId (required):
  ///
  /// * [bool] deleteAll:
  Future<Response> deleteSentMessageWithHttpInfo(
    String messageId, {
    bool? deleteAll,
  }) async {
    // ignore: prefer_const_declarations
    final path =
        r'/messages/sent/{messageId}'.replaceAll('{messageId}', messageId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (deleteAll != null) {
      queryParams.addAll(_queryParams('', 'deleteAll', deleteAll));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// deleteSentMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] messageId (required):
  ///
  /// * [bool] deleteAll:
  Future<void> deleteSentMessage(
    String messageId, {
    bool? deleteAll,
  }) async {
    final response = await deleteSentMessageWithHttpInfo(
      messageId,
      deleteAll: deleteAll,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /messages/templates/INFORMATION/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getInformationTemplateByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/templates/INFORMATION/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] id (required):
  Future<MessageTemplateDTO?> getInformationTemplateById(
    String id,
  ) async {
    final response = await getInformationTemplateByIdWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageTemplateDTO',
      ) as MessageTemplateDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /messages/templates/INFORMATION' operation and returns the [Response].
  Future<Response> getInformationTemplatesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/messages/templates/INFORMATION';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<List<MessageTemplateDTO>?> getInformationTemplates() async {
    final response = await getInformationTemplatesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<MessageTemplateDTO>') as List)
          .cast<MessageTemplateDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// getMessageCount
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMessageCountWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/messages/count';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// getMessageCount
  ///
  /// PATIENT
  Future<MessageCountDTO?> getMessageCount() async {
    final response = await getMessageCountWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageCountDTO',
      ) as MessageCountDTO;
    }
    return null;
  }

  /// getMessageHistory
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] patientId:
  Future<Response> getMessageHistoryWithHttpInfo({
    String? patientId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/history';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (patientId != null) {
      queryParams.addAll(_queryParams('', 'patientId', patientId));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// getMessageHistory
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] patientId:
  Future<MessageHistoryDTO?> getMessageHistory({
    String? patientId,
  }) async {
    final response = await getMessageHistoryWithHttpInfo(
      patientId: patientId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageHistoryDTO',
      ) as MessageHistoryDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /messages/picture' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [MessageType] type (required):
  ///
  /// * [String] pictureId (required):
  Future<Response> getMessagePictureWithHttpInfo(
    MessageType type,
    String pictureId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/picture';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'type', type));
    queryParams.addAll(_queryParams('', 'pictureId', pictureId));

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [MessageType] type (required):
  ///
  /// * [String] pictureId (required):
  Future<FileGetDTO?> getMessagePicture(
    MessageType type,
    String pictureId,
  ) async {
    final response = await getMessagePictureWithHttpInfo(
      type,
      pictureId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'FileGetDTO',
      ) as FileGetDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /messages/receiver-names' operation and returns the [Response].
  Future<Response> getMessageReceiverNamesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/messages/receiver-names';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<List<MessageReceiverNameDTO>?> getMessageReceiverNames() async {
    final response = await getMessageReceiverNamesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<MessageReceiverNameDTO>') as List)
          .cast<MessageReceiverNameDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// getMessages
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] page:
  ///
  /// * [int] size:
  Future<Response> getMessagesWithHttpInfo({
    int? page,
    int? size,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/messages';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (page != null) {
      queryParams.addAll(_queryParams('', 'page', page));
    }
    if (size != null) {
      queryParams.addAll(_queryParams('', 'size', size));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// getMessages
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [int] page:
  ///
  /// * [int] size:
  Future<MessageOverviewDTO?> getMessages({
    int? page,
    int? size,
  }) async {
    final response = await getMessagesWithHttpInfo(
      page: page,
      size: size,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageOverviewDTO',
      ) as MessageOverviewDTO;
    }
    return null;
  }

  /// markMessagesRead
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> markMessagesReadWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/messages/read';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// markMessagesRead
  ///
  /// PATIENT
  Future<void> markMessagesRead() async {
    final response = await markMessagesReadWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// schedulePersonalMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MessageSchedulePostDTO] messageSchedulePostDTO (required):
  Future<Response> schedulePersonalMessageWithHttpInfo(
    MessageSchedulePostDTO messageSchedulePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/schedule';

    // ignore: prefer_final_locals
    Object? postBody = messageSchedulePostDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// schedulePersonalMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [MessageSchedulePostDTO] messageSchedulePostDTO (required):
  Future<MessageSchedule?> schedulePersonalMessage(
    MessageSchedulePostDTO messageSchedulePostDTO,
  ) async {
    final response = await schedulePersonalMessageWithHttpInfo(
      messageSchedulePostDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageSchedule',
      ) as MessageSchedule;
    }
    return null;
  }

  /// sendScheduledMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> sendScheduledMessageWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/schedule/send/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// sendScheduledMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> sendScheduledMessage(
    String id,
  ) async {
    final response = await sendScheduledMessageWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// sendSocialMessage
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SocialMessagePostDTO] socialMessagePostDTO (required):
  Future<Response> sendSocialMessageWithHttpInfo(
    SocialMessagePostDTO socialMessagePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/social/send';

    // ignore: prefer_final_locals
    Object? postBody = socialMessagePostDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// sendSocialMessage
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [SocialMessagePostDTO] socialMessagePostDTO (required):
  Future<MessageGetDTO?> sendSocialMessage(
    SocialMessagePostDTO socialMessagePostDTO,
  ) async {
    final response = await sendSocialMessageWithHttpInfo(
      socialMessagePostDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageGetDTO',
      ) as MessageGetDTO;
    }
    return null;
  }

  /// updateInformationTemplate
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MessageTemplatePostDTO] messageTemplatePostDTO (required):
  Future<Response> updateInformationTemplateWithHttpInfo(
    String id,
    MessageTemplatePostDTO messageTemplatePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/templates/INFORMATION/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = messageTemplatePostDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// updateInformationTemplate
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MessageTemplatePostDTO] messageTemplatePostDTO (required):
  Future<MessageTemplate?> updateInformationTemplate(
    String id,
    MessageTemplatePostDTO messageTemplatePostDTO,
  ) async {
    final response = await updateInformationTemplateWithHttpInfo(
      id,
      messageTemplatePostDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'MessageTemplate',
      ) as MessageTemplate;
    }
    return null;
  }

  /// updateScheduledMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MessageSchedulePutDTO] messageSchedulePutDTO (required):
  Future<Response> updateScheduledMessageWithHttpInfo(
    MessageSchedulePutDTO messageSchedulePutDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/schedule/update';

    // ignore: prefer_final_locals
    Object? postBody = messageSchedulePutDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// updateScheduledMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [MessageSchedulePutDTO] messageSchedulePutDTO (required):
  Future<void> updateScheduledMessage(
    MessageSchedulePutDTO messageSchedulePutDTO,
  ) async {
    final response = await updateScheduledMessageWithHttpInfo(
      messageSchedulePutDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// updateSentMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MessagePutDTO] messagePutDTO (required):
  Future<Response> updateSentMessageWithHttpInfo(
    MessagePutDTO messagePutDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/sent';

    // ignore: prefer_final_locals
    Object? postBody = messagePutDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// updateSentMessage
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [MessagePutDTO] messagePutDTO (required):
  Future<void> updateSentMessage(
    MessagePutDTO messagePutDTO,
  ) async {
    final response = await updateSentMessageWithHttpInfo(
      messagePutDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// uploadUserPictureById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TranslationLanguage] language (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<Response> uploadInformationTemplatePictureByIdWithHttpInfo(
    String id,
    TranslationLanguage language,
    MultipartFile pictureFile,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/messages/templates/INFORMATION/{id}/picture'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'language', language));

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (pictureFile != null) {
      hasFields = true;
      mp.fields[r'pictureFile'] = pictureFile.field;
      mp.files.add(pictureFile);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// uploadUserPictureById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TranslationLanguage] language (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<FileGetDTO?> uploadInformationTemplatePictureById(
    String id,
    TranslationLanguage language,
    MultipartFile pictureFile,
  ) async {
    final response = await uploadInformationTemplatePictureByIdWithHttpInfo(
      id,
      language,
      pictureFile,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'FileGetDTO',
      ) as FileGetDTO;
    }
    return null;
  }

  /// uploadMessagePictureById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<Response> uploadMessagePictureByIdWithHttpInfo(
    String id,
    MultipartFile pictureFile,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/sent/{id}/picture'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (pictureFile != null) {
      hasFields = true;
      mp.fields[r'pictureFile'] = pictureFile.field;
      mp.files.add(pictureFile);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// uploadMessagePictureById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<FileGetDTO?> uploadMessagePictureById(
    String id,
    MultipartFile pictureFile,
  ) async {
    final response = await uploadMessagePictureByIdWithHttpInfo(
      id,
      pictureFile,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'FileGetDTO',
      ) as FileGetDTO;
    }
    return null;
  }

  /// uploadScheduledMessagePictureById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TranslationLanguage] language (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<Response> uploadScheduledMessagePictureByIdWithHttpInfo(
    String id,
    TranslationLanguage language,
    MultipartFile pictureFile,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/messages/schedule/PERSONAL/{id}/picture'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'language', language));

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (pictureFile != null) {
      hasFields = true;
      mp.fields[r'pictureFile'] = pictureFile.field;
      mp.files.add(pictureFile);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// uploadScheduledMessagePictureById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TranslationLanguage] language (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<FileGetDTO?> uploadScheduledMessagePictureById(
    String id,
    TranslationLanguage language,
    MultipartFile pictureFile,
  ) async {
    final response = await uploadScheduledMessagePictureByIdWithHttpInfo(
      id,
      language,
      pictureFile,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'FileGetDTO',
      ) as FileGetDTO;
    }
    return null;
  }

  /// uploadSocialMessagePictureById
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<Response> uploadSocialMessagePictureByIdWithHttpInfo(
    String id,
    MultipartFile pictureFile,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/messages/social/picture/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (pictureFile != null) {
      hasFields = true;
      mp.fields[r'pictureFile'] = pictureFile.field;
      mp.files.add(pictureFile);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// uploadSocialMessagePictureById
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<FileGetDTO?> uploadSocialMessagePictureById(
    String id,
    MultipartFile pictureFile,
  ) async {
    final response = await uploadSocialMessagePictureByIdWithHttpInfo(
      id,
      pictureFile,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'FileGetDTO',
      ) as FileGetDTO;
    }
    return null;
  }
}
