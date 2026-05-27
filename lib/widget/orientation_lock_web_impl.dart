// ignore_for_file: deprecated_member_use
import 'dart:html' as html;

Future<void> lockLandscape() async {
  try {
    final orientation = html.window.screen?.orientation;
    if (orientation != null) {
      await orientation.lock('landscape');
    }
  } catch (_) {
    // Orientation lock may not be supported in all browsers.
  }
}

Future<void> unlock() async {
  try {
    final orientation = html.window.screen?.orientation;
    if (orientation != null) {
      orientation.unlock();
    }
  } catch (_) {
    // Ignore if unlock is not supported.
  }
}
