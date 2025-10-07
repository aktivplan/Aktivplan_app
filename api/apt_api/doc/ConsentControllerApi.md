# apt_api.api.ConsentControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *https://aktivplan-plus.ap-stage.at*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getConsents**](ConsentControllerApi.md#getconsents) | **GET** /consents | 


# **getConsents**
> ConsentDataDTO getConsents(resetKey)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ConsentControllerApi();
final resetKey = resetKey_example; // String | 

try {
    final result = api_instance.getConsents(resetKey);
    print(result);
} catch (e) {
    print('Exception when calling ConsentControllerApi->getConsents: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetKey** | **String**|  | 

### Return type

[**ConsentDataDTO**](ConsentDataDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

