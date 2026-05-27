import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/apt_beam_page.dart';
import 'package:aptapp/exercises/exercises_overview_page.dart';
import 'package:aptapp/exercises/modify_exercise.dart';
import 'package:aptapp/exercises/training_plan/modify_training_plan_page.dart';
import 'package:aptapp/exercises/workout/modify_workout_page.dart';
import 'package:aptapp/external_app/external_apps_overview_page.dart';
import 'package:aptapp/external_app/modify_external_app_page.dart';
import 'package:aptapp/health_professionals/modify_health_professional_page.dart';
import 'package:aptapp/institution/insitution_healthprofessionals_page.dart';
import 'package:aptapp/message/message_history_page.dart';
import 'package:aptapp/message/message_overview_page.dart';
import 'package:aptapp/message/modify_message_page.dart';
import 'package:aptapp/patient/modify_patient_page.dart';
import 'package:aptapp/patient/patient_overview_page.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/video/modify_video_template_page.dart';
import 'package:aptapp/video/video_templates_overview_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../institution/modify_institution_page.dart';

final userRepository = KiwiContainer().resolve<UserRepository>();

extension on BeamState {
  String get uriBlueprintAsString => this.uriBlueprint.toString();
}

class HealthcareProfessionalsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/professionals',
        '/professionals/add',
        '/professionals/:id/edit',
        '/professionals/:id/patients',
        '/professionals/:id/patients/add',
        '/professionals/:id/patients/:patientId/edit',
        '/institutions/:id/edit',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      if (state.uriBlueprintAsString == '/professionals')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: BlocProvider.value(
            value: BlocProvider.of<UserBloc>(context)
              ..add(FetchHealthcareProfessionalsEvent(institutionId: stateData['institutionId'] ?? userRepository.currentUser.institutionId)),
            child: InstitutionHealthcareProfessionalsPage(institutionId: stateData['institutionId'] ?? userRepository.currentUser.institutionId),
          ),
        ),
      if (state.uriBlueprintAsString == '/professionals/add')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyHealthProfessionalPage(
            edit: false,
          ),
        ),
      if (state.uriBlueprintAsString == '/professionals/:id/edit')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyHealthProfessionalPage(
            edit: true,
            user: stateData['user'],
            userId: state.pathParameters['id']!,
          ),
        ),
      if (state.uriBlueprint.toString() == '/professionals/:id/patients')
        AptBeamPage(
          context: context,
          key: ValueKey('professionals-${state.pathParameters['id']}-patients'),
          child: BlocProvider.value(
            value: BlocProvider.of<UserBloc>(context)..add(FetchPatientsEvent(healthcareProfessionalId: state.pathParameters['id']!)),
            child: PatientOverviewPage(
              healthcareProfessionalId: state.pathParameters['id']!,
            ),
          ),
        ),
      if (state.uriBlueprint.toString() == '/professionals/:id/patients/add')
        AptBeamPage(
          context: context,
          key: ValueKey('professionals-${state.pathParameters['id']}-addPatient'),
          child: ModifyPatientPage(
            edit: false,
            healthcareProfessionalId: state.pathParameters['id']!,
          ),
        ),
      if (state.uriBlueprint.toString() == '/professionals/:id/patients/:patientId/edit')
        AptBeamPage(
          context: context,
          key: ValueKey('professionals-${state.pathParameters['patientId']}-edit'),
          child: ModifyPatientPage(
            edit: true,
            healthcareProfessionalId: state.pathParameters['id']!,
            patient: stateData['patient'],
            userId: state.pathParameters['patientId']!,
          ),
        ),
      if (state.uriBlueprintAsString == '/institutions/:id/edit')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyInstitutionPage(
            edit: true,
            institution: stateData['institution'],
            institutionId: state.pathParameters['id']!,
          ),
        ),
    ];
  }
}

class TrainingsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns =>
      ['/training', '/training/:trainingType', '/training/:trainingType/add', '/training/:trainingType/:id/edit', '/training/plan/:id/copy'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      if (state.uriBlueprint.toString() == "/training" || state.uriBlueprint.toString() == "/training/:trainingType")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ExerciseOverviewPage(pathType: state.pathParameters['trainingType'] ?? ''),
        ),
      if (state.uriBlueprint.toString() == "/training/:trainingType/add")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: state.pathParameters['trainingType'] == 'plan'
              ? ModifyTrainingPlanPage()
              : ModifyExercisePage(
                  exerciseType: stateData['exerciseType'],
                  exerciseTypeString: state.pathParameters['trainingType']!,
                  edit: false,
                ),
        ),
      if (state.uriBlueprint.toString() == "/training/:trainingType/:id/edit")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: state.pathParameters['trainingType'] == 'plan'
              ? ModifyTrainingPlanPage(trainingPlanId: state.pathParameters['id']!)
              : ModifyExercisePage(
                  exercise: stateData['exercise'],
                  exerciseType: stateData['exerciseType'],
                  exerciseId: state.pathParameters['id']!,
                  exerciseTypeString: state.pathParameters['trainingType']!,
                  edit: true,
                ),
        ),
      if (state.uriBlueprint.toString() == "/training/plan/:id/copy")
        AptBeamPage(
            context: context,
            key: ValueKey(state.uri.toString()),
            child: ModifyTrainingPlanPage(
              trainingPlanId: state.pathParameters['id']!,
              copyExisitingPlan: true,
            )),
    ];
  }
}

class WorkoutAddLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/workout/add'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        AptBeamPage(
          context: context,
          key: ValueKey('workout-add'),
          child: ModifyWorkoutPage(
            edit: false,
            workout: new Workout(exercises: []),
          ),
        ),
      ];
}

class WorkoutEditLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/workout/edit'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('workout-edit'),
        child: ModifyWorkoutPage(
          edit: true,
          workout: stateData['workout'] ?? new Workout(exercises: []),
        ),
      ),
    ];
  }
}

class MessagesLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ["/messages", "/messages/add", "/messages/:id", "/message-history"];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      if (state.uriBlueprint.toString() == "/messages")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: MessageOverviewPage(),
        ),
      if (state.uriBlueprint.toString() == "/messages/add")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyMessagePage(),
        ),
      if (state.uriBlueprint.toString() == "/messages/:id")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyMessagePage(
            message: stateData['message'],
            messageId: state.pathParameters['id']!,
          ),
        ),
      if (state.uriBlueprint.toString() == "/message-history")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: MessageHistoryPage(),
        ),
    ];
  }
}

class VideosLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ["/video-templates", "/video-templates/add", "/video-templates/:id"];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      if (state.uriBlueprint.toString() == "/video-templates")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: VideoTemplatesOverviewPage(),
        ),
      if (state.uriBlueprint.toString() == "/video-templates/add")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyVideoTemplatePage(),
        ),
      if (state.uriBlueprint.toString() == "/video-templates/:id")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyVideoTemplatePage(
            template: stateData['template'],
            templateId: state.pathParameters['id']!,
          ),
        ),
    ];
  }
}

class ExternalAppsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ["/external-apps", "/external-apps/add", "/external-apps/:id"];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      if (state.uriBlueprint.toString() == "/external-apps")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ExternalAppsOverviewPage(),
        ),
      if (state.uriBlueprint.toString() == "/external-apps/add")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyExternalAppPage(),
        ),
      if (state.uriBlueprint.toString() == "/external-apps/:id")
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyExternalAppPage(
            externalApp: stateData['externalApp'],
            externalAppId: state.pathParameters['id']!,
          ),
        ),
    ];
  }
}

List<BeamLocation> institutsAdminLocations = [
  HealthcareProfessionalsLocation(),
  TrainingsLocation(),
  WorkoutAddLocation(),
  WorkoutEditLocation(),
  MessagesLocation(),
  VideosLocation(),
  ExternalAppsLocation(),
];
