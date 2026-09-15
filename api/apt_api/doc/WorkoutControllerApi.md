# apt_api.api.WorkoutControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createWorkout**](WorkoutControllerApi.md#createworkout) | **POST** /workouts | createWorkout
[**deleteWorkout**](WorkoutControllerApi.md#deleteworkout) | **DELETE** /workouts/{id} | deleteWorkout
[**deleteWorkoutVideoById**](WorkoutControllerApi.md#deleteworkoutvideobyid) | **DELETE** /workouts/video/{id} | deleteWorkoutVideoById
[**getWorkouts**](WorkoutControllerApi.md#getworkouts) | **GET** /workouts | 
[**updateWorkout**](WorkoutControllerApi.md#updateworkout) | **PUT** /workouts/{id} | updateWorkout
[**uploadWorkoutVideoById**](WorkoutControllerApi.md#uploadworkoutvideobyid) | **POST** /workouts/video/{id} | uploadWorkoutVideoById


# **createWorkout**
> Workout createWorkout(workoutPostDTO)

createWorkout

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WorkoutControllerApi();
final workoutPostDTO = WorkoutPostDTO(); // WorkoutPostDTO | 

try {
    final result = api_instance.createWorkout(workoutPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling WorkoutControllerApi->createWorkout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workoutPostDTO** | [**WorkoutPostDTO**](WorkoutPostDTO.md)|  | 

### Return type

[**Workout**](Workout.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteWorkout**
> deleteWorkout(id)

deleteWorkout

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WorkoutControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteWorkout(id);
} catch (e) {
    print('Exception when calling WorkoutControllerApi->deleteWorkout: $e\n');
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

# **deleteWorkoutVideoById**
> bool deleteWorkoutVideoById(id)

deleteWorkoutVideoById

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WorkoutControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.deleteWorkoutVideoById(id);
    print(result);
} catch (e) {
    print('Exception when calling WorkoutControllerApi->deleteWorkoutVideoById: $e\n');
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

# **getWorkouts**
> List<Workout> getWorkouts()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WorkoutControllerApi();

try {
    final result = api_instance.getWorkouts();
    print(result);
} catch (e) {
    print('Exception when calling WorkoutControllerApi->getWorkouts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Workout>**](Workout.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateWorkout**
> Workout updateWorkout(id, workoutPostDTO)

updateWorkout

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WorkoutControllerApi();
final id = id_example; // String | 
final workoutPostDTO = WorkoutPostDTO(); // WorkoutPostDTO | 

try {
    final result = api_instance.updateWorkout(id, workoutPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling WorkoutControllerApi->updateWorkout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **workoutPostDTO** | [**WorkoutPostDTO**](WorkoutPostDTO.md)|  | 

### Return type

[**Workout**](Workout.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadWorkoutVideoById**
> FileGetDTO uploadWorkoutVideoById(id, videoFile)

uploadWorkoutVideoById

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WorkoutControllerApi();
final id = id_example; // String | 
final videoFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadWorkoutVideoById(id, videoFile);
    print(result);
} catch (e) {
    print('Exception when calling WorkoutControllerApi->uploadWorkoutVideoById: $e\n');
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

