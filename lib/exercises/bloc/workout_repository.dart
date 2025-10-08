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
