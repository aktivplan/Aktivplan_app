//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SocialControllerApi {
  SocialControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// addContact
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> addContactWithHttpInfo(
    String userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/contact/{userId}'.replaceAll('{userId}', userId);

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

  /// addContact
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<bool?> addContact(
    String userId,
  ) async {
    final response = await addContactWithHttpInfo(
      userId,
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

  /// deleteStatusFile
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteStatusFileWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/status/{id}'.replaceAll('{id}', id);

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

  /// deleteStatusFile
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<bool?> deleteStatusFile(
    String id,
  ) async {
    final response = await deleteStatusFileWithHttpInfo(
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
        'bool',
      ) as bool;
    }
    return null;
  }

  /// getContactDetail
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [String] startDate (required):
  ///
  /// * [String] endDate (required):
  Future<Response> getContactDetailWithHttpInfo(
    String userId,
    String startDate,
    String endDate,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/contact/{userId}'.replaceAll('{userId}', userId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'startDate', startDate));
    queryParams.addAll(_queryParams('', 'endDate', endDate));

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

  /// getContactDetail
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  ///
  /// * [String] startDate (required):
  ///
  /// * [String] endDate (required):
  Future<UserContactDetailDTO?> getContactDetail(
    String userId,
    String startDate,
    String endDate,
  ) async {
    final response = await getContactDetailWithHttpInfo(
      userId,
      startDate,
      endDate,
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
        'UserContactDetailDTO',
      ) as UserContactDetailDTO;
    }
    return null;
  }

  /// getContactOverview
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getContactOverviewWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/social/overview';

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

  /// getContactOverview
  ///
  /// PATIENT
  Future<UserContactOverviewDTO?> getContactOverview() async {
    final response = await getContactOverviewWithHttpInfo();
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
        'UserContactOverviewDTO',
      ) as UserContactOverviewDTO;
    }
    return null;
  }

  /// getStatusFiles
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> getStatusFilesWithHttpInfo(
    String userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/status/user/{userId}'.replaceAll('{userId}', userId);

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

  /// getStatusFiles
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<List<StatusFileDTO>?> getStatusFiles(
    String userId,
  ) async {
    final response = await getStatusFilesWithHttpInfo(
      userId,
    );
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
              responseBody, 'List<StatusFileDTO>') as List)
          .cast<StatusFileDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// markStatusFileSeen
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> markStatusFileSeenWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/status/seen/{id}'.replaceAll('{id}', id);

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

  /// markStatusFileSeen
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<StatusFileDTO?> markStatusFileSeen(
    String id,
  ) async {
    final response = await markStatusFileSeenWithHttpInfo(
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
        'StatusFileDTO',
      ) as StatusFileDTO;
    }
    return null;
  }

  /// removeContact
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<Response> removeContactWithHttpInfo(
    String userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/contact/{userId}'.replaceAll('{userId}', userId);

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

  /// removeContact
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] userId (required):
  Future<bool?> removeContact(
    String userId,
  ) async {
    final response = await removeContactWithHttpInfo(
      userId,
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

  /// setShareActivityData
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ShareActivityDataPostDTO] shareActivityDataPostDTO (required):
  Future<Response> setShareActivityDataWithHttpInfo(
    ShareActivityDataPostDTO shareActivityDataPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/shareActivityData';

    // ignore: prefer_final_locals
    Object? postBody = shareActivityDataPostDTO;

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

  /// setShareActivityData
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [ShareActivityDataPostDTO] shareActivityDataPostDTO (required):
  Future<void> setShareActivityData(
    ShareActivityDataPostDTO shareActivityDataPostDTO,
  ) async {
    final response = await setShareActivityDataWithHttpInfo(
      shareActivityDataPostDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// setStatusMessage
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StatusMessagePostDTO] statusMessagePostDTO (required):
  Future<Response> setStatusMessageWithHttpInfo(
    StatusMessagePostDTO statusMessagePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/statusMessage';

    // ignore: prefer_final_locals
    Object? postBody = statusMessagePostDTO;

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

  /// setStatusMessage
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [StatusMessagePostDTO] statusMessagePostDTO (required):
  Future<void> setStatusMessage(
    StatusMessagePostDTO statusMessagePostDTO,
  ) async {
    final response = await setStatusMessageWithHttpInfo(
      statusMessagePostDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// updateContactOrdering
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [OrderingDTO] orderingDTO (required):
  Future<Response> updateContactOrderingWithHttpInfo(
    OrderingDTO orderingDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/contact/ordering';

    // ignore: prefer_final_locals
    Object? postBody = orderingDTO;

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

  /// updateContactOrdering
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [OrderingDTO] orderingDTO (required):
  Future<void> updateContactOrdering(
    OrderingDTO orderingDTO,
  ) async {
    final response = await updateContactOrderingWithHttpInfo(
      orderingDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// uploadStatusPicture
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<Response> uploadStatusPictureWithHttpInfo(
    MultipartFile pictureFile,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/status/picture';

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

  /// uploadStatusPicture
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<StatusFileDTO?> uploadStatusPicture(
    MultipartFile pictureFile,
  ) async {
    final response = await uploadStatusPictureWithHttpInfo(
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
        'StatusFileDTO',
      ) as StatusFileDTO;
    }
    return null;
  }

  /// uploadStatusText
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StatusTextPostDTO] statusTextPostDTO (required):
  Future<Response> uploadStatusTextWithHttpInfo(
    StatusTextPostDTO statusTextPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/social/status/text';

    // ignore: prefer_final_locals
    Object? postBody = statusTextPostDTO;

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

  /// uploadStatusText
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [StatusTextPostDTO] statusTextPostDTO (required):
  Future<StatusFileDTO?> uploadStatusText(
    StatusTextPostDTO statusTextPostDTO,
  ) async {
    final response = await uploadStatusTextWithHttpInfo(
      statusTextPostDTO,
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
        'StatusFileDTO',
      ) as StatusFileDTO;
    }
    return null;
  }
}
