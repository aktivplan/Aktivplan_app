// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

import '../user_controller_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserControllerRepository userControllerRepository = KiwiContainer().resolve<UserControllerRepository>();
    final UserRepository userRepo = KiwiContainer().resolve<UserRepository>();
    on<ResetUserBlocEvent>((event, emit) async {
      emit(UserInitial());
    });
    on<FetchSinglePatientEvent>((event, emit) async {
      PatientOverviewDTO? patient = await userControllerRepository.getPatientbyId(id: event.id);
      emit(FetchedSinglePatientState(patient: patient!));
    });
    on<FetchPatientsEvent>((event, emit) async {
      PatientsOverviewDTO? patients = await userControllerRepository.getPatients(id: event.healthcareProfessionalId);
      patients!.users.sort((a, b) => (b.lastName ?? "").toLowerCase().compareTo((a.lastName ?? "").toLowerCase()));
      emit(FetchedPatientsState(users: patients));
    });
    on<FetchHealthcareProfessionalsEvent>((event, emit) async {
      HealthcareProfessionalsOverviewDTO? professionals =
          await userControllerRepository.getHealthcareProfessionals(institutionId: event.institutionId);
      emit(FetchedHealthcareProfessionalsState(users: professionals!));
    });
    on<FetchHealthcareProfessionalProfileEvent>((event, emit) async {
      HealthcareProfessionalProfileDTO? profile = await userControllerRepository.getHealthcareProfessionalProfile(event.healthcareProfessionalId);
      emit(FetchedHealthcareProfessionalProfileState(profile: profile!));
    });
    on<FetchInstitutionAdministratorsEvent>((event, emit) async {
      // List<InstitutionAdministratorGetDTO> admins =
      //     await userControllerRepository.getInstitutionAdministrators(id: event.institutionId);
      emit(FetchedInstitutAdministratorsState(users: List.empty()));
    });
    //ADD USER
    on<AddUserEvent>((event, emit) async {
      final UserControllerRepository userControllerRepository = KiwiContainer().resolve<UserControllerRepository>();
      final UserRepository userRepo = KiwiContainer().resolve<UserRepository>();

      if (event.newUser is HealthcareProfessionalGetDTO) {
        try {
          await userControllerRepository.createHealthcareProfessional(healthcareProfessional: event.newUser, picture: event.picture);
          if (userRepo.userRole == UserRole.INSTITUTION_ADMINISTRATOR) emit(AddedHPState());
          if (userRepo.userRole == UserRole.ADMINISTRATOR) emit(AdminAddedHPState());
        } on ApiException catch (e) {
          if (e.code == 409) {
            emit(UserAlreadPresetState());
          } else {
            emit(UsersErrorState(message: e.toString()));
          }
        }
        this.add(FetchHealthcareProfessionalsEvent(
          institutionId: event.newUser.institutionId,
        ));
      } else if (event.newUser is PatientGetDTO) {
        try {
          await userControllerRepository.createPatient(patient: event.newUser, picture: event.picture);
          MatomoTracker.instance.trackEvent(
            eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT, name: EVENT_NAME_CREATE, action: "Created Patient"),
          );
          emit(AddedPatientState());
        } on ApiException catch (e) {
          if (e.code == 409) {
            emit(UserAlreadPresetState());
          } else {
            emit(UsersErrorState(message: e.toString()));
          }
        }
        this.add(FetchPatientsEvent(healthcareProfessionalId: event.newUser.healthcareProfessionalId));
      }
    });

    //UPDATE
    on<UpdateUserEvent>((event, emit) async {
      if (event.user is HealthcareProfessionalGetDTO) {
        var profs =
            await userControllerRepository.updateHealthcareProfessional(id: event.id, healthcareProfessional: event.user, picture: event.picture);

        if (userRepo.userRole == UserRole.INSTITUTION_ADMINISTRATOR) emit(UpdatedHPState());
        if (userRepo.userRole == UserRole.ADMINISTRATOR) emit(AdminUpdatedHPState());

        this.add(FetchHealthcareProfessionalsEvent(
          institutionId: profs!.institutionId!,
        ));
      } else if (event.user is PatientGetDTO) {
        var patient = await userControllerRepository.updatePatient(id: event.id, patient: event.user, picture: event.picture);
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT, name: EVENT_NAME_UPDATE, action: "Updated Patient"),
        );
        emit(UpdatedPatientState());
        this.add(FetchPatientsEvent(healthcareProfessionalId: patient!.healthcareProfessionalId!));
      } else if (event.user is InstitutionAdministratorGetDTO) {}

      //DELETE
    });
    on<DeletePatientEvent>((event, emit) async {
      await userControllerRepository.deletePatient(id: event.id);
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT, name: EVENT_NAME_DELETE, action: "Deleted Patient"),
      );
      emit(DeletedPatientState());
      this.add(FetchPatientsEvent(healthcareProfessionalId: event.healthcareProfessionalId));
    });
    on<DeleteHealthcareProfessionalEvent>((event, emit) async {
      await userControllerRepository.deleteHealthcareProfessional(id: event.id);
      if (userRepo.userRole == UserRole.INSTITUTION_ADMINISTRATOR) emit(DeletedHPState());
      if (userRepo.userRole == UserRole.ADMINISTRATOR) emit(AdminDeletedHPState());
      this.add(FetchHealthcareProfessionalsEvent(
        institutionId: event.institutionId,
      ));
    });
    on<ChangeHealthcareProfessionalForPatientsEvent>((event, emit) async {
      await userControllerRepository.changeHealthcareProfessionalForPatients(event.changeHealthcareProfessionalDTO);
      emit(ChangedHealthcareProfessionalForPatientsState(
          newHealthcareProfessionalName: event.newHealthcareProfessionalName, patientNames: event.patientNames));
      // somehow chino doesn't seem to update immediately
      await Future.delayed(const Duration(seconds: 1));
      this.add(FetchPatientsEvent(healthcareProfessionalId: event.originalHealthcareProfessionalId));
    });
  }
}
