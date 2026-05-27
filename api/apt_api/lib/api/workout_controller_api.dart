//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WorkoutControllerApi {
  WorkoutControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// createWorkout
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [WorkoutPostDTO] workoutPostDTO (required):
  Future<Response> createWorkoutWithHttpInfo(
    WorkoutPostDTO workoutPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/workouts';

    // ignore: prefer_final_locals
    Object? postBody = workoutPostDTO;

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

  /// createWorkout
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [WorkoutPostDTO] workoutPostDTO (required):
  Future<Workout?> createWorkout(
    WorkoutPostDTO workoutPostDTO,
  ) async {
    final response = await createWorkoutWithHttpInfo(
      workoutPostDTO,
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
        'Workout',
      ) as Workout;
    }
    return null;
  }

  /// deleteWorkout
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteWorkoutWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/workouts/{id}'.replaceAll('{id}', id);

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

  /// deleteWorkout
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteWorkout(
    String id,
  ) async {
    final response = await deleteWorkoutWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// deleteWorkoutVideoById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteWorkoutVideoByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/workouts/video/{id}'.replaceAll('{id}', id);

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

  /// deleteWorkoutVideoById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<bool?> deleteWorkoutVideoById(
    String id,
  ) async {
    final response = await deleteWorkoutVideoByIdWithHttpInfo(
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

  /// Performs an HTTP 'GET /workouts' operation and returns the [Response].
  Future<Response> getWorkoutsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/workouts';

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

  Future<List<Workout>?> getWorkouts() async {
    final response = await getWorkoutsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Workout>')
              as List)
          .cast<Workout>()
          .toList(growable: false);
    }
    return null;
  }

  /// updateWorkout
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [WorkoutPostDTO] workoutPostDTO (required):
  Future<Response> updateWorkoutWithHttpInfo(
    String id,
    WorkoutPostDTO workoutPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/workouts/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = workoutPostDTO;

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

  /// updateWorkout
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [WorkoutPostDTO] workoutPostDTO (required):
  Future<Workout?> updateWorkout(
    String id,
    WorkoutPostDTO workoutPostDTO,
  ) async {
    final response = await updateWorkoutWithHttpInfo(
      id,
      workoutPostDTO,
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
        'Workout',
      ) as Workout;
    }
    return null;
  }

  /// uploadWorkoutVideoById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] videoFile (required):
  Future<Response> uploadWorkoutVideoByIdWithHttpInfo(
    String id,
    MultipartFile videoFile,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/workouts/video/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (videoFile != null) {
      hasFields = true;
      mp.fields[r'videoFile'] = videoFile.field;
      mp.files.add(videoFile);
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

  /// uploadWorkoutVideoById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] videoFile (required):
  Future<FileGetDTO?> uploadWorkoutVideoById(
    String id,
    MultipartFile videoFile,
  ) async {
    final response = await uploadWorkoutVideoByIdWithHttpInfo(
      id,
      videoFile,
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
