import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/root_locations.dart';
import 'package:aptapp/push_notifications_manager.dart';
import 'package:beamer/beamer.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userRepository = KiwiContainer().resolve<UserRepository>();
List<BeamGuard> guards = [
  //GLOBAL

  BeamGuard(
    pathPatterns: ['/login'],
    guardNonMatching: true,
    check: (context, location) {
      return userRepository.currentUser != null || location is ResetPasswordLocation || location is ImprintLocation;
    },
    replaceCurrentStack: true,
    beamToNamed: (from, to) => '/login',
  ),

  BeamGuard(
    pathPatterns: ['/login', '/'],
    check: (context, location) {
      return userRepository.currentUser == null;
    },
    replaceCurrentStack: true,
    beamToNamed: (origin, target) {
      switch (userRepository.userRole) {
        case UserRole.ADMINISTRATOR:
          return '/institutions';
        case UserRole.INSTITUTION_ADMINISTRATOR:
          return '/professionals';
        case UserRole.HEALTHCARE_PROFESSIONAL:
          return '/patients';
        case UserRole.PATIENT:
          if (PushNotificationsManager().hasReceivedNotification()) {
            PushNotificationsManager().setReceivedNotification(false);
            SharedPreferences.getInstance().then((value) => value.setBool("receivedNotification", false));
            return "/personal-messages";
          }
          return '/calendar';
        default:
          return '/login';
      }
    },
  ),

  // ADMIN
  BeamGuard(
    pathPatterns: ['/institutions*', '/healthcare-professionals*', '/healthcare-professionals/*/patients/*'],
    replaceCurrentStack: true,
    check: (context, location) {
      userRepository.hasToken(context);
      final beamState = location.state as BeamState;
      return userRepository.userRole == UserRole.ADMINISTRATOR ||
          (beamState.uriBlueprint.toString() == "/institutions/:id/edit" && userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR);
    },
    beamToNamed: (from, to) => '/login',
  ),
  // INSTITUTION ADMIN
  BeamGuard(
    replaceCurrentStack: true,
    pathPatterns: ['/professionals*', '/professionals/*'],
    check: (context, location) {
      userRepository.hasToken(context);
      return userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR;
    },
    beamToNamed: (from, to) => '/login',
  ),
  // HEALTHCARE_PROFESSIONAL
  BeamGuard(
    replaceCurrentStack: true,
    pathPatterns: ['/patients', '/patients*'],
    check: (context, location) {
      userRepository.hasToken(context);
      return userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL ||
          userRepository.userRole == UserRole.ADMINISTRATOR ||
          userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR;
    },
    beamToNamed: (from, to) => '/login',
  ),
  // INSTITUTION_ADMINISTRATOR && HEALTHCARE_PROFESSIONAL
  BeamGuard(
    replaceCurrentStack: true,
    pathPatterns: ['/training*', '/workout*', '/messages*'],
    check: (context, location) {
      userRepository.hasToken(context);
      return userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL ||
          userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR ||
          userRepository.userRole == UserRole.ADMINISTRATOR;
    },
    beamToNamed: (from, to) => '/login',
  ),
  // PATIENT
  BeamGuard(
    replaceCurrentStack: true,
    pathPatterns: [
      '/calendar',
      '/videos',
      '/export',
      '/active-minutes',
      '/my-healthcare-professional/*',
      '/data',
      '/data/edit',
      '/personal-messages'
    ],
    check: (context, location) {
      userRepository.hasToken(context);
      return userRepository.userRole == UserRole.PATIENT;
    },
    beamToNamed: (from, to) => '/login',
  ),
];
