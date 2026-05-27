//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActivityControllerApi {
  ActivityControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /activities' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ActivityPostDTO] activityPostDTO (required):
  Future<Response> createActivityWithHttpInfo(
    ActivityPostDTO activityPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities';

    // ignore: prefer_final_locals
    Object? postBody = activityPostDTO;

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
  /// * [ActivityPostDTO] activityPostDTO (required):
  Future<Activity?> createActivity(
    ActivityPostDTO activityPostDTO,
  ) async {
    final response = await createActivityWithHttpInfo(
      activityPostDTO,
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
        'Activity',
      ) as Activity;
    }
    return null;
  }

  /// createExtraActivity
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ExtraActivityPostDTO] extraActivityPostDTO (required):
  Future<Response> createExtraActivityWithHttpInfo(
    ExtraActivityPostDTO extraActivityPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/EXTRA';

    // ignore: prefer_final_locals
    Object? postBody = extraActivityPostDTO;

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

  /// createExtraActivity
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [ExtraActivityPostDTO] extraActivityPostDTO (required):
  Future<ActivityOverviewDTO?> createExtraActivity(
    ExtraActivityPostDTO extraActivityPostDTO,
  ) async {
    final response = await createExtraActivityWithHttpInfo(
      extraActivityPostDTO,
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
        'ActivityOverviewDTO',
      ) as ActivityOverviewDTO;
    }
    return null;
  }

  /// Performs an HTTP 'POST /activities/personalGoals' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PersonalGoalPostDTO] personalGoalPostDTO (required):
  Future<Response> createPersonalGoalWithHttpInfo(
    PersonalGoalPostDTO personalGoalPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/personalGoals';

    // ignore: prefer_final_locals
    Object? postBody = personalGoalPostDTO;

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
  /// * [PersonalGoalPostDTO] personalGoalPostDTO (required):
  Future<PersonalGoal?> createPersonalGoal(
    PersonalGoalPostDTO personalGoalPostDTO,
  ) async {
    final response = await createPersonalGoalWithHttpInfo(
      personalGoalPostDTO,
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
        'PersonalGoal',
      ) as PersonalGoal;
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /activities/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteActivityWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/{id}'.replaceAll('{id}', id);

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

  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteActivity(
    String id,
  ) async {
    final response = await deleteActivityWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// deleteActivityVideoById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteActivityVideoByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/video/{id}'.replaceAll('{id}', id);

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

  /// deleteActivityVideoById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<bool?> deleteActivityVideoById(
    String id,
  ) async {
    final response = await deleteActivityVideoByIdWithHttpInfo(
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

  /// Performs an HTTP 'DELETE /activities/personalGoals/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deletePersonalGoalWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/personalGoals/{id}'.replaceAll('{id}', id);

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

  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deletePersonalGoal(
    String id,
  ) async {
    final response = await deletePersonalGoalWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /activities/activeMinutes/{type}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ActiveMinutesType] type (required):
  ///
  /// * [String] startDate (required):
  ///
  /// * [String] endDate (required):
  ///
  /// * [String] patientId:
  Future<Response> getActiveMinutesWithHttpInfo(
    ActiveMinutesType type,
    String startDate,
    String endDate, {
    String? patientId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/activeMinutes/{type}'
        .replaceAll('{type}', type.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (patientId != null) {
      queryParams.addAll(_queryParams('', 'patientId', patientId));
    }
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

  /// Parameters:
  ///
  /// * [ActiveMinutesType] type (required):
  ///
  /// * [String] startDate (required):
  ///
  /// * [String] endDate (required):
  ///
  /// * [String] patientId:
  Future<ActiveMinutesOverviewDTO?> getActiveMinutes(
    ActiveMinutesType type,
    String startDate,
    String endDate, {
    String? patientId,
  }) async {
    final response = await getActiveMinutesWithHttpInfo(
      type,
      startDate,
      endDate,
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
        'ActiveMinutesOverviewDTO',
      ) as ActiveMinutesOverviewDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /activities' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] startDate (required):
  ///
  /// * [String] endDate (required):
  ///
  /// * [String] patientId:
  Future<Response> getActivitiesWithHttpInfo(
    String startDate,
    String endDate, {
    String? patientId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/activities';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (patientId != null) {
      queryParams.addAll(_queryParams('', 'patientId', patientId));
    }
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

  /// Parameters:
  ///
  /// * [String] startDate (required):
  ///
  /// * [String] endDate (required):
  ///
  /// * [String] patientId:
  Future<List<ActivityOverviewDTO>?> getActivities(
    String startDate,
    String endDate, {
    String? patientId,
  }) async {
    final response = await getActivitiesWithHttpInfo(
      startDate,
      endDate,
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
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<ActivityOverviewDTO>') as List)
          .cast<ActivityOverviewDTO>()
          .toList(growable: false);
    }
    return null;
  }

  /// getActivityNamesAutocomplete
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ActivityType] type (required):
  Future<Response> getActivityNamesAutocompleteWithHttpInfo(
    ActivityType type,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/{type}/autocomplete'
        .replaceAll('{type}', type.toString());

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

  /// getActivityNamesAutocomplete
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [ActivityType] type (required):
  Future<ActivityAutocompleteGetDTO?> getActivityNamesAutocomplete(
    ActivityType type,
  ) async {
    final response = await getActivityNamesAutocompleteWithHttpInfo(
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
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ActivityAutocompleteGetDTO',
      ) as ActivityAutocompleteGetDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /activities/active-minutes/percentage-data' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] date (required):
  ///
  /// * [String] patientId:
  Future<Response> getActivityPercentageDataWithHttpInfo(
    String date, {
    String? patientId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/active-minutes/percentage-data';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (patientId != null) {
      queryParams.addAll(_queryParams('', 'patientId', patientId));
    }
    queryParams.addAll(_queryParams('', 'date', date));

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
  /// * [String] date (required):
  ///
  /// * [String] patientId:
  Future<ActivityPercentageDataDTO?> getActivityPercentageData(
    String date, {
    String? patientId,
  }) async {
    final response = await getActivityPercentageDataWithHttpInfo(
      date,
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
        'ActivityPercentageDataDTO',
      ) as ActivityPercentageDataDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /activities/personalGoals' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId:
  Future<Response> getPersonalGoalsWithHttpInfo({
    String? patientId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/personalGoals';

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

  /// Parameters:
  ///
  /// * [String] patientId:
  Future<List<PersonalGoal>?> getPersonalGoals({
    String? patientId,
  }) async {
    final response = await getPersonalGoalsWithHttpInfo(
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
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<PersonalGoal>') as List)
          .cast<PersonalGoal>()
          .toList(growable: false);
    }
    return null;
  }

  /// Performs an HTTP 'PUT /activities/hide' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [HideActivityPostDTO] hideActivityPostDTO (required):
  Future<Response> hideActivityWithHttpInfo(
    HideActivityPostDTO hideActivityPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/hide';

    // ignore: prefer_final_locals
    Object? postBody = hideActivityPostDTO;

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

  /// Parameters:
  ///
  /// * [HideActivityPostDTO] hideActivityPostDTO (required):
  Future<void> hideActivity(
    HideActivityPostDTO hideActivityPostDTO,
  ) async {
    final response = await hideActivityWithHttpInfo(
      hideActivityPostDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /activities/move' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [MoveActivityPostDTO] moveActivityPostDTO (required):
  Future<Response> moveActivityWithHttpInfo(
    MoveActivityPostDTO moveActivityPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/move';

    // ignore: prefer_final_locals
    Object? postBody = moveActivityPostDTO;

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
  /// * [MoveActivityPostDTO] moveActivityPostDTO (required):
  Future<Activity?> moveActivity(
    MoveActivityPostDTO moveActivityPostDTO,
  ) async {
    final response = await moveActivityWithHttpInfo(
      moveActivityPostDTO,
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
        'Activity',
      ) as Activity;
    }
    return null;
  }

  /// Performs an HTTP 'POST /activities/personalGoals/move' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [MovePersonalGoalPostDTO] movePersonalGoalPostDTO (required):
  Future<Response> movePersonalGoalWithHttpInfo(
    MovePersonalGoalPostDTO movePersonalGoalPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/personalGoals/move';

    // ignore: prefer_final_locals
    Object? postBody = movePersonalGoalPostDTO;

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
  /// * [MovePersonalGoalPostDTO] movePersonalGoalPostDTO (required):
  Future<PersonalGoal?> movePersonalGoal(
    MovePersonalGoalPostDTO movePersonalGoalPostDTO,
  ) async {
    final response = await movePersonalGoalWithHttpInfo(
      movePersonalGoalPostDTO,
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
        'PersonalGoal',
      ) as PersonalGoal;
    }
    return null;
  }

  /// Performs an HTTP 'PUT /activities/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ActivityPostDTO] activityPostDTO (required):
  Future<Response> updateActivityWithHttpInfo(
    String id,
    ActivityPostDTO activityPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = activityPostDTO;

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

  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ActivityPostDTO] activityPostDTO (required):
  Future<Activity?> updateActivity(
    String id,
    ActivityPostDTO activityPostDTO,
  ) async {
    final response = await updateActivityWithHttpInfo(
      id,
      activityPostDTO,
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
        'Activity',
      ) as Activity;
    }
    return null;
  }

  /// updateActivityRating
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] date (required):
  ///
  /// * [ActivityPatientRatingPostDTO] activityPatientRatingPostDTO (required):
  Future<Response> updateActivityRatingWithHttpInfo(
    String id,
    String date,
    ActivityPatientRatingPostDTO activityPatientRatingPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/{id}/{date}'
        .replaceAll('{id}', id)
        .replaceAll('{date}', date);

    // ignore: prefer_final_locals
    Object? postBody = activityPatientRatingPostDTO;

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

  /// updateActivityRating
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] date (required):
  ///
  /// * [ActivityPatientRatingPostDTO] activityPatientRatingPostDTO (required):
  Future<ActivityPatientRating?> updateActivityRating(
    String id,
    String date,
    ActivityPatientRatingPostDTO activityPatientRatingPostDTO,
  ) async {
    final response = await updateActivityRatingWithHttpInfo(
      id,
      date,
      activityPatientRatingPostDTO,
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
        'ActivityPatientRating',
      ) as ActivityPatientRating;
    }
    return null;
  }

  /// updateExtraActivity
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ExtraActivityPutDTO] extraActivityPutDTO (required):
  Future<Response> updateExtraActivityWithHttpInfo(
    String id,
    ExtraActivityPutDTO extraActivityPutDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/EXTRA/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = extraActivityPutDTO;

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

  /// updateExtraActivity
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ExtraActivityPutDTO] extraActivityPutDTO (required):
  Future<ActivityOverviewDTO?> updateExtraActivity(
    String id,
    ExtraActivityPutDTO extraActivityPutDTO,
  ) async {
    final response = await updateExtraActivityWithHttpInfo(
      id,
      extraActivityPutDTO,
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
        'ActivityOverviewDTO',
      ) as ActivityOverviewDTO;
    }
    return null;
  }

  /// Performs an HTTP 'PUT /activities/personalGoals/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PersonalGoalPostDTO] personalGoalPostDTO (required):
  Future<Response> updatePersonalGoalWithHttpInfo(
    String id,
    PersonalGoalPostDTO personalGoalPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/personalGoals/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = personalGoalPostDTO;

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

  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PersonalGoalPostDTO] personalGoalPostDTO (required):
  Future<PersonalGoal?> updatePersonalGoal(
    String id,
    PersonalGoalPostDTO personalGoalPostDTO,
  ) async {
    final response = await updatePersonalGoalWithHttpInfo(
      id,
      personalGoalPostDTO,
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
        'PersonalGoal',
      ) as PersonalGoal;
    }
    return null;
  }

  /// uploadActivityVideoById
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
  Future<Response> uploadActivityVideoByIdWithHttpInfo(
    String id,
    MultipartFile videoFile,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/activities/video/{id}'.replaceAll('{id}', id);

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

  /// uploadActivityVideoById
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] videoFile (required):
  Future<FileGetDTO?> uploadActivityVideoById(
    String id,
    MultipartFile videoFile,
  ) async {
    final response = await uploadActivityVideoByIdWithHttpInfo(
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
