# apt_api.api.WidgetControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getKlimafitPlant**](WidgetControllerApi.md#getklimafitplant) | **GET** /widget/klimafit-plant | 
[**getKlimafitPlantForPatient**](WidgetControllerApi.md#getklimafitplantforpatient) | **GET** /widget/klimafit-plant/{patientId} | 
[**getKlimafitPlantForPatientPng**](WidgetControllerApi.md#getklimafitplantforpatientpng) | **GET** /widget/klimafit-plant/{patientId}/png | 
[**getPatientDailyActivities**](WidgetControllerApi.md#getpatientdailyactivities) | **GET** /widget/daily-activities/{patientId} | 
[**getPatientDailyActivitiesPng**](WidgetControllerApi.md#getpatientdailyactivitiespng) | **GET** /widget/daily-activities/{patientId}/png | 


# **getKlimafitPlant**
> String getKlimafitPlant(numberOfDays, activityPointsActivity, activityPointsActiveMobility, isProfileView)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WidgetControllerApi();
final numberOfDays = 56; // int | 
final activityPointsActivity = 56; // int | 
final activityPointsActiveMobility = 56; // int | 
final isProfileView = true; // bool | 

try {
    final result = api_instance.getKlimafitPlant(numberOfDays, activityPointsActivity, activityPointsActiveMobility, isProfileView);
    print(result);
} catch (e) {
    print('Exception when calling WidgetControllerApi->getKlimafitPlant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **numberOfDays** | **int**|  | [optional] [default to 1]
 **activityPointsActivity** | **int**|  | [optional] [default to 50]
 **activityPointsActiveMobility** | **int**|  | [optional] [default to 0]
 **isProfileView** | **bool**|  | [optional] [default to false]

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/svg+xml

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getKlimafitPlantForPatient**
> String getKlimafitPlantForPatient(patientId, isProfileView)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WidgetControllerApi();
final patientId = patientId_example; // String | 
final isProfileView = true; // bool | 

try {
    final result = api_instance.getKlimafitPlantForPatient(patientId, isProfileView);
    print(result);
} catch (e) {
    print('Exception when calling WidgetControllerApi->getKlimafitPlantForPatient: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | 
 **isProfileView** | **bool**|  | [optional] [default to false]

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/svg+xml

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getKlimafitPlantForPatientPng**
> String getKlimafitPlantForPatientPng(patientId, isProfileView)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WidgetControllerApi();
final patientId = patientId_example; // String | 
final isProfileView = true; // bool | 

try {
    final result = api_instance.getKlimafitPlantForPatientPng(patientId, isProfileView);
    print(result);
} catch (e) {
    print('Exception when calling WidgetControllerApi->getKlimafitPlantForPatientPng: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | 
 **isProfileView** | **bool**|  | [optional] [default to false]

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/png

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientDailyActivities**
> String getPatientDailyActivities(patientId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WidgetControllerApi();
final patientId = patientId_example; // String | 

try {
    final result = api_instance.getPatientDailyActivities(patientId);
    print(result);
} catch (e) {
    print('Exception when calling WidgetControllerApi->getPatientDailyActivities: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | 

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/svg+xml

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientDailyActivitiesPng**
> String getPatientDailyActivitiesPng(patientId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WidgetControllerApi();
final patientId = patientId_example; // String | 

try {
    final result = api_instance.getPatientDailyActivitiesPng(patientId);
    print(result);
} catch (e) {
    print('Exception when calling WidgetControllerApi->getPatientDailyActivitiesPng: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | 

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/png

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

