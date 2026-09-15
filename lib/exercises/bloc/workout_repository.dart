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
