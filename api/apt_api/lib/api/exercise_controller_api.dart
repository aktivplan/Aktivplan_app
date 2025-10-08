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

class ExerciseControllerApi {
  ExerciseControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// createEnduranceExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [EnduranceExercisePostDTO] enduranceExercisePostDTO (required):
  Future<Response> createEnduranceExerciseWithHttpInfo(
    EnduranceExercisePostDTO enduranceExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/ENDURANCE';

    // ignore: prefer_final_locals
    Object? postBody = enduranceExercisePostDTO;

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

  /// createEnduranceExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [EnduranceExercisePostDTO] enduranceExercisePostDTO (required):
  Future<EnduranceExercise?> createEnduranceExercise(
    EnduranceExercisePostDTO enduranceExercisePostDTO,
  ) async {
    final response = await createEnduranceExerciseWithHttpInfo(
      enduranceExercisePostDTO,
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
        'EnduranceExercise',
      ) as EnduranceExercise;
    }
    return null;
  }

  /// createHypertrophyExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<Response> createHypertrophyExerciseWithHttpInfo(
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/HYPERTROPHY';

    // ignore: prefer_final_locals
    Object? postBody = strengtheningExercisePostDTO;

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

  /// createHypertrophyExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<StrengtheningExercise?> createHypertrophyExercise(
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    final response = await createHypertrophyExerciseWithHttpInfo(
      strengtheningExercisePostDTO,
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
        'StrengtheningExercise',
      ) as StrengtheningExercise;
    }
    return null;
  }

  /// createIntervalExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [IntervalExercisePostDTO] intervalExercisePostDTO (required):
  Future<Response> createIntervalExerciseWithHttpInfo(
    IntervalExercisePostDTO intervalExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/INTERVAL';

    // ignore: prefer_final_locals
    Object? postBody = intervalExercisePostDTO;

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

  /// createIntervalExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [IntervalExercisePostDTO] intervalExercisePostDTO (required):
  Future<IntervalExercise?> createIntervalExercise(
    IntervalExercisePostDTO intervalExercisePostDTO,
  ) async {
    final response = await createIntervalExerciseWithHttpInfo(
      intervalExercisePostDTO,
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
        'IntervalExercise',
      ) as IntervalExercise;
    }
    return null;
  }

  /// createOtherExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [OtherExercisePostDTO] otherExercisePostDTO (required):
  Future<Response> createOtherExerciseWithHttpInfo(
    OtherExercisePostDTO otherExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/OTHER';

    // ignore: prefer_final_locals
    Object? postBody = otherExercisePostDTO;

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

  /// createOtherExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [OtherExercisePostDTO] otherExercisePostDTO (required):
  Future<OtherExercise?> createOtherExercise(
    OtherExercisePostDTO otherExercisePostDTO,
  ) async {
    final response = await createOtherExerciseWithHttpInfo(
      otherExercisePostDTO,
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
        'OtherExercise',
      ) as OtherExercise;
    }
    return null;
  }

  /// createStrengtheningExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<Response> createStrengtheningExerciseWithHttpInfo(
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/STRENGTHENING';

    // ignore: prefer_final_locals
    Object? postBody = strengtheningExercisePostDTO;

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

  /// createStrengtheningExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<StrengtheningExercise?> createStrengtheningExercise(
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    final response = await createStrengtheningExerciseWithHttpInfo(
      strengtheningExercisePostDTO,
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
        'StrengtheningExercise',
      ) as StrengtheningExercise;
    }
    return null;
  }

  /// createTask
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TaskPostDTO] taskPostDTO (required):
  Future<Response> createTaskWithHttpInfo(
    TaskPostDTO taskPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/TASK';

    // ignore: prefer_final_locals
    Object? postBody = taskPostDTO;

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

  /// createTask
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [TaskPostDTO] taskPostDTO (required):
  Future<Task?> createTask(
    TaskPostDTO taskPostDTO,
  ) async {
    final response = await createTaskWithHttpInfo(
      taskPostDTO,
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
        'Task',
      ) as Task;
    }
    return null;
  }

  /// deleteExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteExerciseWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/{id}'.replaceAll('{id}', id);

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

  /// deleteExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteExercise(
    String id,
  ) async {
    final response = await deleteExerciseWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /exercises/{type}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ExerciseType] type (required):
  Future<Response> getExercisesWithHttpInfo(
    ExerciseType type,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/{type}'.replaceAll('{type}', type.toString());

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
  /// * [ExerciseType] type (required):
  Future<List<ExerciseOverviewDTO>?> getExercises(
    ExerciseType type,
  ) async {
    final response = await getExercisesWithHttpInfo(
      type,
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
              responseBody, 'List<ExerciseOverviewDTO>') as List)
          .cast<ExerciseOverviewDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// updateEnduranceExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [EnduranceExercisePostDTO] enduranceExercisePostDTO (required):
  Future<Response> updateEnduranceExerciseWithHttpInfo(
    String id,
    EnduranceExercisePostDTO enduranceExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/ENDURANCE/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = enduranceExercisePostDTO;

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

  /// updateEnduranceExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [EnduranceExercisePostDTO] enduranceExercisePostDTO (required):
  Future<EnduranceExercise?> updateEnduranceExercise(
    String id,
    EnduranceExercisePostDTO enduranceExercisePostDTO,
  ) async {
    final response = await updateEnduranceExerciseWithHttpInfo(
      id,
      enduranceExercisePostDTO,
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
        'EnduranceExercise',
      ) as EnduranceExercise;
    }
    return null;
  }

  /// updateHypertrophyExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<Response> updateHypertrophyExerciseWithHttpInfo(
    String id,
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/HYPERTROPHY/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = strengtheningExercisePostDTO;

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

  /// updateHypertrophyExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<StrengtheningExercise?> updateHypertrophyExercise(
    String id,
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    final response = await updateHypertrophyExerciseWithHttpInfo(
      id,
      strengtheningExercisePostDTO,
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
        'StrengtheningExercise',
      ) as StrengtheningExercise;
    }
    return null;
  }

  /// updateIntervalExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [IntervalExercisePostDTO] intervalExercisePostDTO (required):
  Future<Response> updateIntervalExerciseWithHttpInfo(
    String id,
    IntervalExercisePostDTO intervalExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/INTERVAL/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = intervalExercisePostDTO;

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

  /// updateIntervalExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [IntervalExercisePostDTO] intervalExercisePostDTO (required):
  Future<IntervalExercise?> updateIntervalExercise(
    String id,
    IntervalExercisePostDTO intervalExercisePostDTO,
  ) async {
    final response = await updateIntervalExerciseWithHttpInfo(
      id,
      intervalExercisePostDTO,
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
        'IntervalExercise',
      ) as IntervalExercise;
    }
    return null;
  }

  /// updateOtherExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [OtherExercisePostDTO] otherExercisePostDTO (required):
  Future<Response> updateOtherExerciseWithHttpInfo(
    String id,
    OtherExercisePostDTO otherExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/OTHER/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = otherExercisePostDTO;

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

  /// updateOtherExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [OtherExercisePostDTO] otherExercisePostDTO (required):
  Future<OtherExercise?> updateOtherExercise(
    String id,
    OtherExercisePostDTO otherExercisePostDTO,
  ) async {
    final response = await updateOtherExerciseWithHttpInfo(
      id,
      otherExercisePostDTO,
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
        'OtherExercise',
      ) as OtherExercise;
    }
    return null;
  }

  /// updateStrengtheningExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<Response> updateStrengtheningExerciseWithHttpInfo(
    String id,
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/STRENGTHENING/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = strengtheningExercisePostDTO;

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

  /// updateStrengtheningExercise
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [StrengtheningExercisePostDTO] strengtheningExercisePostDTO (required):
  Future<StrengtheningExercise?> updateStrengtheningExercise(
    String id,
    StrengtheningExercisePostDTO strengtheningExercisePostDTO,
  ) async {
    final response = await updateStrengtheningExerciseWithHttpInfo(
      id,
      strengtheningExercisePostDTO,
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
        'StrengtheningExercise',
      ) as StrengtheningExercise;
    }
    return null;
  }

  /// updateTask
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TaskPostDTO] taskPostDTO (required):
  Future<Response> updateTaskWithHttpInfo(
    String id,
    TaskPostDTO taskPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/exercises/TASK/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = taskPostDTO;

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

  /// updateTask
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [TaskPostDTO] taskPostDTO (required):
  Future<Task?> updateTask(
    String id,
    TaskPostDTO taskPostDTO,
  ) async {
    final response = await updateTaskWithHttpInfo(
      id,
      taskPostDTO,
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
        'Task',
      ) as Task;
    }
    return null;
  }
}
