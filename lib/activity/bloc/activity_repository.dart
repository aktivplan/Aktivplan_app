// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/utils/constants.dart';

class ActivityRepository {
  final activityApi = new ActivityControllerApi(apiClient);

  Future<List<ActivityOverviewDTO>?> getPatientActivities({String? patientId, required DateTime endDate, required DateTime startDate}) async {
    return activityApi.getActivities(englishDateFormat.format(startDate), englishDateFormat.format(endDate), patientId: patientId);
  }

  Future<Activity?> createActivity({required ActivityPostDTO activity}) async {
    return activityApi.createActivity(activity);
  }

  Future<ActivityOverviewDTO?> createExtraActivity({required ExtraActivityPostDTO activity}) async {
    return activityApi.createExtraActivity(activity);
  }

  Future<Activity?> updateActivity({required String id, required ActivityPostDTO activity}) async {
    return activityApi.updateActivity(id, activity);
  }

  Future<ActivityOverviewDTO?> updateExtraActivity({required String id, required ExtraActivityPutDTO activity}) async {
    return activityApi.updateExtraActivity(id, activity);
  }

  Future<ActivityAutocompleteGetDTO?> fetchAutocomplete() async {
    return activityApi.getActivityNamesAutocomplete();
  }

  Future deleteActivity({required String id}) async {
    await activityApi.deleteActivity(id);
  }

  Future<ActiveMinutesOverviewDTO?> getActiveMinutes(DateTime endDate, DateTime startDate, ActiveMinutesType type, {String? patientId}) async {
    return activityApi.getActiveMinutes(type, englishDateFormat.format(startDate), englishDateFormat.format(endDate), patientId: patientId);
  }

  Future<List<PersonalGoal>?> getPersonalGoals({String? patientId}) async {
    return activityApi.getPersonalGoals(patientId: patientId);
  }

  Future createPersonalGoal({required PersonalGoalPostDTO personalGoal}) async {
    await activityApi.createPersonalGoal(personalGoal);
  }

  Future<PersonalGoal?> updatePersonalGoal({required String id, required PersonalGoalPostDTO personalGoal}) async {
    return activityApi.updatePersonalGoal(id, personalGoal);
  }

  Future deletePersonalGoal({required String id}) async {
    await activityApi.deletePersonalGoal(id);
  }

  Future<ActivityPatientRating?> updateActivityRating(
      {required String date, required String id, required ActivityPatientRatingPostDTO activityPatientRating}) async {
    return activityApi.updateActivityRating(id, date, activityPatientRating);
  }

  Future hideActivity(HideActivityPostDTO hideActivity) async {
    await activityApi.hideActivity(hideActivity);
  }

  Future<Activity?> moveActivity(MoveActivityPostDTO moveActivity) async {
    return activityApi.moveActivity(moveActivity);
  }

  Future<PersonalGoal?> movePersonalGoal(MovePersonalGoalPostDTO movePersonalGoal) async {
    return activityApi.movePersonalGoal(movePersonalGoal);
  }

  Future<ActivityPercentageDataDTO?> getActivityPercentageData(String date, String patientId) async {
    return activityApi.getActivityPercentageData(date, patientId: patientId);
  }
}
