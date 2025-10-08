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

class ExerciseRepository {
  final exerciseApi = new ExerciseControllerApi(apiClient);

  Future<List<ExerciseOverviewDTO>?> getExercise({required ExerciseType type}) async {
    return exerciseApi.getExercises(type);
  }

  Future<List<ExerciseOverviewDTO>?> getHypertrophyExercise() async {
    return exerciseApi.getExercises(ExerciseType.HYPERTROPHY);
  }

  Future<List<ExerciseOverviewDTO>?> getStrengtheningExercise() async {
    return exerciseApi.getExercises(ExerciseType.STRENGTHENING);
  }

  Future<EnduranceExercise?> createEndurance({required EnduranceExercisePostDTO enduranceExercise}) async {
    return exerciseApi.createEnduranceExercise(enduranceExercise);
  }

  Future<IntervalExercise?> createInterval({required IntervalExercisePostDTO intervalExercise}) async {
    return exerciseApi.createIntervalExercise(intervalExercise);
  }

  Future<StrengtheningExercise?> createStrengthening({required StrengtheningExercisePostDTO strengtheningExercise}) async {
    if (strengtheningExercise.type == ExerciseType.HYPERTROPHY) {
      return exerciseApi.createHypertrophyExercise(strengtheningExercise);
    }
    return exerciseApi.createStrengtheningExercise(strengtheningExercise);
  }

  Future<OtherExercise?> createOther({required OtherExercisePostDTO otherExercise}) async {
    return exerciseApi.createOtherExercise(otherExercise);
  }

  Future<Task?> createTask({required TaskPostDTO task}) async {
    return exerciseApi.createTask(task);
  }

  Future<EnduranceExercise?> updateEndurance({required String id, required EnduranceExercisePostDTO enduranceExercise}) async {
    return exerciseApi.updateEnduranceExercise(id, enduranceExercise);
  }

  Future<IntervalExercise?> updateInterval({required String id, required IntervalExercisePostDTO intervalExercise}) async {
    return exerciseApi.updateIntervalExercise(id, intervalExercise);
  }

  Future<StrengtheningExercise?> updateStrengthening({required String id, required StrengtheningExercisePostDTO strengtheningExercise}) async {
    if (strengtheningExercise.type == ExerciseType.HYPERTROPHY) {
      return exerciseApi.updateHypertrophyExercise(id, strengtheningExercise);
    }
    return exerciseApi.updateStrengtheningExercise(id, strengtheningExercise);
  }

  Future<OtherExercise?> updateOther({required String id, required OtherExercisePostDTO otherExercise}) async {
    return exerciseApi.updateOtherExercise(id, otherExercise);
  }

  Future<Task?> updateTask({required String id, required TaskPostDTO task}) async {
    return exerciseApi.updateTask(id, task);
  }

  Future deleteExerciseType({required String id}) async {
    await exerciseApi.deleteExercise(id);
  }
}
