# apt_api.api.ExternalAppControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createExternalApp**](ExternalAppControllerApi.md#createexternalapp) | **POST** /external-apps | createExternalApp
[**deleteExternalApp**](ExternalAppControllerApi.md#deleteexternalapp) | **DELETE** /external-apps/{id} | deleteExternalApp
[**getExternalAppById**](ExternalAppControllerApi.md#getexternalappbyid) | **GET** /external-apps/{id} | 
[**getExternalApps**](ExternalAppControllerApi.md#getexternalapps) | **GET** /external-apps | 
[**updateExternalApp**](ExternalAppControllerApi.md#updateexternalapp) | **PUT** /external-apps/{id} | updateExternalApp
[**updateExternalAppOrdering**](ExternalAppControllerApi.md#updateexternalappordering) | **PUT** /external-apps/templates/order | updateExternalAppOrdering


# **createExternalApp**
> ExternalApp createExternalApp(externalAppPostDTO)

createExternalApp

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExternalAppControllerApi();
final externalAppPostDTO = ExternalAppPostDTO(); // ExternalAppPostDTO | 

try {
    final result = api_instance.createExternalApp(externalAppPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ExternalAppControllerApi->createExternalApp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **externalAppPostDTO** | [**ExternalAppPostDTO**](ExternalAppPostDTO.md)|  | 

### Return type

[**ExternalApp**](ExternalApp.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteExternalApp**
> deleteExternalApp(id)

deleteExternalApp

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExternalAppControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteExternalApp(id);
} catch (e) {
    print('Exception when calling ExternalAppControllerApi->deleteExternalApp: $e\n');
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

# **getExternalAppById**
> ExternalAppDTO getExternalAppById(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExternalAppControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getExternalAppById(id);
    print(result);
} catch (e) {
    print('Exception when calling ExternalAppControllerApi->getExternalAppById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ExternalAppDTO**](ExternalAppDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getExternalApps**
> List<ExternalAppDTO> getExternalApps()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExternalAppControllerApi();

try {
    final result = api_instance.getExternalApps();
    print(result);
} catch (e) {
    print('Exception when calling ExternalAppControllerApi->getExternalApps: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ExternalAppDTO>**](ExternalAppDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateExternalApp**
> ExternalApp updateExternalApp(id, externalAppPostDTO)

updateExternalApp

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExternalAppControllerApi();
final id = id_example; // String | 
final externalAppPostDTO = ExternalAppPostDTO(); // ExternalAppPostDTO | 

try {
    final result = api_instance.updateExternalApp(id, externalAppPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ExternalAppControllerApi->updateExternalApp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **externalAppPostDTO** | [**ExternalAppPostDTO**](ExternalAppPostDTO.md)|  | 

### Return type

[**ExternalApp**](ExternalApp.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateExternalAppOrdering**
> List<ExternalApp> updateExternalAppOrdering(orderingDTO)

updateExternalAppOrdering

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExternalAppControllerApi();
final orderingDTO = OrderingDTO(); // OrderingDTO | 

try {
    final result = api_instance.updateExternalAppOrdering(orderingDTO);
    print(result);
} catch (e) {
    print('Exception when calling ExternalAppControllerApi->updateExternalAppOrdering: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderingDTO** | [**OrderingDTO**](OrderingDTO.md)|  | 

### Return type

[**List<ExternalApp>**](ExternalApp.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

