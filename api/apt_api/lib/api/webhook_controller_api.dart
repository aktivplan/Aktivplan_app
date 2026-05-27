//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WebhookControllerApi {
  WebhookControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// createOrUpdateP2RCoach
  ///
  /// ROLE_P2R_CLIENT - requires caatsId and institutionP2RFocus (for internally gathering institution) in request body
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [P2RCoachPostDTO] p2RCoachPostDTO (required):
  Future<Response> createOrUpdateP2RCoachWithHttpInfo(
    P2RCoachPostDTO p2RCoachPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/webhooks/p2r/coach';

    // ignore: prefer_final_locals
    Object? postBody = p2RCoachPostDTO;

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

  /// createOrUpdateP2RCoach
  ///
  /// ROLE_P2R_CLIENT - requires caatsId and institutionP2RFocus (for internally gathering institution) in request body
  ///
  /// Parameters:
  ///
  /// * [P2RCoachPostDTO] p2RCoachPostDTO (required):
  Future<HealthcareProfessionalGetDTO?> createOrUpdateP2RCoach(
    P2RCoachPostDTO p2RCoachPostDTO,
  ) async {
    final response = await createOrUpdateP2RCoachWithHttpInfo(
      p2RCoachPostDTO,
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
        'HealthcareProfessionalGetDTO',
      ) as HealthcareProfessionalGetDTO;
    }
    return null;
  }

  /// createOrUpdateP2RPatient
  ///
  /// ROLE_P2R_CLIENT - requires caatsId and institutionP2RFocus (for internally gathering institution) in request body
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [P2RPatientPostDTO] p2RPatientPostDTO (required):
  Future<Response> createOrUpdateP2RPatientWithHttpInfo(
    P2RPatientPostDTO p2RPatientPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/webhooks/p2r/patient';

    // ignore: prefer_final_locals
    Object? postBody = p2RPatientPostDTO;

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

  /// createOrUpdateP2RPatient
  ///
  /// ROLE_P2R_CLIENT - requires caatsId and institutionP2RFocus (for internally gathering institution) in request body
  ///
  /// Parameters:
  ///
  /// * [P2RPatientPostDTO] p2RPatientPostDTO (required):
  Future<PatientGetDTO?> createOrUpdateP2RPatient(
    P2RPatientPostDTO p2RPatientPostDTO,
  ) async {
    final response = await createOrUpdateP2RPatientWithHttpInfo(
      p2RPatientPostDTO,
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
        'PatientGetDTO',
      ) as PatientGetDTO;
    }
    return null;
  }
}
