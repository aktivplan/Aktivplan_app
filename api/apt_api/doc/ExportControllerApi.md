# apt_api.api.ExportControllerApi

## Load the API package
```dart
import 'package:apt_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createCSV**](ExportControllerApi.md#createcsv) | **POST** /export/csv | 
[**createReport**](ExportControllerApi.md#createreport) | **POST** /export/report | 
[**getCSV**](ExportControllerApi.md#getcsv) | **GET** /export/csv/{key} | 
[**getReport**](ExportControllerApi.md#getreport) | **GET** /export/report/{key} | 


# **createCSV**
> PreparedReportDTO createCSV(cSVPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExportControllerApi();
final cSVPostDTO = CSVPostDTO(); // CSVPostDTO | 

try {
    final result = api_instance.createCSV(cSVPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ExportControllerApi->createCSV: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cSVPostDTO** | [**CSVPostDTO**](CSVPostDTO.md)|  | 

### Return type

[**PreparedReportDTO**](PreparedReportDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createReport**
> PreparedReportDTO createReport(reportPostDTO)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExportControllerApi();
final reportPostDTO = ReportPostDTO(); // ReportPostDTO | 

try {
    final result = api_instance.createReport(reportPostDTO);
    print(result);
} catch (e) {
    print('Exception when calling ExportControllerApi->createReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **reportPostDTO** | [**ReportPostDTO**](ReportPostDTO.md)|  | 

### Return type

[**PreparedReportDTO**](PreparedReportDTO.md)

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCSV**
> String getCSV(key, filename)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExportControllerApi();
final key = key_example; // String | 
final filename = filename_example; // String | 

try {
    final result = api_instance.getCSV(key, filename);
    print(result);
} catch (e) {
    print('Exception when calling ExportControllerApi->getCSV: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 
 **filename** | **String**|  | 

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReport**
> String getReport(key)



### Example
```dart
import 'package:apt_api/api.dart';
// TODO Configure API key authorization: apiKey
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('apiKey').apiKeyPrefix = 'Bearer';

final api_instance = ExportControllerApi();
final key = key_example; // String | 

try {
    final result = api_instance.getReport(key);
    print(result);
} catch (e) {
    print('Exception when calling ExportControllerApi->getReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 

### Return type

**String**

### Authorization

[apiKey](../README.md#apiKey)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

