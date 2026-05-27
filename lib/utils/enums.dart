import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

extension ExerciseTypeExtension on ExerciseType {
  IconData get iconData {
    switch (this) {
      case ExerciseType.ENDURANCE:
        return Icons.directions_run;
      case ExerciseType.HYPERTROPHY:
      case ExerciseType.STRENGTHENING:
        return MdiIcons.weightLifter;
      case ExerciseType.INTERVAL:
        return Icons.timer_outlined;
      case ExerciseType.OTHER:
        return Icons.accessibility;
      case ExerciseType.TASK:
        return Symbols.digital_wellbeing;
      default:
        return Icons.library_books;
    }
  }

  String getTranslatedText(BuildContext context) {
    switch (this) {
      case ExerciseType.ENDURANCE:
        return context.i18n.exercise_ENDURANCE;
      case ExerciseType.INTERVAL:
        return context.i18n.exercise_INTERVAL;
      case ExerciseType.STRENGTHENING:
        return context.i18n.exercise_STRENGTHENING;
      case ExerciseType.OTHER:
        return context.i18n.exercise_OTHER;
      case ExerciseType.TASK:
        return context.i18n.exercise_TASK;
      case ExerciseType.HYPERTROPHY:
      default:
        return context.i18n.exercise_HYPERTROPHY;
    }
  }
}

extension ActivityExtension on ActivityType {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case ActivityType.APPOINTMENT:
        return context.i18n.activity_APPOINTMENT;
      case ActivityType.ENDURANCE:
        return context.i18n.activity_ENDURANCE;
      case ActivityType.EXTRA:
        return context.i18n.activity_EXTRA;
      case ActivityType.HYPERTROPHY:
        return context.i18n.activity_HYPERTROPHY;
      case ActivityType.INTERVAL:
        return context.i18n.activity_INTERVAL;
      case ActivityType.STRENGTHENING:
        return context.i18n.activity_STRENGTHENING;
      case ActivityType.OTHER:
        return context.i18n.activity_OTHER;
      case ActivityType.TASK:
        return context.i18n.activity_TASK;
      case ActivityType.PREDEFINED_ACTIVITY:
        return context.i18n.activity_PREDEFINED_ACTIVITY;
      case ActivityType.PREDEFINED_ACTIVE_MOBILITY:
        return context.i18n.activity_PREDEFINED_ACTIVE_MOBILITY;
      case ActivityType.WORKOUT:
      default:
        return context.i18n.activity_WORKOUT;
    }
  }

  String getExerciseText(BuildContext context) {
    switch (this) {
      case ActivityType.APPOINTMENT:
        return context.i18n.activity_APPOINTMENT;
      case ActivityType.ENDURANCE:
        return context.i18n.exercise_ENDURANCE;
      case ActivityType.EXTRA:
        return context.i18n.activity_EXTRA;
      case ActivityType.HYPERTROPHY:
        return context.i18n.exercise_HYPERTROPHY;
      case ActivityType.INTERVAL:
        return context.i18n.exercise_INTERVAL;
      case ActivityType.STRENGTHENING:
        return context.i18n.exercise_STRENGTHENING;
      case ActivityType.OTHER:
        return context.i18n.exercise_OTHER;
      case ActivityType.TASK:
        return context.i18n.exercise_TASK;
      case ActivityType.WORKOUT:
      default:
        return context.i18n.activity_WORKOUT;
    }
  }

  IconData get iconData {
    switch (this) {
      case ActivityType.APPOINTMENT:
        return MdiIcons.calendarOutline;
      case ActivityType.ENDURANCE:
        return Icons.directions_run;
      case ActivityType.EXTRA:
        return Icons.person_add;
      case ActivityType.HYPERTROPHY:
      case ActivityType.STRENGTHENING:
      case ActivityType.PREDEFINED_ACTIVITY:
        return MdiIcons.weightLifter;
      case ActivityType.INTERVAL:
        return Icons.timer_outlined;
      case ActivityType.OTHER:
        return Icons.accessibility;
      case ActivityType.TASK:
        return Symbols.digital_wellbeing;
      case ActivityType.PREDEFINED_ACTIVE_MOBILITY:
        return Symbols.pedal_bike;
      case ActivityType.WORKOUT:
      default:
        return Icons.library_books;
    }
  }

  List<DropdownMenuItem<PredefinedActivityType>> getPredefinedActivityTypes(BuildContext context) {
    List<PredefinedActivityType> types = [];
    if (this == ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
      types = [
        PredefinedActivityType.WALKING,
        PredefinedActivityType.CYCLING,
        PredefinedActivityType.E_BIKING,
        PredefinedActivityType.PUBLIC_TRANSPORT_WALKING,
        PredefinedActivityType.CAR_WALKING,
        PredefinedActivityType.OTHER
      ];
    } else if (this == ActivityType.PREDEFINED_ACTIVITY) {
      types = [
        PredefinedActivityType.HIKING,
        PredefinedActivityType.WALKING,
        PredefinedActivityType.FAST_WALKING,
        PredefinedActivityType.NORDIC_WALKING,
        PredefinedActivityType.RUNNING,
        PredefinedActivityType.CYCLING,
        PredefinedActivityType.E_BIKING,
        PredefinedActivityType.SWIMMING,
        PredefinedActivityType.STRENGTH_TRAINING,
        PredefinedActivityType.OTHER
      ];
    }
    return types.map((e) {
      return DropdownMenuItem(
        child: Text(e.getTranslatedText(context)),
        value: e,
      );
    }).toList();
  }

  Color get backgroundColor {
    if (this == ActivityType.EXTRA) {
      return extraActivityColor;
    }
    if (this == ActivityType.TASK) {
      return plannedTaskColor;
    }
    if (this == ActivityType.APPOINTMENT) {
      return primaryColor;
    }
    if (this == ActivityType.PREDEFINED_ACTIVITY) {
      return predefinedActivityColor;
    }
    if (this == ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
      return predefinedActiveMobilityColor;
    }
    return plannedActivityColor;
  }
}

