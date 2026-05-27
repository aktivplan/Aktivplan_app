//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TrainingPlanControllerApi {
  TrainingPlanControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// createTrainingPlan
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TrainingPlanPostDTO] trainingPlanPostDTO (required):
  Future<Response> createTrainingPlanWithHttpInfo(
    TrainingPlanPostDTO trainingPlanPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/training-plans';

    // ignore: prefer_final_locals
    Object? postBody = trainingPlanPostDTO;

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

  /// createTrainingPlan
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [TrainingPlanPostDTO] trainingPlanPostDTO (required):
  Future<TrainingPlan?> createTrainingPlan(
    TrainingPlanPostDTO trainingPlanPostDTO,
  ) async {
    final response = await createTrainingPlanWithHttpInfo(
      trainingPlanPostDTO,
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
        'TrainingPlan',
      ) as TrainingPlan;
    }
    return null;
  }

  /// deleteTrainingPlan
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteTrainingPlanWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/training-plans/{id}'.replaceAll('{id}', id);

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

  /// deleteTrainingPlan
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteTrainingPlan(
    String id,
  ) async {
    final response = await deleteTrainingPlanWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /training-plans/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getTrainingPlanWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/training-plans/{id}'.replaceAll('{id}', id);

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
  Future<TrainingPlanPostDTO?> getTrainingPlan(
    String id,
  ) async {
    final response = await getTrainingPlanWithHttpInfo(
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
        'TrainingPlanPostDTO',
      ) as TrainingPlanPostDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /training-plans' operation and returns the [Response].
  Future<Response> getTrainingPlansWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/training-plans';

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

  Future<List<TrainingPlanOverviewDTO>?> getTrainingPlans() async {
    final response = await getTrainingPlansWithHttpInfo();
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
              responseBody, 'List<TrainingPlanOverviewDTO>') as List)
          .cast<TrainingPlanOverviewDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// updateTrainingPlan
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TrainingPlanPostDTO] trainingPlanPostDTO (required):
  Future<Response> updateTrainingPlanWithHttpInfo(
    String id,
    TrainingPlanPostDTO trainingPlanPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/training-plans/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = trainingPlanPostDTO;

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

  /// updateTrainingPlan
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TrainingPlanPostDTO] trainingPlanPostDTO (required):
  Future<TrainingPlan?> updateTrainingPlan(
    String id,
    TrainingPlanPostDTO trainingPlanPostDTO,
  ) async {
    final response = await updateTrainingPlanWithHttpInfo(
      id,
      trainingPlanPostDTO,
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
        'TrainingPlan',
      ) as TrainingPlan;
    }
    return null;
  }
}
