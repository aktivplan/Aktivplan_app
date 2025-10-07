# Aktivplanplus Application

Flutter multiplatform mobile application

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

We recommend using the Flutter Version Manager with the Flutter 3.24.5 release

## Update Api

```
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Deployment

- [Setup AWS Cli with access_key and access_secret](https://aws.amazon.com/cli/)

### DEV

```
fvm flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true && cp -R build/web/* ../apt-backend/src/main/resources/static
```

### PROD

#### WEB

```
fvm flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true --dart-define BASE_URL=https://aktivplan.lbidhp.at --dart-define MATOMO_URL=https://analytics.alphaport.at --dart-define MATOMO_SITE_ID=5 && cp -R build/web/* ../apt-backend/src/main/resources/static
```

#### IOS

```
fvm flutter build ios --release --dart-define BASE_URL=https://aktivplan.lbidhp.at --dart-define MATOMO_URL=https://analytics.alphaport.at --dart-define MATOMO_SITE_ID=5
```

In Xcode have a valid release profile configured (see Apple docs)

For Uploading to Appstore Connect use `Product > Archive` make sure you have selected `Any iOS Device (arm64, armv7)` otherwise Archive is not available

#### Android

##### Google Play Release

```
fvm flutter build appbundle --release --dart-define BASE_URL=https://aktivplan.lbidhp.at --dart-define MATOMO_URL=https://analytics.alphaport.at --dart-define MATOMO_SITE_ID=5
```

##### APK Release

```
fvm flutter build apk --release --dart-define BASE_URL=https://aktivplan.lbidhp.at --dart-define MATOMO_URL=https://analytics.alphaport.at --dart-define MATOMO_SITE_ID=5
```

### Testing

On the Web:

```
fvm flutter run -d chrome --web-port 2021 integration_test/login_test.dart
fvm flutter run -d chrome --web-port 2021 integration_test/administrator_test.dart
fvm flutter run -d chrome --web-port 2021 integration_test/institution_administrator_test.dart
fvm flutter run -d chrome --web-port 2021 integration_test/health_expert_test.dart
fvm flutter run -d chrome --web-port 2021 integration_test/patient_test.dart
```

On Android/iOS devices:

```
fvm flutter test integration_test
```

For Firebase

```
fvm flutter build apk
./android/gradlew app:assembleAndroidTest
./android/gradlew app:assembleDebug -Ptarget=integration_test/administrator_test.dart
```

Upload the debug apk to the test lab

### App Force Update

When there should be a new App version which must be updated to that version, the version.json file in the static folder must be updated with the new version number. Therefore the version.json accessible through the Web App might be different from an older version.json stored in the local App assets. When that happens a screen is shown which forces the user to update the App (see the linked [issue](https://gitlab.alphaport.at/lbi/activity-planning-tool/aptapp/-/issues/219)).

### Port forward database

´´´
kubectl config use-context ap-cluster-prod-new
kubectl port-forward -n activity-planning-plus-prod-infrastructure svc/mongodb 27017:27017
´´´
