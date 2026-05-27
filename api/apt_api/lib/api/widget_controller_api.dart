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
  Future<Response> getKlimafitPlantWithHttpInfo({
    int? numberOfDays,
    int? activityPointsActivity,
    int? activityPointsActiveMobility,
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
  Future<String?> getKlimafitPlant({
    int? numberOfDays,
    int? activityPointsActivity,
    int? activityPointsActiveMobility,
  }) async {
    final response = await getKlimafitPlantWithHttpInfo(
      numberOfDays: numberOfDays,
      activityPointsActivity: activityPointsActivity,
      activityPointsActiveMobility: activityPointsActiveMobility,
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
