import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:aptapp/main.dart' as app;

import 'test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('admin screen tests', () {
    testWidgets('login and go through all possible screens', (tester) async {
      disableOverflowErrors();
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tapMenuItem(tester, find, KEY_BUTTON_LOGOUT);
      await doLogin(tester, find, "admin@example.com", "password");
      await switchLanguage(tester, find);

      await scrollAndTap(tester, find, KEY_BUTTON_ADD, KEY_INSTITUTION_OVERVIEW_SCROLL_VIEW);
      await scrollAndTap(tester, find, KEY_BUTTON_CANCEL, KEY_INSTITUTION_SCROLL_VIEW);
      await tester.tap(find.text(INSTITUTION_NAME));
      await tester.pumpAndSettle();

      await tapHealthcareProfessionalsAndBelow(tester, find);

      final Finder breadCrumbFinder = find.byKey(const ValueKey(KEY_PATIENT_CALENDAR_BREAD_CRUMB_HEALTHCARE_PROFESSIONAL));
      // bread crumb only visible in desktop mode
      if (breadCrumbFinder.evaluate().isNotEmpty) {
        await tester.tap(breadCrumbFinder);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey(KEY_PATIENTS_BREAD_CRUMB_INSTITUTION)));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey(KEY_HEALTHCARE_PROFESSIONALS_BREAD_CRUMB_INSTITUTIONS)));
        await tester.pumpAndSettle();
      }

      await tapExercises(tester, find, "test kraft", "test hy");
      await tapMessages(tester);
    });
  });
}
