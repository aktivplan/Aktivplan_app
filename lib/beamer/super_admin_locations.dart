// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/beamer/apt_beam_page.dart';
import 'package:aptapp/health_professionals/modify_health_professional_page.dart';
import 'package:aptapp/institution/bloc/institution_bloc.dart';
import 'package:aptapp/institution/insitution_healthprofessionals_page.dart';
import 'package:aptapp/institution/insitution_overview_page.dart';
import 'package:aptapp/institution/modify_institution_page.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/modify_patient_page.dart';
import 'package:aptapp/patient/patient_overview_page.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final superAdminLocations = [
  SuperAdminInstitutionLocations(),
];

extension on BeamState {
  String get uriBlueprintAsString => this.uriBlueprint.toString();
}

class SuperAdminInstitutionLocations extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final stateData = data as Map<String, dynamic>? ?? {};
    return [
      if (state.uriBlueprintAsString == '/institutions')
        AptBeamPage(
          context: context,
          title: context.i18n.institutionOverview,
          key: ValueKey(state.uri.toString()),
          child: BlocProvider.value(
            value: BlocProvider.of<InstitutionBloc>(context)..add(FetchInstitutionsEvent()),
            child: InstitutionOverviewPage(),
          ),
        ),
      if (state.uriBlueprintAsString == '/institutions/add')
        AptBeamPage(
          context: context,
          title: context.i18n.addInstitution,
          key: ValueKey(state.uri.toString()),
          child: ModifyInstitutionPage(
            edit: false,
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
      if (state.uriBlueprintAsString == '/institutions/:institutionId/healthcare-professionals')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: InstitutionHealthcareProfessionalsPage(institutionId: state.pathParameters['institutionId']!),
        ),
      if (state.uriBlueprintAsString == '/institutions/:institutionId/healthcare-professionals/add')
        AptBeamPage(
          context: context,
          child: ModifyHealthProfessionalPage(
            edit: false,
            institutionId: state.pathParameters['institutionId']!,
          ),
        ),
      if (state.uriBlueprintAsString == '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/edit')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyHealthProfessionalPage(
            edit: true,
            user: stateData['user'],
            institutionId: state.pathParameters['institutionId']!,
            userId: state.pathParameters['healthcareProfessionalId']!,
          ),
        ),
      if (state.uriBlueprintAsString == '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/patients')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: BlocProvider.value(
            value: BlocProvider.of<UserBloc>(context)
              ..add(FetchPatientsEvent(healthcareProfessionalId: state.pathParameters['healthcareProfessionalId']!)),
            child: PatientOverviewPage(
              healthcareProfessionalId: state.pathParameters['healthcareProfessionalId']!,
              institutionId: state.pathParameters['institutionId']!,
            ),
          ),
        ),
      if (state.uriBlueprintAsString == '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/patients/add')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyPatientPage(
            edit: false,
            healthcareProfessionalId: state.pathParameters['healthcareProfessionalId']!,
            institutionId: state.pathParameters['institutionId']!,
          ),
        ),
      if (state.uriBlueprintAsString == '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/patients/:patientId')
        AptBeamPage(
          context: context,
          key: ValueKey(state.uri.toString()),
          child: ModifyPatientPage(
            edit: true,
            healthcareProfessionalId: state.pathParameters['healthcareProfessionalId']!,
            patient: stateData['patient'],
            userId: state.pathParameters['patientId']!,
            institutionId: state.pathParameters['institutionId']!,
          ),
        ),
    ];
  }

  @override
  List<String> get pathPatterns => [
        '/institutions',
        '/institutions/add',
        '/institutions/:id/edit',
        '/institutions/:institutionId/healthcare-professionals',
        '/institutions/:institutionId/healthcare-professionals/add',
        '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/edit',
        '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/patients',
        '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/patients/add',
        '/institutions/:institutionId/healthcare-professionals/:healthcareProfessionalId/patients/:patientId',
      ];
}
