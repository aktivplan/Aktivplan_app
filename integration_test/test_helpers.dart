// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

const INSTITUTION_NAME = "Sportmedizin Salzburg";
const HEALTHCARE_PROFESSIONAL_NAME = "House Gregory";
const PATIENT_NAME = "Prohaska Herbert";

void disableOverflowErrors() {
  final originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception;
    final isOverflowError =
        exception is FlutterError && !exception.diagnostics.any((e) => e.value.toString().startsWith("A RenderFlex overflowed by"));

    if (isOverflowError) {
      print(details);
    } else if (originalOnError != null) {
      originalOnError(details);
    }
  };
}

Future<void> doLogin(final WidgetTester tester, final CommonFinders find, final String username, final String password) async {
  await tester.enterText(find.byKey(const ValueKey(KEY_LOGIN_TEXT_EMAIL)), username);
  await tester.enterText(find.byKey(const ValueKey(KEY_LOGIN_TEXT_PASSWORD)), password);
  await tester.ensureVisible(find.byKey(const ValueKey(KEY_LOGIN_BUTTON_SUBMIT)));
  await tester.tap(find.byKey(const ValueKey(KEY_LOGIN_BUTTON_SUBMIT)));
  await tester.pumpAndSettle();
}

Future<void> scrollAndTap(final WidgetTester tester, final CommonFinders find, final String elementKey, final String scrollElementKey) async {
  await tester.dragUntilVisible(find.byKey(ValueKey(elementKey)), find.byKey(ValueKey(scrollElementKey)), const Offset(0, -800));
  await tester.tap(find.byKey(ValueKey(elementKey)));
  await tester.pumpAndSettle();
}

Future<Finder> tapMenuItem(final WidgetTester tester, final CommonFinders find, final String elementKey) async {
  final Finder elementFinder = find.byKey(ValueKey(elementKey));
  if (elementFinder.evaluate().isNotEmpty) {
    await tester.tap(elementFinder);
    await tester.pumpAndSettle();
    return elementFinder;
  } else {
    final Finder drawerFinder = find.byKey(const ValueKey(KEY_BUTTON_DRAWER));
    if (drawerFinder.evaluate().isEmpty) {
      return drawerFinder;
    }
    await tester.tap(drawerFinder);
    await tester.pumpAndSettle();
    final Finder mobileElement = find.byKey(ValueKey(elementKey));
    await tester.tap(mobileElement);
    await tester.pumpAndSettle();
    return mobileElement;
  }
}

Future<void> tapHealthcareProfessionalsAndBelow(final WidgetTester tester, final CommonFinders find) async {
  await tester.tap(find.byKey(const ValueKey(KEY_HEALTHCARE_PROFESSIONALS_BUTTON_EDIT_INSTITUTION)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_INSTITUTION_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_ADD, KEY_HEALTHCARE_PROFESSIONALS_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
  await tester.tap(find.text(HEALTHCARE_PROFESSIONAL_NAME));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey(KEY_PATIENTS_BUTTON_EDIT_HEALTH_EXPERT)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_PATIENTS_BUTTON_MESSAGES, KEY_PATIENTS_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_PATIENTS_SCROLL_VIEW);
  await tapPatients(tester, find);
}

Future<void> tapPatients(final WidgetTester tester, final CommonFinders find) async {
  await scrollAndTap(tester, find, KEY_BUTTON_ADD, KEY_PATIENTS_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_PATIENT_DATA_SCROLL_VIEW);
  await tester.tap(find.text("PDF").first);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
  await tester.tap(find.text("CSV").first);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
  await tester.tap(find.text(PATIENT_NAME));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey(KEY_PATIENT_CALENDAR_BUTTON_EDIT)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_PATIENT_DATA_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_PATIENT_CALENDAR_CARD_ACTIVE_MINUTES, KEY_PATIENT_CALENDAR_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CLOSE)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_PATIENT_CALENDAR_BUTTON_ADD_PERSONAL_GOAL, KEY_PATIENT_CALENDAR_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_PATIENT_CALENDAR_BUTTON_FINAL_CHECK, KEY_PATIENT_CALENDAR_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_PATIENT_CALENDAR_BUTTON_MESSAGE, KEY_PATIENT_CALENDAR_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_PATIENT_CALENDAR_BUTTON_CONVERSATION_GUIDE, KEY_PATIENT_CALENDAR_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_PATIENT_CALENDAR_CONVERSATION_GUIDE_BUTTON_START)));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_BUTTON_NEXT, KEY_LAYOUT_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_NEXT, KEY_LAYOUT_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_LAYOUT_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_PATIENT_CALENDAR_BUTTON_EDIT_NOTES, KEY_PATIENT_CALENDAR_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CANCEL)));
  await tester.pumpAndSettle();
}

