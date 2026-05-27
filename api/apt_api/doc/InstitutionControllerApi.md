# apt_api.api.InstitutionControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createInstitution**](InstitutionControllerApi.md#createinstitution) | **POST** /institutions | createInstitution
[**deleteInstitution**](InstitutionControllerApi.md#deleteinstitution) | **DELETE** /institutions/{id} | deleteInstitution
[**getInstitutionById**](InstitutionControllerApi.md#getinstitutionbyid) | **GET** /institutions/{id} | 
[**getInstitutionUserCountById**](InstitutionControllerApi.md#getinstitutionusercountbyid) | **GET** /institutions/{id}/user-count | 
[**getInstitutions**](InstitutionControllerApi.md#getinstitutions) | **GET** /institutions | getInstitutions
[**importExerciseData**](InstitutionControllerApi.md#importexercisedata) | **POST** /institutions/import-exercise-data | 
[**updateInstitution**](InstitutionControllerApi.md#updateinstitution) | **PUT** /institutions/{id} | updateInstitution


# **createInstitution**
> InstitutionDTO createInstitution(institutionPostDTO)

createInstitution

ADMINISTRATOR

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = InstitutionControllerApi();
final institutionPostDTO = InstitutionPostDTO(); // InstitutionPostDTO | 

try {
    final result = api_instance.createInstitution(institutionPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling InstitutionControllerApi->createInstitution: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **institutionPostDTO** | [**InstitutionPostDTO**](InstitutionPostDTO.md)|  | 

### Return type

[**InstitutionDTO**](InstitutionDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteInstitution**
> deleteInstitution(id)

deleteInstitution

ADMINISTRATOR

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = InstitutionControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteInstitution(id);
} catch (e) {
    print('Exception when calling InstitutionControllerApi->deleteInstitution: $e\n');
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

# **getInstitutionById**
> InstitutionDTO getInstitutionById(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = InstitutionControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getInstitutionById(id);
    print(result);
} catch (e) {
    print('Exception when calling InstitutionControllerApi->getInstitutionById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**InstitutionDTO**](InstitutionDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getInstitutionUserCountById**
> InstitutionCountDTO getInstitutionUserCountById(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = InstitutionControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getInstitutionUserCountById(id);
    print(result);
} catch (e) {
    print('Exception when calling InstitutionControllerApi->getInstitutionUserCountById: $e\n');
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

# **getInstitutions**
> List<InstitutionDTO> getInstitutions()

getInstitutions

ADMINISTRATOR

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = InstitutionControllerApi();

try {
    final result = api_instance.getInstitutions();
    print(result);
} catch (e) {
    print('Exception when calling InstitutionControllerApi->getInstitutions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<InstitutionDTO>**](InstitutionDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **importExerciseData**
> importExerciseData(institutionImportDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = InstitutionControllerApi();
final institutionImportDTO = InstitutionImportDTO(); // InstitutionImportDTO | 

try {
    api_instance.importExerciseData(institutionImportDTO);
} catch (e) {
    print('Exception when calling InstitutionControllerApi->importExerciseData: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **institutionImportDTO** | [**InstitutionImportDTO**](InstitutionImportDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateInstitution**
> InstitutionDTO updateInstitution(id, institutionPostDTO)

updateInstitution

ADMINISTRATOR

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = InstitutionControllerApi();
final id = id_example; // String | 
final institutionPostDTO = InstitutionPostDTO(); // InstitutionPostDTO | 

try {
    final result = api_instance.updateInstitution(id, institutionPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling InstitutionControllerApi->updateInstitution: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **institutionPostDTO** | [**InstitutionPostDTO**](InstitutionPostDTO.md)|  | 

### Return type

[**InstitutionDTO**](InstitutionDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

