import 'orientation_lock_impl.dart' if (dart.library.html) 'orientation_lock_web_impl.dart' as impl;

abstract class OrientationLock {
  static Future<void> lockLandscape() => impl.lockLandscape();
  static Future<void> unlock() => impl.unlock();
}