extension ActivityRepeatExtension on ActivityRepeat {
  String getTranslatedShortText(BuildContext context) {
    switch (this) {
      case ActivityRepeat.NEVER:
        return context.i18n.activityRepeatShort_NEVER;
      case ActivityRepeat.WEEKLY:
        return context.i18n.activityRepeatShort_WEEKLY;
      case ActivityRepeat.BIWEEKLY:
      default:
        return context.i18n.activityRepeatShort_BIWEEKLY;
    }
  }

  String getTranslatedText(BuildContext context) {
    switch (this) {
      case ActivityRepeat.NEVER:
        return context.i18n.activityRepeat_NEVER;
      case ActivityRepeat.WEEKLY:
        return context.i18n.activityRepeat_WEEKLY;
      case ActivityRepeat.BIWEEKLY:
      default:
        return context.i18n.activityRepeat_BIWEEKLY;
    }
  }
}

extension WeekType on DayOfWeek {
  int getWeekday() {
    switch (this) {
      case DayOfWeek.MONDAY:
        return 1;
      case DayOfWeek.TUESDAY:
        return 2;
      case DayOfWeek.WEDNESDAY:
        return 3;
      case DayOfWeek.THURSDAY:
        return 4;
      case DayOfWeek.FRIDAY:
        return 5;
      case DayOfWeek.SATURDAY:
        return 6;
      default:
        return 0;
    }
  }

  String getTranslatedShortName(BuildContext context) {
    return DateFormat.EEEE(Localizations.localeOf(context).languageCode).dateSymbols.STANDALONESHORTWEEKDAYS[getWeekday()];
  }

  String getTranslatedText(BuildContext context) {
    return DateFormat.EEEE(Localizations.localeOf(context).languageCode).dateSymbols.STANDALONEWEEKDAYS[getWeekday()];
  }
}

