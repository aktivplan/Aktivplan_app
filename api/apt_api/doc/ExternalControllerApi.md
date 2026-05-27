# apt_api.api.ExternalControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createHealthData**](ExternalControllerApi.md#createhealthdata) | **POST** /external/health-data | 


# **createHealthData**
> HealthData createHealthData(healthDataPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExternalControllerApi();
final healthDataPostDTO = HealthDataPostDTO(); // HealthDataPostDTO | 

try {
    final result = api_instance.createHealthData(healthDataPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ExternalControllerApi->createHealthData: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **healthDataPostDTO** | [**HealthDataPostDTO**](HealthDataPostDTO.md)|  | 

### Return type

[**HealthData**](HealthData.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

