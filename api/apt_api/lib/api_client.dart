//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiClient {
  ApiClient({
    this.basePath = 'https://aktivplan-plus.ap-stage.at',
    this.authentication,
  });

  final String basePath;
  final Authentication? authentication;

  var _client = Client();
  final _defaultHeaderMap = <String, String>{};

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  set client(Client newClient) {
    _client = newClient;
  }

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType,
  ) async {
    await authentication?.applyToParams(queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final urlEncodedQueryParams = queryParams.map((param) => '$param');
    final queryString = urlEncodedQueryParams.isNotEmpty
        ? '?${urlEncodedQueryParams.join('&')}'
        : '';
    final uri = Uri.parse('$basePath$path$queryString');

    try {
      // Special case for uploading a single file which isn't a 'multipart/form-data'.
      if (body is MultipartFile &&
          (contentType == null ||
              !contentType.toLowerCase().startsWith('multipart/form-data'))) {
        final request = StreamedRequest(method, uri);
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
              request.sink.add,
              onDone: request.sink.close,
              // ignore: avoid_types_on_closure_parameters
              onError: (Object error, StackTrace trace) => request.sink.close(),
              cancelOnError: true,
            );
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = MultipartRequest(method, uri);
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      final msgBody = contentType == 'application/x-www-form-urlencoded'
          ? formParams
          : await serializeAsync(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch (method) {
        case 'POST':
          return await _client.post(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'PUT':
          return await _client.put(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'DELETE':
          return await _client.delete(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'PATCH':
          return await _client.patch(
            uri,
            headers: nullableHeaderParams,
            body: msgBody,
          );
        case 'HEAD':
          return await _client.head(
            uri,
            headers: nullableHeaderParams,
          );
        case 'GET':
          return await _client.get(
            uri,
            headers: nullableHeaderParams,
          );
      }
    } on SocketException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        trace,
      );
    } on TlsException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        error,
        trace,
      );
    } on IOException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        trace,
      );
    } on ClientException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        trace,
      );
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        trace,
      );
    }

    throw ApiException(
      HttpStatus.badRequest,
      'Invalid HTTP operation: $method $path',
    );
  }

  Future<dynamic> deserializeAsync(
    String value,
    String targetType, {
    bool growable = false,
  }) async =>
      // ignore: deprecated_member_use_from_same_package
      deserialize(value, targetType, growable: growable);

  @Deprecated(
      'Scheduled for removal in OpenAPI Generator 6.x. Use deserializeAsync() instead.')
  dynamic deserialize(
    String value,
    String targetType, {
    bool growable = false,
  }) {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType =
        targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String'
        ? value
        : fromJson(json.decode(value), targetType, growable: growable);
  }

  // ignore: deprecated_member_use_from_same_package
  Future<String> serializeAsync(Object? value) async => serialize(value);

  @Deprecated(
      'Scheduled for removal in OpenAPI Generator 6.x. Use serializeAsync() instead.')
  String serialize(Object? value) => value == null ? '' : json.encode(value);

  /// Returns a native instance of an OpenAPI class matching the [specified type][targetType].
  static dynamic fromJson(
    dynamic value,
    String targetType, {
    bool growable = false,
  }) {
    try {
      switch (targetType) {
        case 'String':
          return value is String ? value : value.toString();
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse(value);
        case 'AccessTokenDTO':
          return AccessTokenDTO.fromJson(value);
        case 'ActiveMinutesDTO':
          return ActiveMinutesDTO.fromJson(value);
        case 'ActiveMinutesOverviewDTO':
          return ActiveMinutesOverviewDTO.fromJson(value);
        case 'ActiveMinutesType':
          return ActiveMinutesTypeTypeTransformer().decode(value);
        case 'Activity':
          return Activity.fromJson(value);
        case 'ActivityAutocompleteGetDTO':
          return ActivityAutocompleteGetDTO.fromJson(value);
        case 'ActivityGraphDTO':
          return ActivityGraphDTO.fromJson(value);
        case 'ActivityOverviewDTO':
          return ActivityOverviewDTO.fromJson(value);
        case 'ActivityPatientRating':
          return ActivityPatientRating.fromJson(value);
        case 'ActivityPatientRatingPostDTO':
          return ActivityPatientRatingPostDTO.fromJson(value);
        case 'ActivityPercentageDataDTO':
          return ActivityPercentageDataDTO.fromJson(value);
        case 'ActivityPostDTO':
          return ActivityPostDTO.fromJson(value);
        case 'ActivityProfileDTO':
          return ActivityProfileDTO.fromJson(value);
        case 'ActivityRepeat':
          return ActivityRepeatTypeTransformer().decode(value);
        case 'ActivityType':
          return ActivityTypeTypeTransformer().decode(value);
        case 'AdministratorGetDTO':
          return AdministratorGetDTO.fromJson(value);
        case 'AppointmentPostDTO':
          return AppointmentPostDTO.fromJson(value);
        case 'AuthenticationDTO':
          return AuthenticationDTO.fromJson(value);
        case 'CSVPostDTO':
          return CSVPostDTO.fromJson(value);
        case 'ChangeHealthcareProfessionalDTO':
          return ChangeHealthcareProfessionalDTO.fromJson(value);
        case 'ChangePasswordDTO':
          return ChangePasswordDTO.fromJson(value);
        case 'ConsentDataDTO':
          return ConsentDataDTO.fromJson(value);
        case 'ConsentErrorCause':
          return ConsentErrorCauseTypeTransformer().decode(value);
        case 'ConsentGetDTO':
          return ConsentGetDTO.fromJson(value);
        case 'ConsentType':
          return ConsentTypeTypeTransformer().decode(value);
        case 'CurrentUserDTO':
          return CurrentUserDTO.fromJson(value);
        case 'DayOfWeek':
          return DayOfWeekTypeTransformer().decode(value);
        case 'EnduranceExercise':
          return EnduranceExercise.fromJson(value);
        case 'EnduranceExercisePostDTO':
          return EnduranceExercisePostDTO.fromJson(value);
        case 'ExerciseOverviewDTO':
          return ExerciseOverviewDTO.fromJson(value);
        case 'ExerciseType':
          return ExerciseTypeTypeTransformer().decode(value);
        case 'ExportPatientIdentificator':
          return ExportPatientIdentificatorTypeTransformer().decode(value);
        case 'ExportSignOption':
          return ExportSignOptionTypeTransformer().decode(value);
        case 'ExternalApp':
          return ExternalApp.fromJson(value);
        case 'ExternalAppDTO':
          return ExternalAppDTO.fromJson(value);
        case 'ExternalAppPostDTO':
          return ExternalAppPostDTO.fromJson(value);
        case 'ExtraActivityPostDTO':
          return ExtraActivityPostDTO.fromJson(value);
        case 'ExtraActivityPutDTO':
          return ExtraActivityPutDTO.fromJson(value);
        case 'FileGetDTO':
          return FileGetDTO.fromJson(value);
        case 'FirebaseTokenDTO':
          return FirebaseTokenDTO.fromJson(value);
        case 'FirebaseTokenTarget':
          return FirebaseTokenTargetTypeTransformer().decode(value);
        case 'ForgotPasswordDTO':
          return ForgotPasswordDTO.fromJson(value);
        case 'HealthData':
          return HealthData.fromJson(value);
        case 'HealthDataChangeDTO':
          return HealthDataChangeDTO.fromJson(value);
        case 'HealthDataPostDTO':
          return HealthDataPostDTO.fromJson(value);
        case 'HealthcareProfessionalGetDTO':
          return HealthcareProfessionalGetDTO.fromJson(value);
        case 'HealthcareProfessionalPostDTO':
          return HealthcareProfessionalPostDTO.fromJson(value);
        case 'HealthcareProfessionalProfileDTO':
          return HealthcareProfessionalProfileDTO.fromJson(value);
        case 'HealthcareProfessionalsOverviewDTO':
          return HealthcareProfessionalsOverviewDTO.fromJson(value);
        case 'HideActivityPostDTO':
          return HideActivityPostDTO.fromJson(value);
        case 'InstitutionAdministratorGetDTO':
          return InstitutionAdministratorGetDTO.fromJson(value);
        case 'InstitutionCountDTO':
          return InstitutionCountDTO.fromJson(value);
        case 'InstitutionDTO':
          return InstitutionDTO.fromJson(value);
        case 'InstitutionFocus':
          return InstitutionFocusTypeTransformer().decode(value);
        case 'InstitutionImportDTO':
          return InstitutionImportDTO.fromJson(value);
        case 'InstitutionImportType':
          return InstitutionImportTypeTypeTransformer().decode(value);
        case 'InstitutionPostDTO':
          return InstitutionPostDTO.fromJson(value);
        case 'IntervalExercise':
          return IntervalExercise.fromJson(value);
        case 'IntervalExercisePostDTO':
          return IntervalExercisePostDTO.fromJson(value);
        case 'LanguageSwitchDTO':
          return LanguageSwitchDTO.fromJson(value);
        case 'MessageCountDTO':
          return MessageCountDTO.fromJson(value);
        case 'MessageDTO':
          return MessageDTO.fromJson(value);
        case 'MessageGetDTO':
          return MessageGetDTO.fromJson(value);
        case 'MessageHistoryDTO':
          return MessageHistoryDTO.fromJson(value);
        case 'MessageOverviewDTO':
          return MessageOverviewDTO.fromJson(value);
        case 'MessagePutDTO':
          return MessagePutDTO.fromJson(value);
        case 'MessageReceiverNameDTO':
          return MessageReceiverNameDTO.fromJson(value);
        case 'MessageSchedule':
          return MessageSchedule.fromJson(value);
        case 'MessageScheduleGetDTO':
          return MessageScheduleGetDTO.fromJson(value);
        case 'MessageSchedulePostDTO':
          return MessageSchedulePostDTO.fromJson(value);
        case 'MessageSchedulePutDTO':
          return MessageSchedulePutDTO.fromJson(value);
        case 'MessageSendToType':
          return MessageSendToTypeTypeTransformer().decode(value);
        case 'MessageTemplate':
          return MessageTemplate.fromJson(value);
        case 'MessageTemplateDTO':
          return MessageTemplateDTO.fromJson(value);
        case 'MessageTemplatePostDTO':
          return MessageTemplatePostDTO.fromJson(value);
        case 'MessageType':
          return MessageTypeTypeTransformer().decode(value);
        case 'MoveActivityPostDTO':
          return MoveActivityPostDTO.fromJson(value);
        case 'MovePersonalGoalPostDTO':
          return MovePersonalGoalPostDTO.fromJson(value);
        case 'OrderingDTO':
          return OrderingDTO.fromJson(value);
        case 'OtherExercise':
          return OtherExercise.fromJson(value);
        case 'OtherExercisePostDTO':
          return OtherExercisePostDTO.fromJson(value);
        case 'PatientGetDTO':
          return PatientGetDTO.fromJson(value);
        case 'PatientNotesDTO':
          return PatientNotesDTO.fromJson(value);
        case 'PatientOverviewDTO':
          return PatientOverviewDTO.fromJson(value);
        case 'PatientPostDTO':
          return PatientPostDTO.fromJson(value);
        case 'PatientState':
          return PatientStateTypeTransformer().decode(value);
        case 'PatientStateDTO':
          return PatientStateDTO.fromJson(value);
        case 'PatientsOverviewDTO':
          return PatientsOverviewDTO.fromJson(value);
        case 'PersonalGoal':
          return PersonalGoal.fromJson(value);
        case 'PersonalGoalPostDTO':
          return PersonalGoalPostDTO.fromJson(value);
        case 'PreparedReportDTO':
          return PreparedReportDTO.fromJson(value);
        case 'RefreshTokenDTO':
          return RefreshTokenDTO.fromJson(value);
        case 'ReportPostDTO':
          return ReportPostDTO.fromJson(value);
        case 'ResetPasswordDTO':
          return ResetPasswordDTO.fromJson(value);
        case 'ShareActivityDataPostDTO':
          return ShareActivityDataPostDTO.fromJson(value);
        case 'SocialMessagePostDTO':
          return SocialMessagePostDTO.fromJson(value);
        case 'StatusFileDTO':
          return StatusFileDTO.fromJson(value);
        case 'StatusFileType':
          return StatusFileTypeTypeTransformer().decode(value);
        case 'StatusMessagePostDTO':
          return StatusMessagePostDTO.fromJson(value);
        case 'StatusTextPostDTO':
          return StatusTextPostDTO.fromJson(value);
        case 'StrengtheningExercise':
          return StrengtheningExercise.fromJson(value);
        case 'StrengtheningExerciseMuscleGroup':
          return StrengtheningExerciseMuscleGroupTypeTransformer()
              .decode(value);
        case 'StrengtheningExercisePostDTO':
          return StrengtheningExercisePostDTO.fromJson(value);
        case 'Task':
          return Task.fromJson(value);
        case 'TaskPostDTO':
          return TaskPostDTO.fromJson(value);
        case 'TrainingPlan':
          return TrainingPlan.fromJson(value);
        case 'TrainingPlanExercisePostDTO':
          return TrainingPlanExercisePostDTO.fromJson(value);
        case 'TrainingPlanOverviewDTO':
          return TrainingPlanOverviewDTO.fromJson(value);
        case 'TrainingPlanPostDTO':
          return TrainingPlanPostDTO.fromJson(value);
        case 'TranslationLanguage':
          return TranslationLanguageTypeTransformer().decode(value);
        case 'UserContactDTO':
          return UserContactDTO.fromJson(value);
        case 'UserContactDetailDTO':
          return UserContactDetailDTO.fromJson(value);
        case 'UserContactOverviewDTO':
          return UserContactOverviewDTO.fromJson(value);
        case 'UserRole':
          return UserRoleTypeTransformer().decode(value);
        case 'VideoTemplate':
          return VideoTemplate.fromJson(value);
        case 'VideoTemplateDTO':
          return VideoTemplateDTO.fromJson(value);
        case 'VideoTemplatePostDTO':
          return VideoTemplatePostDTO.fromJson(value);
        case 'Workout':
          return Workout.fromJson(value);
        case 'WorkoutPostDTO':
          return WorkoutPostDTO.fromJson(value);
        default:
          dynamic match;
          if (value is List &&
              (match = _regList.firstMatch(targetType)?.group(1)) != null) {
            return value
                .map<dynamic>((dynamic v) => fromJson(
                      v,
                      match,
                      growable: growable,
                    ))
                .toList(growable: growable);
          }
          if (value is Set &&
              (match = _regSet.firstMatch(targetType)?.group(1)) != null) {
            return value
                .map<dynamic>((dynamic v) => fromJson(
                      v,
                      match,
                      growable: growable,
                    ))
                .toSet();
          }
          if (value is Map &&
              (match = _regMap.firstMatch(targetType)?.group(1)) != null) {
            return Map<String, dynamic>.fromIterables(
              value.keys.cast<String>(),
              value.values.map<dynamic>((dynamic v) => fromJson(
                    v,
                    match,
                    growable: growable,
                  )),
            );
          }
      }
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.internalServerError,
        'Exception during deserialization.',
        error,
        trace,
      );
    }
    throw ApiException(
      HttpStatus.internalServerError,
      'Could not find a suitable class for deserialization',
    );
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable = false,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> decodeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String' ? message.json : json.decode(message.json);
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
      ? message.json
      : ApiClient.fromJson(
          json.decode(message.json),
          targetType,
          growable: message.growable,
        );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object? value) async =>
    value == null ? '' : json.encode(value);
