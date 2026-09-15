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
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DatahubControllerApi {
  DatahubControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /datahub/recommendations/{patientId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  Future<Response> getRecommendationsWithHttpInfo(
    String patientId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/datahub/recommendations/{patientId}'
        .replaceAll('{patientId}', patientId);

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
  /// * [String] patientId (required):
  Future<DatahubResponse?> getRecommendations(
    String patientId,
  ) async {
    final response = await getRecommendationsWithHttpInfo(
      patientId,
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
        'DatahubResponse',
      ) as DatahubResponse;
    }
    return null;
  }

  /// Performs an HTTP 'GET /datahub/recommendations/{patientId}/{date}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  ///
  /// * [String] date (required):
  Future<Response> getRecommendationsForDateWithHttpInfo(
    String patientId,
    String date,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/datahub/recommendations/{patientId}/{date}'
        .replaceAll('{patientId}', patientId)
        .replaceAll('{date}', date);

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
  /// * [String] patientId (required):
  ///
  /// * [String] date (required):
  Future<DatahubResponse?> getRecommendationsForDate(
    String patientId,
    String date,
  ) async {
    final response = await getRecommendationsForDateWithHttpInfo(
      patientId,
      date,
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
        'DatahubResponse',
      ) as DatahubResponse;
    }
    return null;
  }

  /// Performs an HTTP 'GET /datahub/request-structure' operation and returns the [Response].
  Future<Response> getRequestStructureWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/datahub/request-structure';

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

  Future<DatahubRequestDataDTO?> getRequestStructure() async {
    final response = await getRequestStructureWithHttpInfo();
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
        'DatahubRequestDataDTO',
      ) as DatahubRequestDataDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /datahub/test-request/{patientId}/{date}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  ///
  /// * [String] date (required):
  Future<Response> getTestRequestDataWithHttpInfo(
    String patientId,
    String date,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/datahub/test-request/{patientId}/{date}'
        .replaceAll('{patientId}', patientId)
        .replaceAll('{date}', date);

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
  /// * [String] patientId (required):
  ///
  /// * [String] date (required):
  Future<DatahubRequestDataDTO?> getTestRequestData(
    String patientId,
    String date,
  ) async {
    final response = await getTestRequestDataWithHttpInfo(
      patientId,
      date,
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
        'DatahubRequestDataDTO',
      ) as DatahubRequestDataDTO;
    }
    return null;
  }

  /// Performs an HTTP 'POST /datahub/test-request/{patientId}/{date}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  ///
  /// * [String] date (required):
  Future<Response> testRequestWithHttpInfo(
    String patientId,
    String date,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/datahub/test-request/{patientId}/{date}'
        .replaceAll('{patientId}', patientId)
        .replaceAll('{date}', date);

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

  /// Parameters:
  ///
  /// * [String] patientId (required):
  ///
  /// * [String] date (required):
  Future<DatahubResponse?> testRequest(
    String patientId,
    String date,
  ) async {
    final response = await testRequestWithHttpInfo(
      patientId,
      date,
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
        'DatahubResponse',
      ) as DatahubResponse;
    }
    return null;
  }
}
