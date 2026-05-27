import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:aptapp/main.dart' as app;

import 'test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('patient tests', () {
    testWidgets('login and go through all possible screens', (tester) async {
      disableOverflowErrors();
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tapMenuItem(tester, find, KEY_BUTTON_LOGOUT);
      await doLogin(tester, find, "ap-patient3@example.com", "password");
      await switchLanguage(tester, find);

      await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_NOTIFICATIONS)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CLOSE)));
      await tester.pumpAndSettle();

      final Finder buttonFinder = find.byKey(const ValueKey(KEY_PATIENT_CALENDAR_BUTTON_PREVIOUS_WEEK));
      // desktop calendar
      if (buttonFinder.evaluate().isEmpty) {
        await scrollAndTap(tester, find, KEY_PATIENT_CALENDAR_CARD_ACTIVE_MINUTES, KEY_PATIENT_CALENDAR_SCROLL_VIEW);
        await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CLOSE)));
        await tester.pumpAndSettle();
      }
      // mobile calendar
      else {}

      await tapMenuItem(tester, find, KEY_BUTTON_VIDEOS);
      await tapMenuItem(tester, find, KEY_BUTTON_EXPORT);
      await tapMenuItem(tester, find, KEY_BUTTON_HELP);
      //await tapMenuItem(tester, find, KEY_BUTTON_LEGAL_NOTICE);

      await tapMenuItem(tester, find, KEY_BUTTON_PROFILE);
      await scrollAndTap(tester, find, KEY_PATIENT_PROFILE_REQUEST_CHANGES, KEY_PATIENT_PROFILE_SCROLL_VIEW);
      await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CLOSE)));
      await tester.pumpAndSettle();
      await scrollAndTap(tester, find, KEY_PATIENT_PROFILE_BUTTON_CHANGE_PASSWORD, KEY_PATIENT_PROFILE_SCROLL_VIEW);
      await tester.tap(find.byKey(const ValueKey(KEY_BUTTON_CLOSE)));
      await tester.pumpAndSettle();
    });
  });
}
