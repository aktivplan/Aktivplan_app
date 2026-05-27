# apt_api.api.UserControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**canSelfSignIn**](UserControllerApi.md#canselfsignin) | **GET** /users/public/can-self-sign-in | 
[**changeHealthcareProfessionalForPatients**](UserControllerApi.md#changehealthcareprofessionalforpatients) | **PUT** /users/change-healthcare-professional | 
[**createHealthcareProfessional**](UserControllerApi.md#createhealthcareprofessional) | **POST** /users/HEALTHCARE_PROFESSIONAL | createHealthcareProfessional
[**createPatient**](UserControllerApi.md#createpatient) | **POST** /users/PATIENT | createPatient
[**deleteHealthcareProfessional**](UserControllerApi.md#deletehealthcareprofessional) | **DELETE** /users/HEALTHCARE_PROFESSIONAL/{id} | deleteHealthcareProfessional
[**deletePatient**](UserControllerApi.md#deletepatient) | **DELETE** /users/PATIENT/{id} | deletePatient
[**deleteUserPictureById**](UserControllerApi.md#deleteuserpicturebyid) | **DELETE** /users/userPicture/{id} | 
[**existsEmail**](UserControllerApi.md#existsemail) | **GET** /users/existsMail | 
[**getHealthcareProfessionalById**](UserControllerApi.md#gethealthcareprofessionalbyid) | **GET** /users/HEALTHCARE_PROFESSIONAL/{id} | updateHealthcareProfessional
[**getHealthcareProfessionalProfile**](UserControllerApi.md#gethealthcareprofessionalprofile) | **GET** /users/HEALTHCARE_PROFESSIONAL/{id}/profile | getHealthcareProfessionalProfile
[**getHealthcareProfessionalsOverview**](UserControllerApi.md#gethealthcareprofessionalsoverview) | **GET** /users/HEALTHCARE_PROFESSIONAL | getHealthcareProfessionalsOverview
[**getPatientById**](UserControllerApi.md#getpatientbyid) | **GET** /users/PATIENT/{id} | 
[**getPatientCheckMarks**](UserControllerApi.md#getpatientcheckmarks) | **GET** /users/PATIENT/{id}/check-marks | 
[**getPatientNotes**](UserControllerApi.md#getpatientnotes) | **GET** /users/PATIENT/{id}/notes | 
[**getPatientUserCountByHealthcareProfessionalId**](UserControllerApi.md#getpatientusercountbyhealthcareprofessionalid) | **GET** /users/HEALTHCARE_PROFESSIONAL/{id}/user-count | 
[**getPatientsOverview**](UserControllerApi.md#getpatientsoverview) | **GET** /users/PATIENT | getPatientsOverview
[**getUserPictureById**](UserControllerApi.md#getuserpicturebyid) | **GET** /users/userPicture/{id} | 
[**requestHealthDataChange**](UserControllerApi.md#requesthealthdatachange) | **POST** /users/PATIENT/request-health-data-change | requestHealthDataChange
[**requestProfileDeletion**](UserControllerApi.md#requestprofiledeletion) | **POST** /users/PATIENT/request-deletion | requestProfileDeletion
[**sendPatientWelcomeMail**](UserControllerApi.md#sendpatientwelcomemail) | **PUT** /users/PATIENT/WELCOME_MAIL/{id} | sendPatientWelcomeMail
[**storePatientCheckMarks**](UserControllerApi.md#storepatientcheckmarks) | **PUT** /users/PATIENT/{id}/check-marks | 
[**storePatientNotes**](UserControllerApi.md#storepatientnotes) | **PUT** /users/PATIENT/{id}/notes | 
[**storePatientState**](UserControllerApi.md#storepatientstate) | **PUT** /users/PATIENT/{id}/state | 
[**updateHealthcareProfessional**](UserControllerApi.md#updatehealthcareprofessional) | **PUT** /users/HEALTHCARE_PROFESSIONAL/{id} | updateHealthcareProfessional
[**updatePatient**](UserControllerApi.md#updatepatient) | **PUT** /users/PATIENT/{id} | 
[**uploadUserPictureById**](UserControllerApi.md#uploaduserpicturebyid) | **POST** /users/userPicture/{id} | 


# **canSelfSignIn**
> bool canSelfSignIn(healthcareProfessionalId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final healthcareProfessionalId = healthcareProfessionalId_example; // String | 

try {
    final result = api_instance.canSelfSignIn(healthcareProfessionalId);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->canSelfSignIn: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **healthcareProfessionalId** | **String**|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changeHealthcareProfessionalForPatients**
> changeHealthcareProfessionalForPatients(changeHealthcareProfessionalDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final changeHealthcareProfessionalDTO = ChangeHealthcareProfessionalDTO(); // ChangeHealthcareProfessionalDTO | 

try {
    api_instance.changeHealthcareProfessionalForPatients(changeHealthcareProfessionalDTO);
} catch (e) {
    print('Exception when calling UserControllerApi->changeHealthcareProfessionalForPatients: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changeHealthcareProfessionalDTO** | [**ChangeHealthcareProfessionalDTO**](ChangeHealthcareProfessionalDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createHealthcareProfessional**
> HealthcareProfessionalGetDTO createHealthcareProfessional(healthcareProfessionalPostDTO)

createHealthcareProfessional

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final healthcareProfessionalPostDTO = HealthcareProfessionalPostDTO(); // HealthcareProfessionalPostDTO | 

try {
    final result = api_instance.createHealthcareProfessional(healthcareProfessionalPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->createHealthcareProfessional: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **healthcareProfessionalPostDTO** | [**HealthcareProfessionalPostDTO**](HealthcareProfessionalPostDTO.md)|  | 

### Return type

[**HealthcareProfessionalGetDTO**](HealthcareProfessionalGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPatient**
> PatientGetDTO createPatient(patientPostDTO)

createPatient

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final patientPostDTO = PatientPostDTO(); // PatientPostDTO | 

try {
    final result = api_instance.createPatient(patientPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->createPatient: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientPostDTO** | [**PatientPostDTO**](PatientPostDTO.md)|  | 

### Return type

[**PatientGetDTO**](PatientGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteHealthcareProfessional**
> deleteHealthcareProfessional(id)

deleteHealthcareProfessional

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteHealthcareProfessional(id);
} catch (e) {
    print('Exception when calling UserControllerApi->deleteHealthcareProfessional: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePatient**
> deletePatient(id)

deletePatient

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    api_instance.deletePatient(id);
} catch (e) {
    print('Exception when calling UserControllerApi->deletePatient: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserPictureById**
> deleteUserPictureById(id, userRole)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final userRole = ; // UserRole | 

try {
    api_instance.deleteUserPictureById(id, userRole);
} catch (e) {
    print('Exception when calling UserControllerApi->deleteUserPictureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userRole** | [**UserRole**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **existsEmail**
> bool existsEmail(email, existingUserId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final email = email_example; // String | 
final existingUserId = existingUserId_example; // String | 

try {
    final result = api_instance.existsEmail(email, existingUserId);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->existsEmail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **existingUserId** | **String**|  | [optional] 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHealthcareProfessionalById**
> HealthcareProfessionalGetDTO getHealthcareProfessionalById(id)

updateHealthcareProfessional

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getHealthcareProfessionalById(id);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getHealthcareProfessionalById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**HealthcareProfessionalGetDTO**](HealthcareProfessionalGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHealthcareProfessionalProfile**
> HealthcareProfessionalProfileDTO getHealthcareProfessionalProfile(id)

getHealthcareProfessionalProfile

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getHealthcareProfessionalProfile(id);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getHealthcareProfessionalProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**HealthcareProfessionalProfileDTO**](HealthcareProfessionalProfileDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHealthcareProfessionalsOverview**
> HealthcareProfessionalsOverviewDTO getHealthcareProfessionalsOverview(institutionId)

getHealthcareProfessionalsOverview

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final institutionId = institutionId_example; // String | 

try {
    final result = api_instance.getHealthcareProfessionalsOverview(institutionId);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getHealthcareProfessionalsOverview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **institutionId** | **String**|  | [optional] 

### Return type

[**HealthcareProfessionalsOverviewDTO**](HealthcareProfessionalsOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientById**
> PatientOverviewDTO getPatientById(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getPatientById(id);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getPatientById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PatientOverviewDTO**](PatientOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientCheckMarks**
> List<bool> getPatientCheckMarks(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getPatientCheckMarks(id);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getPatientCheckMarks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

**List<bool>**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientNotes**
> PatientNotesDTO getPatientNotes(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getPatientNotes(id);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getPatientNotes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PatientNotesDTO**](PatientNotesDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientUserCountByHealthcareProfessionalId**
> InstitutionCountDTO getPatientUserCountByHealthcareProfessionalId(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getPatientUserCountByHealthcareProfessionalId(id);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getPatientUserCountByHealthcareProfessionalId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**InstitutionCountDTO**](InstitutionCountDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientsOverview**
> PatientsOverviewDTO getPatientsOverview(healthcareProfessionalId)

getPatientsOverview

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final healthcareProfessionalId = healthcareProfessionalId_example; // String | 

try {
    final result = api_instance.getPatientsOverview(healthcareProfessionalId);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getPatientsOverview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **healthcareProfessionalId** | **String**|  | [optional] 

### Return type

[**PatientsOverviewDTO**](PatientsOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserPictureById**
> FileGetDTO getUserPictureById(id, userRole)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final userRole = ; // UserRole | 

try {
    final result = api_instance.getUserPictureById(id, userRole);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getUserPictureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userRole** | [**UserRole**](.md)|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestHealthDataChange**
> requestHealthDataChange(healthDataChangeDTO)

requestHealthDataChange

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final healthDataChangeDTO = HealthDataChangeDTO(); // HealthDataChangeDTO | 

try {
    api_instance.requestHealthDataChange(healthDataChangeDTO);
} catch (e) {
    print('Exception when calling UserControllerApi->requestHealthDataChange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **healthDataChangeDTO** | [**HealthDataChangeDTO**](HealthDataChangeDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestProfileDeletion**
> requestProfileDeletion()

requestProfileDeletion

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();

try {
    api_instance.requestProfileDeletion();
} catch (e) {
    print('Exception when calling UserControllerApi->requestProfileDeletion: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendPatientWelcomeMail**
> sendPatientWelcomeMail(id)

sendPatientWelcomeMail

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 

try {
    api_instance.sendPatientWelcomeMail(id);
} catch (e) {
    print('Exception when calling UserControllerApi->sendPatientWelcomeMail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storePatientCheckMarks**
> storePatientCheckMarks(id, requestBody)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final requestBody = [List<bool>()]; // List<bool> | 

try {
    api_instance.storePatientCheckMarks(id, requestBody);
} catch (e) {
    print('Exception when calling UserControllerApi->storePatientCheckMarks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **requestBody** | [**List<bool>**](bool.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storePatientNotes**
> storePatientNotes(id, patientNotesDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final patientNotesDTO = PatientNotesDTO(); // PatientNotesDTO | 

try {
    api_instance.storePatientNotes(id, patientNotesDTO);
} catch (e) {
    print('Exception when calling UserControllerApi->storePatientNotes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **patientNotesDTO** | [**PatientNotesDTO**](PatientNotesDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storePatientState**
> storePatientState(id, patientStateDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final patientStateDTO = PatientStateDTO(); // PatientStateDTO | 

try {
    api_instance.storePatientState(id, patientStateDTO);
} catch (e) {
    print('Exception when calling UserControllerApi->storePatientState: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **patientStateDTO** | [**PatientStateDTO**](PatientStateDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateHealthcareProfessional**
> HealthcareProfessionalGetDTO updateHealthcareProfessional(id, healthcareProfessionalPostDTO)

updateHealthcareProfessional

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final healthcareProfessionalPostDTO = HealthcareProfessionalPostDTO(); // HealthcareProfessionalPostDTO | 

try {
    final result = api_instance.updateHealthcareProfessional(id, healthcareProfessionalPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->updateHealthcareProfessional: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **healthcareProfessionalPostDTO** | [**HealthcareProfessionalPostDTO**](HealthcareProfessionalPostDTO.md)|  | 

### Return type

[**HealthcareProfessionalGetDTO**](HealthcareProfessionalGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePatient**
> PatientGetDTO updatePatient(id, patientPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final patientPostDTO = PatientPostDTO(); // PatientPostDTO | 

try {
    final result = api_instance.updatePatient(id, patientPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->updatePatient: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **patientPostDTO** | [**PatientPostDTO**](PatientPostDTO.md)|  | 

### Return type

[**PatientGetDTO**](PatientGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadUserPictureById**
> FileGetDTO uploadUserPictureById(id, userRole, pictureFile)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = UserControllerApi();
final id = id_example; // String | 
final userRole = ; // UserRole | 
final pictureFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadUserPictureById(id, userRole, pictureFile);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->uploadUserPictureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userRole** | [**UserRole**](.md)|  | 
 **pictureFile** | **MultipartFile**|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

