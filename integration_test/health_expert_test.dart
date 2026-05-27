import 'package:aptapp/utils/keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:aptapp/main.dart' as app;

import 'test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('health expert tests', () {
    testWidgets('login and go through all possible screens', (tester) async {
      disableOverflowErrors();
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tapMenuItem(tester, find, KEY_BUTTON_LOGOUT);
      await doLogin(tester, find, "ap-hp@example.com", "password");
      await switchLanguage(tester, find);

      await tapPatients(tester, find);
      await tapExercises(tester, find, "Liegestütz", "Hypertroph");
      await tapMessages(tester);
    });
  });
}
