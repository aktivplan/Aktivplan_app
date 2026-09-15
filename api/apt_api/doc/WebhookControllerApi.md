# apt_api.api.WebhookControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOrUpdateP2RCoach**](WebhookControllerApi.md#createorupdatep2rcoach) | **PUT** /webhooks/p2r/coach | createOrUpdateP2RCoach
[**createOrUpdateP2RPatient**](WebhookControllerApi.md#createorupdatep2rpatient) | **PUT** /webhooks/p2r/patient | createOrUpdateP2RPatient


# **createOrUpdateP2RCoach**
> HealthcareProfessionalGetDTO createOrUpdateP2RCoach(p2RCoachPostDTO)

createOrUpdateP2RCoach

ROLE_P2R_CLIENT - requires caatsId and institutionP2RFocus (for internally gathering institution) in request body

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WebhookControllerApi();
final p2RCoachPostDTO = P2RCoachPostDTO(); // P2RCoachPostDTO | 

try {
    final result = api_instance.createOrUpdateP2RCoach(p2RCoachPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling WebhookControllerApi->createOrUpdateP2RCoach: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **p2RCoachPostDTO** | [**P2RCoachPostDTO**](P2RCoachPostDTO.md)|  | 

### Return type

[**HealthcareProfessionalGetDTO**](HealthcareProfessionalGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createOrUpdateP2RPatient**
> PatientGetDTO createOrUpdateP2RPatient(p2RPatientPostDTO)

createOrUpdateP2RPatient

ROLE_P2R_CLIENT - requires caatsId and institutionP2RFocus (for internally gathering institution) in request body

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = WebhookControllerApi();
final p2RPatientPostDTO = P2RPatientPostDTO(); // P2RPatientPostDTO | 

try {
    final result = api_instance.createOrUpdateP2RPatient(p2RPatientPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling WebhookControllerApi->createOrUpdateP2RPatient: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **p2RPatientPostDTO** | [**P2RPatientPostDTO**](P2RPatientPostDTO.md)|  | 

### Return type

[**PatientGetDTO**](PatientGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