enum Months {
  DEFAULT,
  JANUARY,
  FEBRUARY,
  MARCH,
  APRIL,
  MAY,
  JUNE,
  JULY,
  AUGUST,
  SEPTEMBER,
  OCTOBER,
  NOVEMBER,
  DECEMBER,
}

extension MuscleExtension on StrengtheningExerciseMuscleGroup {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case StrengtheningExerciseMuscleGroup.ARMS:
        return context.i18n.muscleGroup_ARMS;
      case StrengtheningExerciseMuscleGroup.BACK:
        return context.i18n.muscleGroup_BACK;
      case StrengtheningExerciseMuscleGroup.ABDOMINAL:
        return context.i18n.muscleGroup_ABDOMINAL;
      case StrengtheningExerciseMuscleGroup.CHEST:
        return context.i18n.muscleGroup_CHEST;
      case StrengtheningExerciseMuscleGroup.LEGS:
        return context.i18n.muscleGroup_LEGS;
      case StrengtheningExerciseMuscleGroup.SHOULDERS:
      default:
        return context.i18n.muscleGroup_SHOULDERS;
    }
  }
}

extension PatientStateExtension on PatientState {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case PatientState.INAPPROPRIATE_TRAINING_PLAN:
        return context.i18n.patientState_INAPPROPRIATE_TRAINING_PLAN;
      case PatientState.ON_VACATION:
        return context.i18n.patientState_ON_VACATION;
      case PatientState.SICK:
        return context.i18n.patientState_SICK;
      case PatientState.NO_STATE:
      default:
        return context.i18n.patientState_NO_STATE;
    }
  }
}

extension InstitutionFocusExtension on InstitutionFocus {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case InstitutionFocus.CARDIOVASCULAR_REHABILITATION:
        return context.i18n.institutionFocus_CARDIOVASCULAR_REHABILITATION;
      case InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE:
        return context.i18n.institutionFocus_PROMOTING_A_HEALTHY_LIFESTYLE;
      case InstitutionFocus.KLIMAFIT:
        return context.i18n.institutionFocus_KLIMAFIT;
      case InstitutionFocus.KLIMAFIT_LIGHT:
        return context.i18n.institutionFocus_KLIMAFIT_LIGHT;
      case InstitutionFocus.PREHAB_TO_REHAB:
        return context.i18n.institutionFocus_PREHAB_TO_REHAB;
      default:
        return context.i18n.institutionFocus_CARDIOVASCULAR_REHABILITATION;
    }
  }

  bool isKlimafit() {
    return this == InstitutionFocus.KLIMAFIT || this == InstitutionFocus.KLIMAFIT_LIGHT;
  }
}

extension InstitutionP2RFocusExtension on InstitutionP2RFocus {
  String getText(BuildContext context) {
    switch (this) {
      case InstitutionP2RFocus.ORTHO_BV:
        return "Ortho BV";
      case InstitutionP2RFocus.ONKO_SALK:
        return "Onko Salk";
      case InstitutionP2RFocus.KARDIO_MUW:
        return "Kardio MUW";
      default:
        return context.i18n.institutionFocusP2RFocus_GENERAL;
    }
  }
}

extension InstitutionImportTypeExtension on InstitutionImportType {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case InstitutionImportType.EXERCISES:
        return context.i18n.activities;
      case InstitutionImportType.MESSAGES:
        return context.i18n.tipsAndInfos;
      case InstitutionImportType.VIDEOS:
        return context.i18n.themeVideos;
      case InstitutionImportType.EXTERNAL_APPS:
      default:
        return context.i18n.additionalApps;
    }
  }
}

extension MessageSendToTypeExtension on MessageSendToType {
  String getTranslatedText(String patientName, BuildContext context) {
    switch (this) {
      case MessageSendToType.ALL:
        return context.i18n.messageSendToType_ALL;
      case MessageSendToType.SOME:
        return context.i18n.messageSendToType_SOME;
      default:
        return patientName;
    }
  }
}

