//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ExternalAppControllerApi {
  ExternalAppControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// createExternalApp
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ExternalAppPostDTO] externalAppPostDTO (required):
  Future<Response> createExternalAppWithHttpInfo(
    ExternalAppPostDTO externalAppPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/external-apps';

    // ignore: prefer_final_locals
    Object? postBody = externalAppPostDTO;

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

  /// createExternalApp
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [ExternalAppPostDTO] externalAppPostDTO (required):
  Future<ExternalApp?> createExternalApp(
    ExternalAppPostDTO externalAppPostDTO,
  ) async {
    final response = await createExternalAppWithHttpInfo(
      externalAppPostDTO,
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
        'ExternalApp',
      ) as ExternalApp;
    }
    return null;
  }

  /// deleteExternalApp
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteExternalAppWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/external-apps/{id}'.replaceAll('{id}', id);

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

  /// deleteExternalApp
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteExternalApp(
    String id,
  ) async {
    final response = await deleteExternalAppWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /external-apps/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getExternalAppByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/external-apps/{id}'.replaceAll('{id}', id);

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
  Future<ExternalAppDTO?> getExternalAppById(
    String id,
  ) async {
    final response = await getExternalAppByIdWithHttpInfo(
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
        'ExternalAppDTO',
      ) as ExternalAppDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /external-apps' operation and returns the [Response].
  Future<Response> getExternalAppsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/external-apps';

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

  Future<List<ExternalAppDTO>?> getExternalApps() async {
    final response = await getExternalAppsWithHttpInfo();
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
              responseBody, 'List<ExternalAppDTO>') as List)
          .cast<ExternalAppDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// updateExternalApp
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ExternalAppPostDTO] externalAppPostDTO (required):
  Future<Response> updateExternalAppWithHttpInfo(
    String id,
    ExternalAppPostDTO externalAppPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/external-apps/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = externalAppPostDTO;

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

  /// updateExternalApp
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ExternalAppPostDTO] externalAppPostDTO (required):
  Future<ExternalApp?> updateExternalApp(
    String id,
    ExternalAppPostDTO externalAppPostDTO,
  ) async {
    final response = await updateExternalAppWithHttpInfo(
      id,
      externalAppPostDTO,
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
        'ExternalApp',
      ) as ExternalApp;
    }
    return null;
  }

  /// updateExternalAppOrdering
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [OrderingDTO] orderingDTO (required):
  Future<Response> updateExternalAppOrderingWithHttpInfo(
    OrderingDTO orderingDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/external-apps/templates/order';

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

  /// updateExternalAppOrdering
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [OrderingDTO] orderingDTO (required):
  Future<List<ExternalApp>?> updateExternalAppOrdering(
    OrderingDTO orderingDTO,
  ) async {
    final response = await updateExternalAppOrderingWithHttpInfo(
      orderingDTO,
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
              responseBody, 'List<ExternalApp>') as List)
          .cast<ExternalApp>()
          .toList(growable: false);
    }
    return null;
  }
}
