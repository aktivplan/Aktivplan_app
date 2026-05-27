import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
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

bool showPersonalGoalsForPatient(InstitutionDTO institution) {
  return institution.institutionFocus != InstitutionFocus.KLIMAFIT_LIGHT;
}

String getRatingText(BuildContext context, int? value) {
  switch (value) {
    case 0:
      return context.i18n.trainingValue_0;
    case 1:
    case 2:
    case 3:
      return context.i18n.trainingValue_1_3;
    case 4:
    case 5:
    case 6:
    case 7:
      return context.i18n.trainingValue_4_7;
    case 8:
    case 9:
    case 10:
      return context.i18n.trainingValue_8_10;
    default:
      return context.i18n.trainingValue_0;
  }
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

DayOfWeek getDayOfWeekfromDateTime(DateTime dateTime) {
  switch (dateTime.weekday) {
    case 1:
      return DayOfWeek.MONDAY;
    case 2:
      return DayOfWeek.TUESDAY;
    case 3:
      return DayOfWeek.WEDNESDAY;
    case 4:
      return DayOfWeek.THURSDAY;
    case 5:
      return DayOfWeek.FRIDAY;
    case 6:
      return DayOfWeek.SATURDAY;
    case 7:
    default:
      return DayOfWeek.SUNDAY;
  }
}

String getPesiValueText(BuildContext context, int pesiValue) {
  switch (pesiValue) {
    case 1:
      return context.i18n.pesiValue_1;
    case 2:
      return context.i18n.pesiValue_2;
    case 3:
      return context.i18n.pesiValue_3;
    case 4:
      return context.i18n.pesiValue_4;
    case 5:
      return context.i18n.pesiValue_5;
    default:
      return "";
  }
}
