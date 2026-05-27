//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthenticationControllerApi {
  AuthenticationControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /authentication/change-password' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ChangePasswordDTO] changePasswordDTO (required):
  Future<Response> changeUserPasswordWithHttpInfo(
    ChangePasswordDTO changePasswordDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/change-password';

    // ignore: prefer_final_locals
    Object? postBody = changePasswordDTO;

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
  /// * [ChangePasswordDTO] changePasswordDTO (required):
  Future<bool?> changeUserPassword(
    ChangePasswordDTO changePasswordDTO,
  ) async {
    final response = await changeUserPasswordWithHttpInfo(
      changePasswordDTO,
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

  /// Performs an HTTP 'POST /authentication/login' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [AuthenticationDTO] authenticationDTO (required):
  Future<Response> createAuthenticationTokenWithHttpInfo(
    AuthenticationDTO authenticationDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/login';

    // ignore: prefer_final_locals
    Object? postBody = authenticationDTO;

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
  /// * [AuthenticationDTO] authenticationDTO (required):
  Future<AccessTokenDTO?> createAuthenticationToken(
    AuthenticationDTO authenticationDTO,
  ) async {
    final response = await createAuthenticationTokenWithHttpInfo(
      authenticationDTO,
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
        'AccessTokenDTO',
      ) as AccessTokenDTO;
    }
    return null;
  }

  /// createAuthenticationTokenWithCredentials
  ///
  /// Either authenticate using client-id and client-secret or by using a CAATS token
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TokenRequestDTO] tokenRequestDTO (required):
  Future<Response> createAuthenticationTokenWithCredentialsWithHttpInfo(
    TokenRequestDTO tokenRequestDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/token';

    // ignore: prefer_final_locals
    Object? postBody = tokenRequestDTO;

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

  /// createAuthenticationTokenWithCredentials
  ///
  /// Either authenticate using client-id and client-secret or by using a CAATS token
  ///
  /// Parameters:
  ///
  /// * [TokenRequestDTO] tokenRequestDTO (required):
  Future<AccessTokenDTO?> createAuthenticationTokenWithCredentials(
    TokenRequestDTO tokenRequestDTO,
  ) async {
    final response = await createAuthenticationTokenWithCredentialsWithHttpInfo(
      tokenRequestDTO,
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
        'AccessTokenDTO',
      ) as AccessTokenDTO;
    }
    return null;
  }

  /// Performs an HTTP 'POST /authentication/forgotPassword' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ForgotPasswordDTO] forgotPasswordDTO (required):
  Future<Response> forgotPasswordWithHttpInfo(
    ForgotPasswordDTO forgotPasswordDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/forgotPassword';

    // ignore: prefer_final_locals
    Object? postBody = forgotPasswordDTO;

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
  /// * [ForgotPasswordDTO] forgotPasswordDTO (required):
  Future<bool?> forgotPassword(
    ForgotPasswordDTO forgotPasswordDTO,
  ) async {
    final response = await forgotPasswordWithHttpInfo(
      forgotPasswordDTO,
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

  /// Performs an HTTP 'GET /authentication/currentUser' operation and returns the [Response].
  Future<Response> getCurrentUserWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/currentUser';

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

  Future<CurrentUserDTO?> getCurrentUser() async {
    final response = await getCurrentUserWithHttpInfo();
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
        'CurrentUserDTO',
      ) as CurrentUserDTO;
    }
    return null;
  }

  /// Performs an HTTP 'POST /authentication/refresh' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [RefreshTokenDTO] refreshTokenDTO (required):
  Future<Response> refreshAuthenticationTokenWithHttpInfo(
    RefreshTokenDTO refreshTokenDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/refresh';

    // ignore: prefer_final_locals
    Object? postBody = refreshTokenDTO;

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
  /// * [RefreshTokenDTO] refreshTokenDTO (required):
  Future<AccessTokenDTO?> refreshAuthenticationToken(
    RefreshTokenDTO refreshTokenDTO,
  ) async {
    final response = await refreshAuthenticationTokenWithHttpInfo(
      refreshTokenDTO,
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
        'AccessTokenDTO',
      ) as AccessTokenDTO;
    }
    return null;
  }

  /// Performs an HTTP 'POST /authentication/resetPassword' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ResetPasswordDTO] resetPasswordDTO (required):
  Future<Response> resetPasswordWithHttpInfo(
    ResetPasswordDTO resetPasswordDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/resetPassword';

    // ignore: prefer_final_locals
    Object? postBody = resetPasswordDTO;

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
  /// * [ResetPasswordDTO] resetPasswordDTO (required):
  Future<bool?> resetPassword(
    ResetPasswordDTO resetPasswordDTO,
  ) async {
    final response = await resetPasswordWithHttpInfo(
      resetPasswordDTO,
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

  /// Performs an HTTP 'POST /authentication/revokeFirebaseToken' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FirebaseTokenDTO] firebaseTokenDTO (required):
  Future<Response> revokeFirebaseTokenWithHttpInfo(
    FirebaseTokenDTO firebaseTokenDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/revokeFirebaseToken';

    // ignore: prefer_final_locals
    Object? postBody = firebaseTokenDTO;

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
  /// * [FirebaseTokenDTO] firebaseTokenDTO (required):
  Future<void> revokeFirebaseToken(
    FirebaseTokenDTO firebaseTokenDTO,
  ) async {
    final response = await revokeFirebaseTokenWithHttpInfo(
      firebaseTokenDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /authentication/firebaseToken' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FirebaseTokenDTO] firebaseTokenDTO (required):
  Future<Response> storeFirebaseTokenWithHttpInfo(
    FirebaseTokenDTO firebaseTokenDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/firebaseToken';

    // ignore: prefer_final_locals
    Object? postBody = firebaseTokenDTO;

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
  /// * [FirebaseTokenDTO] firebaseTokenDTO (required):
  Future<void> storeFirebaseToken(
    FirebaseTokenDTO firebaseTokenDTO,
  ) async {
    final response = await storeFirebaseTokenWithHttpInfo(
      firebaseTokenDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /authentication/language' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [LanguageSwitchDTO] languageSwitchDTO (required):
  Future<Response> switchCurrentLanguageWithHttpInfo(
    LanguageSwitchDTO languageSwitchDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/authentication/language';

    // ignore: prefer_final_locals
    Object? postBody = languageSwitchDTO;

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
  /// * [LanguageSwitchDTO] languageSwitchDTO (required):
  Future<void> switchCurrentLanguage(
    LanguageSwitchDTO languageSwitchDTO,
  ) async {
    final response = await switchCurrentLanguageWithHttpInfo(
      languageSwitchDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
