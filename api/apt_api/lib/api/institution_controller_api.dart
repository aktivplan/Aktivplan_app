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

class InstitutionControllerApi {
  InstitutionControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// createInstitution
  ///
  /// ADMINISTRATOR
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [InstitutionPostDTO] institutionPostDTO (required):
  Future<Response> createInstitutionWithHttpInfo(
    InstitutionPostDTO institutionPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/institutions';

    // ignore: prefer_final_locals
    Object? postBody = institutionPostDTO;

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

  /// createInstitution
  ///
  /// ADMINISTRATOR
  ///
  /// Parameters:
  ///
  /// * [InstitutionPostDTO] institutionPostDTO (required):
  Future<InstitutionDTO?> createInstitution(
    InstitutionPostDTO institutionPostDTO,
  ) async {
    final response = await createInstitutionWithHttpInfo(
      institutionPostDTO,
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
        'InstitutionDTO',
      ) as InstitutionDTO;
    }
    return null;
  }

  /// deleteInstitution
  ///
  /// ADMINISTRATOR
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteInstitutionWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/institutions/{id}'.replaceAll('{id}', id);

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

  /// deleteInstitution
  ///
  /// ADMINISTRATOR
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteInstitution(
    String id,
  ) async {
    final response = await deleteInstitutionWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /institutions/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getInstitutionByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/institutions/{id}'.replaceAll('{id}', id);

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
  Future<InstitutionDTO?> getInstitutionById(
    String id,
  ) async {
    final response = await getInstitutionByIdWithHttpInfo(
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
        'InstitutionDTO',
      ) as InstitutionDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /institutions/{id}/user-count' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getInstitutionUserCountByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/institutions/{id}/user-count'.replaceAll('{id}', id);

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
  Future<InstitutionCountDTO?> getInstitutionUserCountById(
    String id,
  ) async {
    final response = await getInstitutionUserCountByIdWithHttpInfo(
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
        'InstitutionCountDTO',
      ) as InstitutionCountDTO;
    }
    return null;
  }

  /// getInstitutions
  ///
  /// ADMINISTRATOR
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getInstitutionsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/institutions';

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

  /// getInstitutions
  ///
  /// ADMINISTRATOR
  Future<List<InstitutionDTO>?> getInstitutions() async {
    final response = await getInstitutionsWithHttpInfo();
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
              responseBody, 'List<InstitutionDTO>') as List)
          .cast<InstitutionDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// Performs an HTTP 'POST /institutions/import-exercise-data' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [InstitutionImportDTO] institutionImportDTO (required):
  Future<Response> importExerciseDataWithHttpInfo(
    InstitutionImportDTO institutionImportDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/institutions/import-exercise-data';

    // ignore: prefer_final_locals
    Object? postBody = institutionImportDTO;

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

  /// Parameters:
  ///
  /// * [InstitutionImportDTO] institutionImportDTO (required):
  Future<void> importExerciseData(
    InstitutionImportDTO institutionImportDTO,
  ) async {
    final response = await importExerciseDataWithHttpInfo(
      institutionImportDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// updateInstitution
  ///
  /// ADMINISTRATOR
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [InstitutionPostDTO] institutionPostDTO (required):
  Future<Response> updateInstitutionWithHttpInfo(
    String id,
    InstitutionPostDTO institutionPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/institutions/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = institutionPostDTO;

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

  /// updateInstitution
  ///
  /// ADMINISTRATOR
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [InstitutionPostDTO] institutionPostDTO (required):
  Future<InstitutionDTO?> updateInstitution(
    String id,
    InstitutionPostDTO institutionPostDTO,
  ) async {
    final response = await updateInstitutionWithHttpInfo(
      id,
      institutionPostDTO,
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
        'InstitutionDTO',
      ) as InstitutionDTO;
    }
    return null;
  }
}
