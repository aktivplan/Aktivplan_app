# apt_api.model.PatientPostDTO

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**homeLocation** | [**LocationDTO**](LocationDTO.md) |  | [optional] 
**homeLocationAddress** | **String** |  | [optional] 
**workLocation** | [**LocationDTO**](LocationDTO.md) |  | [optional] 
**workLocationAddress** | **String** |  | [optional] 
**heatTolerance** | [**HeatTolerance**](HeatTolerance.md) |  | [optional] 
**mobilityPreferences** | [**List<MobilityPreference>**](MobilityPreference.md) |  | [optional] [default to const []]
**dislikedMobilityPreferences** | [**List<MobilityPreference>**](MobilityPreference.md) |  | [optional] [default to const []]
**preferredActivities** | [**List<PredefinedActivityType>**](PredefinedActivityType.md) |  | [optional] [default to const []]
**dislikedActivities** | [**List<PredefinedActivityType>**](PredefinedActivityType.md) |  | [optional] [default to const []]
**email** | **String** |  | [optional] 
**institutionId** | **String** |  | [optional] 
**healthcareProfessionalId** | **String** |  | [optional] 
**firstName** | **String** |  | [optional] 
**lastName** | **String** |  | [optional] 
**birthDate** | **String** |  | [optional] 
**height** | **int** |  | [optional] 
**weight** | **int** |  | [optional] 
**activityClass** | **int** |  | [optional] 
**maximumHeartRate** | **int** |  | [optional] 
**maximumBloodPressure** | **String** |  | [optional] 
**maximumPerformance** | **double** |  | [optional] 
**maximumOxygenConsumption** | **double** |  | [optional] 
**diseases** | **String** |  | [optional] 
**medication** | **String** |  | [optional] 
**participantId** | **String** |  | [optional] 
**surgeryDate** | **String** |  | [optional] 
**surgeryTime** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


