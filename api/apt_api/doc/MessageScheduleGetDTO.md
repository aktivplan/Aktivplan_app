# apt_api.model.MessageScheduleGetDTO

## Load the model package
```dart
import 'package:apt_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**sendToType** | [**MessageSendToType**](MessageSendToType.md) |  | 
**recipientIds** | **List<String>** |  | [optional] [default to const []]
**recipientsOfHealthcareProfessionalId** | **String** |  | [optional] 
**recipientsOfInstitutionId** | **String** |  | [optional] 
**subject** | **Map<String, String>** |  | [optional] [default to const {}]
**text** | **Map<String, String>** |  | [optional] [default to const {}]
**scheduleDateTime** | **String** | time to schedule in YYYY-MM-DDTHH:mm in UTC | [optional] 
**id** | **String** |  | [optional] 
**senderId** | **String** |  | [optional] 
**senderName** | **String** |  | [optional] 
**pictureId** | **Map<String, String>** |  | [optional] [default to const {}]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


