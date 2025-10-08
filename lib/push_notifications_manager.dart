// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/authentication/user_repository.dart';
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
        FirebaseMessaging.instance.getToken().then((token) {
          assert(token != null);
          _firebaseToken = token ?? "";
          if (prefs.getKeys().contains("firebaseToken") && prefs.getString("firebaseToken") != _firebaseToken) {
            KiwiContainer().resolve<UserRepository>().revokeFirebaseToken(prefs.getString("firebaseToken") ?? "");
          }
          prefs.setString("firebaseToken", _firebaseToken);
          KiwiContainer().resolve<UserRepository>().storeFirebaseToken();
        });
      }

      _initialized = true;
    }
  }
}
