# apt_api.model.StrengtheningExercise

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**institutionId** | **String** |  | [optional] 
**importId** | **String** |  | [optional] 
**type** | [**ExerciseType**](ExerciseType.md) |  | [optional] 
**hint** | **Map<String, String>** |  | [optional] [default to const {}]
**name** | **Map<String, String>** |  | [optional] [default to const {}]
**youTubeUrl** | **Map<String, String>** |  | [optional] [default to const {}]
**videoFileKey** | **String** |  | [optional] 
**exerciseIntensityPercentageStart** | **int** |  | [optional] 
**exerciseIntensityPercentageEnd** | **int** |  | [optional] 
**exerciseTrainingHeartRateLowerLimit** | **int** |  | [optional] 
**exerciseTrainingHeartRateUpperLimit** | **int** |  | [optional] 
**exerciseDurationSeconds** | **int** |  | [optional] 
**exerciseRepeatCount** | **int** |  | [optional] 
**exerciseRepeatSets** | **int** |  | [optional] 
**exerciseBreakBetweenSetsDurationSeconds** | **int** |  | [optional] 
**muscleGroups** | [**List<StrengtheningExerciseMuscleGroup>**](StrengtheningExerciseMuscleGroup.md) |  | [optional] [default to const []]
**weight** | **int** |  | [optional] 
**needsEquipment** | **bool** |  | [optional] 
**hasRepeatCount** | **bool** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


