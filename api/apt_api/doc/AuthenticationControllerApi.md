# apt_api.api.AuthenticationControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *https://aktivplan-plus.ap-stage.at*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changeUserPassword**](AuthenticationControllerApi.md#changeuserpassword) | **POST** /authentication/change-password | 
[**createAuthenticationToken**](AuthenticationControllerApi.md#createauthenticationtoken) | **POST** /authentication/login | 
[**forgotPassword**](AuthenticationControllerApi.md#forgotpassword) | **POST** /authentication/forgotPassword | 
[**getCurrentUser**](AuthenticationControllerApi.md#getcurrentuser) | **GET** /authentication/currentUser | 
[**refreshAuthenticationToken**](AuthenticationControllerApi.md#refreshauthenticationtoken) | **POST** /authentication/refresh | 
[**resetPassword**](AuthenticationControllerApi.md#resetpassword) | **POST** /authentication/resetPassword | 
[**revokeFirebaseToken**](AuthenticationControllerApi.md#revokefirebasetoken) | **POST** /authentication/revokeFirebaseToken | 
[**storeFirebaseToken**](AuthenticationControllerApi.md#storefirebasetoken) | **POST** /authentication/firebaseToken | 
[**switchCurrentLanguage**](AuthenticationControllerApi.md#switchcurrentlanguage) | **POST** /authentication/language | 


# **changeUserPassword**
> bool changeUserPassword(changePasswordDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final changePasswordDTO = ChangePasswordDTO(); // ChangePasswordDTO | 

try {
    final result = api_instance.changeUserPassword(changePasswordDTO);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->changeUserPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordDTO** | [**ChangePasswordDTO**](ChangePasswordDTO.md)|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAuthenticationToken**
> AccessTokenDTO createAuthenticationToken(authenticationDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final authenticationDTO = AuthenticationDTO(); // AuthenticationDTO | 

try {
    final result = api_instance.createAuthenticationToken(authenticationDTO);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->createAuthenticationToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authenticationDTO** | [**AuthenticationDTO**](AuthenticationDTO.md)|  | 

### Return type

[**AccessTokenDTO**](AccessTokenDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **forgotPassword**
> bool forgotPassword(forgotPasswordDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final forgotPasswordDTO = ForgotPasswordDTO(); // ForgotPasswordDTO | 

try {
    final result = api_instance.forgotPassword(forgotPasswordDTO);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->forgotPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **forgotPasswordDTO** | [**ForgotPasswordDTO**](ForgotPasswordDTO.md)|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCurrentUser**
> CurrentUserDTO getCurrentUser()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();

try {
    final result = api_instance.getCurrentUser();
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->getCurrentUser: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CurrentUserDTO**](CurrentUserDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshAuthenticationToken**
> AccessTokenDTO refreshAuthenticationToken(refreshTokenDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final refreshTokenDTO = RefreshTokenDTO(); // RefreshTokenDTO | 

try {
    final result = api_instance.refreshAuthenticationToken(refreshTokenDTO);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->refreshAuthenticationToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenDTO** | [**RefreshTokenDTO**](RefreshTokenDTO.md)|  | 

### Return type

[**AccessTokenDTO**](AccessTokenDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> bool resetPassword(resetPasswordDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final resetPasswordDTO = ResetPasswordDTO(); // ResetPasswordDTO | 

try {
    final result = api_instance.resetPassword(resetPasswordDTO);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->resetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordDTO** | [**ResetPasswordDTO**](ResetPasswordDTO.md)|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokeFirebaseToken**
> revokeFirebaseToken(firebaseTokenDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final firebaseTokenDTO = FirebaseTokenDTO(); // FirebaseTokenDTO | 

try {
    api_instance.revokeFirebaseToken(firebaseTokenDTO);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->revokeFirebaseToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **firebaseTokenDTO** | [**FirebaseTokenDTO**](FirebaseTokenDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storeFirebaseToken**
> storeFirebaseToken(firebaseTokenDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final firebaseTokenDTO = FirebaseTokenDTO(); // FirebaseTokenDTO | 

try {
    api_instance.storeFirebaseToken(firebaseTokenDTO);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->storeFirebaseToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **firebaseTokenDTO** | [**FirebaseTokenDTO**](FirebaseTokenDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **switchCurrentLanguage**
> switchCurrentLanguage(languageSwitchDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = AuthenticationControllerApi();
final languageSwitchDTO = LanguageSwitchDTO(); // LanguageSwitchDTO | 

try {
    api_instance.switchCurrentLanguage(languageSwitchDTO);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->switchCurrentLanguage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **languageSwitchDTO** | [**LanguageSwitchDTO**](LanguageSwitchDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

