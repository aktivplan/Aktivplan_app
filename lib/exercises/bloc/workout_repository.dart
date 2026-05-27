import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';
import 'package:http/http.dart';

class WorkoutRepository {
  final workoutApi = new WorkoutControllerApi(apiClient);

  Future<List<Workout>?> fetchWorkouts() async {
    return workoutApi.getWorkouts();
  }

  Future<Workout?> addWorkout({required WorkoutPostDTO workout, MultipartFile? videoFile}) async {
    var createdWorkout = await workoutApi.createWorkout(workout);
    if (videoFile != null) {
      var createdFile = await workoutApi.uploadWorkoutVideoById(createdWorkout!.id!, videoFile);
      createdWorkout.videoFileKey = createdFile?.fileKey ?? "";
    }
    return createdWorkout;
  }

  Future<Workout?> updateWorkout({required String id, required WorkoutPostDTO workout, MultipartFile? videoFile, bool? didChangeVideoFile}) async {
    var updatedWorkout = await workoutApi.updateWorkout(id, workout);
    if (didChangeVideoFile ?? false) {
      if (videoFile != null) {
        var createdFile = await workoutApi.uploadWorkoutVideoById(updatedWorkout!.id!, videoFile);
        updatedWorkout.videoFileKey = createdFile?.fileKey ?? "";
      } else {
        await workoutApi.deleteWorkoutVideoById(id);
        updatedWorkout!.videoFileKey = "";
      }
    }
    return updatedWorkout;
  }

  Future deleteWorkout({required String id}) async {
    await workoutApi.deleteWorkout(id);
  }
}
