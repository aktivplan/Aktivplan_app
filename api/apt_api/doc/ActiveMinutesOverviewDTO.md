# apt_api.model.ActiveMinutesOverviewDTO

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**activeMinutes** | [**Map<String, ActiveMinutesDTO>**](ActiveMinutesDTO.md) | WEEK: key values are DayOfWeek-Enum-Keys, MONTH: key values are calendar week numbers, ALL: key values are month numbers | [optional] [default to const {}]
**hasPreviousEntry** | **bool** |  | [optional] 
**hasNextEntry** | **bool** |  | [optional] 
**startDate** | **String** |  | [optional] 
**endDate** | **String** |  | [optional] 
**durationMinutesActive** | **int** |  | [optional] 
**durationMinutes** | **int** |  | [optional] 
**averageMinutesPerWeek** | **int** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


