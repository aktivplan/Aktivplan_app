import 'package:apt_api/api.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String getTranslatedText(Map<String, String>? translationField, BuildContext context) {
  if (translationField == null) {
    return "";
  }
  final String userLocale = Localizations.localeOf(context).languageCode.toUpperCase();
  if (translationField.containsKey(userLocale) && (translationField[userLocale] ?? "").isNotEmpty) {
    return translationField[userLocale]!;
  }
  final String otherLocale = userLocale == "DE" ? "EN" : "DE";
  if (translationField.containsKey(otherLocale)) {
    return translationField[otherLocale]!;
  }
  return "";
}

bool hasTranslatedText(Map<String, String>? translationField) {
  if (translationField == null) {
    return false;
  }
  return (translationField.containsKey("DE") && (translationField["DE"] ?? "").isNotEmpty) ||
      (translationField.containsKey("EN") && (translationField["EN"] ?? "").isNotEmpty);
}

Map<String, String> getTranslationObjectFromController(TextEditingController germanTextController, TextEditingController englishTextController) {
  return {"DE": germanTextController.text, "EN": englishTextController.text};
}

Map<String, String> getTranslationObjectFromText(String? germanText, String? englishText) {
  return {"DE": germanText ?? "", "EN": englishText ?? ""};
}

void initTextEditingControllerFromTranslationObject(
    Map<String, String>? translationField, TextEditingController germanTextController, TextEditingController englishTextController) {
  germanTextController.text = translationField?["DE"] ?? "";
  englishTextController.text = translationField?["EN"] ?? "";
}

String getTranslatedTimeString(String? time, BuildContext context) {
  if ((time ?? "").isEmpty) {
    return "";
  }
  final String userLocale = Localizations.localeOf(context).languageCode.toUpperCase();
  if (userLocale == "DE") {
    return "$time Uhr";
  }
  final DateTime tempDate = DateFormat("hh:mm").parse(time!);
  return DateFormat("h:mm a").format(tempDate);
}

String getStrengtheningExecutionString(StrengtheningExercisePostDTO exercise, BuildContext context) {
  if (exercise.hasRepeatCount ?? false) {
    if ((exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0) > 0) {
      return exercise.exerciseRepeatSets == 1
          ? context.i18n.executionWithSetRepeatsAndBreak(exercise.exerciseRepeatCount ?? 1, exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0)
          : context.i18n.executionWithSetsRepeatsAndBreak(
              exercise.exerciseRepeatSets ?? 0, exercise.exerciseRepeatCount ?? 1, exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0);
    }
    return exercise.exerciseRepeatSets == 1
        ? context.i18n.executionWithSetRepeats(exercise.exerciseRepeatCount ?? 1)
        : context.i18n.executionWithSetsRepeats(exercise.exerciseRepeatSets ?? 0, exercise.exerciseRepeatCount ?? 1);
  } else {
    if ((exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0) > 0) {
      return exercise.exerciseRepeatSets == 1
          ? context.i18n.executionWithSetSecondsAndBreak(exercise.exerciseDurationSeconds ?? 0, exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0)
          : context.i18n.executionWithSetsSecondsAndBreak(
              exercise.exerciseRepeatSets ?? 0, exercise.exerciseDurationSeconds ?? 0, exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0);
    }
    return exercise.exerciseRepeatSets == 1
        ? context.i18n.executionWithSetSeconds(exercise.exerciseDurationSeconds ?? 0)
        : context.i18n.executionWithSetsSeconds(exercise.exerciseRepeatSets ?? 0, exercise.exerciseDurationSeconds ?? 0);
  }
}
