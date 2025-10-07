# apt_api.api.TrainingPlanControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *https://aktivplan-plus.ap-stage.at*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createTrainingPlan**](TrainingPlanControllerApi.md#createtrainingplan) | **POST** /training-plans | createTrainingPlan
[**deleteTrainingPlan**](TrainingPlanControllerApi.md#deletetrainingplan) | **DELETE** /training-plans/{id} | deleteTrainingPlan
[**getTrainingPlan**](TrainingPlanControllerApi.md#gettrainingplan) | **GET** /training-plans/{id} | 
[**getTrainingPlans**](TrainingPlanControllerApi.md#gettrainingplans) | **GET** /training-plans | 
[**updateTrainingPlan**](TrainingPlanControllerApi.md#updatetrainingplan) | **PUT** /training-plans/{id} | updateTrainingPlan


# **createTrainingPlan**
> TrainingPlan createTrainingPlan(trainingPlanPostDTO)

createTrainingPlan

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = TrainingPlanControllerApi();
final trainingPlanPostDTO = TrainingPlanPostDTO(); // TrainingPlanPostDTO | 

try {
    final result = api_instance.createTrainingPlan(trainingPlanPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling TrainingPlanControllerApi->createTrainingPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **trainingPlanPostDTO** | [**TrainingPlanPostDTO**](TrainingPlanPostDTO.md)|  | 

### Return type

[**TrainingPlan**](TrainingPlan.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTrainingPlan**
> deleteTrainingPlan(id)

deleteTrainingPlan

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = TrainingPlanControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteTrainingPlan(id);
} catch (e) {
    print('Exception when calling TrainingPlanControllerApi->deleteTrainingPlan: $e\n');
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

# **getTrainingPlan**
> TrainingPlanPostDTO getTrainingPlan(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = TrainingPlanControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getTrainingPlan(id);
    print(result);
} catch (e) {
    print('Exception when calling TrainingPlanControllerApi->getTrainingPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TrainingPlanPostDTO**](TrainingPlanPostDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTrainingPlans**
> List<TrainingPlanOverviewDTO> getTrainingPlans()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = TrainingPlanControllerApi();

try {
    final result = api_instance.getTrainingPlans();
    print(result);
} catch (e) {
    print('Exception when calling TrainingPlanControllerApi->getTrainingPlans: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<TrainingPlanOverviewDTO>**](TrainingPlanOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTrainingPlan**
> TrainingPlan updateTrainingPlan(id, trainingPlanPostDTO)

updateTrainingPlan

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = TrainingPlanControllerApi();
final id = id_example; // String | 
final trainingPlanPostDTO = TrainingPlanPostDTO(); // TrainingPlanPostDTO | 

try {
    final result = api_instance.updateTrainingPlan(id, trainingPlanPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling TrainingPlanControllerApi->updateTrainingPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **trainingPlanPostDTO** | [**TrainingPlanPostDTO**](TrainingPlanPostDTO.md)|  | 

### Return type

[**TrainingPlan**](TrainingPlan.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

