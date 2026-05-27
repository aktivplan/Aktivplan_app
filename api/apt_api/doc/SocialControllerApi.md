# apt_api.api.SocialControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addContact**](SocialControllerApi.md#addcontact) | **POST** /social/contact/{userId} | addContact
[**deleteStatusFile**](SocialControllerApi.md#deletestatusfile) | **DELETE** /social/status/{id} | deleteStatusFile
[**getContactDetail**](SocialControllerApi.md#getcontactdetail) | **GET** /social/contact/{userId} | getContactDetail
[**getContactOverview**](SocialControllerApi.md#getcontactoverview) | **GET** /social/overview | getContactOverview
[**getStatusFiles**](SocialControllerApi.md#getstatusfiles) | **GET** /social/status/user/{userId} | getStatusFiles
[**markStatusFileSeen**](SocialControllerApi.md#markstatusfileseen) | **POST** /social/status/seen/{id} | markStatusFileSeen
[**removeContact**](SocialControllerApi.md#removecontact) | **DELETE** /social/contact/{userId} | removeContact
[**setShareActivityData**](SocialControllerApi.md#setshareactivitydata) | **POST** /social/shareActivityData | setShareActivityData
[**setStatusMessage**](SocialControllerApi.md#setstatusmessage) | **POST** /social/statusMessage | setStatusMessage
[**updateContactOrdering**](SocialControllerApi.md#updatecontactordering) | **PUT** /social/contact/ordering | updateContactOrdering
[**uploadStatusPicture**](SocialControllerApi.md#uploadstatuspicture) | **POST** /social/status/picture | uploadStatusPicture
[**uploadStatusText**](SocialControllerApi.md#uploadstatustext) | **PUT** /social/status/text | uploadStatusText


# **addContact**
> bool addContact(userId)

addContact

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final userId = userId_example; // String | 

try {
    final result = api_instance.addContact(userId);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->addContact: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteStatusFile**
> bool deleteStatusFile(id)

deleteStatusFile

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.deleteStatusFile(id);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->deleteStatusFile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContactDetail**
> UserContactDetailDTO getContactDetail(userId, startDate, endDate)

getContactDetail

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final userId = userId_example; // String | 
final startDate = startDate_example; // String | 
final endDate = endDate_example; // String | 

try {
    final result = api_instance.getContactDetail(userId, startDate, endDate);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->getContactDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **startDate** | **String**|  | 
 **endDate** | **String**|  | 

### Return type

[**UserContactDetailDTO**](UserContactDetailDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContactOverview**
> UserContactOverviewDTO getContactOverview()

getContactOverview

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();

try {
    final result = api_instance.getContactOverview();
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->getContactOverview: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserContactOverviewDTO**](UserContactOverviewDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatusFiles**
> List<StatusFileDTO> getStatusFiles(userId)

getStatusFiles

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final userId = userId_example; // String | 

try {
    final result = api_instance.getStatusFiles(userId);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->getStatusFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**List<StatusFileDTO>**](StatusFileDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markStatusFileSeen**
> StatusFileDTO markStatusFileSeen(id)

markStatusFileSeen

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final id = id_example; // String | 

try {
    final result = api_instance.markStatusFileSeen(id);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->markStatusFileSeen: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**StatusFileDTO**](StatusFileDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeContact**
> bool removeContact(userId)

removeContact

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final userId = userId_example; // String | 

try {
    final result = api_instance.removeContact(userId);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->removeContact: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

**bool**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setShareActivityData**
> setShareActivityData(shareActivityDataPostDTO)

setShareActivityData

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final shareActivityDataPostDTO = ShareActivityDataPostDTO(); // ShareActivityDataPostDTO | 

try {
    api_instance.setShareActivityData(shareActivityDataPostDTO);
} catch (e) {
    print('Exception when calling SocialControllerApi->setShareActivityData: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shareActivityDataPostDTO** | [**ShareActivityDataPostDTO**](ShareActivityDataPostDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setStatusMessage**
> setStatusMessage(statusMessagePostDTO)

setStatusMessage

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final statusMessagePostDTO = StatusMessagePostDTO(); // StatusMessagePostDTO | 

try {
    api_instance.setStatusMessage(statusMessagePostDTO);
} catch (e) {
    print('Exception when calling SocialControllerApi->setStatusMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statusMessagePostDTO** | [**StatusMessagePostDTO**](StatusMessagePostDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateContactOrdering**
> updateContactOrdering(orderingDTO)

updateContactOrdering

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final orderingDTO = OrderingDTO(); // OrderingDTO | 

try {
    api_instance.updateContactOrdering(orderingDTO);
} catch (e) {
    print('Exception when calling SocialControllerApi->updateContactOrdering: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderingDTO** | [**OrderingDTO**](OrderingDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadStatusPicture**
> StatusFileDTO uploadStatusPicture(pictureFile)

uploadStatusPicture

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final pictureFile = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadStatusPicture(pictureFile);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->uploadStatusPicture: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pictureFile** | **MultipartFile**|  | 

### Return type

[**StatusFileDTO**](StatusFileDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadStatusText**
> StatusFileDTO uploadStatusText(statusTextPostDTO)

uploadStatusText

PATIENT

### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = SocialControllerApi();
final statusTextPostDTO = StatusTextPostDTO(); // StatusTextPostDTO | 

try {
    final result = api_instance.uploadStatusText(statusTextPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling SocialControllerApi->uploadStatusText: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statusTextPostDTO** | [**StatusTextPostDTO**](StatusTextPostDTO.md)|  | 

### Return type

[**StatusFileDTO**](StatusFileDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

