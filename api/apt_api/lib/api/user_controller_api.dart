//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserControllerApi {
  UserControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /users/public/can-self-sign-in' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] healthcareProfessionalId (required):
  Future<Response> canSelfSignInWithHttpInfo(
    String healthcareProfessionalId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/public/can-self-sign-in';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(
        _queryParams('', 'healthcareProfessionalId', healthcareProfessionalId));

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
  /// * [String] healthcareProfessionalId (required):
  Future<bool?> canSelfSignIn(
    String healthcareProfessionalId,
  ) async {
    final response = await canSelfSignInWithHttpInfo(
      healthcareProfessionalId,
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

  /// Performs an HTTP 'PUT /users/change-healthcare-professional' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ChangeHealthcareProfessionalDTO] changeHealthcareProfessionalDTO (required):
  Future<Response> changeHealthcareProfessionalForPatientsWithHttpInfo(
    ChangeHealthcareProfessionalDTO changeHealthcareProfessionalDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/change-healthcare-professional';

    // ignore: prefer_final_locals
    Object? postBody = changeHealthcareProfessionalDTO;

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
  /// * [ChangeHealthcareProfessionalDTO] changeHealthcareProfessionalDTO (required):
  Future<void> changeHealthcareProfessionalForPatients(
    ChangeHealthcareProfessionalDTO changeHealthcareProfessionalDTO,
  ) async {
    final response = await changeHealthcareProfessionalForPatientsWithHttpInfo(
      changeHealthcareProfessionalDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// createHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [HealthcareProfessionalPostDTO] healthcareProfessionalPostDTO (required):
  Future<Response> createHealthcareProfessionalWithHttpInfo(
    HealthcareProfessionalPostDTO healthcareProfessionalPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/HEALTHCARE_PROFESSIONAL';

    // ignore: prefer_final_locals
    Object? postBody = healthcareProfessionalPostDTO;

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

  /// createHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
  ///
  /// Parameters:
  ///
  /// * [HealthcareProfessionalPostDTO] healthcareProfessionalPostDTO (required):
  Future<HealthcareProfessionalGetDTO?> createHealthcareProfessional(
    HealthcareProfessionalPostDTO healthcareProfessionalPostDTO,
  ) async {
    final response = await createHealthcareProfessionalWithHttpInfo(
      healthcareProfessionalPostDTO,
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

  /// createPatient
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PatientPostDTO] patientPostDTO (required):
  Future<Response> createPatientWithHttpInfo(
    PatientPostDTO patientPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT';

    // ignore: prefer_final_locals
    Object? postBody = patientPostDTO;

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

  /// createPatient
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [PatientPostDTO] patientPostDTO (required):
  Future<PatientGetDTO?> createPatient(
    PatientPostDTO patientPostDTO,
  ) async {
    final response = await createPatientWithHttpInfo(
      patientPostDTO,
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

  /// deleteHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteHealthcareProfessionalWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/HEALTHCARE_PROFESSIONAL/{id}'.replaceAll('{id}', id);

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

  /// deleteHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteHealthcareProfessional(
    String id,
  ) async {
    final response = await deleteHealthcareProfessionalWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// deletePatient
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deletePatientWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}'.replaceAll('{id}', id);

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

  /// deletePatient
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deletePatient(
    String id,
  ) async {
    final response = await deletePatientWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /users/userPicture/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UserRole] userRole (required):
  Future<Response> deleteUserPictureByIdWithHttpInfo(
    String id,
    UserRole userRole,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/userPicture/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'userRole', userRole));

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
  ///
  /// * [UserRole] userRole (required):
  Future<void> deleteUserPictureById(
    String id,
    UserRole userRole,
  ) async {
    final response = await deleteUserPictureByIdWithHttpInfo(
      id,
      userRole,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /users/existsMail' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] email (required):
  ///
  /// * [String] existingUserId:
  Future<Response> existsEmailWithHttpInfo(
    String email, {
    String? existingUserId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/existsMail';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'email', email));
    if (existingUserId != null) {
      queryParams.addAll(_queryParams('', 'existingUserId', existingUserId));
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
  /// * [String] email (required):
  ///
  /// * [String] existingUserId:
  Future<bool?> existsEmail(
    String email, {
    String? existingUserId,
  }) async {
    final response = await existsEmailWithHttpInfo(
      email,
      existingUserId: existingUserId,
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

  /// updateHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getHealthcareProfessionalByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/HEALTHCARE_PROFESSIONAL/{id}'.replaceAll('{id}', id);

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

  /// updateHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<HealthcareProfessionalGetDTO?> getHealthcareProfessionalById(
    String id,
  ) async {
    final response = await getHealthcareProfessionalByIdWithHttpInfo(
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
        'HealthcareProfessionalGetDTO',
      ) as HealthcareProfessionalGetDTO;
    }
    return null;
  }

  /// getHealthcareProfessionalProfile
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getHealthcareProfessionalProfileWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/users/HEALTHCARE_PROFESSIONAL/{id}/profile'.replaceAll('{id}', id);

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

  /// getHealthcareProfessionalProfile
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<HealthcareProfessionalProfileDTO?> getHealthcareProfessionalProfile(
    String id,
  ) async {
    final response = await getHealthcareProfessionalProfileWithHttpInfo(
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
        'HealthcareProfessionalProfileDTO',
      ) as HealthcareProfessionalProfileDTO;
    }
    return null;
  }

  /// getHealthcareProfessionalsOverview
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] institutionId:
  Future<Response> getHealthcareProfessionalsOverviewWithHttpInfo({
    String? institutionId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/HEALTHCARE_PROFESSIONAL';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (institutionId != null) {
      queryParams.addAll(_queryParams('', 'institutionId', institutionId));
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

  /// getHealthcareProfessionalsOverview
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR
  ///
  /// Parameters:
  ///
  /// * [String] institutionId:
  Future<HealthcareProfessionalsOverviewDTO?>
      getHealthcareProfessionalsOverview({
    String? institutionId,
  }) async {
    final response = await getHealthcareProfessionalsOverviewWithHttpInfo(
      institutionId: institutionId,
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
        'HealthcareProfessionalsOverviewDTO',
      ) as HealthcareProfessionalsOverviewDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/PATIENT/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getPatientByIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}'.replaceAll('{id}', id);

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
  Future<PatientOverviewDTO?> getPatientById(
    String id,
  ) async {
    final response = await getPatientByIdWithHttpInfo(
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
        'PatientOverviewDTO',
      ) as PatientOverviewDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/PATIENT/{id}/check-marks' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getPatientCheckMarksWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}/check-marks'.replaceAll('{id}', id);

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
  Future<List<bool>?> getPatientCheckMarks(
    String id,
  ) async {
    final response = await getPatientCheckMarksWithHttpInfo(
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
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<bool>')
              as List)
          .cast<bool>()
          .toList(growable: false);
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/PATIENT/{id}/notes' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getPatientNotesWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}/notes'.replaceAll('{id}', id);

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
  Future<PatientNotesDTO?> getPatientNotes(
    String id,
  ) async {
    final response = await getPatientNotesWithHttpInfo(
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
        'PatientNotesDTO',
      ) as PatientNotesDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/HEALTHCARE_PROFESSIONAL/{id}/user-count' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getPatientUserCountByHealthcareProfessionalIdWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/HEALTHCARE_PROFESSIONAL/{id}/user-count'
        .replaceAll('{id}', id);

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
  Future<InstitutionCountDTO?> getPatientUserCountByHealthcareProfessionalId(
    String id,
  ) async {
    final response =
        await getPatientUserCountByHealthcareProfessionalIdWithHttpInfo(
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

  /// getPatientsOverview
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] healthcareProfessionalId:
  Future<Response> getPatientsOverviewWithHttpInfo({
    String? healthcareProfessionalId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (healthcareProfessionalId != null) {
      queryParams.addAll(_queryParams(
          '', 'healthcareProfessionalId', healthcareProfessionalId));
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

  /// getPatientsOverview
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] healthcareProfessionalId:
  Future<PatientsOverviewDTO?> getPatientsOverview({
    String? healthcareProfessionalId,
  }) async {
    final response = await getPatientsOverviewWithHttpInfo(
      healthcareProfessionalId: healthcareProfessionalId,
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
        'PatientsOverviewDTO',
      ) as PatientsOverviewDTO;
    }
    return null;
  }

  /// Performs an HTTP 'GET /users/userPicture/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UserRole] userRole (required):
  Future<Response> getUserPictureByIdWithHttpInfo(
    String id,
    UserRole userRole,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/userPicture/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'userRole', userRole));

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
  ///
  /// * [UserRole] userRole (required):
  Future<FileGetDTO?> getUserPictureById(
    String id,
    UserRole userRole,
  ) async {
    final response = await getUserPictureByIdWithHttpInfo(
      id,
      userRole,
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

  /// requestHealthDataChange
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [HealthDataChangeDTO] healthDataChangeDTO (required):
  Future<Response> requestHealthDataChangeWithHttpInfo(
    HealthDataChangeDTO healthDataChangeDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/request-health-data-change';

    // ignore: prefer_final_locals
    Object? postBody = healthDataChangeDTO;

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

  /// requestHealthDataChange
  ///
  /// PATIENT
  ///
  /// Parameters:
  ///
  /// * [HealthDataChangeDTO] healthDataChangeDTO (required):
  Future<void> requestHealthDataChange(
    HealthDataChangeDTO healthDataChangeDTO,
  ) async {
    final response = await requestHealthDataChangeWithHttpInfo(
      healthDataChangeDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// requestProfileDeletion
  ///
  /// PATIENT
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> requestProfileDeletionWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/request-deletion';

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

  /// requestProfileDeletion
  ///
  /// PATIENT
  Future<void> requestProfileDeletion() async {
    final response = await requestProfileDeletionWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// sendPatientWelcomeMail
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> sendPatientWelcomeMailWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/WELCOME_MAIL/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

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

  /// sendPatientWelcomeMail
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> sendPatientWelcomeMail(
    String id,
  ) async {
    final response = await sendPatientWelcomeMailWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PUT /users/PATIENT/{id}/check-marks' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [List<bool>] requestBody (required):
  Future<Response> storePatientCheckMarksWithHttpInfo(
    String id,
    List<bool> requestBody,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}/check-marks'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = requestBody;

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
  /// * [List<bool>] requestBody (required):
  Future<void> storePatientCheckMarks(
    String id,
    List<bool> requestBody,
  ) async {
    final response = await storePatientCheckMarksWithHttpInfo(
      id,
      requestBody,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PUT /users/PATIENT/{id}/notes' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PatientNotesDTO] patientNotesDTO (required):
  Future<Response> storePatientNotesWithHttpInfo(
    String id,
    PatientNotesDTO patientNotesDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}/notes'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = patientNotesDTO;

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
  /// * [PatientNotesDTO] patientNotesDTO (required):
  Future<void> storePatientNotes(
    String id,
    PatientNotesDTO patientNotesDTO,
  ) async {
    final response = await storePatientNotesWithHttpInfo(
      id,
      patientNotesDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PUT /users/PATIENT/{id}/state' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PatientStateDTO] patientStateDTO (required):
  Future<Response> storePatientStateWithHttpInfo(
    String id,
    PatientStateDTO patientStateDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}/state'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = patientStateDTO;

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
  /// * [PatientStateDTO] patientStateDTO (required):
  Future<void> storePatientState(
    String id,
    PatientStateDTO patientStateDTO,
  ) async {
    final response = await storePatientStateWithHttpInfo(
      id,
      patientStateDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// updateHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [HealthcareProfessionalPostDTO] healthcareProfessionalPostDTO (required):
  Future<Response> updateHealthcareProfessionalWithHttpInfo(
    String id,
    HealthcareProfessionalPostDTO healthcareProfessionalPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/HEALTHCARE_PROFESSIONAL/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = healthcareProfessionalPostDTO;

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

  /// updateHealthcareProfessional
  ///
  /// ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [HealthcareProfessionalPostDTO] healthcareProfessionalPostDTO (required):
  Future<HealthcareProfessionalGetDTO?> updateHealthcareProfessional(
    String id,
    HealthcareProfessionalPostDTO healthcareProfessionalPostDTO,
  ) async {
    final response = await updateHealthcareProfessionalWithHttpInfo(
      id,
      healthcareProfessionalPostDTO,
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

  /// Performs an HTTP 'PUT /users/PATIENT/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PatientPostDTO] patientPostDTO (required):
  Future<Response> updatePatientWithHttpInfo(
    String id,
    PatientPostDTO patientPostDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/PATIENT/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = patientPostDTO;

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
  /// * [PatientPostDTO] patientPostDTO (required):
  Future<PatientGetDTO?> updatePatient(
    String id,
    PatientPostDTO patientPostDTO,
  ) async {
    final response = await updatePatientWithHttpInfo(
      id,
      patientPostDTO,
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

  /// Performs an HTTP 'POST /users/userPicture/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UserRole] userRole (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<Response> uploadUserPictureByIdWithHttpInfo(
    String id,
    UserRole userRole,
    MultipartFile pictureFile,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/users/userPicture/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'userRole', userRole));

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (pictureFile != null) {
      hasFields = true;
      mp.fields[r'pictureFile'] = pictureFile.field;
      mp.files.add(pictureFile);
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

  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UserRole] userRole (required):
  ///
  /// * [MultipartFile] pictureFile (required):
  Future<FileGetDTO?> uploadUserPictureById(
    String id,
    UserRole userRole,
    MultipartFile pictureFile,
  ) async {
    final response = await uploadUserPictureByIdWithHttpInfo(
      id,
      userRole,
      pictureFile,
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
