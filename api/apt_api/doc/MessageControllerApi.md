# apt_api.api.MessageControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *https://aktivplan-plus.ap-stage.at*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createInformationTemplate**](MessageControllerApi.md#createinformationtemplate) | **POST** /messages/templates/INFORMATION | createInformationTemplate
[**deleteInformationTemplate**](MessageControllerApi.md#deleteinformationtemplate) | **DELETE** /messages/templates/INFORMATION/{id} | deleteInformationTemplate
[**deleteMessagePicture**](MessageControllerApi.md#deletemessagepicture) | **DELETE** /messages/schedule/{type}/{id}/picture | deleteMessagePicture
[**deleteScheduledMessage**](MessageControllerApi.md#deletescheduledmessage) | **DELETE** /messages/schedule/{id} | deleteScheduledMessage
[**deleteSentMessage**](MessageControllerApi.md#deletesentmessage) | **DELETE** /messages/sent/{messageId} | deleteSentMessage
[**getInformationTemplateById**](MessageControllerApi.md#getinformationtemplatebyid) | **GET** /messages/templates/INFORMATION/{id} | 
[**getInformationTemplates**](MessageControllerApi.md#getinformationtemplates) | **GET** /messages/templates/INFORMATION | 
[**getMessageCount**](MessageControllerApi.md#getmessagecount) | **GET** /messages/count | getMessageCount
[**getMessageHistory**](MessageControllerApi.md#getmessagehistory) | **GET** /messages/history | getMessageHistory
[**getMessagePicture**](MessageControllerApi.md#getmessagepicture) | **GET** /messages/picture | 
[**getMessageReceiverNames**](MessageControllerApi.md#getmessagereceivernames) | **GET** /messages/receiver-names | 
[**getMessages**](MessageControllerApi.md#getmessages) | **GET** /messages | getMessages
[**markMessagesRead**](MessageControllerApi.md#markmessagesread) | **POST** /messages/read | markMessagesRead
[**schedulePersonalMessage**](MessageControllerApi.md#schedulepersonalmessage) | **POST** /messages/schedule | schedulePersonalMessage
[**sendScheduledMessage**](MessageControllerApi.md#sendscheduledmessage) | **POST** /messages/schedule/send/{id} | sendScheduledMessage
[**sendSocialMessage**](MessageControllerApi.md#sendsocialmessage) | **POST** /messages/social/send | sendSocialMessage
[**updateInformationTemplate**](MessageControllerApi.md#updateinformationtemplate) | **PUT** /messages/templates/INFORMATION/{id} | updateInformationTemplate
[**updateScheduledMessage**](MessageControllerApi.md#updatescheduledmessage) | **POST** /messages/schedule/update | updateScheduledMessage
[**updateSentMessage**](MessageControllerApi.md#updatesentmessage) | **PUT** /messages/sent | updateSentMessage
[**uploadInformationTemplatePictureById**](MessageControllerApi.md#uploadinformationtemplatepicturebyid) | **POST** /messages/templates/INFORMATION/{id}/picture | uploadUserPictureById
[**uploadMessagePictureById**](MessageControllerApi.md#uploadmessagepicturebyid) | **POST** /messages/sent/{id}/picture | uploadMessagePictureById
[**uploadScheduledMessagePictureById**](MessageControllerApi.md#uploadscheduledmessagepicturebyid) | **POST** /messages/schedule/PERSONAL/{id}/picture | uploadScheduledMessagePictureById
[**uploadSocialMessagePictureById**](MessageControllerApi.md#uploadsocialmessagepicturebyid) | **POST** /messages/social/picture/{id} | uploadSocialMessagePictureById


# **createInformationTemplate**
> MessageTemplate createInformationTemplate(messageTemplatePostDTO)

createInformationTemplate

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final messageTemplatePostDTO = MessageTemplatePostDTO(); // MessageTemplatePostDTO | 

try {
    final result = api_instance.createInformationTemplate(messageTemplatePostDTO);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->createInformationTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **messageTemplatePostDTO** | [**MessageTemplatePostDTO**](MessageTemplatePostDTO.md)|  | 

### Return type

[**MessageTemplate**](MessageTemplate.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteInformationTemplate**
> deleteInformationTemplate(id)

deleteInformationTemplate

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 

try {
    api_instance.deleteInformationTemplate(id);
} catch (e) {
    print('Exception when calling MessageControllerApi->deleteInformationTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMessagePicture**
> bool deleteMessagePicture(type, id, pictureId)

deleteMessagePicture

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final type = ; // MessageType | 
final id = id_example; // String | 
final pictureId = pictureId_example; // String | 

try {
    final result = api_instance.deleteMessagePicture(type, id, pictureId);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->deleteMessagePicture: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | [**MessageType**](.md)|  | 
 **id** | **String**|  | 
 **pictureId** | **String**|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteScheduledMessage**
> deleteScheduledMessage(id, patientId)

deleteScheduledMessage

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 
final patientId = patientId_example; // String | 

try {
    api_instance.deleteScheduledMessage(id, patientId);
} catch (e) {
    print('Exception when calling MessageControllerApi->deleteScheduledMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **patientId** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSentMessage**
> deleteSentMessage(messageId, deleteAll)

deleteSentMessage

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final messageId = messageId_example; // String | 
final deleteAll = true; // bool | 

try {
    api_instance.deleteSentMessage(messageId, deleteAll);
} catch (e) {
    print('Exception when calling MessageControllerApi->deleteSentMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **messageId** | **String**|  | 
 **deleteAll** | **bool**|  | [optional] [default to false]

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getInformationTemplateById**
> MessageTemplateDTO getInformationTemplateById(id)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.getInformationTemplateById(id);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->getInformationTemplateById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**MessageTemplateDTO**](MessageTemplateDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getInformationTemplates**
> List<MessageTemplateDTO> getInformationTemplates()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();

try {
    final result = api_instance.getInformationTemplates();
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->getInformationTemplates: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<MessageTemplateDTO>**](MessageTemplateDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessageCount**
> MessageCountDTO getMessageCount()

getMessageCount

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();

try {
    final result = api_instance.getMessageCount();
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->getMessageCount: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MessageCountDTO**](MessageCountDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessageHistory**
> MessageHistoryDTO getMessageHistory(patientId)

getMessageHistory

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final patientId = patientId_example; // String | 

try {
    final result = api_instance.getMessageHistory(patientId);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->getMessageHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patientId** | **String**|  | [optional] [default to '']

### Return type

[**MessageHistoryDTO**](MessageHistoryDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessagePicture**
> FileGetDTO getMessagePicture(type, pictureId)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final type = ; // MessageType | 
final pictureId = pictureId_example; // String | 

try {
    final result = api_instance.getMessagePicture(type, pictureId);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->getMessagePicture: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | [**MessageType**](.md)|  | 
 **pictureId** | **String**|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessageReceiverNames**
> List<MessageReceiverNameDTO> getMessageReceiverNames()



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();

try {
    final result = api_instance.getMessageReceiverNames();
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->getMessageReceiverNames: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<MessageReceiverNameDTO>**](MessageReceiverNameDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessages**
> MessageOverviewDTO getMessages(page, size)

getMessages

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final page = 56; // int | 
final size = 56; // int | 

try {
    final result = api_instance.getMessages(page, size);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->getMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 200]

### Return type

[**MessageOverviewDTO**](MessageOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markMessagesRead**
> markMessagesRead()

markMessagesRead

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();

try {
    api_instance.markMessagesRead();
} catch (e) {
    print('Exception when calling MessageControllerApi->markMessagesRead: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **schedulePersonalMessage**
> MessageSchedule schedulePersonalMessage(messageSchedulePostDTO)

schedulePersonalMessage

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final messageSchedulePostDTO = MessageSchedulePostDTO(); // MessageSchedulePostDTO | 

try {
    final result = api_instance.schedulePersonalMessage(messageSchedulePostDTO);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->schedulePersonalMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **messageSchedulePostDTO** | [**MessageSchedulePostDTO**](MessageSchedulePostDTO.md)|  | 

### Return type

[**MessageSchedule**](MessageSchedule.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendScheduledMessage**
> sendScheduledMessage(id)

sendScheduledMessage

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 

try {
    api_instance.sendScheduledMessage(id);
} catch (e) {
    print('Exception when calling MessageControllerApi->sendScheduledMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendSocialMessage**
> MessageGetDTO sendSocialMessage(socialMessagePostDTO)

sendSocialMessage

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final socialMessagePostDTO = SocialMessagePostDTO(); // SocialMessagePostDTO | 

try {
    final result = api_instance.sendSocialMessage(socialMessagePostDTO);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->sendSocialMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **socialMessagePostDTO** | [**SocialMessagePostDTO**](SocialMessagePostDTO.md)|  | 

### Return type

[**MessageGetDTO**](MessageGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateInformationTemplate**
> MessageTemplate updateInformationTemplate(id, messageTemplatePostDTO)

updateInformationTemplate

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 
final messageTemplatePostDTO = MessageTemplatePostDTO(); // MessageTemplatePostDTO | 

try {
    final result = api_instance.updateInformationTemplate(id, messageTemplatePostDTO);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->updateInformationTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **messageTemplatePostDTO** | [**MessageTemplatePostDTO**](MessageTemplatePostDTO.md)|  | 

### Return type

[**MessageTemplate**](MessageTemplate.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateScheduledMessage**
> updateScheduledMessage(messageSchedulePutDTO)

updateScheduledMessage

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final messageSchedulePutDTO = MessageSchedulePutDTO(); // MessageSchedulePutDTO | 

try {
    api_instance.updateScheduledMessage(messageSchedulePutDTO);
} catch (e) {
    print('Exception when calling MessageControllerApi->updateScheduledMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **messageSchedulePutDTO** | [**MessageSchedulePutDTO**](MessageSchedulePutDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSentMessage**
> updateSentMessage(messagePutDTO)

updateSentMessage

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final messagePutDTO = MessagePutDTO(); // MessagePutDTO | 

try {
    api_instance.updateSentMessage(messagePutDTO);
} catch (e) {
    print('Exception when calling MessageControllerApi->updateSentMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **messagePutDTO** | [**MessagePutDTO**](MessagePutDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadInformationTemplatePictureById**
> FileGetDTO uploadInformationTemplatePictureById(id, language, pictureFile)

uploadUserPictureById

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 
final language = ; // TranslationLanguage | 
final pictureFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadInformationTemplatePictureById(id, language, pictureFile);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->uploadInformationTemplatePictureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **language** | [**TranslationLanguage**](.md)|  | 
 **pictureFile** | **MultipartFile**|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadMessagePictureById**
> FileGetDTO uploadMessagePictureById(id, pictureFile)

uploadMessagePictureById

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 
final pictureFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadMessagePictureById(id, pictureFile);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->uploadMessagePictureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **pictureFile** | **MultipartFile**|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadScheduledMessagePictureById**
> FileGetDTO uploadScheduledMessagePictureById(id, language, pictureFile)

uploadScheduledMessagePictureById

ADMINISTRATOR | INSTITUTION_ADMINISTRATOR | HEALTHCARE_PROFESSIONAL

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 
final language = ; // TranslationLanguage | 
final pictureFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadScheduledMessagePictureById(id, language, pictureFile);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->uploadScheduledMessagePictureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **language** | [**TranslationLanguage**](.md)|  | 
 **pictureFile** | **MultipartFile**|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadSocialMessagePictureById**
> FileGetDTO uploadSocialMessagePictureById(id, pictureFile)

uploadSocialMessagePictureById

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = MessageControllerApi();
final id = id_example; // String | 
final pictureFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadSocialMessagePictureById(id, pictureFile);
    print(result);
} catch (e) {
    print('Exception when calling MessageControllerApi->uploadSocialMessagePictureById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **pictureFile** | **MultipartFile**|  | 

### Return type

[**FileGetDTO**](FileGetDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

