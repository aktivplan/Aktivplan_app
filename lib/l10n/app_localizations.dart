import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @achievedActivityShort.
  ///
  /// In de, this message translates to:
  /// **'Gratulation, Ziel erreicht!'**
  String get achievedActivityShort;

  /// No description provided for @achieveUntil.
  ///
  /// In de, this message translates to:
  /// **'Erreichen bis'**
  String get achieveUntil;

  /// No description provided for @active.
  ///
  /// In de, this message translates to:
  /// **'aktiv'**
  String get active;

  /// No description provided for @activeMinutes.
  ///
  /// In de, this message translates to:
  /// **'Aktive Minuten'**
  String get activeMinutes;

  /// No description provided for @activeMinutesKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätspunkte'**
  String get activeMinutesKlimafit;

  /// No description provided for @activeMinutesHide.
  ///
  /// In de, this message translates to:
  /// **'Aktive Minuten ausblenden'**
  String get activeMinutesHide;

  /// No description provided for @activeMinutesHideKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätspunkte ausblenden'**
  String get activeMinutesHideKlimafit;

  /// No description provided for @activeMinutesInCalendarWeek.
  ///
  /// In de, this message translates to:
  /// **'Aktive Minuten in KW {calendarWeek}'**
  String activeMinutesInCalendarWeek(int calendarWeek);

  /// No description provided for @activeMinutesInCalendarWeekKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätspunkte in KW {calendarWeek}'**
  String activeMinutesInCalendarWeekKlimafit(int calendarWeek);

  /// No description provided for @activeMinutesPerWeek.
  ///
  /// In de, this message translates to:
  /// **'Aktive Minuten pro Woche'**
  String get activeMinutesPerWeek;

  /// No description provided for @activeMinutesPerWeekKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätspunkte pro Woche'**
  String get activeMinutesPerWeekKlimafit;

  /// No description provided for @activeMinutesPerWeekAmount.
  ///
  /// In de, this message translates to:
  /// **'{amount} aktive Minuten pro Woche'**
  String activeMinutesPerWeekAmount(int amount);

  /// No description provided for @activeMinutesPerWeekAmountKlimafit.
  ///
  /// In de, this message translates to:
  /// **'{amount} Aktivitätspunkte pro Woche'**
  String activeMinutesPerWeekAmountKlimafit(int amount);

  /// No description provided for @activeMinutesShow.
  ///
  /// In de, this message translates to:
  /// **'Aktive Minuten anzeigen'**
  String get activeMinutesShow;

  /// No description provided for @activeMinutesShowKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätspunkte anzeigen'**
  String get activeMinutesShowKlimafit;

  /// No description provided for @activities.
  ///
  /// In de, this message translates to:
  /// **'Aktivitäten'**
  String get activities;

  /// No description provided for @activity.
  ///
  /// In de, this message translates to:
  /// **'Aktivität'**
  String get activity;

  /// No description provided for @activity_APPOINTMENT.
  ///
  /// In de, this message translates to:
  /// **'Termin'**
  String get activity_APPOINTMENT;

  /// No description provided for @activity_ENDURANCE.
  ///
  /// In de, this message translates to:
  /// **'Ausdauer'**
  String get activity_ENDURANCE;

  /// No description provided for @activity_EXTRA.
  ///
  /// In de, this message translates to:
  /// **'Extra'**
  String get activity_EXTRA;

  /// No description provided for @activity_HYPERTROPHY.
  ///
  /// In de, this message translates to:
  /// **'Hypertrophietraining'**
  String get activity_HYPERTROPHY;

  /// No description provided for @activity_INTERVAL.
  ///
  /// In de, this message translates to:
  /// **'Intervall Ausdauer'**
  String get activity_INTERVAL;

  /// No description provided for @activity_OTHER.
  ///
  /// In de, this message translates to:
  /// **'Andere Übung'**
  String get activity_OTHER;

  /// No description provided for @activity_PREDEFINED_ACTIVE_MOBILITY.
  ///
  /// In de, this message translates to:
  /// **'Aktive Mobilität'**
  String get activity_PREDEFINED_ACTIVE_MOBILITY;

  /// No description provided for @activity_PREDEFINED_ACTIVITY.
  ///
  /// In de, this message translates to:
  /// **'Aktivität'**
  String get activity_PREDEFINED_ACTIVITY;

  /// No description provided for @activity_STRENGTHENING.
  ///
  /// In de, this message translates to:
  /// **'Kraftausdauer'**
  String get activity_STRENGTHENING;

  /// No description provided for @activity_TASK.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe'**
  String get activity_TASK;

  /// No description provided for @activity_WORKOUT.
  ///
  /// In de, this message translates to:
  /// **'Workout'**
  String get activity_WORKOUT;

  /// No description provided for @activityClass.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätsklasse'**
  String get activityClass;

  /// No description provided for @activityClass_0_description.
  ///
  /// In de, this message translates to:
  /// **'Kein Training'**
  String get activityClass_0_description;

  /// No description provided for @activityClass_0_frequency.
  ///
  /// In de, this message translates to:
  /// **'-'**
  String get activityClass_0_frequency;

  /// No description provided for @activityClass_0_duration.
  ///
  /// In de, this message translates to:
  /// **'-'**
  String get activityClass_0_duration;

  /// No description provided for @activityClass_1_description.
  ///
  /// In de, this message translates to:
  /// **'Gelegentliches, leichtes Training'**
  String get activityClass_1_description;

  /// No description provided for @activityClass_1_frequency.
  ///
  /// In de, this message translates to:
  /// **'Einmal alle zwei Wochen'**
  String get activityClass_1_frequency;

  /// No description provided for @activityClass_1_duration.
  ///
  /// In de, this message translates to:
  /// **'Weniger als 15 Minuten'**
  String get activityClass_1_duration;

  /// No description provided for @activityClass_2_description.
  ///
  /// In de, this message translates to:
  /// **'Gelegentliches, leichtes Training'**
  String get activityClass_2_description;

  /// No description provided for @activityClass_2_frequency.
  ///
  /// In de, this message translates to:
  /// **'Einmal alle zwei Wochen'**
  String get activityClass_2_frequency;

  /// No description provided for @activityClass_2_duration.
  ///
  /// In de, this message translates to:
  /// **'15 bis 30 Minuten'**
  String get activityClass_2_duration;

  /// No description provided for @activityClass_3_description.
  ///
  /// In de, this message translates to:
  /// **'Gelegentliches, leichtes Training'**
  String get activityClass_3_description;

  /// No description provided for @activityClass_3_frequency.
  ///
  /// In de, this message translates to:
  /// **'Einmal pro Woche'**
  String get activityClass_3_frequency;

  /// No description provided for @activityClass_3_duration.
  ///
  /// In de, this message translates to:
  /// **'ca. 30 Minuten'**
  String get activityClass_3_duration;

  /// No description provided for @activityClass_4_description.
  ///
  /// In de, this message translates to:
  /// **'Regelmäßiges Training'**
  String get activityClass_4_description;

  /// No description provided for @activityClass_4_frequency.
  ///
  /// In de, this message translates to:
  /// **'Zwei- bis dreimal pro Woche'**
  String get activityClass_4_frequency;

  /// No description provided for @activityClass_4_duration.
  ///
  /// In de, this message translates to:
  /// **'ca. 45 Minuten'**
  String get activityClass_4_duration;

  /// No description provided for @activityClass_5_description.
  ///
  /// In de, this message translates to:
  /// **'Regelmäßiges Training'**
  String get activityClass_5_description;

  /// No description provided for @activityClass_5_frequency.
  ///
  /// In de, this message translates to:
  /// **'Zwei- bis dreimal pro Woche'**
  String get activityClass_5_frequency;

  /// No description provided for @activityClass_5_duration.
  ///
  /// In de, this message translates to:
  /// **'45 Minuten bis 1 Stunde'**
  String get activityClass_5_duration;

  /// No description provided for @activityClass_6_description.
  ///
  /// In de, this message translates to:
  /// **'Regelmäßiges Training'**
  String get activityClass_6_description;

  /// No description provided for @activityClass_6_frequency.
  ///
  /// In de, this message translates to:
  /// **'Zwei- bis dreimal pro Woche'**
  String get activityClass_6_frequency;

  /// No description provided for @activityClass_6_duration.
  ///
  /// In de, this message translates to:
  /// **'1 bis 3 Stunden'**
  String get activityClass_6_duration;

  /// No description provided for @activityClass_7_description.
  ///
  /// In de, this message translates to:
  /// **'Regelmäßiges Training'**
  String get activityClass_7_description;

  /// No description provided for @activityClass_7_frequency.
  ///
  /// In de, this message translates to:
  /// **'Zwei- bis dreimal pro Woche'**
  String get activityClass_7_frequency;

  /// No description provided for @activityClass_7_duration.
  ///
  /// In de, this message translates to:
  /// **'3 bis 7 Stunden'**
  String get activityClass_7_duration;

  /// No description provided for @activityClass_8_description.
  ///
  /// In de, this message translates to:
  /// **'Tägliches Training'**
  String get activityClass_8_description;

  /// No description provided for @activityClass_8_frequency.
  ///
  /// In de, this message translates to:
  /// **'Fast täglich'**
  String get activityClass_8_frequency;

  /// No description provided for @activityClass_8_duration.
  ///
  /// In de, this message translates to:
  /// **'7 bis 11 Stunden'**
  String get activityClass_8_duration;

  /// No description provided for @activityClass_9_description.
  ///
  /// In de, this message translates to:
  /// **'Tägliches Training'**
  String get activityClass_9_description;

  /// No description provided for @activityClass_9_frequency.
  ///
  /// In de, this message translates to:
  /// **'Täglich'**
  String get activityClass_9_frequency;

  /// No description provided for @activityClass_9_duration.
  ///
  /// In de, this message translates to:
  /// **'11 bis 15 Stunden'**
  String get activityClass_9_duration;

  /// No description provided for @activityClass_10_description.
  ///
  /// In de, this message translates to:
  /// **'Tägliches Training'**
  String get activityClass_10_description;

  /// No description provided for @activityClass_10_frequency.
  ///
  /// In de, this message translates to:
  /// **'Täglich'**
  String get activityClass_10_frequency;

  /// No description provided for @activityClass_10_duration.
  ///
  /// In de, this message translates to:
  /// **'Mehr als 15 Stunden'**
  String get activityClass_10_duration;

  /// No description provided for @activityClasses.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätsklassen'**
  String get activityClasses;

  /// No description provided for @activityDataCheckQuestion.
  ///
  /// In de, this message translates to:
  /// **'Sind die folgenden Angaben korrekt?'**
  String get activityDataCheckQuestion;

  /// No description provided for @activityMoveHint.
  ///
  /// In de, this message translates to:
  /// **'Drücke lange auf eine Aktivität, um sie auf einen anderen Tag zu verschieben.'**
  String get activityMoveHint;

  /// No description provided for @activityMoveWarning.
  ///
  /// In de, this message translates to:
  /// **'Hinweis: Durch das Verschieben ist diese Aktivität nun nicht mehr Teil der Terminserie.'**
  String get activityMoveWarning;

  /// No description provided for @activityPlanStep1.
  ///
  /// In de, this message translates to:
  /// **'Art der Aktivität wählen'**
  String get activityPlanStep1;

  /// No description provided for @activityPlanStep1Short.
  ///
  /// In de, this message translates to:
  /// **'Aktivität wählen'**
  String get activityPlanStep1Short;

  /// No description provided for @activityPlanStep2.
  ///
  /// In de, this message translates to:
  /// **'Aktivität anpassen'**
  String get activityPlanStep2;

  /// No description provided for @activityPlanStep2Appointment.
  ///
  /// In de, this message translates to:
  /// **'Termin anpassen'**
  String get activityPlanStep2Appointment;

  /// No description provided for @activityPlanStep3.
  ///
  /// In de, this message translates to:
  /// **'Aktivität planen'**
  String get activityPlanStep3;

  /// No description provided for @activityPlanStep3Appointment.
  ///
  /// In de, this message translates to:
  /// **'Termin planen'**
  String get activityPlanStep3Appointment;

  /// No description provided for @activityPreference.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätspräferenz'**
  String get activityPreference;

  /// No description provided for @activityRepeat_BIWEEKLY.
  ///
  /// In de, this message translates to:
  /// **'Alle 2 Wochen'**
  String get activityRepeat_BIWEEKLY;

  /// No description provided for @activityRepeat_NEVER.
  ///
  /// In de, this message translates to:
  /// **'Keine Wiederholung'**
  String get activityRepeat_NEVER;

  /// No description provided for @activityRepeat_WEEKLY.
  ///
  /// In de, this message translates to:
  /// **'Wöchentliche Wiederholung'**
  String get activityRepeat_WEEKLY;

  /// No description provided for @activityRepeatShort_BIWEEKLY.
  ///
  /// In de, this message translates to:
  /// **'Alle 2 Wochen'**
  String get activityRepeatShort_BIWEEKLY;

  /// No description provided for @activityRepeatShort_NEVER.
  ///
  /// In de, this message translates to:
  /// **'Niemals'**
  String get activityRepeatShort_NEVER;

  /// No description provided for @activityRepeatShort_WEEKLY.
  ///
  /// In de, this message translates to:
  /// **'Wöchentlich'**
  String get activityRepeatShort_WEEKLY;

  /// No description provided for @activityScore.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätsscore'**
  String get activityScore;

  /// No description provided for @actualHeartFrequency.
  ///
  /// In de, this message translates to:
  /// **'Tatsächliche Herzfrequenz'**
  String get actualHeartFrequency;

  /// No description provided for @actualTotalDuration.
  ///
  /// In de, this message translates to:
  /// **'Tatsächliche Gesamtdauer'**
  String get actualTotalDuration;

  /// No description provided for @actualTotalDurationMin.
  ///
  /// In de, this message translates to:
  /// **'Tatsächliche Gesamtdauer (min)'**
  String get actualTotalDurationMin;

  /// No description provided for @add.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get add;

  /// No description provided for @addActivity.
  ///
  /// In de, this message translates to:
  /// **'Aktivität hinzufügen'**
  String get addActivity;

  /// No description provided for @addApp.
  ///
  /// In de, this message translates to:
  /// **'App hinzufügen'**
  String get addApp;

  /// No description provided for @addContact.
  ///
  /// In de, this message translates to:
  /// **'Kontakt hinzufügen'**
  String get addContact;

  /// No description provided for @addedApp.
  ///
  /// In de, this message translates to:
  /// **'App erfolgreich hinzugefügt'**
  String get addedApp;

  /// No description provided for @addedAt.
  ///
  /// In de, this message translates to:
  /// **'Hinzugefügt am'**
  String get addedAt;

  /// No description provided for @addedContact.
  ///
  /// In de, this message translates to:
  /// **'Kontakt erfolgreich hinzugefügt'**
  String get addedContact;

  /// No description provided for @addedContactError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Hinzufügen des Kontakts'**
  String get addedContactError;

  /// No description provided for @addedExercise_ENDURANCE.
  ///
  /// In de, this message translates to:
  /// **'Ausdauertraining erfolgreich hinzugefügt'**
  String get addedExercise_ENDURANCE;

  /// No description provided for @addedExercise_HYPERTROPHY.
  ///
  /// In de, this message translates to:
  /// **'Hypertrophietraining erfolgreich hinzugefügt'**
  String get addedExercise_HYPERTROPHY;

  /// No description provided for @addedExercise_INTERVAL.
  ///
  /// In de, this message translates to:
  /// **'Intervall Ausdauertraining erfolgreich hinzugefügt'**
  String get addedExercise_INTERVAL;

  /// No description provided for @addedExercise_OTHER.
  ///
  /// In de, this message translates to:
  /// **'Übung erfolgreich hinzugefügt'**
  String get addedExercise_OTHER;

  /// No description provided for @addedExercise_STRENGTHENING.
  ///
  /// In de, this message translates to:
  /// **'Kraftausdauertraining erfolgreich hinzugefügt'**
  String get addedExercise_STRENGTHENING;

  /// No description provided for @addedExercise_TASK.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe erfolgreich hinzugefügt'**
  String get addedExercise_TASK;

  /// No description provided for @addedHealthcareProfessional.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*in erfolgreich hinzugefügt'**
  String get addedHealthcareProfessional;

  /// No description provided for @addedInstitution.
  ///
  /// In de, this message translates to:
  /// **'Institut erfolgreich hinzugefügt'**
  String get addedInstitution;

  /// No description provided for @addedMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht erfolgreich hinzugefügt'**
  String get addedMessage;

  /// No description provided for @addedPatient.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*in erfolgreich hinzugefügt'**
  String get addedPatient;

  /// No description provided for @addedTrainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Trainingsplan erfolgreich hinzugefügt'**
  String get addedTrainingPlan;

  /// No description provided for @addedVideo.
  ///
  /// In de, this message translates to:
  /// **'Video erfolgreich hinzugefügt'**
  String get addedVideo;

  /// No description provided for @addedWorkout.
  ///
  /// In de, this message translates to:
  /// **'Workout erfolgreich hinzugefügt'**
  String get addedWorkout;

  /// No description provided for @addExercise.
  ///
  /// In de, this message translates to:
  /// **'Übung hinzufügen'**
  String get addExercise;

  /// No description provided for @addHealthcareProfessional.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*in hinzufügen'**
  String get addHealthcareProfessional;

  /// No description provided for @addInstitution.
  ///
  /// In de, this message translates to:
  /// **'Institut hinzufügen'**
  String get addInstitution;

  /// No description provided for @additionalApp.
  ///
  /// In de, this message translates to:
  /// **'Weitere App'**
  String get additionalApp;

  /// No description provided for @additionalApps.
  ///
  /// In de, this message translates to:
  /// **'Weitere Apps'**
  String get additionalApps;

  /// No description provided for @additionalAppsDescription.
  ///
  /// In de, this message translates to:
  /// **'Im Folgenden sind frei verfügbare Apps gelistet, die du dir installieren kannst, um zusätzliche Unterstützung bei deinen Aktivitäten zu erhalten. Bitte beachte, dass wir keinerlei Haftung für die Inhalte dieser Apps übernehmen.'**
  String get additionalAppsDescription;

  /// No description provided for @addMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht hinzufügen'**
  String get addMessage;

  /// No description provided for @addPatient.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*in hinzufügen'**
  String get addPatient;

  /// No description provided for @addPersonalGoal.
  ///
  /// In de, this message translates to:
  /// **'Ziel hinzufügen'**
  String get addPersonalGoal;

  /// No description provided for @addProfilePicture.
  ///
  /// In de, this message translates to:
  /// **'Profilbild hinzufügen'**
  String get addProfilePicture;

  /// No description provided for @addRecipient.
  ///
  /// In de, this message translates to:
  /// **'Empfänger*in hinzufügen'**
  String get addRecipient;

  /// No description provided for @addTask.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe hinzufügen'**
  String get addTask;

  /// No description provided for @addTrainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Trainingsplan hinzufügen'**
  String get addTrainingPlan;

  /// No description provided for @addVideo.
  ///
  /// In de, this message translates to:
  /// **'Video hinzufügen'**
  String get addVideo;

  /// No description provided for @addWorkout.
  ///
  /// In de, this message translates to:
  /// **'Workout hinzufügen'**
  String get addWorkout;

  /// No description provided for @adherenceToTrainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Einhaltung Trainingsplan'**
  String get adherenceToTrainingPlan;

  /// No description provided for @adherenceToTrainingPlanInCalendarWeek.
  ///
  /// In de, this message translates to:
  /// **'Einhaltung Trainingsplan in KW {calendarWeek}'**
  String adherenceToTrainingPlanInCalendarWeek(int calendarWeek);

  /// No description provided for @adjust.
  ///
  /// In de, this message translates to:
  /// **'anpassen'**
  String get adjust;

  /// No description provided for @administrator.
  ///
  /// In de, this message translates to:
  /// **'Administrator*in'**
  String get administrator;

  /// No description provided for @allowTrainingPlans.
  ///
  /// In de, this message translates to:
  /// **'Erstellung und Anwendung von vorgefertigten Trainingsplänen erlauben'**
  String get allowTrainingPlans;

  /// No description provided for @allowRescheduleActivities.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*innen erlauben, eine geplante Aktivität innerhalb einer Woche zu verschieben'**
  String get allowRescheduleActivities;

  /// No description provided for @allPatients.
  ///
  /// In de, this message translates to:
  /// **'Alle Patienten'**
  String get allPatients;

  /// No description provided for @amount.
  ///
  /// In de, this message translates to:
  /// **'Anzahl'**
  String get amount;

  /// No description provided for @amountRepeats.
  ///
  /// In de, this message translates to:
  /// **'Anzahl der Wiederholungen'**
  String get amountRepeats;

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'aktivplan+'**
  String get appTitle;

  /// No description provided for @back.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get back;

  /// No description provided for @birthdate.
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum'**
  String get birthdate;

  /// No description provided for @bodyHeight.
  ///
  /// In de, this message translates to:
  /// **'Körpergröße'**
  String get bodyHeight;

  /// No description provided for @bodyHeightWithUnit.
  ///
  /// In de, this message translates to:
  /// **'Körpergröße (cm)'**
  String get bodyHeightWithUnit;

  /// No description provided for @bodyWeight.
  ///
  /// In de, this message translates to:
  /// **'Körpergewicht'**
  String get bodyWeight;

  /// No description provided for @bodyWeightWithUnit.
  ///
  /// In de, this message translates to:
  /// **'Körpergewicht (kg)'**
  String get bodyWeightWithUnit;

  /// No description provided for @browseGallery.
  ///
  /// In de, this message translates to:
  /// **'Galerie durchsuchen'**
  String get browseGallery;

  /// No description provided for @calendarEntry.
  ///
  /// In de, this message translates to:
  /// **'Kalendereintrag'**
  String get calendarEntry;

  /// No description provided for @calendarInfoActiveMinutes.
  ///
  /// In de, this message translates to:
  /// **'Hat in den letzten vier Wochen <color>{percentage}%</color> der geplanten aktiven Minuten absolviert.'**
  String calendarInfoActiveMinutes(int percentage);

  /// No description provided for @calendarInfoActiveMinutesKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Hat in den letzten vier Wochen <color>{percentage}%</color> der geplanten Aktivitätspunkte absolviert.'**
  String calendarInfoActiveMinutesKlimafit(int percentage);

  /// No description provided for @calendarInfoActiveMinutesThreeWeeks.
  ///
  /// In de, this message translates to:
  /// **'Hat in den letzten drei Wochen <color>{percentage}%</color> der aktiven Minuten absolviert. Davon waren {percentagePlanned}% geplante Aktivitäten.'**
  String calendarInfoActiveMinutesThreeWeeks(
      int percentage, int percentagePlanned);

  /// No description provided for @calendarInfoActiveMinutesNoTraining.
  ///
  /// In de, this message translates to:
  /// **'Vier Wochenstatus nicht vorhanden, da in den vergangen vier Wochen kein Training geplant war.'**
  String get calendarInfoActiveMinutesNoTraining;

  /// No description provided for @calendarInfoActiveMinutesNoTrainingThreeWeeks.
  ///
  /// In de, this message translates to:
  /// **'Drei Wochenstatus nicht vorhanden, da in den vergangen drei Wochen kein Training geplant war.'**
  String get calendarInfoActiveMinutesNoTrainingThreeWeeks;

  /// No description provided for @calendarWeek.
  ///
  /// In de, this message translates to:
  /// **'Kalenderwoche'**
  String get calendarWeek;

  /// No description provided for @calendarWeekShort.
  ///
  /// In de, this message translates to:
  /// **'KW'**
  String get calendarWeekShort;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @cancelText.
  ///
  /// In de, this message translates to:
  /// **'Sind Sie sicher, dass Sie den Vorgang abbrechen wollen? Ihre Eingaben/Änderungen gehen dabei verloren.'**
  String get cancelText;

  /// No description provided for @cancelYes.
  ///
  /// In de, this message translates to:
  /// **'Ja, abbrechen'**
  String get cancelYes;

  /// No description provided for @captureImageWithCamera.
  ///
  /// In de, this message translates to:
  /// **'Bild mit Kamera aufnehmen'**
  String get captureImageWithCamera;

  /// No description provided for @changeOfMyHealthData.
  ///
  /// In de, this message translates to:
  /// **'Änderung meiner Daten'**
  String get changeOfMyHealthData;

  /// No description provided for @changePassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get changePassword;

  /// No description provided for @choose.
  ///
  /// In de, this message translates to:
  /// **'Wählen'**
  String get choose;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @comorbidities.
  ///
  /// In de, this message translates to:
  /// **'Begleiterkrankungen'**
  String get comorbidities;

  /// No description provided for @confirmNewPassword.
  ///
  /// In de, this message translates to:
  /// **'Bestätige neues Passwort'**
  String get confirmNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort bestätigen'**
  String get confirmPassword;

  /// No description provided for @copy.
  ///
  /// In de, this message translates to:
  /// **'Kopieren'**
  String get copy;

  /// No description provided for @consentTextCreatePatient.
  ///
  /// In de, this message translates to:
  /// **'Ich bestätige hiermit, dass ich den künftigen Nutzer/die künftige Nutzerin aufgeklärt habe und seine/ihre Zustimmung zur Verarbeitung seiner/ihrer Daten zum Zweck der Registrierung eingeholt habe.'**
  String get consentTextCreatePatient;

  /// No description provided for @consentTextCreatePatientDetail.
  ///
  /// In de, this message translates to:
  /// **'<b>Ziel</b>\n• <b>Unterstützung der Aktivitätsplanung:</b> Die aktivplan App soll Sie und Ihre Gesundheitsexpert*innen dabei unterstützen, Trainingsaktivitäten individuell zu planen und optimal an Ihren Gesundheitszustand anzupassen.\n• <b>Visualisierung und Verfolgung der Aktivitäten:</b> Die App bietet Ihnen die Möglichkeit, die mit Ihren Gesundheitsexpert*innen geplanten Aktivitäten auf Ihrem Smartphone anzusehen und zu verfolgen, sowie zusätzliche Aktivitäten einzutragen.\n\n<b>Ablauf</b>\n• <b>Expliziter Nutzungswille:</b> Wenn Sie sich explizit zur Nutzung der aktivplan App bereit erklären, werden die im Leistungstest erhobenen Daten von Ihren Gesundheitsexpert*innen in die Anwendung eingegeben.\n• <b>Leistungsdaten - Basis für Trainingsplan:</b>Die im Leistungstest erhobenen Daten schaffen die Basis für einen individuell angepassten Trainingsplan. (Zum Beispiel Training im optimalen Herzfrequenzbereich.)\n• <b>Installation über E-Mail Link:</b> Nach der Eingabe Ihrer Daten erhalten Sie eine E-Mail mit einem Link. Über diesen Link können Sie die aktivplan App auf Ihrem Handy installieren und sich anmelden. Wenn Sie sich nicht innerhalb der nächsten 10 Tage anmelden, werden Ihre Daten aus der Anwendung gelöscht.\n\n<b>Datenschutz und Datenverwertung</b>\n• <b>Vertraulichkeit:</b> Alle Information werden vertraulich behandelt.\n• <b>Sichere Datenspeicherung:</b> Ihre persönlichen Daten werden pseudonymisiert und auf sicheren Servern gespeichert, gemäß der DSGVO.\n• <b>Zweck der Datenverwertung:</b> Die aufgenommenen Daten dienen dazu, dass ein individuell an Sie angepasstes und optimal auf Ihren Gesundheitszustand abgestimmtes Training erstellt wird. (Zum Beispiel Training im optimalen Herzfrequenzbereich.)\n\n<b>Freiwillige Teilnahme und Rücktrittsfreiheit</b>\n• <b>Freiwilligkeit:</b> Die Nutzung der aktivplan App ist vollkommen freiwillig.\n• <b>Automatische Löschung der Daten nach 10 Tagen:</b> Wenn Sie sich nicht innerhalb der nächsten 10 Tage über den in der E-Mail bereitgestellten Link anmelden, werden Ihre Daten aus der Anwendung gelöscht.\n• <b>Beendigung jederzeit:</b> Nach der Registrierung können Sie die Nutzung der aktivplan App natürlich auch jederzeit beenden, womit auch die Löschung aller Ihrer Daten einhergeht.\n\n<b>Fragen</b>\n• <b>Jederzeit Kontaktaufnahme:</b> Sollten Sie noch Fragen haben, können Sie jederzeit gerne Kontakt aufnehmen.'**
  String get consentTextCreatePatientDetail;

  /// No description provided for @consentText_PRIVACY_POLICY.
  ///
  /// In de, this message translates to:
  /// **'Ich habe die <a>Datenschutzerklärung</a> gelesen und bin damit einverstanden.'**
  String get consentText_PRIVACY_POLICY;

  /// No description provided for @consentText_TERMS_AND_CONDITIONS.
  ///
  /// In de, this message translates to:
  /// **'Ich habe die <a>Nutzungsbedingungen</a> gelesen und bin damit einverstanden.'**
  String get consentText_TERMS_AND_CONDITIONS;

  /// No description provided for @contact.
  ///
  /// In de, this message translates to:
  /// **'Kontaktieren'**
  String get contact;

  /// No description provided for @content.
  ///
  /// In de, this message translates to:
  /// **'Inhalt'**
  String get content;

  /// No description provided for @contentEnglish.
  ///
  /// In de, this message translates to:
  /// **'Inhalt (englische Übersetzung)'**
  String get contentEnglish;

  /// No description provided for @conversationGuide.
  ///
  /// In de, this message translates to:
  /// **'Leitfaden Gespräch'**
  String get conversationGuide;

  /// No description provided for @conversationGuideStep0Question1.
  ///
  /// In de, this message translates to:
  /// **'Worum geht es in diesem Gespräch und was ist das Ziel?'**
  String get conversationGuideStep0Question1;

  /// No description provided for @conversationGuideStep0Question1Answer.
  ///
  /// In de, this message translates to:
  /// **'In diesem Gespräch geht es darum, dass wir gemeinsam einen wöchentlichen Trainingsplan für Sie erstellen, den Sie dann nach Abschluss Ihres kardiologischen Reha Programms selber weiterführen können.'**
  String get conversationGuideStep0Question1Answer;

  /// No description provided for @conversationGuideStep0Question1AnswerHealthyLifeStyle.
  ///
  /// In de, this message translates to:
  /// **'In diesem Gespräch geht es darum, dass wir gemeinsam einen wöchentlichen Trainingsplan für Sie erstellen, den Sie dann selber weiterführen können.'**
  String get conversationGuideStep0Question1AnswerHealthyLifeStyle;

  /// No description provided for @conversationGuideStep0Question2.
  ///
  /// In de, this message translates to:
  /// **'Warum sollen Sie in den Entscheidungsprozess einbezogen werden?'**
  String get conversationGuideStep0Question2;

  /// No description provided for @conversationGuideStep0Question2Answer.
  ///
  /// In de, this message translates to:
  /// **'Es gibt verschiedene Möglichkeiten, so einen Trainingsplan zu gestalten, und es ist wichtig, Ihre Vorlieben in der Entscheidung einzubringen.'**
  String get conversationGuideStep0Question2Answer;

  /// No description provided for @conversationGuideStep1.
  ///
  /// In de, this message translates to:
  /// **'Wissensstand erörtern\nund Informieren'**
  String get conversationGuideStep1;

  /// No description provided for @conversationGuideStep1Headline.
  ///
  /// In de, this message translates to:
  /// **'Was wissen Sie bereits über Ihre Herz-Kreislauf-Erkrankung?'**
  String get conversationGuideStep1Headline;

  /// No description provided for @conversationGuideStep1Short.
  ///
  /// In de, this message translates to:
  /// **'Wissensstand'**
  String get conversationGuideStep1Short;

  /// No description provided for @conversationGuideStep1Question1.
  ///
  /// In de, this message translates to:
  /// **'Was versteht man unter einer Herz-Kreislauf-Erkrankung? / Sind Sie mit Ihrer Herz-Kreislauf-Erkrankung vertraut?'**
  String get conversationGuideStep1Question1;

  /// No description provided for @conversationGuideStep1Question1Answer.
  ///
  /// In de, this message translates to:
  /// **'<b>Herz-Kreislauf-Erkrankungen sind Erkrankungen des Herzens und der Blutgefäße.</b>\nEs gibt viele verschiedene Herz-Kreislauf-Erkrankungen, aber einige wenige machen den größten Anteil aus.\nDie häufigsten Herz-Kreislauf-Erkrankungen sind:\n\n• Bluthochdruck,\n• Arteriosklerose („Verkalkung“ der Arterien)\n• Koronare Herzerkrankung\n• Chronisches Herzversagen (Herzinsuffizienz)\n\nHerz-Kreislauf-Erkrankungen sind in Österreich die häufigste Todesursache.\n<b>Zu den schwerwiegenden Folgen von Herz-Kreislauf-Erkrankungen zählen:</b>\n\n• Herzinfarkt (durch Gefäßverschluss am Herzen)\n• Schlaganfall (durch Gefäßverschluss im Gehirn)\n• Herzrhythmusstörungen'**
  String get conversationGuideStep1Question1Answer;

  /// No description provided for @conversationGuideStep1Question2.
  ///
  /// In de, this message translates to:
  /// **'Was verursacht Herz-Kreislauf-Erkrankungen? / Was sind die Risikofaktoren für Herz-Kreislauf-Erkrankungen?'**
  String get conversationGuideStep1Question2;

  /// No description provided for @conversationGuideStep1Question2Answer.
  ///
  /// In de, this message translates to:
  /// **'Manche Herz-Kreislauf-Erkrankungen haben spezifische und individuelle Gründe.\nAber im Allgemeinen kann man sagen, <b>dass bestimmtes ungesundes Verhalten Herz-Kreislauf-Erkrankungen begünstigt:</b>\n\n• Sehr kalorien-, zucker- und fetthaltige Ernährung\n• Bewegungsmangel\n• Alkoholkonsum\n• Nikotinkonsum'**
  String get conversationGuideStep1Question2Answer;

  /// No description provided for @conversationGuideStep1Question3.
  ///
  /// In de, this message translates to:
  /// **'Kann man Herz-Kreislauf-Erkrankungen vorbeugen?'**
  String get conversationGuideStep1Question3;

  /// No description provided for @conversationGuideStep1Question3Answer.
  ///
  /// In de, this message translates to:
  /// **'Man kann Herz-Kreislauf-Erkrankungen mit Anpassungen des Lebensstils gut vorbeugen.\nPersonen, die bereits ein schwerwiegendes Ereignis wie einen Herzinfarkt hatten, können weiteren Ereignissen vorbeugen.\n<b>Die wichtigsten Maßnahmen zur Vorbeugung sind:</b>\n\n• Regelmäßige herzgesunde Bewegung\n• Nicht rauchen\n• Normaler Blutdruck\n• Normaler Blutzuckerspiegel\n• Normaler Gesamtcholesterinspiegel (durch gesunde Ernährung und Medikamente)\n• Herz-Kreislauf Medikamente regelmäßig einnehmen\n• Normales Gewicht\n• Gesunde Ernährung'**
  String get conversationGuideStep1Question3Answer;

  /// No description provided for @conversationGuideStep1Question4.
  ///
  /// In de, this message translates to:
  /// **'Was sind die Auswirkungen von herzgesunder Bewegung?'**
  String get conversationGuideStep1Question4;

  /// No description provided for @conversationGuideStep1Question4Answer.
  ///
  /// In de, this message translates to:
  /// **'Regelmäßige herzgesunde Bewegung ist eine der wichtigsten vorbeugenden Maßnahmen für Personen mit Herz-Kreislauf-Erkrankungen und <more1>für alle Menschen</more1>. <more2>Positive Wirkungen</more2> treten bis ins höchste Alter ein – es gibt keine „Altersgrenze“.\n\nEine körperliche Aktivität ist dann besonders herzgesund, wenn man sich bei mittlerer Anstrengung (Intensität) bewegt. Moderate Anstrengung bedeutet, dass man etwas außer Atem kommt und dabei noch plaudern, aber nicht mehr singen kann.\n\nFür Personen, die „körperlich inaktiv“ sind, bringt schon der Wechsel zu „ein wenig körperlich aktiv“ einen wesentlichen gesundheitlichen Nutzen. „Ein wenig körperlich aktiv“ bedeutet z.B., dass man mehrmals pro Tag 5 Minuten zügig zu Fuß geht.\n\nEin möglicher Nachteil von Bewegung und körperlicher Aktivität ist eine gewisse Verletzungsgefahr. Diese ist bei richtiger Durchführung aber gering.'**
  String get conversationGuideStep1Question4Answer;

  /// No description provided for @conversationGuideStep1Question4AnswerHealthyLifeStyle.
  ///
  /// In de, this message translates to:
  /// **'Regelmäßige herzgesunde Bewegung ist eine der wichtigsten vorbeugenden Maßnahmen <more1>für jeden von uns</more1>. <more2>Positive Wirkungen</more2> treten bis ins höchste Alter ein – es gibt keine „Altersgrenze“.\n\nEine körperliche Aktivität ist dann besonders herzgesund, wenn man sich bei mittlerer Anstrengung (Intensität) bewegt. Moderate Anstrengung bedeutet, dass man etwas außer Atem kommt und dabei noch plaudern, aber nicht mehr singen kann.\n\nFür Personen, die „körperlich inaktiv“ sind, bringt schon der Wechsel zu „ein wenig körperlich aktiv“ einen wesentlichen gesundheitlichen Nutzen. „Ein wenig körperlich aktiv“ bedeutet z.B., dass man mehrmals pro Tag 5 Minuten zügig zu Fuß geht.\n\nEin möglicher Nachteil von Bewegung und körperlicher Aktivität ist eine gewisse Verletzungsgefahr. Diese ist bei richtiger Durchführung aber gering.'**
  String get conversationGuideStep1Question4AnswerHealthyLifeStyle;

  /// No description provided for @conversationGuideStep1Question4AnswerMore1.
  ///
  /// In de, this message translates to:
  /// **'<b>Erwachsene, die sich regelmäßig bewegen:</b>\n\n• sind fitter und gesünder\n• fühlen sich besser\n• bekommen seltener chronische Erkrankungen, z.B. Herz-Kreislauf-Erkrankungen, Diabetes oder verschiedene Arten von Krebs\n• haben weniger Angstgefühle und das Gehirn arbeitet nach der Bewegung besser\n• schlafen besser\n• werden im Alltag nicht so schnell müde, z.B. wenn sie Stiegen steigen oder etwas Schweres tragen\n• werden seltener übergewichtig'**
  String get conversationGuideStep1Question4AnswerMore1;

  /// No description provided for @conversationGuideStep1Question4AnswerMore2.
  ///
  /// In de, this message translates to:
  /// **'<b>Positive Wirkungen von regelmäßiger herzgesunder Bewegung für Personen mit Herz-Kreislauf-Erkrankungen:</b>\n\n• Verbesserung des Fettstoffwechsels\n• Reduktion von Übergewicht und Blutdruck\n• Reduktion von Entzündungen\n• Verbesserung der Insulinempfindlichkeit und damit Behandlung und Vorbeugung von Typ-2-Diabetes\n• Normalisierung des Blutglukosespiegels'**
  String get conversationGuideStep1Question4AnswerMore2;

  /// No description provided for @conversationGuideStep2.
  ///
  /// In de, this message translates to:
  /// **'Vorlieben erfragen\nund Möglichkeiten anbieten'**
  String get conversationGuideStep2;

  /// No description provided for @conversationGuideStep2Headline.
  ///
  /// In de, this message translates to:
  /// **'Welche Art von Bewegung oder Sport sagt Ihnen persönlich zu?'**
  String get conversationGuideStep2Headline;

  /// No description provided for @conversationGuideStep2Short.
  ///
  /// In de, this message translates to:
  /// **'Vorlieben'**
  String get conversationGuideStep2Short;

  /// No description provided for @conversationGuideStep2Question1.
  ///
  /// In de, this message translates to:
  /// **'Welche Art der Bewegung oder Sport machen Sie aktuell oder haben Sie früher gerne gemacht?'**
  String get conversationGuideStep2Question1;

  /// No description provided for @conversationGuideStep2Question1Answer.
  ///
  /// In de, this message translates to:
  /// **'Dabei soll nicht nur an klassische Sportarten und gezieltes Training gedacht werden, sondern auch an soziale Gelegenheiten (z.B. Tanz, Gruppenwanderung) und alltägliche Bewegung und Aktivitäten (z.B. den Hund ausführen, Hausarbeit, Gartenarbeit, Treppensteigen).\n\n• Mit welcher Art der Bewegung oder Sport haben Sie bereits positive Erfahrung gemacht?\n• Mit welcher Art der Bewegung oder Sport haben Sie negative Erfahrung gemacht?\n• Gibt es Bewegungsformen oder Sportarten, mit denen Sie keine Erfahrung haben, die Sie aber interessieren?\n\n<b>Optional (eventuell hilfreich bei wenig Bewegung):</b>\n\n• Wobei kommen Sie in Ihrem üblichen Alltag am meisten zum Schwitzen oder zum Schnaufen?\n• Sind Sie oder waren Sie früher in einem Sportverein?\n• Was hat Ihnen damals im Turnunterricht Spaß gemacht?'**
  String get conversationGuideStep2Question1Answer;

  /// No description provided for @conversationGuideStep2Question2.
  ///
  /// In de, this message translates to:
  /// **'Sind Sie sich bewusst, dass auch Alltagsaktivitäten als herzgesunde Bewegung gelten?'**
  String get conversationGuideStep2Question2;

  /// No description provided for @conversationGuideStep2Question2Answer.
  ///
  /// In de, this message translates to:
  /// **'<b>Nicht nur klassischer Sport und gezieltes Training gelten als herzgesunde Bewegung, sondern auch alltägliche Bewegung und Aktivitäten leisten einen Beitrag zur Herzgesundheit.</b>\n\nBeispiele sind den Hund ausführen, Hausarbeit, Gartenarbeit, Treppensteigen oder eine Steigung hochgehen.\n\nDiese Bewegung und Aktivitäten sind besonders bei mittlerer oder starker Anstrengung herzgesund, das heißt, wenn dabei das Herz deutlich schneller schlägt, man stärker atmen muss, es einem warm wird und man ein bisschen ins Schwitzen kommt.'**
  String get conversationGuideStep2Question2Answer;

  /// No description provided for @conversationGuideStep2Question3.
  ///
  /// In de, this message translates to:
  /// **'Welche verschiedenen Trainingsmethoden gibt es und welche Vorteile haben diese?'**
  String get conversationGuideStep2Question3;

  /// No description provided for @conversationGuideStep2Question3Answer.
  ///
  /// In de, this message translates to:
  /// **'<b>Es wird empfohlen, jede Woche sowohl ausdauerorientierte Bewegung als auch muskelkräftigende Bewegung auszuüben.</b>\n\n<more1>Ausdauerorientierte Bewegung</more1> nützt generell mehr dem Herz-Kreislauf-System, der Atmung und dem Stoffwechsel.\n\n<more2>Muskelkräftigende Bewegung</more2> nützt generell mehr der Körperhaltung, Knochendichte, Sturzprophylaxe und beim Bewegen schwerer Gegenstände im Alltag.'**
  String get conversationGuideStep2Question3Answer;

  /// No description provided for @conversationGuideStep2Question3AnswerMore1.
  ///
  /// In de, this message translates to:
  /// **'<b>Ausdauerorientierte Bewegung</b>\n\n• Man bewegt den ganzen Körper rhythmisch über einen längeren Zeitraum.\n• Beispiele sind zügiges Gehen, Laufen, Radfahren, Tanzen, Basketball, Schwimmen.\n• Das Herz schlägt deutlich schneller, man muss stärker atmen, es wird einem warm und man kommt ins Schwitzen.\n• Erwachsenen mit chronischen Erkrankungen wird empfohlen, jede Woche zusammengezählt 150 Minuten (2 ½ Stunden ausdauerorientierte Bewegung mit mittlerer Anstrengung auszuüben.\n• Mittlere Anstrengung bedeutet, dass das Herz deutlich schneller schlägt und man dabei etwas stärker atmen muss - aber nicht zu stark (man sollte dabei noch reden aber nicht mehr singen können).'**
  String get conversationGuideStep2Question3AnswerMore1;

  /// No description provided for @conversationGuideStep2Question3AnswerMore2.
  ///
  /// In de, this message translates to:
  /// **'<b>Muskelkräftigende Bewegung</b>\n\n• Man trainiert gezielt große Muskelgruppen (Bein-, Hüft, Brust, Rücken,Bauch, Schulter- und Armmuskulatur).\n• Beispiele sind Übungen mit Gewichten oder elastischen Bändern, Kniebeugen, Liegestütze.\n• Beim Training zum Kraftaufbau (Hypertrophietraining) wählt man ein Gewicht mit dem man gerade 8 bis 12 Wiederholungen schafft.\n• Beim Kraftausdauertraining macht man 20 bis 40 Wiederholungen.\n• Erwachsenen mit chronischen Erkrankungen wird empfohlen, zweimal pro Woche muskelkräftigende Bewegung für alle großen Muskelgruppen auszuüben.'**
  String get conversationGuideStep2Question3AnswerMore2;

  /// No description provided for @conversationGuideStep2Question4.
  ///
  /// In de, this message translates to:
  /// **'Wie oft können Sie sich vorstellen Bewegung in Ihren Alltag einzuplanen?'**
  String get conversationGuideStep2Question4;

  /// No description provided for @conversationGuideStep2Question4Answer.
  ///
  /// In de, this message translates to:
  /// **'Sowohl <b>längere und strukturierte Trainingseinheiten</b> (z.B. jede Woche eine Stunde Herzsportgruppe, zweimal pro Woche eine halbe Stunde Joggen) als auch <b>kürzere in den Alltag eingebaute Bewegungseinheiten</b> (z.B. jeden Tag 10 Minuten am Stück zu Fuß gehen, jeden Tag einmal Treppensteigen anstatt mit dem Lift fahren) sind hilfreich.\n\n<b>Wenn möglich sollte beides in der Trainingsplanung berücksichtigt werden:</b>\n\n• Wie oft könnten Sie sich vorstellen eine längere und strukturierte Trainingseinheiten durchzuführen?\n• Wie oft könnten Sie sich vorstellen eine kürzere, in den Alltag integrierte Bewegungseinheit durchzuführen?'**
  String get conversationGuideStep2Question4Answer;

  /// No description provided for @conversationGuideStep3.
  ///
  /// In de, this message translates to:
  /// **'Bedeutsame Ziele setzen'**
  String get conversationGuideStep3;

  /// No description provided for @conversationGuideStep3Short.
  ///
  /// In de, this message translates to:
  /// **'Ziele'**
  String get conversationGuideStep3Short;

  /// No description provided for @conversationGuideStep3Headline.
  ///
  /// In de, this message translates to:
  /// **'Da Sie ja Ihre körperliche Aktivität steigern wollen, lassen Sie uns dieses Ziel nun etwas konkreter machen.'**
  String get conversationGuideStep3Headline;

  /// No description provided for @conversationGuideStep3Question1.
  ///
  /// In de, this message translates to:
  /// **'Was würden Sie sich persönlich von regelmässiger herzgesunder Bewegung erhoffen?'**
  String get conversationGuideStep3Question1;

  /// No description provided for @conversationGuideStep3Question1Answer.
  ///
  /// In de, this message translates to:
  /// **'Diese Frage ist bewusst offen formuliert, um die Gedanken der Person zu hören.\nDie Gedanken der Person sollten ohne Beeinflussung, Filtern oder Bewertung aufgenommen werden.\n<more1>Verschiedenste Aussagen</more1> können hier möglich sein, zum Beispiel aus einer gesundheitlichen oder sozialen Motivation heraus.\nEs soll auch festgehalten werden, wenn eine Person keine konkrete Erwartung äußern kann.\n\nDiese Aussagen können Ausgangspunkte für die Formulierung der konkreten Bewegungsziele im nächsten Schritt bieten.'**
  String get conversationGuideStep3Question1Answer;

  /// No description provided for @conversationGuideStep3Question1AnswerMore1.
  ///
  /// In de, this message translates to:
  /// **'<b>Mögliche Aussagen:</b>\n\n• „Dass ich keinen weiteren Herzinfarkt haben werde“\n• „Dass ich noch lange genug lebe und fit bleibe, um auf der Hochzeit meines Enkelkindes zu tanzen“\n• „Dass ich dadurch mein Körpergewicht im gesunden Bereich halte“\n• „Dass ich dadurch meinen ungesunden Lebensstil ausgleiche“'**
  String get conversationGuideStep3Question1AnswerMore1;

  /// No description provided for @conversationGuideStep3Question2.
  ///
  /// In de, this message translates to:
  /// **'Lassen Sie uns jetzt versuchen, konkrete Bewegungsziele zu formulieren. Also etwas, worauf Sie hinarbeiten mõchten, und das man dann abhaken kann wenn Sie es geschafft haben. Gibt es da etwas woran Sie denken?'**
  String get conversationGuideStep3Question2;

  /// No description provided for @conversationGuideStep3Question2Answer.
  ///
  /// In de, this message translates to:
  /// **'<b>Ideen sammeln:</b> „Es soll durchaus herausfordernd sein, und auch etwas sein, was für Sie persönlich eine gewisse Bedeutung hat.“\n\n<b>Konkretes Beispiel:</b> „Andere Personen haben sich ein Bewegungsziel gesetzt, einen bestimmten Wanderweg zurückzulegen, oder eine bestimmte Fahrradstrecke abzufahren.“\n\n<b>Große Ziele in kleine Schritte aufteilen:</b> „Das ist ein gutes Ziel, das notieren wir - es klingt aber auch durchaus herausfordernd. Wollen wir zusätzlich ein Ziel formulieren, das einen Zwischenschritt auf dem Weg dahin darstellt - und wie würde dieses Zwischenziel aussehen?“\n\n<b>Bewegungsziele mit einem „Erreichen bis“ Datum versehen:</b> „Bis wann würden Sie denn sagen, dass Sie dieses Ziel erreicht haben möchten?“\n\nldealerweise sollten Bewegungsziele so konkret formuliert sein, dass man klar beurteilen kann, wann ein Ziel erreicht worden ist und <more1>„abgehakt“</more1> werden kann. Wenn es einer Person schwerfällt, an ein konkretes „abhakbares“ Ziel zu denken, kann auch eine <more2>vage Zielformulierung</more2> festgehalten werden (z.B. „mich mehr bewegen“ oder „etwas gesünder leben“).'**
  String get conversationGuideStep3Question2Answer;

  /// No description provided for @conversationGuideStep3Question2AnswerMore1.
  ///
  /// In de, this message translates to:
  /// **'<b>„Abhakbares“ Ziel formulieren</b>\n\nTypischerweise werden sogenannte <b>„Leistungsziele“</b> formuliert. Das heißt das Ziel ist erreicht, wenn eine bestimmte neue körperliche Leistung geschafft wurde, zum Beispiel „10.000 Schritte ohne Pause gehen“.\n\nAber auch sogenannte <b>„Lernziele“ oder „Prozessziele“</b> können formuliert werden.\n\nBeim <b>Lernziel</b> geht es ums <b>Erlangen neuen Wissens</b> (z.B. „Einen Gehweg nahe meiner Wohnadresse ausfindig machen, auf dem ich dann regelmäßig meine Gehstrecke trainieren kann“) oder <b>neuer Fertigkeiten</b> (z.B. „Lernen, wie ich meine Gehstrecke auf dem Laufband im Fitness Center trainieren kann“).\n\nBeim <b>Prozessziel</b> geht es ums <b>Umsetzen oder Erhalten bestehender Strategien</b> (z.B. „immer mit zügigem Tempo zu gehen“ oder „weiterhin regelmäßig einmal am Tag 10 Minuten am Stück gehen“).'**
  String get conversationGuideStep3Question2AnswerMore1;

  /// No description provided for @conversationGuideStep3Question2AnswerMore2.
  ///
  /// In de, this message translates to:
  /// **'<b>Vage Zielformulierung</b>\n\nVage formulierte Ziele sollten auch mit einem „Erreichen bis“ Datum versehen werden.\n\nEs sollte bei einem Nachfolgegespräch dann wieder versucht werden, ein konkretes „abhakbares“ Ziel zu formulieren. Eine erste vage Zielformulierung kann hilfreich sein, um später eine konkrete Zielformulierung zu finden.'**
  String get conversationGuideStep3Question2AnswerMore2;

  /// No description provided for @copyWeek.
  ///
  /// In de, this message translates to:
  /// **'Woche kopieren'**
  String get copyWeek;

  /// No description provided for @create.
  ///
  /// In de, this message translates to:
  /// **'Erstellen'**
  String get create;

  /// No description provided for @createdBy.
  ///
  /// In de, this message translates to:
  /// **'Erstellt von'**
  String get createdBy;

  /// No description provided for @databaseOverwritten.
  ///
  /// In de, this message translates to:
  /// **'Datenbank erfolgreich überschrieben'**
  String get databaseOverwritten;

  /// No description provided for @date.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get date;

  /// No description provided for @day.
  ///
  /// In de, this message translates to:
  /// **'Tag'**
  String get day;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @deleteActivity.
  ///
  /// In de, this message translates to:
  /// **'Aktivität löschen'**
  String get deleteActivity;

  /// No description provided for @deleteAll.
  ///
  /// In de, this message translates to:
  /// **'Alle Löschen'**
  String get deleteAll;

  /// No description provided for @deleteImage.
  ///
  /// In de, this message translates to:
  /// **'Bild löschen'**
  String get deleteImage;

  /// No description provided for @deleteVideo.
  ///
  /// In de, this message translates to:
  /// **'Video löschen'**
  String get deleteVideo;

  /// No description provided for @deletedApp.
  ///
  /// In de, this message translates to:
  /// **'App erfolgreich gelöscht'**
  String get deletedApp;

  /// No description provided for @deletedExercise_ENDURANCE.
  ///
  /// In de, this message translates to:
  /// **'Ausdauertraining erfolgreich gelöscht'**
  String get deletedExercise_ENDURANCE;

  /// No description provided for @deletedExercise_HYPERTROPHY.
  ///
  /// In de, this message translates to:
  /// **'Hypertrophietraining erfolgreich gelöscht'**
  String get deletedExercise_HYPERTROPHY;

  /// No description provided for @deletedExercise_INTERVAL.
  ///
  /// In de, this message translates to:
  /// **'Intervall Ausdauertraining erfolgreich gelöscht'**
  String get deletedExercise_INTERVAL;

  /// No description provided for @deletedExercise_OTHER.
  ///
  /// In de, this message translates to:
  /// **'Übung erfolgreich gelöscht'**
  String get deletedExercise_OTHER;

  /// No description provided for @deletedExercise_STRENGTHENING.
  ///
  /// In de, this message translates to:
  /// **'Kraftausdauertraining erfolgreich gelöscht'**
  String get deletedExercise_STRENGTHENING;

  /// No description provided for @deletedExercise_TASK.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe erfolgreich gelöscht'**
  String get deletedExercise_TASK;

  /// No description provided for @deletedHealthcareProfessional.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*in erfolgreich gelöscht'**
  String get deletedHealthcareProfessional;

  /// No description provided for @deletedInstitution.
  ///
  /// In de, this message translates to:
  /// **'Institut erfolgreich gelöscht'**
  String get deletedInstitution;

  /// No description provided for @deletedMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht erfolgreich gelöscht'**
  String get deletedMessage;

  /// No description provided for @deletedPatient.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*in erfolgreich gelöscht'**
  String get deletedPatient;

  /// No description provided for @deletedTrainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Trainingsplan erfolgreich gelöscht'**
  String get deletedTrainingPlan;

  /// No description provided for @deletedVideo.
  ///
  /// In de, this message translates to:
  /// **'Video erfolgreich gelöscht'**
  String get deletedVideo;

  /// No description provided for @deletedWorkout.
  ///
  /// In de, this message translates to:
  /// **'Workout erfolgreich gelöscht'**
  String get deletedWorkout;

  /// No description provided for @deleteForAllRecipients.
  ///
  /// In de, this message translates to:
  /// **'Ja, für alle Empfänger*innen löschen'**
  String get deleteForAllRecipients;

  /// No description provided for @deleteForThisRecipient.
  ///
  /// In de, this message translates to:
  /// **'Ja, für diese*n Empfänger*in löschen'**
  String get deleteForThisRecipient;

  /// No description provided for @deleteLastWeek.
  ///
  /// In de, this message translates to:
  /// **'Letzte Woche löschen'**
  String get deleteLastWeek;

  /// No description provided for @deleteMessageActivity.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du die geplante Aktivität {name} löschen wollen?'**
  String deleteMessageActivity(String name);

  /// No description provided for @deleteMessageAdditionalApp.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diese App löschen willst? Es wird damit für alle Mitglieder des Instituts gelöscht.'**
  String get deleteMessageAdditionalApp;

  /// No description provided for @deleteMessageAdditionalAppTitle.
  ///
  /// In de, this message translates to:
  /// **'App löschen'**
  String get deleteMessageAdditionalAppTitle;

  /// No description provided for @deleteMessageAllActivities.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du alle zukünftigen Instanzen dieser Übung löschen willst?\n\n*Aktivitäten, die bereits abgeschlossen wurden, werden nicht gelöscht.'**
  String get deleteMessageAllActivities;

  /// No description provided for @deleteMessageAllActivitiesTrainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du alle Instanzen dieser Übung löschen willst?'**
  String get deleteMessageAllActivitiesTrainingPlan;

  /// No description provided for @deleteMessageAllAppointments.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du alle zukünftigen Instanzen dieses Termins löschen willst?'**
  String get deleteMessageAllAppointments;

  /// No description provided for @deleteMessageExerciseType.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du dieses {typeName} löschen willst? Es wird damit für alle Mitglieder des Instituts gelöscht.'**
  String deleteMessageExerciseType(String typeName);

  /// No description provided for @deleteMessageExerciseTypeEndurance.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du dieses kontinuerliche Ausdauertraining löschen willst? Es wird damit für alle Mitglieder des Instituts gelöscht.'**
  String get deleteMessageExerciseTypeEndurance;

  /// No description provided for @deleteMessageExerciseTypeOther.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diese andere Übung löschen willst? Es wird damit für alle Mitglieder des Instituts gelöscht.'**
  String get deleteMessageExerciseTypeOther;

  /// No description provided for @deleteMessageExerciseTypeTitle.
  ///
  /// In de, this message translates to:
  /// **'{typeName} löschen'**
  String deleteMessageExerciseTypeTitle(String typeName);

  /// No description provided for @deleteMessageExerciseTypeTrainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diesen Trainingsplan löschen willst? Es wird damit für alle Mitglieder des Instituts gelöscht.'**
  String get deleteMessageExerciseTypeTrainingPlan;

  /// No description provided for @deleteMessageHealthcareProfessionals.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du das Konto des/der Gesundheitsexpert*in {name} löschen willst? Alle zugehörigen Konten von {patientCount} Nutzer*innen werden ebenfalls unwiderruflich und mit sofortiger Wirkung gelöscht.'**
  String deleteMessageHealthcareProfessionals(String name, int patientCount);

  /// No description provided for @deleteMessageHealthcareProfessionalsTitle.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*in löschen'**
  String get deleteMessageHealthcareProfessionalsTitle;

  /// No description provided for @deleteMessageInstitutions.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du das Institut {name} löschen willst? Alle zugehörigen Konten von {healthcareProfessionalCount} Gesundheitsexpert*innen und {patientCount} Nutzer*innen werden ebenfalls unwiderruflich und mit sofortiger Wirkung gelöscht.'**
  String deleteMessageInstitutions(
      String name, int healthcareProfessionalCount, int patientCount);

  /// No description provided for @deleteMessageInstitutionsTitle.
  ///
  /// In de, this message translates to:
  /// **'Institut löschen'**
  String get deleteMessageInstitutionsTitle;

  /// No description provided for @deleteMessageMessagePersonal.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diese Nachricht löschen willst?'**
  String get deleteMessageMessagePersonal;

  /// No description provided for @deleteMessageMessageTemplate.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diese Nachricht löschen willst? Sie wird damit für alle Mitglieder des Instituts gelöscht.'**
  String get deleteMessageMessageTemplate;

  /// No description provided for @deleteMessageMessageTemplateTitle.
  ///
  /// In de, this message translates to:
  /// **'Nachricht löschen'**
  String get deleteMessageMessageTemplateTitle;

  /// No description provided for @deleteMessageNotes.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diese Notizen löschen willst?'**
  String get deleteMessageNotes;

  /// No description provided for @deleteMessageNotesTitle.
  ///
  /// In de, this message translates to:
  /// **'Notizen löschen'**
  String get deleteMessageNotesTitle;

  /// No description provided for @deleteMessagePatientActivity.
  ///
  /// In de, this message translates to:
  /// **'Sind Sie sicher, dass Sie die geplante Aktivität {name} löschen wollen? Alle eingetragenen Wiederholungen werden ebenfalls gelöscht!'**
  String deleteMessagePatientActivity(String name);

  /// No description provided for @deleteMessagePatients.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du das Konto des/der Nutzer*in {name} unwiderruflich und mit sofortiger Wirkung löschen willst?'**
  String deleteMessagePatients(String name);

  /// No description provided for @deleteMessagePatientsTitle.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*in löschen'**
  String get deleteMessagePatientsTitle;

  /// No description provided for @deleteMessagePersonalGoal.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du dieses Ziel löschen willst?'**
  String get deleteMessagePersonalGoal;

  /// No description provided for @deleteMessagePersonalGoalTitle.
  ///
  /// In de, this message translates to:
  /// **'Ziel löschen'**
  String get deleteMessagePersonalGoalTitle;

  /// No description provided for @deleteMessageThisActivity.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diese Aktivität löschen willst?'**
  String get deleteMessageThisActivity;

  /// No description provided for @deleteMessageThisActivityTitle.
  ///
  /// In de, this message translates to:
  /// **'Aktivität löschen'**
  String get deleteMessageThisActivityTitle;

  /// No description provided for @deleteMessageThisActivityTooltip.
  ///
  /// In de, this message translates to:
  /// **'Aktivitäten, die bereits ausgeführt wurden, können nicht gelöscht werden.'**
  String get deleteMessageThisActivityTooltip;

  /// No description provided for @deleteMessageThisAppointment.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du diesen Termin löschen möchtest?'**
  String get deleteMessageThisAppointment;

  /// No description provided for @deleteMessageThisAppointmentTitle.
  ///
  /// In de, this message translates to:
  /// **'Termin löschen'**
  String get deleteMessageThisAppointmentTitle;

  /// No description provided for @deleteMessageVideoTemplate.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du dieses Video löschen willst? Es wird damit für alle Mitglieder des Instituts gelöscht.'**
  String get deleteMessageVideoTemplate;

  /// No description provided for @deleteMessageVideoTemplateTitle.
  ///
  /// In de, this message translates to:
  /// **'Themenvideo löschen'**
  String get deleteMessageVideoTemplateTitle;

  /// No description provided for @deleteMessageWorkout.
  ///
  /// In de, this message translates to:
  /// **'Sind Sie sicher, dass Sie das Workout {name} löschen wollen? Das Workout wird damit für alle Mitglieder des Instituts gelöscht.'**
  String deleteMessageWorkout(String name);

  /// No description provided for @deleteObject.
  ///
  /// In de, this message translates to:
  /// **'Objekt löschen'**
  String get deleteObject;

  /// No description provided for @deleteProfilePicture.
  ///
  /// In de, this message translates to:
  /// **'Profilbild löschen'**
  String get deleteProfilePicture;

  /// No description provided for @deleteProfilePictureText.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du dein Profilbild endgültig löschen willst?'**
  String get deleteProfilePictureText;

  /// No description provided for @deleteNo.
  ///
  /// In de, this message translates to:
  /// **'Nein, nicht löschen'**
  String get deleteNo;

  /// No description provided for @deleteThis.
  ///
  /// In de, this message translates to:
  /// **'diese löschen'**
  String get deleteThis;

  /// No description provided for @deleteYes.
  ///
  /// In de, this message translates to:
  /// **'Ja, unwiderruflich löschen'**
  String get deleteYes;

  /// No description provided for @description.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get description;

  /// No description provided for @descriptionShort.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get descriptionShort;

  /// No description provided for @details.
  ///
  /// In de, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @detailsToMessage.
  ///
  /// In de, this message translates to:
  /// **'Details zur Nachricht'**
  String get detailsToMessage;

  /// No description provided for @dislikedActivityPreference.
  ///
  /// In de, this message translates to:
  /// **'Anti-Aktivität'**
  String get dislikedActivityPreference;

  /// No description provided for @dislikedMobilityPreference.
  ///
  /// In de, this message translates to:
  /// **'Anti-Mobilität'**
  String get dislikedMobilityPreference;

  /// No description provided for @documentation.
  ///
  /// In de, this message translates to:
  /// **'Dokumentation'**
  String get documentation;

  /// No description provided for @documentTitle.
  ///
  /// In de, this message translates to:
  /// **'Titel des Dokuments'**
  String get documentTitle;

  /// No description provided for @csvExport.
  ///
  /// In de, this message translates to:
  /// **'CSV Export'**
  String get csvExport;

  /// No description provided for @duplicate.
  ///
  /// In de, this message translates to:
  /// **'Duplizieren'**
  String get duplicate;

  /// No description provided for @duration.
  ///
  /// In de, this message translates to:
  /// **'Dauer'**
  String get duration;

  /// No description provided for @durationValueMinutes.
  ///
  /// In de, this message translates to:
  /// **'min'**
  String get durationValueMinutes;

  /// No description provided for @durationValuePoints.
  ///
  /// In de, this message translates to:
  /// **'Punkte'**
  String get durationValuePoints;

  /// No description provided for @durationValueSeconds.
  ///
  /// In de, this message translates to:
  /// **'sek'**
  String get durationValueSeconds;

  /// No description provided for @edit.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get edit;

  /// No description provided for @editActivity.
  ///
  /// In de, this message translates to:
  /// **'Aktivität bearbeiten'**
  String get editActivity;

  /// No description provided for @editAll.
  ///
  /// In de, this message translates to:
  /// **'alle bearbeiten'**
  String get editAll;

  /// No description provided for @editThis.
  ///
  /// In de, this message translates to:
  /// **'diese bearbeiten'**
  String get editThis;

  /// No description provided for @editThisActivityTooltip.
  ///
  /// In de, this message translates to:
  /// **'Aktivitäten, die bereits ausgeführt wurden, können nicht bearbeitet werden.'**
  String get editThisActivityTooltip;

  /// No description provided for @editHealthcareProfessional.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*in bearbeiten'**
  String get editHealthcareProfessional;

  /// No description provided for @editInstitution.
  ///
  /// In de, this message translates to:
  /// **'Institut bearbeiten'**
  String get editInstitution;

  /// No description provided for @editPatient.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*in bearbeiten'**
  String get editPatient;

  /// No description provided for @editProfilePicture.
  ///
  /// In de, this message translates to:
  /// **'Profilbild bearbeiten'**
  String get editProfilePicture;

  /// No description provided for @email.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// No description provided for @emailAdministrator.
  ///
  /// In de, this message translates to:
  /// **'E-Mail Administrator*in'**
  String get emailAdministrator;

  /// No description provided for @emailBeingSent.
  ///
  /// In de, this message translates to:
  /// **'E-Mail wird gesendet...'**
  String get emailBeingSent;

  /// No description provided for @emailSent.
  ///
  /// In de, this message translates to:
  /// **'E-Mail gesendet'**
  String get emailSent;

  /// No description provided for @emailSentError.
  ///
  /// In de, this message translates to:
  /// **'E-Mail konnte nicht gesendet werden.'**
  String get emailSentError;

  /// No description provided for @enableSocialFeatures.
  ///
  /// In de, this message translates to:
  /// **'Soziale Funktionen aktivieren'**
  String get enableSocialFeatures;

  /// No description provided for @endLocation.
  ///
  /// In de, this message translates to:
  /// **'Zielort'**
  String get endLocation;

  /// No description provided for @endTime.
  ///
  /// In de, this message translates to:
  /// **'Endzeit'**
  String get endTime;

  /// No description provided for @englishTranslationNote.
  ///
  /// In de, this message translates to:
  /// **'(englische Übersetzung)'**
  String get englishTranslationNote;

  /// No description provided for @englishTranslationOptional.
  ///
  /// In de, this message translates to:
  /// **'Englische Übersetzung (optional)'**
  String get englishTranslationOptional;

  /// No description provided for @error.
  ///
  /// In de, this message translates to:
  /// **'Leider ist etwas schiefgelaufen. Versuchen Sie es später erneut.'**
  String get error;

  /// No description provided for @errorNoInternet.
  ///
  /// In de, this message translates to:
  /// **'Die Anfrage konnte nicht verarbeitet werden, bitte überprüfe Deine Internetverbindung.'**
  String get errorNoInternet;

  /// No description provided for @errorPageNotFound.
  ///
  /// In de, this message translates to:
  /// **'Diese Seite haben wir leider nicht gefunden...'**
  String get errorPageNotFound;

  /// No description provided for @equipment.
  ///
  /// In de, this message translates to:
  /// **'Gerät'**
  String get equipment;

  /// No description provided for @exercise.
  ///
  /// In de, this message translates to:
  /// **'Übung'**
  String get exercise;

  /// No description provided for @exercise_ENDURANCE.
  ///
  /// In de, this message translates to:
  /// **'Kontinuierliches Ausdauertraining'**
  String get exercise_ENDURANCE;

  /// No description provided for @exercise_HYPERTROPHY.
  ///
  /// In de, this message translates to:
  /// **'Hypertrophietraining'**
  String get exercise_HYPERTROPHY;

  /// No description provided for @exercise_INTERVAL.
  ///
  /// In de, this message translates to:
  /// **'Intervall Ausdauertraining'**
  String get exercise_INTERVAL;

  /// No description provided for @exercise_OTHER.
  ///
  /// In de, this message translates to:
  /// **'Andere Übung'**
  String get exercise_OTHER;

  /// No description provided for @exercise_STRENGTHENING.
  ///
  /// In de, this message translates to:
  /// **'Kraftausdauertraining'**
  String get exercise_STRENGTHENING;

  /// No description provided for @exercise_TASK.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe'**
  String get exercise_TASK;

  /// No description provided for @exerciseBreakBetweenSets.
  ///
  /// In de, this message translates to:
  /// **'Pause zwischen Sätzen (sek)'**
  String get exerciseBreakBetweenSets;

  /// No description provided for @exerciseDurationMinutes.
  ///
  /// In de, this message translates to:
  /// **'Dauer (min)'**
  String get exerciseDurationMinutes;

  /// No description provided for @exerciseDurationSeconds.
  ///
  /// In de, this message translates to:
  /// **'Dauer (sek)'**
  String get exerciseDurationSeconds;

  /// No description provided for @exerciseIntensity.
  ///
  /// In de, this message translates to:
  /// **'Belastungsintensität (% max. HF)'**
  String get exerciseIntensity;

  /// No description provided for @exerciseIntensityPhase.
  ///
  /// In de, this message translates to:
  /// **'Belastungsphase'**
  String get exerciseIntensityPhase;

  /// No description provided for @exerciseNeedsEquipment.
  ///
  /// In de, this message translates to:
  /// **'Gerät erforderlich'**
  String get exerciseNeedsEquipment;

  /// No description provided for @exerciseNumberOfIntervals.
  ///
  /// In de, this message translates to:
  /// **'Anzahl Intervalle'**
  String get exerciseNumberOfIntervals;

  /// No description provided for @exerciseNumberOfSets.
  ///
  /// In de, this message translates to:
  /// **'Anzahl der Sätze'**
  String get exerciseNumberOfSets;

  /// No description provided for @exerciseRecoveryPhase.
  ///
  /// In de, this message translates to:
  /// **'Erholungsphase'**
  String get exerciseRecoveryPhase;

  /// No description provided for @exerciseRepeats.
  ///
  /// In de, this message translates to:
  /// **'Wiederholungen'**
  String get exerciseRepeats;

  /// No description provided for @exerciseTrainingHeartRateLowerLimit.
  ///
  /// In de, this message translates to:
  /// **'Trainingsherzfrequenz (untere Grenze)'**
  String get exerciseTrainingHeartRateLowerLimit;

  /// No description provided for @exerciseTrainingHeartRateUpperLimit.
  ///
  /// In de, this message translates to:
  /// **'Trainingsherzfrequenz (obere Grenze)'**
  String get exerciseTrainingHeartRateUpperLimit;

  /// No description provided for @exercises.
  ///
  /// In de, this message translates to:
  /// **'Übungen'**
  String get exercises;

  /// No description provided for @exerciseWorkoutStrength.
  ///
  /// In de, this message translates to:
  /// **'Krafttraining'**
  String get exerciseWorkoutStrength;

  /// No description provided for @executeActivity.
  ///
  /// In de, this message translates to:
  /// **'Aktivität eintragen'**
  String get executeActivity;

  /// No description provided for @executed.
  ///
  /// In de, this message translates to:
  /// **'Ausgeführt'**
  String get executed;

  /// No description provided for @executeTask.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe eintragen'**
  String get executeTask;

  /// No description provided for @execution.
  ///
  /// In de, this message translates to:
  /// **'Ausführung'**
  String get execution;

  /// No description provided for @executionWithSetRepeats.
  ///
  /// In de, this message translates to:
  /// **'1 Satz je {setRepeats} Wh.'**
  String executionWithSetRepeats(int setRepeats);

  /// No description provided for @executionWithSetsRepeats.
  ///
  /// In de, this message translates to:
  /// **'{numberSets} Sätze je {setRepeats} Wh.'**
  String executionWithSetsRepeats(int numberSets, int setRepeats);

  /// No description provided for @executionWithSetRepeatsAndBreak.
  ///
  /// In de, this message translates to:
  /// **'1 Satz je {setRepeats} Wh. / {breakDuration} sek. Pause zwischen den Sätzen'**
  String executionWithSetRepeatsAndBreak(int setRepeats, int breakDuration);

  /// No description provided for @executionWithSetsRepeatsAndBreak.
  ///
  /// In de, this message translates to:
  /// **'{numberSets} Sätze je {setRepeats} Wh. / {breakDuration} sek. Pause zwischen den Sätzen'**
  String executionWithSetsRepeatsAndBreak(
      int numberSets, int setRepeats, int breakDuration);

  /// No description provided for @executionWithSetSeconds.
  ///
  /// In de, this message translates to:
  /// **'1 Satz je {setDuration} sek.'**
  String executionWithSetSeconds(int setDuration);

  /// No description provided for @executionWithSetsSeconds.
  ///
  /// In de, this message translates to:
  /// **'{amountSets} Sätze je {setDuration} sek.'**
  String executionWithSetsSeconds(int amountSets, int setDuration);

  /// No description provided for @executionWithSetSecondsAndBreak.
  ///
  /// In de, this message translates to:
  /// **'1 Satz je {setDuration} sek. / {breakDuration} sek. Pause zwischen den Sätzen'**
  String executionWithSetSecondsAndBreak(int setDuration, int breakDuration);

  /// No description provided for @executionWithSetsSecondsAndBreak.
  ///
  /// In de, this message translates to:
  /// **'{numberSets} Sätze je {setDuration} sek. / {breakDuration} sek. Pause zwischen den Sätzen'**
  String executionWithSetsSecondsAndBreak(
      int numberSets, int setDuration, int breakDuration);

  /// No description provided for @export_END_OF_DOCUMENT.
  ///
  /// In de, this message translates to:
  /// **'Am Ende des Dokuments'**
  String get export_END_OF_DOCUMENT;

  /// No description provided for @export_WEEKLY.
  ///
  /// In de, this message translates to:
  /// **'Wöchentlich'**
  String get export_WEEKLY;

  /// No description provided for @export_NO_IDENTIFICATOR.
  ///
  /// In de, this message translates to:
  /// **'Kein Identifikator'**
  String get export_NO_IDENTIFICATOR;

  /// No description provided for @export_ID.
  ///
  /// In de, this message translates to:
  /// **'Alphanumerische ID'**
  String get export_ID;

  /// No description provided for @export_NAME.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get export_NAME;

  /// No description provided for @export.
  ///
  /// In de, this message translates to:
  /// **'Exportieren'**
  String get export;

  /// No description provided for @exportDocumentation.
  ///
  /// In de, this message translates to:
  /// **'Dokumentation exportieren'**
  String get exportDocumentation;

  /// No description provided for @exportEndDate.
  ///
  /// In de, this message translates to:
  /// **'Zeitraum (bis)'**
  String get exportEndDate;

  /// No description provided for @exportHint.
  ///
  /// In de, this message translates to:
  /// **'Um die Dokumentation herunterladen zu können, stelle sicher, dass Pop-ups in Deinem Browser zugelassen sind.'**
  String get exportHint;

  /// No description provided for @exportStartDate.
  ///
  /// In de, this message translates to:
  /// **'Zeitraum (von)'**
  String get exportStartDate;

  /// No description provided for @extraActivity.
  ///
  /// In de, this message translates to:
  /// **'Extra Aktivität'**
  String get extraActivity;

  /// No description provided for @extraActivityPlural.
  ///
  /// In de, this message translates to:
  /// **'Extra Aktivitäten'**
  String get extraActivityPlural;

  /// No description provided for @filename.
  ///
  /// In de, this message translates to:
  /// **'Dateiname'**
  String get filename;

  /// No description provided for @finalCheck.
  ///
  /// In de, this message translates to:
  /// **'Finaler Check'**
  String get finalCheck;

  /// No description provided for @finalCheck1.
  ///
  /// In de, this message translates to:
  /// **'mindestens ein bedeutungsvolles Ziel gesetzt'**
  String get finalCheck1;

  /// No description provided for @finalCheck2.
  ///
  /// In de, this message translates to:
  /// **'ein Trainingsplan gemeinsam erarbeitet'**
  String get finalCheck2;

  /// No description provided for @finalCheck3.
  ///
  /// In de, this message translates to:
  /// **'offene Fragen/Sorgen/Befürchtungen besprochen'**
  String get finalCheck3;

  /// No description provided for @finalCheck4.
  ///
  /// In de, this message translates to:
  /// **'ausreichend Informationsmaterial (in gewünschter Form) zur Verfügung gestellt'**
  String get finalCheck4;

  /// No description provided for @finalCheck5.
  ///
  /// In de, this message translates to:
  /// **'darauf hingewiesen, dass die Ziele und der Trainingsplan in Folgeterminen noch angepasst werden können'**
  String get finalCheck5;

  /// No description provided for @finalCheckText.
  ///
  /// In de, this message translates to:
  /// **'Mit <u>Fokus auf den/die Patient*in</u> und unter <u>Berücksichtigung seiner/ihrer Vorlieben und Vorerfahrungen</u> wurde ...'**
  String get finalCheckText;

  /// No description provided for @firstAppointment.
  ///
  /// In de, this message translates to:
  /// **'Erster Termin'**
  String get firstAppointment;

  /// No description provided for @firstName.
  ///
  /// In de, this message translates to:
  /// **'Vorname'**
  String get firstName;

  /// No description provided for @firstNameAdministrator.
  ///
  /// In de, this message translates to:
  /// **'Vorname Administrator*in'**
  String get firstNameAdministrator;

  /// No description provided for @german.
  ///
  /// In de, this message translates to:
  /// **'Deutsch'**
  String get german;

  /// No description provided for @goal.
  ///
  /// In de, this message translates to:
  /// **'Ziel'**
  String get goal;

  /// No description provided for @handOver.
  ///
  /// In de, this message translates to:
  /// **'Übergeben'**
  String get handOver;

  /// No description provided for @heatTolerance.
  ///
  /// In de, this message translates to:
  /// **'Subjektive Hitzetoleranz'**
  String get heatTolerance;

  /// No description provided for @heatTolerance_AVERAGE.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get heatTolerance_AVERAGE;

  /// No description provided for @heatTolerance_GOOD.
  ///
  /// In de, this message translates to:
  /// **'Gut'**
  String get heatTolerance_GOOD;

  /// No description provided for @heatTolerance_POOR.
  ///
  /// In de, this message translates to:
  /// **'Schlecht'**
  String get heatTolerance_POOR;

  /// No description provided for @healthcareProfessional.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*in'**
  String get healthcareProfessional;

  /// No description provided for @healthcareProfessionals.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*innen'**
  String get healthcareProfessionals;

  /// No description provided for @help.
  ///
  /// In de, this message translates to:
  /// **'Hilfe'**
  String get help;

  /// No description provided for @helpOnboardingGuide.
  ///
  /// In de, this message translates to:
  /// **'<a>App-Rundgang &gt;</a>'**
  String get helpOnboardingGuide;

  /// No description provided for @helpTextProblems.
  ///
  /// In de, this message translates to:
  /// **'Bei Fragen oder Problemen mit aktivplan bitten wir um Kontaktaufnahme.'**
  String get helpTextProblems;

  /// No description provided for @helpUserGuideExperts.
  ///
  /// In de, this message translates to:
  /// **'<a href=\'https://resources.lbidhp.at/aktivplan/consent/docs/Handbuch_Gesundheitsexperten.pdf\'>Benutzerhandbuch &gt;</a>'**
  String get helpUserGuideExperts;

  /// No description provided for @helpUserGuidePatients.
  ///
  /// In de, this message translates to:
  /// **'<a href=\'https://resources.lbidhp.at/aktivplan/consent/docs/Handbuch_Patienten.pdf\'>Benutzerhandbuch &gt;</a>'**
  String get helpUserGuidePatients;

  /// No description provided for @hintRequiredFields.
  ///
  /// In de, this message translates to:
  /// **'* Pflichtfelder'**
  String get hintRequiredFields;

  /// No description provided for @homeLocation.
  ///
  /// In de, this message translates to:
  /// **'Heimatort'**
  String get homeLocation;

  /// No description provided for @id.
  ///
  /// In de, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @identificator.
  ///
  /// In de, this message translates to:
  /// **'Identifikator'**
  String get identificator;

  /// No description provided for @inactive.
  ///
  /// In de, this message translates to:
  /// **'inaktiv'**
  String get inactive;

  /// No description provided for @institution.
  ///
  /// In de, this message translates to:
  /// **'Institut'**
  String get institution;

  /// No description provided for @institutionAdministrator.
  ///
  /// In de, this message translates to:
  /// **'Administrator*in des Instituts'**
  String get institutionAdministrator;

  /// No description provided for @institutionAvailabilityPhone.
  ///
  /// In de, this message translates to:
  /// **'Telefonische Erreichbarkeit (z.B. Montag - Freitag, 9.00 - 15.00 Uhr)'**
  String get institutionAvailabilityPhone;

  /// No description provided for @institutionAvailabilityPhoneEnglish.
  ///
  /// In de, this message translates to:
  /// **'Telefonische Erreichbarkeit (z.B. Monday - Friday, 9.00 - 15.00 o\'clock)'**
  String get institutionAvailabilityPhoneEnglish;

  /// No description provided for @institutionEmailUserQueries.
  ///
  /// In de, this message translates to:
  /// **'E-Mail für Rückfragen von Nutzer*innen'**
  String get institutionEmailUserQueries;

  /// No description provided for @institutionFocus.
  ///
  /// In de, this message translates to:
  /// **'Schwerpunkt des Instituts'**
  String get institutionFocus;

  /// No description provided for @institutionFocus_CARDIOVASCULAR_REHABILITATION.
  ///
  /// In de, this message translates to:
  /// **'Herz-Kreislauf-Rehabilitation'**
  String get institutionFocus_CARDIOVASCULAR_REHABILITATION;

  /// No description provided for @institutionFocus_KLIMAFIT.
  ///
  /// In de, this message translates to:
  /// **'Klimafit'**
  String get institutionFocus_KLIMAFIT;

  /// No description provided for @institutionFocus_KLIMAFIT_LIGHT.
  ///
  /// In de, this message translates to:
  /// **'Klimafit Light'**
  String get institutionFocus_KLIMAFIT_LIGHT;

  /// No description provided for @institutionFocus_PREHAB_TO_REHAB.
  ///
  /// In de, this message translates to:
  /// **'Prehab2Rehab'**
  String get institutionFocus_PREHAB_TO_REHAB;

  /// No description provided for @institutionFocus_PROMOTING_A_HEALTHY_LIFESTYLE.
  ///
  /// In de, this message translates to:
  /// **'Förderung eines gesunden Lebensstils'**
  String get institutionFocus_PROMOTING_A_HEALTHY_LIFESTYLE;

  /// No description provided for @institutionFocusP2RFocus_GENERAL.
  ///
  /// In de, this message translates to:
  /// **'Allgemein'**
  String get institutionFocusP2RFocus_GENERAL;

  /// No description provided for @institutionGetInTouchNotes.
  ///
  /// In de, this message translates to:
  /// **'Sonstige Hinweise zur Kontaktaufnahme (z.B. Wir bemühen uns, alle Anfragen innerhalb von 24 Stunden zu bearbeiten.)'**
  String get institutionGetInTouchNotes;

  /// No description provided for @institutionGetInTouchNotesEnglish.
  ///
  /// In de, this message translates to:
  /// **'Sonstige Hinweise zur Kontaktaufnahme (z.B. We strive to process all requests within 24 hours.)'**
  String get institutionGetInTouchNotesEnglish;

  /// No description provided for @institutionOverview.
  ///
  /// In de, this message translates to:
  /// **'Institutsübersicht'**
  String get institutionOverview;

  /// No description provided for @institutionPhoneNumberUserQueries.
  ///
  /// In de, this message translates to:
  /// **'Telefonnummer für Rückfragen von Nutzer*innen'**
  String get institutionPhoneNumberUserQueries;

  /// No description provided for @institutionUrl.
  ///
  /// In de, this message translates to:
  /// **'Website des Instituts'**
  String get institutionUrl;

  /// No description provided for @intensity.
  ///
  /// In de, this message translates to:
  /// **'Belastungsintensität'**
  String get intensity;

  /// No description provided for @intensityDuration.
  ///
  /// In de, this message translates to:
  /// **'Belastungsintensität / Dauer'**
  String get intensityDuration;

  /// No description provided for @intensityLineBreak.
  ///
  /// In de, this message translates to:
  /// **'Belastungs-\nintensität'**
  String get intensityLineBreak;

  /// No description provided for @intervalCount.
  ///
  /// In de, this message translates to:
  /// **'Anzahl der Intervalle'**
  String get intervalCount;

  /// No description provided for @intervals.
  ///
  /// In de, this message translates to:
  /// **'Intervalle'**
  String get intervals;

  /// No description provided for @jobName.
  ///
  /// In de, this message translates to:
  /// **'Berufsbezeichnung'**
  String get jobName;

  /// No description provided for @kg.
  ///
  /// In de, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @lastActiveAt.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt aktiv am'**
  String get lastActiveAt;

  /// No description provided for @lastAppointment.
  ///
  /// In de, this message translates to:
  /// **'Letzter Termin'**
  String get lastAppointment;

  /// No description provided for @lastName.
  ///
  /// In de, this message translates to:
  /// **'Nachname'**
  String get lastName;

  /// No description provided for @lastNameAdministrator.
  ///
  /// In de, this message translates to:
  /// **'Nachname Administrator*in'**
  String get lastNameAdministrator;

  /// No description provided for @lastOnlineAt.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt online am {date} um {time} Uhr'**
  String lastOnlineAt(String date, String time);

  /// No description provided for @lastOnlineTodayAt.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt online heute um {time} Uhr'**
  String lastOnlineTodayAt(String time);

  /// No description provided for @lastOnlineYesterdayAt.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt online gestern um {time} Uhr'**
  String lastOnlineYesterdayAt(String time);

  /// No description provided for @legalNoticeCompanyContactAddress.
  ///
  /// In de, this message translates to:
  /// **'Lindhofstr. 22, 5020 Salzburg, Österreich'**
  String get legalNoticeCompanyContactAddress;

  /// No description provided for @legalNoticeCompanyContactPhone.
  ///
  /// In de, this message translates to:
  /// **'Tel.: <phone number=\'+435725582701\'>+43 (0) 5 7255 82701</phone>'**
  String get legalNoticeCompanyContactPhone;

  /// No description provided for @legalNoticeCompanyContactMail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail: <mail target=\'office@dhp.lbg.ac.at\'>office@dhp.lbg.ac.at</mail>'**
  String get legalNoticeCompanyContactMail;

  /// No description provided for @legalNoticeCompanyDescription.
  ///
  /// In de, this message translates to:
  /// **'Rechtlich unselbstständige Einrichtung der Ludwig Boltzmann Gesellschaft GmbH'**
  String get legalNoticeCompanyDescription;

  /// No description provided for @legalNoticeCompanyName.
  ///
  /// In de, this message translates to:
  /// **'Ludwig Boltzmann Institut für digitale Gesundheit und Prävention'**
  String get legalNoticeCompanyName;

  /// No description provided for @legalNoticeDataProtection.
  ///
  /// In de, this message translates to:
  /// **'Datenschutz'**
  String get legalNoticeDataProtection;

  /// No description provided for @legalNoticeMoreInformation.
  ///
  /// In de, this message translates to:
  /// **'<a href=\'https://dhp.lbg.ac.at/impressum\'>Weitere Infos &gt;</a>'**
  String get legalNoticeMoreInformation;

  /// No description provided for @legalNoticePrivacyPolicy.
  ///
  /// In de, this message translates to:
  /// **'<a href=\'https://resources.lbidhp.at/aktivplan/consent/docs/Datenschutzerklarung_v2.html\'>Datenschutzerklärung &gt;</a>'**
  String get legalNoticePrivacyPolicy;

  /// No description provided for @legalNoticeTermsAndConditions.
  ///
  /// In de, this message translates to:
  /// **'<a href=\'https://resources.lbidhp.at/aktivplan/consent/docs/AGB_v1.pdf\'>Allgemeine Geschäftsbedingungen &gt;</a>'**
  String get legalNoticeTermsAndConditions;

  /// No description provided for @legalNoticeTermsAndConditionsMenu.
  ///
  /// In de, this message translates to:
  /// **'Impressum & Datenschutz'**
  String get legalNoticeTermsAndConditionsMenu;

  /// No description provided for @less.
  ///
  /// In de, this message translates to:
  /// **'weniger'**
  String get less;

  /// No description provided for @letsGo.
  ///
  /// In de, this message translates to:
  /// **'Los geht\'s!'**
  String get letsGo;

  /// No description provided for @literature.
  ///
  /// In de, this message translates to:
  /// **'Literatur'**
  String get literature;

  /// No description provided for @location.
  ///
  /// In de, this message translates to:
  /// **'Ort'**
  String get location;

  /// No description provided for @login.
  ///
  /// In de, this message translates to:
  /// **'Anmelden'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get logout;

  /// No description provided for @maximumBloodPressure.
  ///
  /// In de, this message translates to:
  /// **'Maximaler Blutdruck'**
  String get maximumBloodPressure;

  /// No description provided for @maximumBloodPressureShort.
  ///
  /// In de, this message translates to:
  /// **'Max. Blutdruck'**
  String get maximumBloodPressureShort;

  /// No description provided for @maximumBloodPressureWithUnit.
  ///
  /// In de, this message translates to:
  /// **'Maximaler Blutdruck (100/50 - 300/200 mmHg)'**
  String get maximumBloodPressureWithUnit;

  /// No description provided for @maximumHeartRate.
  ///
  /// In de, this message translates to:
  /// **'Maximale Herzfrequenz'**
  String get maximumHeartRate;

  /// No description provided for @maximumHeartRateShort.
  ///
  /// In de, this message translates to:
  /// **'Max. Herzfrequenz'**
  String get maximumHeartRateShort;

  /// No description provided for @maximumHeartRateWithUnit.
  ///
  /// In de, this message translates to:
  /// **'Maximale Herzfrequenz (60 - 220 bpm)'**
  String get maximumHeartRateWithUnit;

  /// No description provided for @maximumOxygen.
  ///
  /// In de, this message translates to:
  /// **'Maximale Sauerstoffaufnahme'**
  String get maximumOxygen;

  /// No description provided for @maximumOxygenShort.
  ///
  /// In de, this message translates to:
  /// **'Max. Sauerstoffaufnahme'**
  String get maximumOxygenShort;

  /// No description provided for @maximumOxygenWithUnit.
  ///
  /// In de, this message translates to:
  /// **'Maximale Sauerstoffaufnahme (10 - 100 ml/kg/min)'**
  String get maximumOxygenWithUnit;

  /// No description provided for @maximumPerformance.
  ///
  /// In de, this message translates to:
  /// **'Maximale Leistung'**
  String get maximumPerformance;

  /// No description provided for @maximumPerformanceShort.
  ///
  /// In de, this message translates to:
  /// **'Max. Leistung'**
  String get maximumPerformanceShort;

  /// No description provided for @maximumPerformanceWithUnit.
  ///
  /// In de, this message translates to:
  /// **'Maximale Leistung (0,1 - 8 Watt/kg)'**
  String get maximumPerformanceWithUnit;

  /// No description provided for @medication.
  ///
  /// In de, this message translates to:
  /// **'Medikamente'**
  String get medication;

  /// No description provided for @message.
  ///
  /// In de, this message translates to:
  /// **'Nachricht'**
  String get message;

  /// No description provided for @messageHistoryHint.
  ///
  /// In de, this message translates to:
  /// **'Diese Funktion ist nur für Nachrichten an mehrere Personen gedacht. Nachrichten an einzelne Personen können über das Nutzerprofil versendet werden.'**
  String get messageHistoryHint;

  /// No description provided for @messageHistoryHintPatient.
  ///
  /// In de, this message translates to:
  /// **'Über den Menüpunkt \"Nachrichten\" können Nachrichten an mehrere Personen gesendet werden.'**
  String get messageHistoryHintPatient;

  /// No description provided for @messageRestriction.
  ///
  /// In de, this message translates to:
  /// **'Einschränkung'**
  String get messageRestriction;

  /// No description provided for @messageRestriction_AFTER_SURGERY.
  ///
  /// In de, this message translates to:
  /// **'Nach der Operation'**
  String get messageRestriction_AFTER_SURGERY;

  /// No description provided for @messageRestriction_BEFORE_SURGERY.
  ///
  /// In de, this message translates to:
  /// **'Vor der Operation'**
  String get messageRestriction_BEFORE_SURGERY;

  /// No description provided for @messageRestriction_NO_RESTRICTION.
  ///
  /// In de, this message translates to:
  /// **'Keine Einschränkung'**
  String get messageRestriction_NO_RESTRICTION;

  /// No description provided for @messages.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten'**
  String get messages;

  /// No description provided for @messagesHint.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten in dieser Liste sollten informativ oder motivierend sein. Vor dem Hinzufügen einer neuen Nachricht bitte beachten, dass diese an alle Nutzer*innen gesendet wird (zu unterschiedlichen, zufälligen Zeitpunkten) und daher alle Nutzer*innen ansprechen sollte.'**
  String get messagesHint;

  /// No description provided for @messagesScheduledFor.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten geplant für {name}'**
  String messagesScheduledFor(String name);

  /// No description provided for @messageSendToType_ALL.
  ///
  /// In de, this message translates to:
  /// **'Alle Nutzer*innen'**
  String get messageSendToType_ALL;

  /// No description provided for @messageSendToType_SOME.
  ///
  /// In de, this message translates to:
  /// **'Ausgewählte Empfänger*innen'**
  String get messageSendToType_SOME;

  /// No description provided for @minimumDaysBetweenInformationMessages.
  ///
  /// In de, this message translates to:
  /// **'Mindestabstand Tage zwischen Informationsnachrichten'**
  String get minimumDaysBetweenInformationMessages;

  /// No description provided for @minutes.
  ///
  /// In de, this message translates to:
  /// **'Minuten'**
  String get minutes;

  /// No description provided for @minutesKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Aktivitätspunkten'**
  String get minutesKlimafit;

  /// No description provided for @mobilityPreference.
  ///
  /// In de, this message translates to:
  /// **'Mobilitätspräferenz'**
  String get mobilityPreference;

  /// No description provided for @mobilityPreference_BIKE.
  ///
  /// In de, this message translates to:
  /// **'Fahrrad'**
  String get mobilityPreference_BIKE;

  /// No description provided for @mobilityPreference_CAR.
  ///
  /// In de, this message translates to:
  /// **'Auto'**
  String get mobilityPreference_CAR;

  /// No description provided for @mobilityPreference_FOOT.
  ///
  /// In de, this message translates to:
  /// **'Zu Fuß'**
  String get mobilityPreference_FOOT;

  /// No description provided for @mobilityPreference_PUBLIC_TRANSPORT.
  ///
  /// In de, this message translates to:
  /// **'Öffentliche Verkehrsmittel'**
  String get mobilityPreference_PUBLIC_TRANSPORT;

  /// No description provided for @month.
  ///
  /// In de, this message translates to:
  /// **'Monat'**
  String get month;

  /// No description provided for @more.
  ///
  /// In de, this message translates to:
  /// **'mehr'**
  String get more;

  /// No description provided for @muscleGroup_ABDOMINAL.
  ///
  /// In de, this message translates to:
  /// **'Bauch'**
  String get muscleGroup_ABDOMINAL;

  /// No description provided for @muscleGroup_ARMS.
  ///
  /// In de, this message translates to:
  /// **'Arme'**
  String get muscleGroup_ARMS;

  /// No description provided for @muscleGroup_BACK.
  ///
  /// In de, this message translates to:
  /// **'Rücken'**
  String get muscleGroup_BACK;

  /// No description provided for @muscleGroup_CHEST.
  ///
  /// In de, this message translates to:
  /// **'Brust'**
  String get muscleGroup_CHEST;

  /// No description provided for @muscleGroup_LEGS.
  ///
  /// In de, this message translates to:
  /// **'Beine'**
  String get muscleGroup_LEGS;

  /// No description provided for @muscleGroup_SHOULDERS.
  ///
  /// In de, this message translates to:
  /// **'Schultern'**
  String get muscleGroup_SHOULDERS;

  /// No description provided for @muscleGroups.
  ///
  /// In de, this message translates to:
  /// **'Muskelgruppen'**
  String get muscleGroups;

  /// No description provided for @myCode.
  ///
  /// In de, this message translates to:
  /// **'Mein Code'**
  String get myCode;

  /// No description provided for @myContacts.
  ///
  /// In de, this message translates to:
  /// **'Meine Kontakte'**
  String get myContacts;

  /// No description provided for @myHealthData.
  ///
  /// In de, this message translates to:
  /// **'Meine Daten'**
  String get myHealthData;

  /// No description provided for @myProfile.
  ///
  /// In de, this message translates to:
  /// **'Mein Profil'**
  String get myProfile;

  /// No description provided for @name.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameEnglish.
  ///
  /// In de, this message translates to:
  /// **'Name (englische Übersetzung)'**
  String get nameEnglish;

  /// No description provided for @newEmptyWeek.
  ///
  /// In de, this message translates to:
  /// **'Neue leere Woche'**
  String get newEmptyWeek;

  /// No description provided for @newPassword.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort'**
  String get newPassword;

  /// No description provided for @newValue.
  ///
  /// In de, this message translates to:
  /// **'Neu'**
  String get newValue;

  /// No description provided for @newVersionAvailable.
  ///
  /// In de, this message translates to:
  /// **'Neue Version verfügbar'**
  String get newVersionAvailable;

  /// No description provided for @newVersionAvailableText.
  ///
  /// In de, this message translates to:
  /// **'Eine neue Version ({version}) der aktivplan-App ist verfügbar. Bitte aktualisiere die App.'**
  String newVersionAvailableText(String version);

  /// No description provided for @next.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get next;

  /// No description provided for @nextExercise.
  ///
  /// In de, this message translates to:
  /// **'Nächste Übung: {name}'**
  String nextExercise(String name);

  /// No description provided for @nextPlannedActivity.
  ///
  /// In de, this message translates to:
  /// **'Nächste geplante Aktivität'**
  String get nextPlannedActivity;

  /// No description provided for @no.
  ///
  /// In de, this message translates to:
  /// **'Nein'**
  String get no;

  /// No description provided for @noApps.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Apps erfasst.'**
  String get noApps;

  /// No description provided for @none.
  ///
  /// In de, this message translates to:
  /// **'keine'**
  String get none;

  /// No description provided for @noExercises.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Trainings erfasst.'**
  String get noExercises;

  /// No description provided for @noImagesSelected.
  ///
  /// In de, this message translates to:
  /// **'Keine Bilder ausgewählt'**
  String get noImagesSelected;

  /// No description provided for @noInstitutions.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Institute hinzugefügt.'**
  String get noInstitutions;

  /// No description provided for @noMessages.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Nachrichten erfasst.'**
  String get noMessages;

  /// No description provided for @noNewNotifications.
  ///
  /// In de, this message translates to:
  /// **'Keine neuen Benachrichtigungen.'**
  String get noNewNotifications;

  /// No description provided for @noNextPlannedActivity.
  ///
  /// In de, this message translates to:
  /// **'Kein geplanten Aktivitäten in nächster Zeit.'**
  String get noNextPlannedActivity;

  /// No description provided for @noPatientNotes.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Notizen erfasst'**
  String get noPatientNotes;

  /// No description provided for @noPatients.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Nutzer erfasst.'**
  String get noPatients;

  /// No description provided for @noPersonalGoals.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Ziele gesetzt'**
  String get noPersonalGoals;

  /// No description provided for @noPlannedActivities.
  ///
  /// In de, this message translates to:
  /// **'Keine Aktivitäten geplant'**
  String get noPlannedActivities;

  /// No description provided for @noTasks.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Aufgaben erfasst.'**
  String get noTasks;

  /// No description provided for @noTrainingPlans.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Trainingspläne erfasst.'**
  String get noTrainingPlans;

  /// No description provided for @notExecuted.
  ///
  /// In de, this message translates to:
  /// **'Noch nicht ausgeführt'**
  String get notExecuted;

  /// No description provided for @notifications.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen'**
  String get notifications;

  /// No description provided for @noVideos.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Videos erfasst.'**
  String get noVideos;

  /// No description provided for @now.
  ///
  /// In de, this message translates to:
  /// **'Jetzt'**
  String get now;

  /// No description provided for @noWorkoutExercise.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Übungen erfasst.'**
  String get noWorkoutExercise;

  /// No description provided for @noWorkouts.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Workout erfasst.'**
  String get noWorkouts;

  /// No description provided for @note.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get note;

  /// No description provided for @notes.
  ///
  /// In de, this message translates to:
  /// **'Anmerkungen'**
  String get notes;

  /// No description provided for @notesEnglish.
  ///
  /// In de, this message translates to:
  /// **'Anmerkungen (englische Übersetzung)'**
  String get notesEnglish;

  /// No description provided for @notesHealthExpert.
  ///
  /// In de, this message translates to:
  /// **'Notizen Gesundheitsexpert*in'**
  String get notesHealthExpert;

  /// No description provided for @older.
  ///
  /// In de, this message translates to:
  /// **'Älter'**
  String get older;

  /// No description provided for @oldPassword.
  ///
  /// In de, this message translates to:
  /// **'Altes Passwort'**
  String get oldPassword;

  /// No description provided for @onboardingText1.
  ///
  /// In de, this message translates to:
  /// **'<h1>Willkommen!</h1>\n\nWir freuen uns, dass Du Dich dafür entschieden hast die <b>aktiv</b>plan App zu verwenden.\n\nMöchtest Du einen kurzen Überblick über die wichtigsten Funktionalitäten der App erhalten?'**
  String get onboardingText1;

  /// No description provided for @onboardingText2.
  ///
  /// In de, this message translates to:
  /// **'<h1>Dein Trainingsplan</h1>\n\nBehalte den Überblick über Deine geplanten Aktivitäten und dokumentiere Details zur Ausführung.\n\nUm zusätzliche Informationen zu einer Aktivität zu erhalten, klicke auf diese Aktivität. Wenn Du eine Aktivität ausgeführt hast, klicke auf den Kreis, um sie abzuhaken.'**
  String get onboardingText2;

  /// No description provided for @onboardingText3.
  ///
  /// In de, this message translates to:
  /// **'<h1>Aktive Minuten</h1>\n\nErreiche jede Woche Dein Ziel und beobachte Deine Fortschritte.\n\nAktive Minuten sammelst Du, indem Du Aktivitäten ausführst und abhakst.\n\nUm mehr Details über den zeitlichen Verlauf zu erfahren, klicke auf die Grafik.'**
  String get onboardingText3;

  /// No description provided for @onboardingText3Klimafit.
  ///
  /// In de, this message translates to:
  /// **'<h1>Aktivitätspunkte</h1>\n\nErreiche jede Woche Dein Ziel und beobachte Deine Fortschritte.\n\nAktivitätspunkte sammelst Du, indem Du Aktivitäten ausführst und abhakst.\n\nUm mehr Details über den zeitlichen Verlauf zu erfahren, klicke auf die Grafik.'**
  String get onboardingText3Klimafit;

  /// No description provided for @onboardingText4.
  ///
  /// In de, this message translates to:
  /// **'<h1>Einhaltung Trainingsplan</h1>\n\nVersuche stets, Dich an den mit den Gesundheitsexpert*innen ausgearbeiteten Trainingsplan zu halten und die Aktivitäten wie geplant durchzuführen.\n\nDiese Grafik zeigt Dir auf einen Blick, wie gut Dir das gelingt.'**
  String get onboardingText4;

  /// No description provided for @onboardingText5.
  ///
  /// In de, this message translates to:
  /// **'<h1>Persönliche Ziele</h1>\n\nDeine persönlichen Ziele werden im Kalender am jeweiligen Tag und unten auf der Trainingsplanseite angezeigt.\n\nUm mehr Details zu einem Ziel anzuzeigen, klicke auf dieses Ziel. Um ein Ziel als erreicht zu markieren, klicke auf den Kreis.'**
  String get onboardingText5;

  /// No description provided for @onboardingText6.
  ///
  /// In de, this message translates to:
  /// **'<h1>Dein Benutzerprofil</h1>\n\nÜber Dein Benutzerprofil kannst Du Deine Daten einsehen und Änderungen anfragen.\n\nAußerdem kannst Du einen &quot;Besonderen Status&quot; einstellen, der deinem/deiner Gesunheitsexpert*in angezeigt wird.'**
  String get onboardingText6;

  /// No description provided for @onboardingText7.
  ///
  /// In de, this message translates to:
  /// **'<h1>Viel Spaß beim Aktivsein!</h1>\n\nEntdecke weitere Funktionen über das Menü.\n\nSollte noch etwas unklar sein, kannst Du unter dem Menüpunkt &quot;Hilfe&quot; ein umfassendes Benutzerhandbuch abrufen.'**
  String get onboardingText7;

  /// No description provided for @or.
  ///
  /// In de, this message translates to:
  /// **'oder'**
  String get or;

  /// No description provided for @orSendLater.
  ///
  /// In de, this message translates to:
  /// **'oder später senden'**
  String get orSendLater;

  /// No description provided for @overwriteDataIrreversibly.
  ///
  /// In de, this message translates to:
  /// **'Daten unwiderruflich überschreiben'**
  String get overwriteDataIrreversibly;

  /// No description provided for @overwriteDatabase.
  ///
  /// In de, this message translates to:
  /// **'Datenbank überschreiben'**
  String get overwriteDatabase;

  /// No description provided for @overwriteDatabaseText.
  ///
  /// In de, this message translates to:
  /// **'Durch die Übertragung der Datenbank werden sämtliche Änderungen (Anpassungen/Löschungen/Ergänzungen), die ein Institut möglicherweise vorgenommen hat, unwiderruflich überschrieben. Bitte wähle aus, welche Daten du überschreiben möchtest:'**
  String get overwriteDatabaseText;

  /// No description provided for @password.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get password;

  /// No description provided for @participantId.
  ///
  /// In de, this message translates to:
  /// **'Teilnehmer*in ID'**
  String get participantId;

  /// No description provided for @patient.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*in'**
  String get patient;

  /// No description provided for @patientHandover.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*innen übergeben'**
  String get patientHandover;

  /// No description provided for @patientHandoverComplete.
  ///
  /// In de, this message translates to:
  /// **'Übergabe erfolgreich'**
  String get patientHandoverComplete;

  /// No description provided for @patientHandoverCompleteMultipleText.
  ///
  /// In de, this message translates to:
  /// **'Patienten {patientNames} wurden erfolgreich an {healthcareProfessionalName} übergeben.'**
  String patientHandoverCompleteMultipleText(
      Object healthcareProfessionalName, Object patientNames);

  /// No description provided for @patientHandoverCompleteSingleText.
  ///
  /// In de, this message translates to:
  /// **'Patient {patientName} wurde erfolgreich an {healthcareProfessionalName} übergeben.'**
  String patientHandoverCompleteSingleText(
      Object healthcareProfessionalName, Object patientName);

  /// No description provided for @patientNotes.
  ///
  /// In de, this message translates to:
  /// **'Patientennotizen'**
  String get patientNotes;

  /// No description provided for @patientMaximumHeartRate.
  ///
  /// In de, this message translates to:
  /// **'Maximale Herzfrequenz: {value} bpm'**
  String patientMaximumHeartRate(int value);

  /// No description provided for @patientsInfoActiveMinutes.
  ///
  /// In de, this message translates to:
  /// **'Hat in den letzten vier Wochen <trafficLight1/> <b>mindestens 80%</b> <trafficLight2/> <b>50% bis 79%</b> <trafficLight3/> <b>weniger als 50%</b> der geplanten aktiven Minuten absolviert.'**
  String get patientsInfoActiveMinutes;

  /// No description provided for @patientsInfoActiveMinutesKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Hat in den letzten vier Wochen <trafficLight1/> <b>mindestens 80%</b> <trafficLight2/> <b>50% bis 79%</b> <trafficLight3/> <b>weniger als 50%</b> der geplanten Aktivitätspunkte absolviert.'**
  String get patientsInfoActiveMinutesKlimafit;

  /// No description provided for @patientsInfoActiveMinutesThreeWeeks.
  ///
  /// In de, this message translates to:
  /// **'Hat in den letzten drei Wochen <trafficLight1/> <b>mindestens 80%</b> <trafficLight2/> <b>50% bis 79%</b> <trafficLight3/> <b>weniger als 50%</b> der aktiven Minuten absolviert.'**
  String get patientsInfoActiveMinutesThreeWeeks;

  /// No description provided for @patientState_INAPPROPRIATE_TRAINING_PLAN.
  ///
  /// In de, this message translates to:
  /// **'Plan unpassend'**
  String get patientState_INAPPROPRIATE_TRAINING_PLAN;

  /// No description provided for @patientState_NO_STATE.
  ///
  /// In de, this message translates to:
  /// **'Plan passend'**
  String get patientState_NO_STATE;

  /// No description provided for @patientState_ON_VACATION.
  ///
  /// In de, this message translates to:
  /// **'Im Urlaub'**
  String get patientState_ON_VACATION;

  /// No description provided for @patientState_SICK.
  ///
  /// In de, this message translates to:
  /// **'Krank'**
  String get patientState_SICK;

  /// No description provided for @patientStateActiveMinutes.
  ///
  /// In de, this message translates to:
  /// **'Aktive Minuten Status'**
  String get patientStateActiveMinutes;

  /// No description provided for @patientStateActiveMinutesPercentage.
  ///
  /// In de, this message translates to:
  /// **'{percentage}% ({percentagePlanned}% gepl. Akt.)'**
  String patientStateActiveMinutesPercentage(
      int percentage, int percentagePlanned);

  /// No description provided for @patientStateFourWeekState.
  ///
  /// In de, this message translates to:
  /// **'Vier-Wochen-Status'**
  String get patientStateFourWeekState;

  /// No description provided for @patientStateNotification.
  ///
  /// In de, this message translates to:
  /// **'Statusmitteilung'**
  String get patientStateNotification;

  /// No description provided for @patientStatePlannedActiveMinutes.
  ///
  /// In de, this message translates to:
  /// **'Geplante aktive Minuten Status'**
  String get patientStatePlannedActiveMinutes;

  /// No description provided for @patientStatePlannedActiveMinutesKlimafit.
  ///
  /// In de, this message translates to:
  /// **'Geplante Aktivitätspunkte Status'**
  String get patientStatePlannedActiveMinutesKlimafit;

  /// No description provided for @patientOverview.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*innenübersicht'**
  String get patientOverview;

  /// No description provided for @patients.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*innen'**
  String get patients;

  /// No description provided for @performedOn.
  ///
  /// In de, this message translates to:
  /// **'Ausgeführt am'**
  String get performedOn;

  /// No description provided for @personalGoal.
  ///
  /// In de, this message translates to:
  /// **'Persönliches Ziel'**
  String get personalGoal;

  /// No description provided for @personalGoalReachedPart1.
  ///
  /// In de, this message translates to:
  /// **'Du hast dein Ziel'**
  String get personalGoalReachedPart1;

  /// No description provided for @personalGoalReachedPart2.
  ///
  /// In de, this message translates to:
  /// **'erreicht.'**
  String get personalGoalReachedPart2;

  /// No description provided for @personalGoalReachedPart2earlier.
  ///
  /// In de, this message translates to:
  /// **'früher erreicht als geplant.'**
  String get personalGoalReachedPart2earlier;

  /// No description provided for @personalGoals.
  ///
  /// In de, this message translates to:
  /// **'Persönliche Ziele'**
  String get personalGoals;

  /// No description provided for @perWeek.
  ///
  /// In de, this message translates to:
  /// **'pro Woche'**
  String get perWeek;

  /// No description provided for @pesiQuestion.
  ///
  /// In de, this message translates to:
  /// **'Wie warm hast du dich gefühlt?'**
  String get pesiQuestion;

  /// No description provided for @pesiValue_1.
  ///
  /// In de, this message translates to:
  /// **'Angenehm'**
  String get pesiValue_1;

  /// No description provided for @pesiValue_2.
  ///
  /// In de, this message translates to:
  /// **'Leicht warm'**
  String get pesiValue_2;

  /// No description provided for @pesiValue_3.
  ///
  /// In de, this message translates to:
  /// **'Warm'**
  String get pesiValue_3;

  /// No description provided for @pesiValue_4.
  ///
  /// In de, this message translates to:
  /// **'Heiß'**
  String get pesiValue_4;

  /// No description provided for @pesiValue_5.
  ///
  /// In de, this message translates to:
  /// **'Sehr heiß'**
  String get pesiValue_5;

  /// No description provided for @phone.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get phone;

  /// No description provided for @picture.
  ///
  /// In de, this message translates to:
  /// **'Foto'**
  String get picture;

  /// No description provided for @plan.
  ///
  /// In de, this message translates to:
  /// **'Planen'**
  String get plan;

  /// No description provided for @plannedActivities.
  ///
  /// In de, this message translates to:
  /// **'Gemeinsam geplante Aktivitäten'**
  String get plannedActivities;

  /// No description provided for @plannedActivity.
  ///
  /// In de, this message translates to:
  /// **'Geplante Aktivität'**
  String get plannedActivity;

  /// No description provided for @plannedActivityPlural.
  ///
  /// In de, this message translates to:
  /// **'Geplante Aktivitäten'**
  String get plannedActivityPlural;

  /// No description provided for @plannedMinutes.
  ///
  /// In de, this message translates to:
  /// **'{amount} min geplant'**
  String plannedMinutes(int amount);

  /// No description provided for @plannedOn.
  ///
  /// In de, this message translates to:
  /// **'Geplant am'**
  String get plannedOn;

  /// No description provided for @plannedOnDays.
  ///
  /// In de, this message translates to:
  /// **'An folgenden Tagen geplant'**
  String get plannedOnDays;

  /// No description provided for @planOnDays.
  ///
  /// In de, this message translates to:
  /// **'An folgenden Tagen planen'**
  String get planOnDays;

  /// No description provided for @pleaseAcceptTerms.
  ///
  /// In de, this message translates to:
  /// **'Bitte Datenschutzbestimmungen akzeptieren.'**
  String get pleaseAcceptTerms;

  /// No description provided for @postImageTitle.
  ///
  /// In de, this message translates to:
  /// **'Bild(er) meiner Story hinzufügen'**
  String get postImageTitle;

  /// No description provided for @postImageText.
  ///
  /// In de, this message translates to:
  /// **'Wähle Bilder aus deiner Gallerie aus \noder mache ein neues Foto.'**
  String get postImageText;

  /// No description provided for @postStatus.
  ///
  /// In de, this message translates to:
  /// **'Status posten'**
  String get postStatus;

  /// No description provided for @postStatusTextHint.
  ///
  /// In de, this message translates to:
  /// **'Was möchtest du teilen?'**
  String get postStatusTextHint;

  /// No description provided for @postedStatusMessage.
  ///
  /// In de, this message translates to:
  /// **'Status erfolgreich gepostet'**
  String get postedStatusMessage;

  /// No description provided for @postedStatusMessageError.
  ///
  /// In de, this message translates to:
  /// **'Status konnte nicht gepostet werden'**
  String get postedStatusMessageError;

  /// No description provided for @postedMinutesAgo.
  ///
  /// In de, this message translates to:
  /// **'min.'**
  String get postedMinutesAgo;

  /// No description provided for @postedHoursAgo.
  ///
  /// In de, this message translates to:
  /// **'Std.'**
  String get postedHoursAgo;

  /// No description provided for @postedItemRemoved.
  ///
  /// In de, this message translates to:
  /// **'Element erfolgreich entfernt'**
  String get postedItemRemoved;

  /// No description provided for @postedItemRemovedError.
  ///
  /// In de, this message translates to:
  /// **'Element konnte nicht entfernt werden'**
  String get postedItemRemovedError;

  /// No description provided for @predefinedActivityType_CAR_WALKING.
  ///
  /// In de, this message translates to:
  /// **'Auto & Gehen'**
  String get predefinedActivityType_CAR_WALKING;

  /// No description provided for @predefinedActivityType_CYCLING.
  ///
  /// In de, this message translates to:
  /// **'Radfahren'**
  String get predefinedActivityType_CYCLING;

  /// No description provided for @predefinedActivityType_E_BIKING.
  ///
  /// In de, this message translates to:
  /// **'E-Bike'**
  String get predefinedActivityType_E_BIKING;

  /// No description provided for @predefinedActivityType_FAST_WALKING.
  ///
  /// In de, this message translates to:
  /// **'Schnelles Gehen'**
  String get predefinedActivityType_FAST_WALKING;

  /// No description provided for @predefinedActivityType_HIKING.
  ///
  /// In de, this message translates to:
  /// **'Wandern'**
  String get predefinedActivityType_HIKING;

  /// No description provided for @predefinedActivityType_NORDIC_WALKING.
  ///
  /// In de, this message translates to:
  /// **'Nordic Walking'**
  String get predefinedActivityType_NORDIC_WALKING;

  /// No description provided for @predefinedActivityType_OTHER.
  ///
  /// In de, this message translates to:
  /// **'Sonstige'**
  String get predefinedActivityType_OTHER;

  /// No description provided for @predefinedActivityType_PUBLIC_TRANSPORT_WALKING.
  ///
  /// In de, this message translates to:
  /// **'Öffi & Gehen'**
  String get predefinedActivityType_PUBLIC_TRANSPORT_WALKING;

  /// No description provided for @predefinedActivityType_RUNNING.
  ///
  /// In de, this message translates to:
  /// **'Laufen'**
  String get predefinedActivityType_RUNNING;

  /// No description provided for @predefinedActivityType_STRENGTH_TRAINING.
  ///
  /// In de, this message translates to:
  /// **'Krafttraining'**
  String get predefinedActivityType_STRENGTH_TRAINING;

  /// No description provided for @predefinedActivityType_SWIMMING.
  ///
  /// In de, this message translates to:
  /// **'Schwimmen'**
  String get predefinedActivityType_SWIMMING;

  /// No description provided for @predefinedActivityType_WALKING.
  ///
  /// In de, this message translates to:
  /// **'Gehen'**
  String get predefinedActivityType_WALKING;

  /// No description provided for @prehab2RehabFocus.
  ///
  /// In de, this message translates to:
  /// **'Prehab2Rehab-Fokus'**
  String get prehab2RehabFocus;

  /// No description provided for @privacySettings.
  ///
  /// In de, this message translates to:
  /// **'Privatsphäre-Einstellungen'**
  String get privacySettings;

  /// No description provided for @qrCodeDescription.
  ///
  /// In de, this message translates to:
  /// **'Dein QR-Code ist privat. Wenn du ihn mit jemanden teilst, kann diese Person ihn über die aktivplan+ App scannen, um dich als Kontakt hinzuzufügen.'**
  String get qrCodeDescription;

  /// No description provided for @qrCodeUnsupported.
  ///
  /// In de, this message translates to:
  /// **'Scanne den QR-Code mit der <b>aktiv</b>plan+ App, um einen Kontakt hinzuzufügen. Lade dazu die <b>aktiv</b>plan+ App auf Dein Handy oder Tablet herunter:'**
  String get qrCodeUnsupported;

  /// No description provided for @rating.
  ///
  /// In de, this message translates to:
  /// **'Anstrengung'**
  String get rating;

  /// No description provided for @ratingQuestion.
  ///
  /// In de, this message translates to:
  /// **'Wie anstrengend war diese Aktivität für dich?'**
  String get ratingQuestion;

  /// No description provided for @ratingValue_0_1.
  ///
  /// In de, this message translates to:
  /// **'sehr leicht'**
  String get ratingValue_0_1;

  /// No description provided for @ratingValue_2_3.
  ///
  /// In de, this message translates to:
  /// **'leicht'**
  String get ratingValue_2_3;

  /// No description provided for @ratingValue_4_5.
  ///
  /// In de, this message translates to:
  /// **'mäßig'**
  String get ratingValue_4_5;

  /// No description provided for @ratingValue_6_7.
  ///
  /// In de, this message translates to:
  /// **'etwas anstrengend'**
  String get ratingValue_6_7;

  /// No description provided for @ratingValue_8_9.
  ///
  /// In de, this message translates to:
  /// **'anstrengend'**
  String get ratingValue_8_9;

  /// No description provided for @ratingValue_10.
  ///
  /// In de, this message translates to:
  /// **'sehr anstrengend'**
  String get ratingValue_10;

  /// No description provided for @recipient.
  ///
  /// In de, this message translates to:
  /// **'Empfänger*in'**
  String get recipient;

  /// No description provided for @recipients.
  ///
  /// In de, this message translates to:
  /// **'Empfänger*innen'**
  String get recipients;

  /// No description provided for @recordedDuration.
  ///
  /// In de, this message translates to:
  /// **'Erfasster Zeitraum'**
  String get recordedDuration;

  /// No description provided for @register.
  ///
  /// In de, this message translates to:
  /// **'Erfassen'**
  String get register;

  /// No description provided for @reminderActivity.
  ///
  /// In de, this message translates to:
  /// **'Erinnerung Aktivität'**
  String get reminderActivity;

  /// No description provided for @removeContact.
  ///
  /// In de, this message translates to:
  /// **'Kontakt entfernen'**
  String get removeContact;

  /// No description provided for @removeContactText.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du den Kontakt {name} entfernen möchtest?'**
  String removeContactText(String name);

  /// No description provided for @removedContact.
  ///
  /// In de, this message translates to:
  /// **'Kontakt erfolgreich entfernt'**
  String get removedContact;

  /// No description provided for @removedContactError.
  ///
  /// In de, this message translates to:
  /// **'Kontakt konnte nicht entfernt werden'**
  String get removedContactError;

  /// No description provided for @removeStoryItemConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'Element entfernen'**
  String get removeStoryItemConfirmTitle;

  /// No description provided for @removeStoryItemConfirmText.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du dieses Element aus deiner Story entfernen möchtest?'**
  String get removeStoryItemConfirmText;

  /// No description provided for @repeat.
  ///
  /// In de, this message translates to:
  /// **'Wiederholen'**
  String get repeat;

  /// No description provided for @repeatOrDurationSets.
  ///
  /// In de, this message translates to:
  /// **'Wh. oder Dauer / Sätze'**
  String get repeatOrDurationSets;

  /// No description provided for @repeatShort.
  ///
  /// In de, this message translates to:
  /// **'Wh.'**
  String get repeatShort;

  /// No description provided for @requestChange.
  ///
  /// In de, this message translates to:
  /// **'Änderung anfragen'**
  String get requestChange;

  /// No description provided for @requestedChange.
  ///
  /// In de, this message translates to:
  /// **'Änderung erfolgreich angefragt'**
  String get requestedChange;

  /// No description provided for @requestChanges.
  ///
  /// In de, this message translates to:
  /// **'Änderungen anfragen'**
  String get requestChanges;

  /// No description provided for @requestProfileDeletion.
  ///
  /// In de, this message translates to:
  /// **'Profil-Löschung anfragen'**
  String get requestProfileDeletion;

  /// No description provided for @requestProfileDeletionButton.
  ///
  /// In de, this message translates to:
  /// **'Löschung anfragen'**
  String get requestProfileDeletionButton;

  /// No description provided for @requestProfileDeletionText.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du dein Profil endgültig löschen willst? Wenn deine Anfrage akzeptiert wird, wird dein Profil und alle in aktivplan gespeicherten Daten unverzüglich gelöscht. Aktivplan ist damit nicht mehr nutzbar.'**
  String get requestProfileDeletionText;

  /// No description provided for @requestedProfileDeletion.
  ///
  /// In de, this message translates to:
  /// **'Anfrage erfolgreich an {name} übermittelt'**
  String requestedProfileDeletion(String name);

  /// No description provided for @required.
  ///
  /// In de, this message translates to:
  /// **'erforderlich'**
  String get required;

  /// No description provided for @resetPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort zurücksetzen'**
  String get resetPassword;

  /// No description provided for @resetPasswordActivated.
  ///
  /// In de, this message translates to:
  /// **'Dein Account wurde erfolgreich aktiviert.\nUm mit Deinem persönlichen <b>aktiv</b>plan zu starten, lade die <b>aktiv</b>plan+ App auf Dein Handy oder Tablet herunter:'**
  String get resetPasswordActivated;

  /// No description provided for @resetPasswordEnterPassword.
  ///
  /// In de, this message translates to:
  /// **'Bitte gib ein neues Passwort für Deinen <b>aktiv</b>plan Account ein.'**
  String get resetPasswordEnterPassword;

  /// No description provided for @resetPasswordFeedbackText.
  ///
  /// In de, this message translates to:
  /// **'Du hast Post! Folge der Anleitung in der E-Mail, um Dein Passwort zurückzusetzen. E-Mail wurde an {email} versendet.'**
  String resetPasswordFeedbackText(String email);

  /// No description provided for @resetPasswordLinkToWebpage.
  ///
  /// In de, this message translates to:
  /// **'Alternativ kann <b>aktiv</b>plan auch über den Webbrowser genutzt werden: <a>Auf der Website einloggen.</a>'**
  String get resetPasswordLinkToWebpage;

  /// No description provided for @resetPasswordRegister.
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get resetPasswordRegister;

  /// No description provided for @resetPasswordSet.
  ///
  /// In de, this message translates to:
  /// **'Dein Passwort wurde erfolgreich aktualisiert.\nUm mit Deinem persönlichen <b>aktiv</b>plan zu starten, lade die <b>aktiv</b>plan+ App auf Dein Handy oder Tablet herunter:'**
  String get resetPasswordSet;

  /// No description provided for @resetPasswordText.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse eingeben mit der das aktivplan-Konto verknüpft ist. Wir senden einen Link an diese Adresse um das Passwort zurückzusetzen.'**
  String get resetPasswordText;

  /// No description provided for @resetPasswordTokenExpired.
  ///
  /// In de, this message translates to:
  /// **'Ups, da ist etwas schiefgelaufen. Dieser Aktivierungslink ist ungültig.\n\nWenn Du Dein Konto bereits aktiviert hast, folge <a>diesem Link</a>, um Dich anzumelden. Wenn Du Dein Konto nicht innerhalb von 10 Tagen nach Erhalt der Einladungs-E-Mail aktiviert hast, ist dieser Link abgelaufen und Dein Konto wurde gelöscht. Um ein neues Konto zu beantragen, wende Dich bitte an Deine zuständigen Gesundheitsexperten.\n\nSolltest Du irgendwelche Fragen oder Bedenken haben, kontaktiere uns bitte unter <mail target=\'aktivplan@dhp.lbg.ac.at\'>aktivplan@dhp.lbg.ac.at</mail>'**
  String get resetPasswordTokenExpired;

  /// No description provided for @resetPasswordTokenInvalid.
  ///
  /// In de, this message translates to:
  /// **'Ups, da ist etwas schiefgelaufen. Dieser Link ist ungültig.\n\nLinks zum Zurücksetzen des Passworts sind nur einmal gültig und verfallen, sobald ein neuer Link angefordert wird. Wenn Du bereits einen neuen Link angefordert hast, kannst Du diesen verwenden, um Dein Passwort zurückzusetzen. Ansonsten kannst du <a>hier</a> einen neuen Link anfordern, um dein Passwort zurückzusetzen.\n\nSolltest Du irgendwelche Fragen oder Bedenken haben, kontaktiere uns bitte unter <mail target=\'aktivplan@dhp.lbg.ac.at\'>aktivplan@dhp.lbg.ac.at</mail>'**
  String get resetPasswordTokenInvalid;

  /// No description provided for @resetPasswordWelcome.
  ///
  /// In de, this message translates to:
  /// **'Willkommen {name}!\nRegistriere Dich, um Deinen <b>aktiv</b>plan Account zu aktivieren.'**
  String resetPasswordWelcome(String name);

  /// No description provided for @responsibleHealthExpert.
  ///
  /// In de, this message translates to:
  /// **'Zuständige*r Gesundheitsexpert*in'**
  String get responsibleHealthExpert;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @saveAndSend.
  ///
  /// In de, this message translates to:
  /// **'Speichern und senden'**
  String get saveAndSend;

  /// No description provided for @saveAndSendLater.
  ///
  /// In de, this message translates to:
  /// **'Speichern und später versenden'**
  String get saveAndSendLater;

  /// No description provided for @saveAndUpdate.
  ///
  /// In de, this message translates to:
  /// **'Speichern und aktualisieren'**
  String get saveAndUpdate;

  /// No description provided for @scanCode.
  ///
  /// In de, this message translates to:
  /// **'Code scannen'**
  String get scanCode;

  /// No description provided for @scanCodeDescription.
  ///
  /// In de, this message translates to:
  /// **'Scanne den QR-Code eines Kontakts, um ihn hinzuzufügen.'**
  String get scanCodeDescription;

  /// No description provided for @scheduledMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht erfolgreich gespeichert'**
  String get scheduledMessage;

  /// No description provided for @select.
  ///
  /// In de, this message translates to:
  /// **'Auswählen'**
  String get select;

  /// No description provided for @selectAll.
  ///
  /// In de, this message translates to:
  /// **'Alle auswählen'**
  String get selectAll;

  /// No description provided for @selectLocationFromMap.
  ///
  /// In de, this message translates to:
  /// **'Standort aus Karte auswählen'**
  String get selectLocationFromMap;

  /// No description provided for @send.
  ///
  /// In de, this message translates to:
  /// **'Senden'**
  String get send;

  /// No description provided for @sendDate.
  ///
  /// In de, this message translates to:
  /// **'Sendedatum'**
  String get sendDate;

  /// No description provided for @sendInvitationMailAgain.
  ///
  /// In de, this message translates to:
  /// **'Einladungsmail'**
  String get sendInvitationMailAgain;

  /// No description provided for @sendLater.
  ///
  /// In de, this message translates to:
  /// **'Später senden'**
  String get sendLater;

  /// No description provided for @sendLink.
  ///
  /// In de, this message translates to:
  /// **'Link senden'**
  String get sendLink;

  /// No description provided for @sendMessageHint.
  ///
  /// In de, this message translates to:
  /// **'Nachrichten werden über die aktivplan-App übermittelt. Der/die Empfänger*in hat keine Möglichkeit, darauf zu reagieren.\nDaher ist es notwendig, Kontaktdaten in der Nachricht zu vermerken, sofern eine Kontaktaufnahme gewünscht wird.'**
  String get sendMessageHint;

  /// No description provided for @sendMessageTo.
  ///
  /// In de, this message translates to:
  /// **'Nachricht an {name}'**
  String sendMessageTo(String name);

  /// No description provided for @sendMessageToAllHint.
  ///
  /// In de, this message translates to:
  /// **'Geplante Nachricht wird auch an zukünftig erstellte Nutzer*innen verschickt'**
  String get sendMessageToAllHint;

  /// No description provided for @sendTime.
  ///
  /// In de, this message translates to:
  /// **'Sendezeitpunkt'**
  String get sendTime;

  /// No description provided for @sent.
  ///
  /// In de, this message translates to:
  /// **'Gesendet'**
  String get sent;

  /// No description provided for @sentMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht erfolgreich gesendet'**
  String get sentMessage;

  /// No description provided for @sentMessageError.
  ///
  /// In de, this message translates to:
  /// **'Nachricht konnte nicht gesendet werden'**
  String get sentMessageError;

  /// No description provided for @set.
  ///
  /// In de, this message translates to:
  /// **'Satz'**
  String get set;

  /// No description provided for @sets.
  ///
  /// In de, this message translates to:
  /// **'Sätze'**
  String get sets;

  /// No description provided for @share.
  ///
  /// In de, this message translates to:
  /// **'teilen'**
  String get share;

  /// No description provided for @shareActivityData.
  ///
  /// In de, this message translates to:
  /// **'Meine Aktivitätsdaten mit meinen Kontakten teilen'**
  String get shareActivityData;

  /// No description provided for @signature.
  ///
  /// In de, this message translates to:
  /// **'Unterschrift'**
  String get signature;

  /// No description provided for @skip.
  ///
  /// In de, this message translates to:
  /// **'Überspringen'**
  String get skip;

  /// No description provided for @start.
  ///
  /// In de, this message translates to:
  /// **'Starten'**
  String get start;

  /// No description provided for @startDate.
  ///
  /// In de, this message translates to:
  /// **'Startdatum'**
  String get startDate;

  /// No description provided for @startLocation.
  ///
  /// In de, this message translates to:
  /// **'Startort'**
  String get startLocation;

  /// No description provided for @startTime.
  ///
  /// In de, this message translates to:
  /// **'Startzeit'**
  String get startTime;

  /// No description provided for @startTour.
  ///
  /// In de, this message translates to:
  /// **'Rundgang starten'**
  String get startTour;

  /// No description provided for @startTourAgain.
  ///
  /// In de, this message translates to:
  /// **'Rundgang erneut starten'**
  String get startTourAgain;

  /// No description provided for @state.
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get state;

  /// No description provided for @statusMessage.
  ///
  /// In de, this message translates to:
  /// **'Statusmeldung (nur für Kontakte sichtbar)'**
  String get statusMessage;

  /// No description provided for @subject.
  ///
  /// In de, this message translates to:
  /// **'Betreff'**
  String get subject;

  /// No description provided for @surgeryDate.
  ///
  /// In de, this message translates to:
  /// **'OP-Datum'**
  String get surgeryDate;

  /// No description provided for @surgeryTime.
  ///
  /// In de, this message translates to:
  /// **'OP-Zeit'**
  String get surgeryTime;

  /// No description provided for @switchLanguage.
  ///
  /// In de, this message translates to:
  /// **'Sprache zu Englisch ändern'**
  String get switchLanguage;

  /// No description provided for @taskNotes.
  ///
  /// In de, this message translates to:
  /// **'Notizen zur Aufgabe'**
  String get taskNotes;

  /// No description provided for @till.
  ///
  /// In de, this message translates to:
  /// **'bis'**
  String get till;

  /// No description provided for @time.
  ///
  /// In de, this message translates to:
  /// **'Zeit'**
  String get time;

  /// No description provided for @tipsAndInfos.
  ///
  /// In de, this message translates to:
  /// **'Tipps & Infos'**
  String get tipsAndInfos;

  /// No description provided for @title.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get title;

  /// No description provided for @titleEnglish.
  ///
  /// In de, this message translates to:
  /// **'Titel (englische Übersetzung)'**
  String get titleEnglish;

  /// No description provided for @themeVideo.
  ///
  /// In de, this message translates to:
  /// **'Themenvideo'**
  String get themeVideo;

  /// No description provided for @themeVideos.
  ///
  /// In de, this message translates to:
  /// **'Themenvideos'**
  String get themeVideos;

  /// No description provided for @thisWeek.
  ///
  /// In de, this message translates to:
  /// **'Diese Woche'**
  String get thisWeek;

  /// No description provided for @today.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In de, this message translates to:
  /// **'Morgen'**
  String get tomorrow;

  /// No description provided for @total.
  ///
  /// In de, this message translates to:
  /// **'Gesamt'**
  String get total;

  /// No description provided for @training.
  ///
  /// In de, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @trainingDescription.
  ///
  /// In de, this message translates to:
  /// **'Trainingsbeschreibung'**
  String get trainingDescription;

  /// No description provided for @trainingDuration.
  ///
  /// In de, this message translates to:
  /// **'Trainingsdauer'**
  String get trainingDuration;

  /// No description provided for @trainingFrequency.
  ///
  /// In de, this message translates to:
  /// **'Trainingshäufigkeit'**
  String get trainingFrequency;

  /// No description provided for @trainingHeartFrequency.
  ///
  /// In de, this message translates to:
  /// **'Trainingsherzfrequenz'**
  String get trainingHeartFrequency;

  /// No description provided for @trainingHeartFrequencyBpm.
  ///
  /// In de, this message translates to:
  /// **'Trainingsherzfrequenz (bpm)'**
  String get trainingHeartFrequencyBpm;

  /// No description provided for @trainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Trainingsplan'**
  String get trainingPlan;

  /// No description provided for @trainingPlanCopyOf.
  ///
  /// In de, this message translates to:
  /// **'{name} Kopie'**
  String trainingPlanCopyOf(String name);

  /// No description provided for @trainingState.
  ///
  /// In de, this message translates to:
  /// **'Trainingsstatus (nur für Gesundheitsexpert*in sichtbar)'**
  String get trainingState;

  /// No description provided for @trainingType.
  ///
  /// In de, this message translates to:
  /// **'Trainingsart'**
  String get trainingType;

  /// No description provided for @trainingValue_0.
  ///
  /// In de, this message translates to:
  /// **'Kein Training'**
  String get trainingValue_0;

  /// No description provided for @trainingValue_1_3.
  ///
  /// In de, this message translates to:
  /// **'Gelegentliches Training, leichtes Training'**
  String get trainingValue_1_3;

  /// No description provided for @trainingValue_4_7.
  ///
  /// In de, this message translates to:
  /// **'Regelmäßiges Training'**
  String get trainingValue_4_7;

  /// No description provided for @trainingValue_8_10.
  ///
  /// In de, this message translates to:
  /// **'Tägliches Training'**
  String get trainingValue_8_10;

  /// No description provided for @tryAgain.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get tryAgain;

  /// No description provided for @tryAgainLater.
  ///
  /// In de, this message translates to:
  /// **'Versuchen Sie es später nochmal.'**
  String get tryAgainLater;

  /// No description provided for @undoExecution.
  ///
  /// In de, this message translates to:
  /// **'Ausführung rückgängig machen'**
  String get undoExecution;

  /// No description provided for @undoMove.
  ///
  /// In de, this message translates to:
  /// **'Verschieben rückgängig machen'**
  String get undoMove;

  /// No description provided for @undoRatingText.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du die Ausführung dieser Aktivität rückgängig machen willst? Die Daten zur Ausführung gehen dabei verloren.'**
  String get undoRatingText;

  /// No description provided for @update.
  ///
  /// In de, this message translates to:
  /// **'Aktualisieren'**
  String get update;

  /// No description provided for @updatedApp.
  ///
  /// In de, this message translates to:
  /// **'App aktualisiert'**
  String get updatedApp;

  /// No description provided for @updatedExercise_ENDURANCE.
  ///
  /// In de, this message translates to:
  /// **'Ausdauertraining aktualisiert'**
  String get updatedExercise_ENDURANCE;

  /// No description provided for @updatedExercise_HYPERTROPHY.
  ///
  /// In de, this message translates to:
  /// **'Hypertrophietraining aktualisiert'**
  String get updatedExercise_HYPERTROPHY;

  /// No description provided for @updatedExercise_INTERVAL.
  ///
  /// In de, this message translates to:
  /// **'Intervall Ausdauertraining aktualisiert'**
  String get updatedExercise_INTERVAL;

  /// No description provided for @updatedExercise_OTHER.
  ///
  /// In de, this message translates to:
  /// **'Übung aktualisiert'**
  String get updatedExercise_OTHER;

  /// No description provided for @updatedExercise_STRENGTHENING.
  ///
  /// In de, this message translates to:
  /// **'Kraftausdauertraining aktualisiert'**
  String get updatedExercise_STRENGTHENING;

  /// No description provided for @updatedExercise_TASK.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe aktualisiert'**
  String get updatedExercise_TASK;

  /// No description provided for @updatedInstitution.
  ///
  /// In de, this message translates to:
  /// **'Institut aktualisiert'**
  String get updatedInstitution;

  /// No description provided for @updatedHealthcareProfessional.
  ///
  /// In de, this message translates to:
  /// **'Gesundheitsexpert*in aktualisiert'**
  String get updatedHealthcareProfessional;

  /// No description provided for @updatedMessage.
  ///
  /// In de, this message translates to:
  /// **'Nachricht aktualisiert'**
  String get updatedMessage;

  /// No description provided for @updatedPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort wurde erfolgreich aktualisiert'**
  String get updatedPassword;

  /// No description provided for @updatedPatient.
  ///
  /// In de, this message translates to:
  /// **'Nutzer*in aktualisiert'**
  String get updatedPatient;

  /// No description provided for @updatedTrainingPlan.
  ///
  /// In de, this message translates to:
  /// **'Trainingsplan aktualisiert'**
  String get updatedTrainingPlan;

  /// No description provided for @updatedVideo.
  ///
  /// In de, this message translates to:
  /// **'Video aktualisiert'**
  String get updatedVideo;

  /// No description provided for @updatedWorkout.
  ///
  /// In de, this message translates to:
  /// **'Workout aktualisiert'**
  String get updatedWorkout;

  /// No description provided for @uploadImage.
  ///
  /// In de, this message translates to:
  /// **'Bild hochladen'**
  String get uploadImage;

  /// No description provided for @uploadImageErrorTooBig.
  ///
  /// In de, this message translates to:
  /// **'Bild ist zu groß, maximale Dateigröße: 10 MB'**
  String get uploadImageErrorTooBig;

  /// No description provided for @uploadProfilePicture.
  ///
  /// In de, this message translates to:
  /// **'Profilbild hochladen'**
  String get uploadProfilePicture;

  /// No description provided for @uploadVideo.
  ///
  /// In de, this message translates to:
  /// **'Video hochladen'**
  String get uploadVideo;

  /// No description provided for @validationDefaultLength.
  ///
  /// In de, this message translates to:
  /// **'Eingabe muss zwischen 2 und 100 Zeichen lang sein.'**
  String get validationDefaultLength;

  /// No description provided for @validationDuplicateEmail.
  ///
  /// In de, this message translates to:
  /// **'Es existiert bereits ein Konto für diese E-Mail-Adresse.'**
  String get validationDuplicateEmail;

  /// No description provided for @validationEmail.
  ///
  /// In de, this message translates to:
  /// **'Bitte eine gültige E-Mail-Adresse eingeben.'**
  String get validationEmail;

  /// No description provided for @validationInvalidValue.
  ///
  /// In de, this message translates to:
  /// **'Ungültiger Wert. Bitte kontrollieren Sie Ihre Eingabe.'**
  String get validationInvalidValue;

  /// No description provided for @validationMoveDateWithinAWeek.
  ///
  /// In de, this message translates to:
  /// **'Geplante Aktivitäten können nur innerhalb einer Woche verschoben werden'**
  String get validationMoveDateWithinAWeek;

  /// No description provided for @validationNotEmpty.
  ///
  /// In de, this message translates to:
  /// **'Erfordert eine Eingabe'**
  String get validationNotEmpty;

  /// No description provided for @validationPasswordLength.
  ///
  /// In de, this message translates to:
  /// **'Eingabe muss mindestens 8 Zeichen lang sein.'**
  String get validationPasswordLength;

  /// No description provided for @validationPasswordsNotEqual.
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein.'**
  String get validationPasswordsNotEqual;

  /// No description provided for @validationWrongCredentials.
  ///
  /// In de, this message translates to:
  /// **'Anmeldedaten nicht korrekt.'**
  String get validationWrongCredentials;

  /// No description provided for @validationWrongPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort nicht korrekt.'**
  String get validationWrongPassword;

  /// No description provided for @video.
  ///
  /// In de, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @videoWaitBetweenExercisesSeconds.
  ///
  /// In de, this message translates to:
  /// **'Wartezeit zwischen Übungen (Sekunden)'**
  String get videoWaitBetweenExercisesSeconds;

  /// No description provided for @week.
  ///
  /// In de, this message translates to:
  /// **'Woche'**
  String get week;

  /// No description provided for @weeks.
  ///
  /// In de, this message translates to:
  /// **'Wochen'**
  String get weeks;

  /// No description provided for @weight.
  ///
  /// In de, this message translates to:
  /// **'Gewicht'**
  String get weight;

  /// No description provided for @weightKg.
  ///
  /// In de, this message translates to:
  /// **'Gewicht (kg)'**
  String get weightKg;

  /// No description provided for @wholeDay.
  ///
  /// In de, this message translates to:
  /// **'ganztägig'**
  String get wholeDay;

  /// No description provided for @workLocation.
  ///
  /// In de, this message translates to:
  /// **'Arbeitsort'**
  String get workLocation;

  /// No description provided for @workout.
  ///
  /// In de, this message translates to:
  /// **'Workout'**
  String get workout;

  /// No description provided for @workoutDurationHint.
  ///
  /// In de, this message translates to:
  /// **'Workout-Dauer errechnet sich automatisch aus der Summe der Dauer der Einzelübungen.'**
  String get workoutDurationHint;

  /// No description provided for @workouts.
  ///
  /// In de, this message translates to:
  /// **'Workouts'**
  String get workouts;

  /// No description provided for @importWorkout.
  ///
  /// In de, this message translates to:
  /// **'Workout importieren'**
  String get importWorkout;

  /// No description provided for @year.
  ///
  /// In de, this message translates to:
  /// **'Jahr'**
  String get year;

  /// No description provided for @yes.
  ///
  /// In de, this message translates to:
  /// **'Ja'**
  String get yes;

  /// No description provided for @yourWeeklyGoal.
  ///
  /// In de, this message translates to:
  /// **'Dein Wochenziel'**
  String get yourWeeklyGoal;

  /// No description provided for @youTubeUrl.
  ///
  /// In de, this message translates to:
  /// **'YouTube Link'**
  String get youTubeUrl;

  /// No description provided for @youTubeUrlEnglish.
  ///
  /// In de, this message translates to:
  /// **'YouTube Link (englische Übersetzung)'**
  String get youTubeUrlEnglish;

  /// No description provided for @morninig.
  ///
  /// In de, this message translates to:
  /// **'Morgen'**
  String get morninig;

  /// No description provided for @afternoon.
  ///
  /// In de, this message translates to:
  /// **'Nachmittag'**
  String get afternoon;

  /// No description provided for @evening.
  ///
  /// In de, this message translates to:
  /// **'Abend'**
  String get evening;

  /// No description provided for @liveHealthData.
  ///
  /// In de, this message translates to:
  /// **'Live-Gesundheitsdaten'**
  String get liveHealthData;

  /// No description provided for @connectToGoogleHealthConnect.
  ///
  /// In de, this message translates to:
  /// **'Verbinden Sie sich mit Google Health Connect'**
  String get connectToGoogleHealthConnect;

  /// No description provided for @disconnectFromGoogleHealthConnect.
  ///
  /// In de, this message translates to:
  /// **'Sie sind mit Google Health Connect verbunden'**
  String get disconnectFromGoogleHealthConnect;

  /// No description provided for @connectToAppleHealth.
  ///
  /// In de, this message translates to:
  /// **'Verbinden Sie sich mit Apple Health'**
  String get connectToAppleHealth;

  /// No description provided for @disconnectFromAppleHealth.
  ///
  /// In de, this message translates to:
  /// **'Sie sind mit Apple Health verbunden'**
  String get disconnectFromAppleHealth;

  /// No description provided for @permissionRquest.
  ///
  /// In de, this message translates to:
  /// **'Um Aktivitätsdaten von Google Health Connect/Apple Health abzurufen, gehen Sie bitte zu App-Info -> Berechtigungen und erteilen Sie die folgende(n) Berechtigung(en):'**
  String get permissionRquest;

  /// No description provided for @physicalActivity.
  ///
  /// In de, this message translates to:
  /// **'Physische Aktivität'**
  String get physicalActivity;

  /// No description provided for @walking.
  ///
  /// In de, this message translates to:
  /// **'Gehen'**
  String get walking;

  /// No description provided for @running.
  ///
  /// In de, this message translates to:
  /// **'Laufen'**
  String get running;

  /// No description provided for @running_Treadmill.
  ///
  /// In de, this message translates to:
  /// **'Laufen auf dem Laufband'**
  String get running_Treadmill;

  /// No description provided for @walking_Treadmill.
  ///
  /// In de, this message translates to:
  /// **'Gehen auf dem Laufband'**
  String get walking_Treadmill;

  /// No description provided for @hiking.
  ///
  /// In de, this message translates to:
  /// **'Wandern'**
  String get hiking;

  /// No description provided for @biking.
  ///
  /// In de, this message translates to:
  /// **'Radfahren'**
  String get biking;

  /// No description provided for @swimmming.
  ///
  /// In de, this message translates to:
  /// **'Schwimmen'**
  String get swimmming;

  /// No description provided for @connect.
  ///
  /// In de, this message translates to:
  /// **'Verbinden'**
  String get connect;

  /// No description provided for @connectToDevice.
  ///
  /// In de, this message translates to:
  /// **'Ein Gerät verbinden'**
  String get connectToDevice;

  /// No description provided for @connectToDeviceDescription.
  ///
  /// In de, this message translates to:
  /// **'Finden Sie Ihr Gerät und verbinden Sie es mit aktivplan'**
  String get connectToDeviceDescription;

  /// No description provided for @viewPossibleDevices.
  ///
  /// In de, this message translates to:
  /// **'Mögliche geräte ansehen'**
  String get viewPossibleDevices;

  /// No description provided for @connectPolarDevice.
  ///
  /// In de, this message translates to:
  /// **'Polar Gerät verbinden'**
  String get connectPolarDevice;

  /// No description provided for @polarVeritySenseTitle.
  ///
  /// In de, this message translates to:
  /// **'Polar Verity Sense'**
  String get polarVeritySenseTitle;

  /// No description provided for @polarVeritySenseDescription.
  ///
  /// In de, this message translates to:
  /// **'Schließen Sie Ihr Polar Gerät an und sehen Sie sich Ihre Daten hier an'**
  String get polarVeritySenseDescription;

  /// No description provided for @interruptingDevice.
  ///
  /// In de, this message translates to:
  /// **'Gerät trennen'**
  String get interruptingDevice;

  /// No description provided for @connecting.
  ///
  /// In de, this message translates to:
  /// **'Verbinden'**
  String get connecting;

  /// No description provided for @searchingForDevices.
  ///
  /// In de, this message translates to:
  /// **'Suche nach Geräten'**
  String get searchingForDevices;

  /// No description provided for @connectedDevice.
  ///
  /// In de, this message translates to:
  /// **'Sie sind verbunden mit'**
  String get connectedDevice;

  /// No description provided for @batteryLevel.
  ///
  /// In de, this message translates to:
  /// **'Batteriestand'**
  String get batteryLevel;

  /// No description provided for @bluetoothTurnOnTitle.
  ///
  /// In de, this message translates to:
  /// **'Bluetooth einschalten'**
  String get bluetoothTurnOnTitle;

  /// No description provided for @bluetoothTurnOnText.
  ///
  /// In de, this message translates to:
  /// **'Bitte schalten Sie Bluetooth ein, um eine Verbindung zu Ihrem Gerät herzustellen.'**
  String get bluetoothTurnOnText;

  /// No description provided for @bluetoothPermissionTitle.
  ///
  /// In de, this message translates to:
  /// **'Bluetooth-Erlaubnis'**
  String get bluetoothPermissionTitle;

  /// No description provided for @bluetoothPermissionText.
  ///
  /// In de, this message translates to:
  /// **'Bitte erlauben Sie der App, sich über Bluetooth mit Ihrem Gerät zu verbinden.'**
  String get bluetoothPermissionText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
