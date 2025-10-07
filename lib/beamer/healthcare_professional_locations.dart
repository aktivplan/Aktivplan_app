import 'package:aptapp/activity/create_activity_page.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/apt_beam_page.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/message_history_page.dart';
import 'package:aptapp/patient/conversation_guide/conversation_guide_page.dart';
import 'package:aptapp/patient/conversation_guide/final_check_page.dart';
import 'package:aptapp/patient/export_documentation_page.dart';
import 'package:aptapp/patient/modify_patient_page.dart';
import 'package:aptapp/patient/patient_calendar/goal_setting_page.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar_page.dart';
import 'package:aptapp/patient/patient_calendar/patient_notes_page.dart';
import 'package:aptapp/patient/patient_overview_page.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

///
/// Healthcare Professional
///
final userRepository = KiwiContainer().resolve<UserRepository>();

class PatientsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/patients',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};

    return [
      AptBeamPage(
        title: context.i18n.patientOverview,
        context: context,
        key: ValueKey('patients}'),
        child: BlocProvider.value(
          value: BlocProvider.of<UserBloc>(context)
            ..add(FetchPatientsEvent(healthcareProfessionalId: stateData['healthcareProfessionalId'] ?? userRepository.currentUser.id)),
          child: PatientOverviewPage(
            healthcareProfessionalId: stateData['healthcareProfessionalId'] ?? userRepository.currentUser.id,
          ),
        ),
      ),
    ];
  }
}

class PatientsAddLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/add'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        title: context.i18n.addPatient,
        context: context,
        key: ValueKey('patients-add'),
        child: ModifyPatientPage(
          edit: false,
        ),
      ),
    ];
  }
}

class PatientsEditLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/patients/edit/:id',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        title: context.i18n.editPatient,
        key: ValueKey('patients-${state.pathParameters['id']}-edit'),
        child: ModifyPatientPage(
          edit: true,
          patient: stateData['patient'],
          userId: state.pathParameters['id']!,
        ),
      ),
    ];
  }
}

class PatientsConversationGuideLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/conversation-guide'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-conversation-guide'),
        child: ConversationGuidePage(
          patientId: state.pathParameters['id']!,
          patientNotes: stateData['notes'],
          personalGoals: stateData['personalGoals'],
          institutionFocus: stateData['institutionFocus'],
        ),
      ),
    ];
  }
}

class PatientsFinalCheckLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/final-check'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-final-check'),
        child: FinalCheckPage(patientId: state.pathParameters['id']!),
      ),
    ];
  }
}

class PatientsSendMessageLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/message-history'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-message-history'),
        child: MessageHistoryPage(
          patientId: state.pathParameters['id']!,
          patientName: stateData['patientName'] ?? "",
        ),
      ),
    ];
  }
}

class PatientsMessageHistoryLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/message-history'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-message-history'),
        child: MessageHistoryPage(
          patientId: state.pathParameters['id']!,
          patientName: stateData['patientName'] ?? "",
        ),
      ),
    ];
  }
}

class PatientNotesLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/calendar/notes'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-calendar-notes'),
        child: PatientNotesPage(
          patientId: state.pathParameters['id']!,
          patientNotes: stateData['notes'],
        ),
      ),
    ];
  }
}

class PatientsExportLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/export/:type'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-export-${state.pathParameters['type']}'),
        child: ExportDocumentationPage(id: state.pathParameters['id']!, type: state.pathParameters['type']!),
      ),
    ];
  }
}

class PatientsCalendarLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/calendar'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      //...PatientsLocation().pagesBuilder(context),
      //if (data.isNotEmpty)
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-calendar'),
        child: PatientCalendarPage(
          patientId: state.pathParameters['id']!,
        ),
      ),
    ];
  }
}

class PatientsActivityLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/calendar/add-activity'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-add-activity'),
        child: CreateActivityPage(
          patient: stateData['patient'],
          chosenDate: stateData['chosenDate'] ?? DateTime.now(),
          editActivity: stateData['editActivity'],
          progressLevel: stateData['progressLevel'] ?? 0,
          activityId: stateData['activityId'],
          activityType: stateData['activityType'],
          isDuplication: stateData['isDuplication'] ?? false,
          doEditSingleActivity: stateData['doEditSingleActivity'] ?? false,
          onCancelled: () => context.beamToNamed('/patients/${state.pathParameters['id']}/calendar'),
        ),
      ),
    ];
  }
}

class PatientsGoalSettingLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/patients/:id/goal-setting', '/patients/:id/calendar/goal-setting'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('patients-${state.pathParameters['id']}-goal-setting'),
        child: GoalSettingPage(
          patientId: state.pathParameters['id']!,
          editGoal: stateData['editGoal'],
        ),
      ),
    ];
  }
}

List<BeamLocation> hcprofessionalLocations = [
  PatientsLocation(),
  PatientsAddLocation(),
  PatientsEditLocation(),
  PatientsCalendarLocation(),
  PatientsConversationGuideLocation(),
  PatientsFinalCheckLocation(),
  PatientsSendMessageLocation(),
  PatientsMessageHistoryLocation(),
  PatientNotesLocation(),
  PatientsExportLocation(),
  PatientsActivityLocation(),
  PatientsGoalSettingLocation(),
];
