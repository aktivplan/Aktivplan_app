import 'package:flutter/foundation.dart';

/// Whether the on-device HealthKit debug tooling is available: the "add sample
/// workout to health" button on the calendar, and the `[hkit-match]` tracing
/// that explains every matching decision.
///
/// On in any debug build. For a release-speed APK that still carries the tools:
///
///     fvm flutter build apk --dart-define=DEBUG_TOOLS=true
///
/// A plain `flutter build apk` leaves it false, and because this is a `const`
/// the guarded code is tree-shaken out of that build entirely.
const bool showDebugTools = kDebugMode || bool.fromEnvironment('DEBUG_TOOLS');
