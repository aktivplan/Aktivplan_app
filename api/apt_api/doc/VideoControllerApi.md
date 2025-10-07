# apt_api.api.VideoControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *https://aktivplan-plus.ap-stage.at*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createVideoTemplate**](VideoControllerApi.md#createvideotemplate) | **POST** /videos/templates | createVideoTemplate
[**deleteVideoTemplate**](VideoControllerApi.md#deletevideotemplate) | **DELETE** /videos/templates/{id} | deleteVideoTemplate
[**getVideoTemplateById**](VideoControllerApi.md#getvideotemplatebyid) | **GET** /videos/templates/{id} | 
[**getVideoTemplates**](VideoControllerApi.md#getvideotemplates) | **GET** /videos/templates | 
[**updateVideoTemplate**](VideoControllerApi.md#updatevideotemplate) | **PUT** /videos/templates/{id} | updateVideoTemplate
[**updateVideoTemplateOrdering**](VideoControllerApi.md#updatevideotemplateordering) | **PUT** /videos/templates/order | updateVideoTemplateOrdering


# **createVideoTemplate**
> VideoTemplate createVideoTemplate(videoTemplatePostDTO)

createVideoTemplate

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = VideoControllerApi();
final videoTemplatePostDTO = VideoTemplatePostDTO(); // VideoTemplatePostDTO | 

try {
    final result = api_instance.createVideoTemplate(videoTemplatePostDTO);
    print(result);
} catch (e) {
    print('Exception when calling VideoControllerApi->createVideoTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **videoTemplatePostDTO** | [**VideoTemplatePostDTO**](VideoTemplatePostDTO.md)|  | 

### Return type

[**VideoTemplate**](VideoTemplate.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteVideoTemplate**
> deleteVideoTemplate(id)

deleteVideoTemplate

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = VideoControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteVideoTemplate(id);
} catch (e) {
    print('Exception when calling VideoControllerApi->deleteVideoTemplate: $e\n');
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

# **getVideoTemplateById**
> VideoTemplateDTO getVideoTemplateById(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = VideoControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getVideoTemplateById(id);
    print(result);
} catch (e) {
    print('Exception when calling VideoControllerApi->getVideoTemplateById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**VideoTemplateDTO**](VideoTemplateDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVideoTemplates**
> List<VideoTemplateDTO> getVideoTemplates()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = VideoControllerApi();

try {
    final result = api_instance.getVideoTemplates();
    print(result);
} catch (e) {
    print('Exception when calling VideoControllerApi->getVideoTemplates: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<VideoTemplateDTO>**](VideoTemplateDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateVideoTemplate**
> VideoTemplate updateVideoTemplate(id, videoTemplatePostDTO)

updateVideoTemplate

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = VideoControllerApi();
final id = id_example; // String | 
final videoTemplatePostDTO = VideoTemplatePostDTO(); // VideoTemplatePostDTO | 

try {
    final result = api_instance.updateVideoTemplate(id, videoTemplatePostDTO);
    print(result);
} catch (e) {
    print('Exception when calling VideoControllerApi->updateVideoTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **videoTemplatePostDTO** | [**VideoTemplatePostDTO**](VideoTemplatePostDTO.md)|  | 

### Return type

[**VideoTemplate**](VideoTemplate.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateVideoTemplateOrdering**
> List<VideoTemplate> updateVideoTemplateOrdering(orderingDTO)

updateVideoTemplateOrdering

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = VideoControllerApi();
final orderingDTO = OrderingDTO(); // OrderingDTO | 

try {
    final result = api_instance.updateVideoTemplateOrdering(orderingDTO);
    print(result);
} catch (e) {
    print('Exception when calling VideoControllerApi->updateVideoTemplateOrdering: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderingDTO** | [**OrderingDTO**](OrderingDTO.md)|  | 

### Return type

[**List<VideoTemplate>**](VideoTemplate.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

