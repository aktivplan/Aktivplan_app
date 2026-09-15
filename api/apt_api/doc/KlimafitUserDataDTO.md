# apt_api.model.KlimafitUserDataDTO

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

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


