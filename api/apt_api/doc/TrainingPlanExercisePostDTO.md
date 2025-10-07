# apt_api.model.TrainingPlanExercisePostDTO

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | [**ActivityType**](ActivityType.md) |  | [optional] 
**enduranceExercise** | [**EnduranceExercisePostDTO**](EnduranceExercisePostDTO.md) |  | [optional] 
**intervalExercise** | [**IntervalExercisePostDTO**](IntervalExercisePostDTO.md) |  | [optional] 
**strengtheningExercise** | [**StrengtheningExercisePostDTO**](StrengtheningExercisePostDTO.md) |  | [optional] 
**otherExercise** | [**OtherExercisePostDTO**](OtherExercisePostDTO.md) |  | [optional] 
**workout** | [**WorkoutPostDTO**](WorkoutPostDTO.md) |  | [optional] 
**appointment** | [**AppointmentPostDTO**](AppointmentPostDTO.md) |  | [optional] 
**task** | [**TaskPostDTO**](TaskPostDTO.md) |  | [optional] 
**days** | [**List<DayOfWeek>**](DayOfWeek.md) |  | [optional] [default to const []]
**time** | **String** |  | [optional] 
**repeats** | [**ActivityRepeat**](ActivityRepeat.md) |  | [optional] 
**repeatCount** | **int** |  | [optional] 
**startingWeek** | **int** |  | [optional] 
**datesToHide** | **List<String>** |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