Future<void> tapExercises(final WidgetTester tester, final CommonFinders find, final String workoutStrengtheningExerciseName,
    final String workoutHypertrophyExerciseName) async {
  await tapMenuItem(tester, find, KEY_BUTTON_ACTIVITIES);
  for (final String optionKey in [
    KEY_EXERCISES_OVERVIEW_OPTION_ENDURANCE,
    KEY_EXERCISES_OVERVIEW_OPTION_INTERVAL,
    KEY_EXERCISES_OVERVIEW_OPTION_STRENGTHENING,
    KEY_EXERCISES_OVERVIEW_OPTION_HYPERTROPHY,
    KEY_EXERCISES_OVERVIEW_OPTION_OTHER
  ]) {
    await scrollAndTap(tester, find, optionKey, KEY_EXERCISES_SCROLL_VIEW);
    await scrollAndTap(tester, find, KEY_BUTTON_ADD, KEY_EXERCISES_SCROLL_VIEW);
    await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_EXERCISES_SCROLL_VIEW);
    await tester.tap(find.byKey(ValueKey(KEY_EXERCISES_BREAD_CRUMB_EXERCISES)));
    await tester.pumpAndSettle();
  }
  await scrollAndTap(tester, find, KEY_EXERCISES_OVERVIEW_OPTION_WORKOUT, KEY_EXERCISES_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_ADD, KEY_EXERCISES_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_ADD, KEY_EXERCISES_SCROLL_VIEW);
  await tester.tap(find.byKey(const ValueKey(KEY_WORKOUT_OPTION_STRENGTHENING)));
  await tester.pumpAndSettle();
  await tester.tap(find.text(workoutStrengtheningExerciseName));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey(KEY_WORKOUT_BREAD_CRUMB_EXERCISES)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey(KEY_WORKOUT_OPTION_HYPERTROPHY)));
  await tester.pumpAndSettle(Duration(seconds: 1));
  await tester.tap(find.text(workoutHypertrophyExerciseName));
  await tester.pumpAndSettle();
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_WORKOUT_EXERCISE_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_EXERCISES_SCROLL_VIEW);
}

Future<void> tapMessages(final WidgetTester tester) async {
  await tapMenuItem(tester, find, KEY_BUTTON_MESSAGES);
  await scrollAndTap(tester, find, KEY_BUTTON_ADD, KEY_MESSAGE_OVERVIEW_SCROLL_VIEW);
  await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_LAYOUT_SCROLL_VIEW);
}

Future<void> switchLanguage(final WidgetTester tester, final CommonFinders find) async {
  Finder languageButton = await tapMenuItem(tester, find, KEY_BUTTON_CHANGE_LANGUAGE);
  Text languageText = find
      .descendant(
        of: languageButton,
        matching: find.byType(Text),
      )
      .evaluate()
      .first
      .widget as Text;
  final String newLanguageText = languageText.data ?? "";
  languageButton = await tapMenuItem(tester, find, KEY_BUTTON_CHANGE_LANGUAGE);
  languageText = find
      .descendant(
        of: languageButton,
        matching: find.byType(Text),
      )
      .evaluate()
      .first
      .widget as Text;
  final String initialLanguageText = languageText.data ?? "";
  expect(newLanguageText.compareTo(initialLanguageText) != 0, true);
  final Finder drawerFinder = find.byKey(const ValueKey(KEY_BUTTON_DRAWER_CLOSE));
  // close drawer after language change
  if (drawerFinder.evaluate().isNotEmpty) {
    await tester.tap(drawerFinder);
    await tester.pumpAndSettle();
  }
}
