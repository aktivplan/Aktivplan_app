# apt_api.api.DatahubControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getRequestStructure**](DatahubControllerApi.md#getrequeststructure) | **GET** /datahub/request-structure | 
[**getTestRequestData**](DatahubControllerApi.md#gettestrequestdata) | **GET** /datahub/test-request/{patientId}/{date} | 
[**testRequest**](DatahubControllerApi.md#testrequest) | **POST** /datahub/test-request/{patientId}/{date} | 


# **getRequestStructure**
> DatahubRequestDataDTO getRequestStructure()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = DatahubControllerApi();

try {
    final result = api_instance.getRequestStructure();
    print(result);
} catch (e) {
    print('Exception when calling DatahubControllerApi->getRequestStructure: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DatahubRequestDataDTO**](DatahubRequestDataDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTestRequestData**
> DatahubRequestDataDTO getTestRequestData(patientId, date)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = DatahubControllerApi();
final patientId = patientId_example; // String | 
final date = date_example; // String | 

try {
    final result = api_instance.getTestRequestData(patientId, date);
    print(result);
} catch (e) {
    print('Exception when calling DatahubControllerApi->getTestRequestData: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | 
 **date** | **String**|  | 

### Return type

[**DatahubRequestDataDTO**](DatahubRequestDataDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **testRequest**
> DatahubResponse testRequest(patientId, date)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = DatahubControllerApi();
final patientId = patientId_example; // String | 
final date = date_example; // String | 

try {
    final result = api_instance.testRequest(patientId, date);
    print(result);
} catch (e) {
    print('Exception when calling DatahubControllerApi->testRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | 
 **date** | **String**|  | 

### Return type

[**DatahubResponse**](DatahubResponse.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

