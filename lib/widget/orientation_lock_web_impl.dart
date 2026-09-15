// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:js_interop';
import 'package:web/web.dart' as web;

Future<void> lockLandscape() async {
  try {
    final orientation = web.window.screen.orientation;
    await orientation.lock('landscape').toDart;
  } catch (_) {
    // Orientation lock may not be supported in all browsers.
  }
}

Future<void> unlock() async {
  try {
    final orientation = web.window.screen.orientation;
    orientation.unlock();
  } catch (_) {
    // Ignore if unlock is not supported.
  }
}
