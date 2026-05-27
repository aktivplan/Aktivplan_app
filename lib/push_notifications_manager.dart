import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/firebase_options.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  MessageBloc? _messageBloc;
  bool _initialized = false;
  bool _openedNotification = false;
  String _firebaseToken = "";

  void setMessageBloc(MessageBloc messageBloc) {
    _messageBloc = messageBloc;
  }

  String getToken() {
    return _firebaseToken;
  }

  bool hasReceivedNotification() {
    return _openedNotification;
  }

  void setReceivedNotification(bool openedNotification) {
    _openedNotification = openedNotification;
  }

  Future<void> init() async {
    if (!_initialized) {
      FirebaseMessaging.onMessage.listen((event) {
        if (_messageBloc != null) {
          _messageBloc!..add(FetchMessageCountEvent());
        }
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(category: EVENT_CATEGORY_PUSH_NOTIFICATION, name: EVENT_NAME_RECEIVE, action: "Received Push Notification"),
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        _openedNotification = true;
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(category: EVENT_CATEGORY_PUSH_NOTIFICATION, name: EVENT_NAME_OPEN, action: "Opened Push Notification"),
        );
      });

      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          _openedNotification = true;
          MatomoTracker.instance.trackEvent(
            eventInfo: EventInfo(category: EVENT_CATEGORY_PUSH_NOTIFICATION, name: EVENT_NAME_OPEN, action: "Opened Push Notification"),
          );
        }
      });

      final notficationSetting = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (notficationSetting.authorizationStatus != AuthorizationStatus.denied &&
          notficationSetting.authorizationStatus != AuthorizationStatus.notDetermined) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token;
        if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
          token = await FirebaseMessaging.instance.getToken(
            vapidKey: "BOlQ6Uxy9RaahdNcygvbXuyo5m1CxwbljoKAhSxglp2MCywZTEFTEd-j1I14k-wIaCGknUuQDcYd3TSmJfSuBms",
          );
        } else {
          token = await FirebaseMessaging.instance.getToken();
        }
        _firebaseToken = token ?? "";
        if (prefs.getKeys().contains("firebaseToken") && prefs.getString("firebaseToken") != _firebaseToken) {
          KiwiContainer().resolve<UserRepository>().revokeFirebaseToken(prefs.getString("firebaseToken") ?? "");
        }
        prefs.setString("firebaseToken", _firebaseToken);
        KiwiContainer().resolve<UserRepository>().storeFirebaseToken();
      }

      _initialized = true;
    }
  }
}
