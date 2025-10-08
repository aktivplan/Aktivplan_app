// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:flutter/widgets.dart';

int getWorkoutExercisesDurationInMinutes(List<StrengtheningExercisePostDTO> exercises) {
  int sum = 0;
  exercises.forEach((element) {
    int duration = 0;
    int repeatSets = element.exerciseRepeatSets ?? 1;
    if (element.hasRepeatCount ?? false) {
      duration = ((element.exerciseRepeatCount ?? 1) * 3 * repeatSets) + (60 * repeatSets);
    } else {
      duration = ((element.exerciseDurationSeconds ?? 0) * repeatSets) + (60 * repeatSets);
    }
    sum += duration;
  });
  int totalMinutes = Duration(seconds: sum).inMinutes;
  // ceil to next five minutes
  return (totalMinutes - totalMinutes % 5) + (totalMinutes % 5 != 0 ? 5 : 0);
}

int toNextMinute(int durationSeconds) {
  return (durationSeconds / 60).floor() + (durationSeconds % 60 != 0 ? 1 : 0);
}

int getEnduranceExerciseDurationMinutes(EnduranceExercisePostDTO enduranceExercise) {
  return toNextMinute(enduranceExercise.exerciseDurationSeconds ?? 0);
}

int getIntervalExerciseDurationMinutes(IntervalExercisePostDTO intervalExercise) {
  return toNextMinute(
      ((intervalExercise.exerciseDurationSeconds ?? 0) + (intervalExercise.recoveryDurationSeconds ?? 0)) * (intervalExercise.intervalCount ?? 1));
}

int getStrengtheningExerciseDurationMinutes(StrengtheningExercisePostDTO strengtheningExercise) {
  int duration = 0;
  int repeatSets = strengtheningExercise.exerciseRepeatSets ?? 1;
  if (strengtheningExercise.hasRepeatCount ?? false) {
    duration = ((strengtheningExercise.exerciseRepeatCount ?? 1) * 3 * repeatSets) + (60 * repeatSets);
  } else {
    duration = ((strengtheningExercise.exerciseDurationSeconds ?? 0) * repeatSets) + (60 * repeatSets);
  }
  return toNextMinute(duration);
}

int getOtherExerciseDurationMinutes(OtherExercisePostDTO otherExercise) {
  return toNextMinute(otherExercise.exerciseDurationSeconds ?? 0);
}

bool showThreeWeekStateForPatient(InstitutionDTO institution) {
  return (institution.institutionFocus ?? InstitutionFocus.CARDIOVASCULAR_REHABILITATION) == InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE;
}

Widget getTrafficLightForPercentage(int percentageValue, double size, {Widget? childWidget}) {
  Color trafficLightColor = trafficLight3;
  if (percentageValue < 50) {
    trafficLightColor = trafficLight1;
  } else if (percentageValue < 80) {
    trafficLightColor = trafficLight2;
  }
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: trafficLightColor,
    ),
    child: childWidget,
  );
}
