import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/push_notifications_manager.dart';
import 'package:beamer/beamer.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class UserRepository {
  final auth = new AuthenticationControllerApi(apiClient);
  final socialApi = new SocialControllerApi(apiClient);
  final userApi = new UserControllerApi(apiClient);
  CurrentUserDTO? user;

  UserRole? userRole;
  final _storage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
  bool triggeredRefreshCheck = false;

  get currentUser {
    if (userRole == UserRole.ADMINISTRATOR) {
      return user?.administrator;
    } else if (userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
      return user?.institutionAdministrator;
    } else if (userRole == UserRole.HEALTHCARE_PROFESSIONAL) {
      return user?.healthcareProfessional;
    } else if (userRole == UserRole.PATIENT) {
      return user?.patient;
    }
  }

  HealthcareProfessionalGetDTO? get currentHealthcareProfessional {
    return user?.healthcareProfessional;
  }

  InstitutionDTO? get currentInstitution {
    return user?.institution;
  }

  bool get showTrainingPlans {
    return userRole == UserRole.ADMINISTRATOR || user?.institution?.showTrainingPlans == true;
  }

  bool get hasExternalApps {
    return user?.hasExternalApps ?? false;
  }

  Future<AccessTokenDTO> authenticate({required String email, required String password, required TranslationLanguage language}) async {
    await this.deleteToken();
    final req = AuthenticationDTO()
      ..username = email
      ..password = password
      ..language = language;
    final res = await auth.createAuthenticationToken(req);
    if (!kIsWeb) {
      try {
        await _storage.write(key: "user", value: email);
        await _storage.write(key: "password", value: password);
      } on PlatformException catch (e) {
        print(e);
      }
    }
    this.persistToken(res!).then((value) => this.storeFirebaseToken());
    return res;
  }

  Future<void> storeFirebaseToken() async {
    final token = PushNotificationsManager().getToken();
    final isAuthenticated = await this.hasToken(null);
    if (token.isEmpty || !isAuthenticated) {
      return;
    }
    FirebaseTokenTarget target = FirebaseTokenTarget.WEB;
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        target = FirebaseTokenTarget.ANDROID;
      } else if (Platform.isIOS) {
        target = FirebaseTokenTarget.IOS;
      }
    }
    final firebaseTokenDTO = FirebaseTokenDTO()
      ..token = token
      ..target = target;
    await auth.storeFirebaseToken(firebaseTokenDTO);
  }

  Future<void> revokeFirebaseToken(String token) async {
    if (token.isEmpty) {
      return;
    }
    final isAuthenticated = await this.hasToken(null);
    if (token.isEmpty || !isAuthenticated) {
      return;
    }
    FirebaseTokenTarget target = FirebaseTokenTarget.WEB;
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        target = FirebaseTokenTarget.ANDROID;
      } else if (Platform.isIOS) {
        target = FirebaseTokenTarget.IOS;
      }
    }
    final firebaseTokenDTO = FirebaseTokenDTO()
      ..token = token
      ..target = target;
    await auth.revokeFirebaseToken(firebaseTokenDTO);
  }

  Future<void> getCurrentUser() async {
    apiClient.addDefaultHeader("Authorization", await getToken());
    this.user = await auth.getCurrentUser();
    userRole = user!.userRole;
    MatomoTracker.instance.setOptOut(optOut: !user!.acceptedTracking);
    MatomoTracker.instance.setVisitorUserId("${user!.userRole} ${currentUser.id}");
  }

  updateShareActivityData(bool shareActivityData, bool shareActiveMinutes) async {
    await socialApi.setShareActivityData(ShareActivityDataPostDTO(shareAcitivityData: shareActivityData, shareActiveMinutes: shareActiveMinutes));
    this.user = await auth.getCurrentUser();
  }

  storePatientState(String id, PatientState? patientState) async {
    await userApi.storePatientState(id, PatientStateDTO(state: patientState));
    this.user = await auth.getCurrentUser();
  }

  updateStatusMessage(String statusMessage) async {
    await socialApi.setStatusMessage(StatusMessagePostDTO(statusMessage: statusMessage));
    this.user = await auth.getCurrentUser();
  }

  Future<bool> hasToken(BuildContext? context) async {
    final prefs = await SharedPreferences.getInstance();
    bool toReturn = true;
    if (prefs.getKeys().contains("accessToken_refresh")) {
      final expiry = prefs.getInt("accessToken_expiry");
      final valid = expiry != null ? DateTime.now().addMinutes(1).millisecondsSinceEpoch < expiry : false;
      if (!valid) {
        toReturn = await refreshToken();
      }
    } else {
      toReturn = false;
    }
    if (!toReturn && !kIsWeb) {
      try {
        final credentials = await _storage.readAll();
        if (credentials.containsKey("user") && credentials.containsKey("password")) {
          try {
            TranslationLanguage language = TranslationLanguage.EN;
            if (context != null) {
              language = Localizations.localeOf(context).languageCode == 'de' ? TranslationLanguage.DE : TranslationLanguage.EN;
            }
            await authenticate(email: credentials["user"]!, password: credentials["password"]!, language: language);
            toReturn = true;
          } catch (err) {
            toReturn = false;
          }
        }
      } on PlatformException catch (e) {
        print(e);
        try {
          await _storage.deleteAll();
        } catch (_) {}
        toReturn = false;
      }
    }
    if (context != null && !toReturn) {
      await deleteToken();
      context.beamToNamed("/login");
    }
    return toReturn;
  }

  Future<bool> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    RefreshTokenDTO req = new RefreshTokenDTO();
    req.refreshToken = prefs.getString("accessToken_refresh");
    try {
      apiClient.addDefaultHeader("Authorization", "");
      final res = await auth.refreshAuthenticationToken(req);
      await this.persistToken(res!);
      return true;
    } catch (err) {
      print(err);
    }
    return false;
  }

  Future<bool> checkForRefreshToken({bool periodic = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getKeys().contains("accessToken_refresh")) {
        final expiry = prefs.getInt("accessToken_expiry");
        final valid = DateTime.now().addMinutes(1).millisecondsSinceEpoch < expiry!;
        print("check for refresh token: $valid");
        bool toReturn = true;
        if (!valid) {
          toReturn = await refreshToken();
          if (toReturn) {
            await this.getCurrentUser();
          }
        }
        return toReturn;
      }
      return false;
    } finally {
      if (!triggeredRefreshCheck || periodic) {
        Future.delayed(Duration(seconds: 30), () => this.checkForRefreshToken(periodic: true));
      }
      triggeredRefreshCheck = true;
    }
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains("accessToken_token")) {
      return prefs.getString("accessToken_token")!;
    }
    return "";
  }

  Future<bool> resetPassword({required ResetPasswordDTO resetPassword}) async {
    this.deleteToken();
    bool resetDone = await auth.resetPassword(resetPassword) ?? false;
    return resetDone;
  }

  Future<bool> forgotPassword({required forgotPassword}) async {
    await auth.forgotPassword(forgotPassword);
    return true;
  }

  Future<bool> changePassword(ChangePasswordDTO changePassword) async {
    bool success = await auth.changeUserPassword(changePassword) ?? false;
    if (success && !kIsWeb) {
      try {
        await _storage.write(key: "password", value: changePassword.newPassword);
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return success;
  }

  Future<void> persistToken(AccessTokenDTO accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryDate = DateTime.now().add(Duration(seconds: accessToken.expiresIn!));
    await prefs.setString("accessToken_token", accessToken.accessToken!);
    await prefs.setString("accessToken_refresh", accessToken.refreshToken!);
    await prefs.setInt("accessToken_expiry", expiryDate.millisecondsSinceEpoch);
    apiClient.addDefaultHeader("Authorization", accessToken.accessToken!);
    checkForRefreshToken();
  }

  void persistLanguage(String newLanguageCode) {
    auth.switchCurrentLanguage(LanguageSwitchDTO(language: newLanguageCode == 'de' ? TranslationLanguage.DE : TranslationLanguage.EN));
  }

  deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    user = null;
    userRole = null;
    await prefs.remove("accessToken_token");
    await prefs.remove("accessToken_refresh");
    await prefs.remove("accessToken_expiry");
    if (!kIsWeb) {
      try {
        await _storage.deleteAll();
      } on PlatformException catch (e) {
        print(e);
      }
    }
    apiClient.addDefaultHeader("Authorization", "");
  }
}
