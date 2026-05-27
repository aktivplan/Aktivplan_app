# apt_api.model.UserContactDetailDTO

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**fullName** | **String** |  | [optional] 
**lastActiveDateTime** | **String** |  | [optional] 
**statusMessage** | **String** |  | [optional] 
**profilePicture** | [**FileGetDTO**](FileGetDTO.md) |  | [optional] 
**shareActivityData** | **bool** |  | [optional] 
**shareActiveMinutes** | **bool** |  | [optional] 
**statusFileCount** | **int** |  | [optional] 
**activities** | [**List<ActivityOverviewDTO>**](ActivityOverviewDTO.md) |  | [optional] [default to const []]
**personalGoals** | [**List<PersonalGoal>**](PersonalGoal.md) |  | [optional] [default to const []]
**patient** | [**PatientOverviewDTO**](PatientOverviewDTO.md) |  | [optional] 
**activeMinutes** | [**List<ActiveMinutesOverviewDTO>**](ActiveMinutesOverviewDTO.md) |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