extension MessageRestrictionExtension on MessageRestriction {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case MessageRestriction.NO_RESTRICTION:
        return context.i18n.messageRestriction_NO_RESTRICTION;
      case MessageRestriction.BEFORE_SURGERY:
        return context.i18n.messageRestriction_BEFORE_SURGERY;
      case MessageRestriction.AFTER_SURGERY:
        return context.i18n.messageRestriction_AFTER_SURGERY;
      default:
        return context.i18n.messageRestriction_NO_RESTRICTION;
    }
  }
}

enum PatientSelectMode { None, Handhover }

extension HeatToleranceExtension on HeatTolerance {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case HeatTolerance.GOOD:
        return context.i18n.heatTolerance_GOOD;
      case HeatTolerance.POOR:
        return context.i18n.heatTolerance_POOR;
      case HeatTolerance.AVERAGE:
      default:
        return context.i18n.heatTolerance_AVERAGE;
    }
  }
}

extension MobilityPreferenceExtension on MobilityPreference {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case MobilityPreference.BIKE:
        return context.i18n.mobilityPreference_BIKE;
      case MobilityPreference.CAR:
        return context.i18n.mobilityPreference_CAR;
      case MobilityPreference.PUBLIC_TRANSPORT:
        return context.i18n.mobilityPreference_PUBLIC_TRANSPORT;
      case MobilityPreference.FOOT:
      default:
        return context.i18n.mobilityPreference_FOOT;
    }
  }
}

extension PredefinedActivityTypeExtension on PredefinedActivityType {
  String getTranslatedText(BuildContext context) {
    switch (this) {
      case PredefinedActivityType.HIKING:
        return context.i18n.predefinedActivityType_HIKING;
      case PredefinedActivityType.WALKING:
        return context.i18n.predefinedActivityType_WALKING;
      case PredefinedActivityType.FAST_WALKING:
        return context.i18n.predefinedActivityType_FAST_WALKING;
      case PredefinedActivityType.NORDIC_WALKING:
        return context.i18n.predefinedActivityType_NORDIC_WALKING;
      case PredefinedActivityType.RUNNING:
        return context.i18n.predefinedActivityType_RUNNING;
      case PredefinedActivityType.CYCLING:
        return context.i18n.predefinedActivityType_CYCLING;
      case PredefinedActivityType.E_BIKING:
        return context.i18n.predefinedActivityType_E_BIKING;
      case PredefinedActivityType.SWIMMING:
        return context.i18n.predefinedActivityType_SWIMMING;
      case PredefinedActivityType.STRENGTH_TRAINING:
        return context.i18n.predefinedActivityType_STRENGTH_TRAINING;
      case PredefinedActivityType.PUBLIC_TRANSPORT_WALKING:
        return context.i18n.predefinedActivityType_PUBLIC_TRANSPORT_WALKING;
      case PredefinedActivityType.CAR_WALKING:
        return context.i18n.predefinedActivityType_CAR_WALKING;
      case PredefinedActivityType.OTHER:
      default:
        return context.i18n.predefinedActivityType_OTHER;
    }
  }
}

extension HealthWorkoutActivityTypeExtension on HealthWorkoutActivityType {
  String getTranslatedActivity(BuildContext context) {
    switch (this) {
      case HealthWorkoutActivityType.WALKING:
        return context.i18n.walking;
      case HealthWorkoutActivityType.RUNNING:
        return context.i18n.running;
      case HealthWorkoutActivityType.RUNNING_TREADMILL:
        return context.i18n.running_Treadmill;
      case HealthWorkoutActivityType.WALKING_TREADMILL:
        return context.i18n.walking_Treadmill;
      case HealthWorkoutActivityType.HIKING:
        return context.i18n.hiking;
      case HealthWorkoutActivityType.BIKING:
        return context.i18n.biking;
      case HealthWorkoutActivityType.SWIMMING:
        return context.i18n.swimmming;
      default:
        return this.name;
    }
  }
}
