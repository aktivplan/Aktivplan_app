import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';

class WorkoutRepository {
  final workoutApi = new WorkoutControllerApi(apiClient);

  Future<List<Workout>?> fetchWorkouts() async {
    return workoutApi.getWorkouts();
  }

  Future<Workout?> addWorkout({required WorkoutPostDTO workout}) async {
    return workoutApi.createWorkout(workout);
  }

  Future<Workout?> updateWorkout({required String id, required WorkoutPostDTO workout}) async {
    return workoutApi.updateWorkout(id, workout);
  }

  Future deleteWorkout({required String id}) async {
    await workoutApi.deleteWorkout(id);
  }
}
