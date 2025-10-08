// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchPatientsEvent extends UserEvent {
  final String healthcareProfessionalId;
  FetchPatientsEvent({required this.healthcareProfessionalId});

  @override
  List<Object> get props => [healthcareProfessionalId];
}

class FetchHealthcareProfessionalsEvent extends UserEvent {
  final String institutionId;
  FetchHealthcareProfessionalsEvent({required this.institutionId});

  @override
  List<Object> get props => [institutionId];
}

class FetchHealthcareProfessionalProfileEvent extends UserEvent {
  final String healthcareProfessionalId;
  FetchHealthcareProfessionalProfileEvent({required this.healthcareProfessionalId});
  @override
  List<Object> get props => [];
}

class FetchInstitutionAdministratorsEvent extends UserEvent {
  final String institutionId;
  FetchInstitutionAdministratorsEvent({required this.institutionId});

  @override
  List<Object> get props => [institutionId];
}

class AddUserEvent extends UserEvent {
  final newUser;
  final MultipartFile? picture;

  AddUserEvent({
    required this.newUser,
    this.picture,
  });

  @override
  List<Object> get props => [newUser];
}

class UpdateUserEvent extends UserEvent {
  final String id;
  final user;
  final MultipartFile? picture;

  UpdateUserEvent({required this.id, required this.user, this.picture});

  @override
  List<Object> get props => [id, user];
}

class FetchSinglePatientEvent extends UserEvent {
  final id;
  FetchSinglePatientEvent({this.id});

  @override
  List<Object> get props => [id];
}

class DeletePatientEvent extends UserEvent {
  final String id;
  final String healthcareProfessionalId;

  DeletePatientEvent({required this.id, required this.healthcareProfessionalId});

  @override
  List<Object> get props => [id, healthcareProfessionalId];
}

class DeleteHealthcareProfessionalEvent extends UserEvent {
  final String id;
  final String institutionId;

  DeleteHealthcareProfessionalEvent({required this.id, required this.institutionId});

  @override
  List<Object> get props => [id, institutionId];
}

class ResetUserBlocEvent extends UserEvent {
  ResetUserBlocEvent();

  @override
  List<Object> get props => [];
}

class ChangeHealthcareProfessionalForPatientsEvent extends UserEvent {
  final ChangeHealthcareProfessionalDTO changeHealthcareProfessionalDTO;
  final String originalHealthcareProfessionalId;
  final String newHealthcareProfessionalName;
  final List<String> patientNames;

  ChangeHealthcareProfessionalForPatientsEvent(
      {required this.changeHealthcareProfessionalDTO,
      required this.originalHealthcareProfessionalId,
      required this.newHealthcareProfessionalName,
      required this.patientNames});

  @override
  List<Object> get props => [changeHealthcareProfessionalDTO, originalHealthcareProfessionalId];
}
