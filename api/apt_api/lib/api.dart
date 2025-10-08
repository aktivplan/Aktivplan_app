// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/activity_controller_api.dart';
part 'api/authentication_controller_api.dart';
part 'api/consent_controller_api.dart';
part 'api/exercise_controller_api.dart';
part 'api/export_controller_api.dart';
part 'api/external_app_controller_api.dart';
part 'api/external_controller_api.dart';
part 'api/institution_controller_api.dart';
part 'api/message_controller_api.dart';
part 'api/social_controller_api.dart';
part 'api/training_plan_controller_api.dart';
part 'api/user_controller_api.dart';
part 'api/video_controller_api.dart';
part 'api/workout_controller_api.dart';

part 'model/access_token_dto.dart';
part 'model/active_minutes_dto.dart';
part 'model/active_minutes_overview_dto.dart';
part 'model/active_minutes_type.dart';
part 'model/activity.dart';
part 'model/activity_autocomplete_get_dto.dart';
part 'model/activity_graph_dto.dart';
part 'model/activity_overview_dto.dart';
part 'model/activity_patient_rating.dart';
part 'model/activity_patient_rating_post_dto.dart';
part 'model/activity_percentage_data_dto.dart';
part 'model/activity_post_dto.dart';
part 'model/activity_profile_dto.dart';
part 'model/activity_repeat.dart';
part 'model/activity_type.dart';
part 'model/administrator_get_dto.dart';
part 'model/appointment_post_dto.dart';
part 'model/authentication_dto.dart';
part 'model/csv_post_dto.dart';
part 'model/change_healthcare_professional_dto.dart';
part 'model/change_password_dto.dart';
part 'model/consent_data_dto.dart';
part 'model/consent_error_cause.dart';
part 'model/consent_get_dto.dart';
part 'model/consent_type.dart';
part 'model/current_user_dto.dart';
part 'model/day_of_week.dart';
part 'model/endurance_exercise.dart';
part 'model/endurance_exercise_post_dto.dart';
part 'model/exercise_overview_dto.dart';
part 'model/exercise_type.dart';
part 'model/export_patient_identificator.dart';
part 'model/export_sign_option.dart';
part 'model/external_app.dart';
part 'model/external_app_dto.dart';
part 'model/external_app_post_dto.dart';
part 'model/extra_activity_post_dto.dart';
part 'model/extra_activity_put_dto.dart';
part 'model/file_get_dto.dart';
part 'model/firebase_token_dto.dart';
part 'model/firebase_token_target.dart';
part 'model/forgot_password_dto.dart';
part 'model/health_data.dart';
part 'model/health_data_change_dto.dart';
part 'model/health_data_post_dto.dart';
part 'model/healthcare_professional_get_dto.dart';
part 'model/healthcare_professional_post_dto.dart';
part 'model/healthcare_professional_profile_dto.dart';
part 'model/healthcare_professionals_overview_dto.dart';
part 'model/hide_activity_post_dto.dart';
part 'model/institution_administrator_get_dto.dart';
part 'model/institution_count_dto.dart';
part 'model/institution_dto.dart';
part 'model/institution_focus.dart';
part 'model/institution_import_dto.dart';
part 'model/institution_import_type.dart';
part 'model/institution_post_dto.dart';
part 'model/interval_exercise.dart';
part 'model/interval_exercise_post_dto.dart';
part 'model/language_switch_dto.dart';
part 'model/message_count_dto.dart';
part 'model/message_dto.dart';
part 'model/message_get_dto.dart';
part 'model/message_history_dto.dart';
part 'model/message_overview_dto.dart';
part 'model/message_put_dto.dart';
part 'model/message_receiver_name_dto.dart';
part 'model/message_schedule.dart';
part 'model/message_schedule_get_dto.dart';
part 'model/message_schedule_post_dto.dart';
part 'model/message_schedule_put_dto.dart';
part 'model/message_send_to_type.dart';
part 'model/message_template.dart';
part 'model/message_template_dto.dart';
part 'model/message_template_post_dto.dart';
part 'model/message_type.dart';
part 'model/move_activity_post_dto.dart';
part 'model/move_personal_goal_post_dto.dart';
part 'model/ordering_dto.dart';
part 'model/other_exercise.dart';
part 'model/other_exercise_post_dto.dart';
part 'model/patient_get_dto.dart';
part 'model/patient_notes_dto.dart';
part 'model/patient_overview_dto.dart';
part 'model/patient_post_dto.dart';
part 'model/patient_state.dart';
part 'model/patient_state_dto.dart';
part 'model/patients_overview_dto.dart';
part 'model/personal_goal.dart';
part 'model/personal_goal_post_dto.dart';
part 'model/prepared_report_dto.dart';
part 'model/refresh_token_dto.dart';
part 'model/report_post_dto.dart';
part 'model/reset_password_dto.dart';
part 'model/share_activity_data_post_dto.dart';
part 'model/social_message_post_dto.dart';
part 'model/status_file_dto.dart';
part 'model/status_file_type.dart';
part 'model/status_message_post_dto.dart';
part 'model/status_text_post_dto.dart';
part 'model/strengthening_exercise.dart';
part 'model/strengthening_exercise_muscle_group.dart';
part 'model/strengthening_exercise_post_dto.dart';
part 'model/task.dart';
part 'model/task_post_dto.dart';
part 'model/training_plan.dart';
part 'model/training_plan_exercise_post_dto.dart';
part 'model/training_plan_overview_dto.dart';
part 'model/training_plan_post_dto.dart';
part 'model/translation_language.dart';
part 'model/user_contact_dto.dart';
part 'model/user_contact_detail_dto.dart';
part 'model/user_contact_overview_dto.dart';
part 'model/user_role.dart';
part 'model/video_template.dart';
part 'model/video_template_dto.dart';
part 'model/video_template_post_dto.dart';
part 'model/workout.dart';
part 'model/workout_post_dto.dart';

/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) =>
    pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
