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

class TrainingPlanRepository {
  final trainingPlanApi = new TrainingPlanControllerApi(apiClient);

  Future<List<TrainingPlanOverviewDTO>?> fetchTrainingPlans() async {
    return trainingPlanApi.getTrainingPlans();
  }

  Future<TrainingPlanPostDTO?> fetchTrainingPlan(String id) async {
    return trainingPlanApi.getTrainingPlan(id);
  }

  Future<TrainingPlan?> addTrainingPlan(TrainingPlanPostDTO trainingPlan) async {
    return trainingPlanApi.createTrainingPlan(trainingPlan);
  }

  Future<TrainingPlan?> updateTrainingPlan(String id, TrainingPlanPostDTO trainingPlan) async {
    return trainingPlanApi.updateTrainingPlan(id, trainingPlan);
  }

  Future deleteTrainingPlan(String id) async {
    return trainingPlanApi.deleteTrainingPlan(id);
  }
}
