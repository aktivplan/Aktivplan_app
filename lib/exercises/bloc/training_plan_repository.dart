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
