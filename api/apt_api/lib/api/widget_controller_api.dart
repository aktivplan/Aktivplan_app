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

class WidgetControllerApi {
  WidgetControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /widget/klimafit-plant' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] numberOfDays:
  ///
  /// * [int] activityPointsActivity:
  ///
  /// * [int] activityPointsActiveMobility:
  ///
  /// * [bool] isProfileView:
  Future<Response> getKlimafitPlantWithHttpInfo({
    int? numberOfDays,
    int? activityPointsActivity,
    int? activityPointsActiveMobility,
    bool? isProfileView,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/widget/klimafit-plant';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (numberOfDays != null) {
      queryParams.addAll(_queryParams('', 'numberOfDays', numberOfDays));
    }
    if (activityPointsActivity != null) {
      queryParams.addAll(
          _queryParams('', 'activityPointsActivity', activityPointsActivity));
    }
    if (activityPointsActiveMobility != null) {
      queryParams.addAll(_queryParams(
          '', 'activityPointsActiveMobility', activityPointsActiveMobility));
    }
    if (isProfileView != null) {
      queryParams.addAll(_queryParams('', 'isProfileView', isProfileView));
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
  /// * [int] numberOfDays:
  ///
  /// * [int] activityPointsActivity:
  ///
  /// * [int] activityPointsActiveMobility:
  ///
  /// * [bool] isProfileView:
  Future<String?> getKlimafitPlant({
    int? numberOfDays,
    int? activityPointsActivity,
    int? activityPointsActiveMobility,
    bool? isProfileView,
  }) async {
    final response = await getKlimafitPlantWithHttpInfo(
      numberOfDays: numberOfDays,
      activityPointsActivity: activityPointsActivity,
      activityPointsActiveMobility: activityPointsActiveMobility,
      isProfileView: isProfileView,
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
        'String',
      ) as String;
    }
    return null;
  }

  /// Performs an HTTP 'GET /widget/klimafit-plant/{patientId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  ///
  /// * [bool] isProfileView:
  Future<Response> getKlimafitPlantForPatientWithHttpInfo(
    String patientId, {
    bool? isProfileView,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/widget/klimafit-plant/{patientId}'
        .replaceAll('{patientId}', patientId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (isProfileView != null) {
      queryParams.addAll(_queryParams('', 'isProfileView', isProfileView));
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
  /// * [String] patientId (required):
  ///
  /// * [bool] isProfileView:
  Future<String?> getKlimafitPlantForPatient(
    String patientId, {
    bool? isProfileView,
  }) async {
    final response = await getKlimafitPlantForPatientWithHttpInfo(
      patientId,
      isProfileView: isProfileView,
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
        'String',
      ) as String;
    }
    return null;
  }

  /// Performs an HTTP 'GET /widget/klimafit-plant/{patientId}/png' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  ///
  /// * [bool] isProfileView:
  Future<Response> getKlimafitPlantForPatientPngWithHttpInfo(
    String patientId, {
    bool? isProfileView,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/widget/klimafit-plant/{patientId}/png'
        .replaceAll('{patientId}', patientId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (isProfileView != null) {
      queryParams.addAll(_queryParams('', 'isProfileView', isProfileView));
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
  /// * [String] patientId (required):
  ///
  /// * [bool] isProfileView:
  Future<String?> getKlimafitPlantForPatientPng(
    String patientId, {
    bool? isProfileView,
  }) async {
    final response = await getKlimafitPlantForPatientPngWithHttpInfo(
      patientId,
      isProfileView: isProfileView,
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
        'String',
      ) as String;
    }
    return null;
  }

  /// Performs an HTTP 'GET /widget/daily-activities/{patientId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  Future<Response> getPatientDailyActivitiesWithHttpInfo(
    String patientId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/widget/daily-activities/{patientId}'
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
  Future<String?> getPatientDailyActivities(
    String patientId,
  ) async {
    final response = await getPatientDailyActivitiesWithHttpInfo(
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
        'String',
      ) as String;
    }
    return null;
  }

  /// Performs an HTTP 'GET /widget/daily-activities/{patientId}/png' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] patientId (required):
  Future<Response> getPatientDailyActivitiesPngWithHttpInfo(
    String patientId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/widget/daily-activities/{patientId}/png'
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
  Future<String?> getPatientDailyActivitiesPng(
    String patientId,
  ) async {
    final response = await getPatientDailyActivitiesPngWithHttpInfo(
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
        'String',
      ) as String;
    }
    return null;
  }
}
