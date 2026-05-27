# apt_api.api.ActivityControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createActivity**](ActivityControllerApi.md#createactivity) | **POST** /activities | 
[**createExtraActivity**](ActivityControllerApi.md#createextraactivity) | **POST** /activities/EXTRA | createExtraActivity
[**createPersonalGoal**](ActivityControllerApi.md#createpersonalgoal) | **POST** /activities/personalGoals | 
[**deleteActivity**](ActivityControllerApi.md#deleteactivity) | **DELETE** /activities/{id} | 
[**deleteActivityVideoById**](ActivityControllerApi.md#deleteactivityvideobyid) | **DELETE** /activities/video/{id} | deleteActivityVideoById
[**deletePersonalGoal**](ActivityControllerApi.md#deletepersonalgoal) | **DELETE** /activities/personalGoals/{id} | 
[**getActiveMinutes**](ActivityControllerApi.md#getactiveminutes) | **GET** /activities/activeMinutes/{type} | 
[**getActivities**](ActivityControllerApi.md#getactivities) | **GET** /activities | 
[**getActivityNamesAutocomplete**](ActivityControllerApi.md#getactivitynamesautocomplete) | **GET** /activities/{type}/autocomplete | getActivityNamesAutocomplete
[**getActivityPercentageData**](ActivityControllerApi.md#getactivitypercentagedata) | **GET** /activities/active-minutes/percentage-data | 
[**getPersonalGoals**](ActivityControllerApi.md#getpersonalgoals) | **GET** /activities/personalGoals | 
[**hideActivity**](ActivityControllerApi.md#hideactivity) | **PUT** /activities/hide | 
[**moveActivity**](ActivityControllerApi.md#moveactivity) | **POST** /activities/move | 
[**movePersonalGoal**](ActivityControllerApi.md#movepersonalgoal) | **POST** /activities/personalGoals/move | 
[**updateActivity**](ActivityControllerApi.md#updateactivity) | **PUT** /activities/{id} | 
[**updateActivityRating**](ActivityControllerApi.md#updateactivityrating) | **PUT** /activities/{id}/{date} | updateActivityRating
[**updateExtraActivity**](ActivityControllerApi.md#updateextraactivity) | **PUT** /activities/EXTRA/{id} | updateExtraActivity
[**updatePersonalGoal**](ActivityControllerApi.md#updatepersonalgoal) | **PUT** /activities/personalGoals/{id} | 
[**uploadActivityVideoById**](ActivityControllerApi.md#uploadactivityvideobyid) | **POST** /activities/video/{id} | uploadActivityVideoById


# **createActivity**
> Activity createActivity(activityPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final activityPostDTO = ActivityPostDTO(); // ActivityPostDTO | 

try {
    final result = api_instance.createActivity(activityPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->createActivity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **activityPostDTO** | [**ActivityPostDTO**](ActivityPostDTO.md)|  | 

### Return type

[**Activity**](Activity.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createExtraActivity**
> ActivityOverviewDTO createExtraActivity(extraActivityPostDTO)

createExtraActivity

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final extraActivityPostDTO = ExtraActivityPostDTO(); // ExtraActivityPostDTO | 

try {
    final result = api_instance.createExtraActivity(extraActivityPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->createExtraActivity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **extraActivityPostDTO** | [**ExtraActivityPostDTO**](ExtraActivityPostDTO.md)|  | 

### Return type

[**ActivityOverviewDTO**](ActivityOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createPersonalGoal**
> PersonalGoal createPersonalGoal(personalGoalPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final personalGoalPostDTO = PersonalGoalPostDTO(); // PersonalGoalPostDTO | 

try {
    final result = api_instance.createPersonalGoal(personalGoalPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->createPersonalGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **personalGoalPostDTO** | [**PersonalGoalPostDTO**](PersonalGoalPostDTO.md)|  | 

### Return type

[**PersonalGoal**](PersonalGoal.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteActivity**
> deleteActivity(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteActivity(id);
} catch (e) {
    print('Exception when calling ActivityControllerApi->deleteActivity: $e\n');
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

# **deleteActivityVideoById**
> bool deleteActivityVideoById(id)

deleteActivityVideoById

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.deleteActivityVideoById(id);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->deleteActivityVideoById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePersonalGoal**
> deletePersonalGoal(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 

try {
    api_instance.deletePersonalGoal(id);
} catch (e) {
    print('Exception when calling ActivityControllerApi->deletePersonalGoal: $e\n');
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

# **getActiveMinutes**
> ActiveMinutesOverviewDTO getActiveMinutes(type, startDate, endDate, patientId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final type = ; // ActiveMinutesType | 
final startDate = startDate_example; // String | 
final endDate = endDate_example; // String | 
final patientId = patientId_example; // String | 

try {
    final result = api_instance.getActiveMinutes(type, startDate, endDate, patientId);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->getActiveMinutes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | [**ActiveMinutesType**](.md)|  | 
 **startDate** | **String**|  | 
 **endDate** | **String**|  | 
 **patientId** | **String**|  | [optional] 

### Return type

[**ActiveMinutesOverviewDTO**](ActiveMinutesOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getActivities**
> List<ActivityOverviewDTO> getActivities(startDate, endDate, patientId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final startDate = startDate_example; // String | 
final endDate = endDate_example; // String | 
final patientId = patientId_example; // String | 

try {
    final result = api_instance.getActivities(startDate, endDate, patientId);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->getActivities: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **String**|  | 
 **endDate** | **String**|  | 
 **patientId** | **String**|  | [optional] 

### Return type

[**List<ActivityOverviewDTO>**](ActivityOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getActivityNamesAutocomplete**
> ActivityAutocompleteGetDTO getActivityNamesAutocomplete(type)

getActivityNamesAutocomplete

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final type = ; // ActivityType | 

try {
    final result = api_instance.getActivityNamesAutocomplete(type);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->getActivityNamesAutocomplete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | [**ActivityType**](.md)|  | 

### Return type

[**ActivityAutocompleteGetDTO**](ActivityAutocompleteGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getActivityPercentageData**
> ActivityPercentageDataDTO getActivityPercentageData(date, patientId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final date = date_example; // String | 
final patientId = patientId_example; // String | 

try {
    final result = api_instance.getActivityPercentageData(date, patientId);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->getActivityPercentageData: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **String**|  | 
 **patientId** | **String**|  | [optional] 

### Return type

[**ActivityPercentageDataDTO**](ActivityPercentageDataDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPersonalGoals**
> List<PersonalGoal> getPersonalGoals(patientId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final patientId = patientId_example; // String | 

try {
    final result = api_instance.getPersonalGoals(patientId);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->getPersonalGoals: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | [optional] 

### Return type

[**List<PersonalGoal>**](PersonalGoal.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **hideActivity**
> hideActivity(hideActivityPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final hideActivityPostDTO = HideActivityPostDTO(); // HideActivityPostDTO | 

try {
    api_instance.hideActivity(hideActivityPostDTO);
} catch (e) {
    print('Exception when calling ActivityControllerApi->hideActivity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **hideActivityPostDTO** | [**HideActivityPostDTO**](HideActivityPostDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **moveActivity**
> Activity moveActivity(moveActivityPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final moveActivityPostDTO = MoveActivityPostDTO(); // MoveActivityPostDTO | 

try {
    final result = api_instance.moveActivity(moveActivityPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->moveActivity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **moveActivityPostDTO** | [**MoveActivityPostDTO**](MoveActivityPostDTO.md)|  | 

### Return type

[**Activity**](Activity.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **movePersonalGoal**
> PersonalGoal movePersonalGoal(movePersonalGoalPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final movePersonalGoalPostDTO = MovePersonalGoalPostDTO(); // MovePersonalGoalPostDTO | 

try {
    final result = api_instance.movePersonalGoal(movePersonalGoalPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->movePersonalGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **movePersonalGoalPostDTO** | [**MovePersonalGoalPostDTO**](MovePersonalGoalPostDTO.md)|  | 

### Return type

[**PersonalGoal**](PersonalGoal.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateActivity**
> Activity updateActivity(id, activityPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 
final activityPostDTO = ActivityPostDTO(); // ActivityPostDTO | 

try {
    final result = api_instance.updateActivity(id, activityPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->updateActivity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **activityPostDTO** | [**ActivityPostDTO**](ActivityPostDTO.md)|  | 

### Return type

[**Activity**](Activity.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateActivityRating**
> ActivityPatientRating updateActivityRating(id, date, activityPatientRatingPostDTO)

updateActivityRating

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 
final date = date_example; // String | 
final activityPatientRatingPostDTO = ActivityPatientRatingPostDTO(); // ActivityPatientRatingPostDTO | 

try {
    final result = api_instance.updateActivityRating(id, date, activityPatientRatingPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->updateActivityRating: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **date** | **String**|  | 
 **activityPatientRatingPostDTO** | [**ActivityPatientRatingPostDTO**](ActivityPatientRatingPostDTO.md)|  | 

### Return type

[**ActivityPatientRating**](ActivityPatientRating.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateExtraActivity**
> ActivityOverviewDTO updateExtraActivity(id, extraActivityPutDTO)

updateExtraActivity

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 
final extraActivityPutDTO = ExtraActivityPutDTO(); // ExtraActivityPutDTO | 

try {
    final result = api_instance.updateExtraActivity(id, extraActivityPutDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->updateExtraActivity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **extraActivityPutDTO** | [**ExtraActivityPutDTO**](ExtraActivityPutDTO.md)|  | 

### Return type

[**ActivityOverviewDTO**](ActivityOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePersonalGoal**
> PersonalGoal updatePersonalGoal(id, personalGoalPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 
final personalGoalPostDTO = PersonalGoalPostDTO(); // PersonalGoalPostDTO | 

try {
    final result = api_instance.updatePersonalGoal(id, personalGoalPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->updatePersonalGoal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **personalGoalPostDTO** | [**PersonalGoalPostDTO**](PersonalGoalPostDTO.md)|  | 

### Return type

[**PersonalGoal**](PersonalGoal.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadActivityVideoById**
> FileGetDTO uploadActivityVideoById(id, videoFile)

uploadActivityVideoById

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ActivityControllerApi();
final id = id_example; // String | 
final videoFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadActivityVideoById(id, videoFile);
    print(result);
} catch (e) {
    print('Exception when calling ActivityControllerApi->uploadActivityVideoById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **videoFile** | **MultipartFile**|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

