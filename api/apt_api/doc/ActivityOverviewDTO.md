# apt_api.model.ActivityOverviewDTO

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**activityId** | **String** |  | [optional] 
**date** | **String** |  | [optional] 
**time** | **String** |  | [optional] 
**name** | **Map<String, String>** |  | [optional] [default to const {}]
**durationMinutes** | **int** |  | [optional] 
**plannedDurationMinutes** | **int** |  | [optional] 
**type** | [**ActivityType**](ActivityType.md) |  | [optional] 
**repeats** | [**ActivityRepeat**](ActivityRepeat.md) |  | [optional] 
**healthcareProfessionalName** | **String** |  | [optional] 
**plannedBy** | **String** |  | [optional] 
**rating** | [**ActivityPatientRatingPostDTO**](ActivityPatientRatingPostDTO.md) |  | [optional] 
**activity** | [**ActivityPostDTO**](ActivityPostDTO.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


