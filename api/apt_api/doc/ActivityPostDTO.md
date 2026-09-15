# apt_api.model.ActivityPostDTO

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**plannedBy** | **String** |  | [optional] 
**patientId** | **String** |  | [optional] 
**startDate** | **String** |  | [optional] 
**endDate** | **String** |  | [optional] 
**time** | **String** |  | [optional] 
**endTime** | **String** |  | [optional] 
**workout** | [**WorkoutPostDTO**](WorkoutPostDTO.md) |  | [optional] 
**enduranceExercise** | [**EnduranceExercisePostDTO**](EnduranceExercisePostDTO.md) |  | [optional] 
**intervalExercise** | [**IntervalExercisePostDTO**](IntervalExercisePostDTO.md) |  | [optional] 
**strengtheningExercise** | [**StrengtheningExercisePostDTO**](StrengtheningExercisePostDTO.md) |  | [optional] 
**otherExercise** | [**OtherExercisePostDTO**](OtherExercisePostDTO.md) |  | [optional] 
**task** | [**TaskPostDTO**](TaskPostDTO.md) |  | [optional] 
**appointment** | [**AppointmentPostDTO**](AppointmentPostDTO.md) |  | [optional] 
**trainingPlan** | [**TrainingPlanPostDTO**](TrainingPlanPostDTO.md) |  | [optional] 
**predefinedActivity** | [**PredefinedActivityPostDTO**](PredefinedActivityPostDTO.md) |  | [optional] 
**days** | [**List<DayOfWeek>**](DayOfWeek.md) |  | [optional] [default to const []]
**repeats** | [**ActivityRepeat**](ActivityRepeat.md) |  | [optional] 
**repeatCount** | **int** |  | [optional] 
**name** | **Map<String, String>** |  | [optional] [default to const {}]
**youTubeUrl** | **Map<String, String>** |  | [optional] [default to const {}]
**videoFileKey** | **String** |  | [optional] 
**datesToHide** | **List<String>** |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


