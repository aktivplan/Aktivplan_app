import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:aptapp/main.dart' as app;

import 'test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login screen tests', () {
    testWidgets('login with wrong credentials and navigate to reset password page', (tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tapMenuItem(tester, find, KEY_BUTTON_LOGOUT);

      // don't use real user name to avoid user being blocked by chino
      await doLogin(tester, find, "non-existing-admin@example.com", "wrongpassword");
      expect(find.byKey(const ValueKey(KEY_LOGIN_TEXT_WRONG_CREDENTIALS)), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey(KEY_LOGIN_BUTTON_RESET_PASSWORD)));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey(KEY_RESET_PASSWORD_BUTTON_SUBMIT)), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey(KEY_RESET_PASSWORD_TEXT_EMAIL)), "non-existing-admin@example.com");
      await tester.tap(find.byKey(const ValueKey(KEY_RESET_PASSWORD_BUTTON_SUBMIT)));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey(KEY_RESET_PASSWORD_CONFIRMATION)), findsOneWidget);
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey(KEY_LOGIN_BUTTON_SUBMIT)), findsOneWidget);
    });
  });
}
