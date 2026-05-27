# apt_api.api.WidgetControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getKlimafitPlant**](WidgetControllerApi.md#getklimafitplant) | **GET** /widget/klimafit-plant | 


# **getKlimafitPlant**
> String getKlimafitPlant(numberOfDays, activityPointsActivity, activityPointsActiveMobility)



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

try {
    final result = api_instance.getKlimafitPlant(numberOfDays, activityPointsActivity, activityPointsActiveMobility);
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

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/svg+xml

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

