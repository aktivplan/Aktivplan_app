import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/apt_beam_page.dart';
import 'package:aptapp/message/messages_page.dart';
import 'package:aptapp/patient/additional_apps_page.dart';
import 'package:aptapp/patient/export_documentation_page.dart';
import 'package:aptapp/patient/health_professional_profile_page.dart';
import 'package:aptapp/patient/modify_patient_page.dart';
import 'package:aptapp/patient/patient_calendar/goal_setting_page.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar_page.dart';
import 'package:aptapp/patient/patient_data.dart';
import 'package:aptapp/patient/training_videos_page.dart';
import 'package:aptapp/social/add_contact_page.dart';
import 'package:aptapp/social/add_story_message_page.dart';
import 'package:aptapp/social/add_story_pictures_page.dart';
import 'package:aptapp/social/contact_detail_page.dart';
import 'package:aptapp/social/contact_message_page.dart';
import 'package:aptapp/social/contacts_page.dart';
import 'package:aptapp/social/qr_scan_info.dart';
import 'package:aptapp/social/user_story_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

///
/// Patient
///
///
final userRepository = KiwiContainer().resolve<UserRepository>();

class PatientHomeLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/calendar',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patient-calendar'),
        child: userRepository.currentUser != null ? PatientCalendarPage(patientId: userRepository.currentUser.id) : Container(),
      ),
    ];
  }
}

class MessagesLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/personal-messages',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('patient-messages'),
        child: MessagesPage(),
      ),
    ];
  }
}

class ExportLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/export',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patient-export'),
        child: ExportDocumentationPage(id: stateData['id'] ?? userRepository.currentUser?.id, type: 'pdf'),
      ),
    ];
  }
}

class VideosLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/videos',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('patient-videos'),
        child: TrainingVideosPage(),
      ),
    ];
  }
}

class AdditionalAppsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/additional-apps',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('additional-apps'),
        child: AdditionalAppsPage(),
      ),
    ];
  }
}

class DataLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/calendar/data', '/calendar/data/edit'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      if (state.uri.toString() == "/calendar/data")
        AptBeamPage(
          context: context,
          useMobileBackgroundColor: true,
          key: ValueKey('patient-data'),
          child: PatientDataPage(
            patient: stateData['patient'] ?? userRepository.currentUser,
          ),
        ),
      if (state.uri.toString() == "/calendar/data/edit")
        AptBeamPage(
          context: context,
          key: ValueKey('patient- ${stateData['patient']}-edit'),
          child: ModifyPatientPage(
            edit: true,
            healthcareProfessionalId: stateData['healthcareProfessionalId'],
            patient: stateData['patient'],
          ),
        ),
    ];
  }
}

class ContactsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/contacts',
        '/contacts/add',
        '/contacts/add/:id',
        'contacts/:id',
        'contacts/:id/message',
        'contacts/story/:id',
        '/contacts/my-story/add-message',
        '/contacts/my-story/add-pictures'
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      if (state.uriBlueprint.toString() == "/contacts")
        AptBeamPage(context: context, useMobileBackgroundColor: true, key: ValueKey('patient-contacts'), child: ContactsPage()),
      if (state.uriBlueprint.toString() == "/contacts/:id")
        AptBeamPage(
            context: context,
            useMobileBackgroundColor: true,
            showBackButton: true,
            alternativeBackLocation: "/contacts",
            key: ValueKey('patient-contact-detail'),
            child: ContactDetailPage(
              userId: state.pathParameters['id']!,
            )),
      if (state.uriBlueprint.toString() == "/contacts/:id/message")
        AptBeamPage(
            context: context,
            showBackButton: true,
            alternativeBackLocation: "/contacts/${state.pathParameters['id']!}",
            key: ValueKey('patient-contact-message'),
            child: ContactMessagePage(
              userId: state.pathParameters['id']!,
            )),
      if (state.uriBlueprint.toString() == "/contacts/add")
        AptBeamPage(
            context: context,
            useMobileBackgroundColor: true,
            showBackButton: true,
            alternativeBackLocation: "/contacts",
            key: ValueKey('patient-add-contact'),
            child: AddContactPage()),
      if (state.uriBlueprint.toString() == "/contacts/add/:id")
        AptBeamPage(context: context, useMobileBackgroundColor: true, hideDrawer: true, key: ValueKey('qr-scan-info'), child: QrScanInfoPage()),
      if (state.uriBlueprint.toString().contains("/contacts/story/:id"))
        AptBeamPage(
            context: context,
            useMobileBackgroundColor: true,
            showBackButton: true,
            alternativeBackLocation: "/contacts",
            key: ValueKey('patient-contacts-story'),
            child: UserStoryPage(
              userId: state.pathParameters['id']!,
              fullName: state.queryParameters['fullName'] ?? '',
              profilePicture: state.queryParameters['profilePicture'],
            )),
      if (state.uri.toString() == "/contacts/my-story/add-message")
        AptBeamPage(
            context: context,
            useMobileBackgroundColor: true,
            showBackButton: true,
            alternativeBackLocation: "/contacts",
            key: ValueKey('patient-contacts-story-add-message'),
            child: AddStoryMessagePage()),
      if (state.uri.toString() == "/contacts/my-story/add-pictures")
        AptBeamPage(
            context: context,
            useMobileBackgroundColor: true,
            showBackButton: true,
            alternativeBackLocation: "/contacts",
            key: ValueKey('patient-contacts-story-add-pictures'),
            child: AddStoryPicturesPage()),
    ];
  }
}

class HealthcareProfessionalLocation extends BeamLocation<BeamState> {
  List<String> get pathPatterns => [
        '/my-healthcare-professional/:id',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('patient-healthcare-professional'),
          child: HealthProfessionalProfilePage(
            userId: state.pathParameters['id']!,
          ),
        ),
      ];
}

class GoalSettingLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/calendar/goal-setting'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        showBackButton: true,
        child: GoalSettingPage(
          editGoal: stateData['editGoal'],
          isPatient: true,
        ),
      ),
    ];
  }
}

List<BeamLocation> patientLocations = [
  PatientHomeLocation(),
  MessagesLocation(),
  VideosLocation(),
  AdditionalAppsLocation(),
  ExportLocation(),
  HealthcareProfessionalLocation(),
  DataLocation(),
  ContactsLocation(),
  GoalSettingLocation(),
];
