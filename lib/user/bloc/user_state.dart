part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class FetchedHealthcareProfessionalsState extends UserState {
  final HealthcareProfessionalsOverviewDTO users;

  FetchedHealthcareProfessionalsState({required this.users});

  @override
  List<Object> get props => [users];
}

class FetchedHealthcareProfessionalProfileState extends UserState {
  final HealthcareProfessionalProfileDTO profile;
  FetchedHealthcareProfessionalProfileState({required this.profile});
  @override
  List<Object> get props => [profile];
}

class FetchedPatientsState extends UserState {
  final PatientsOverviewDTO users;

  FetchedPatientsState({required this.users});

  @override
  List<Object> get props => [users];
}

class FetchedInstitutAdministratorsState extends UserState {
  final List<InstitutionAdministratorGetDTO> users;

  FetchedInstitutAdministratorsState({required this.users});

  @override
  List<Object> get props => [users];
}

class UsersErrorState extends UserState {
  final String message;

  UsersErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class UserAlreadPresetState extends UserState {
  UserAlreadPresetState();

  @override
  List<Object> get props => [];
}

class FetchedSinglePatientState extends UserState {
  final PatientOverviewDTO patient;

  FetchedSinglePatientState({required this.patient});

  @override
  List<Object> get props => [patient];
}

class AddedUserState extends UserState {
  AddedUserState();

  @override
  List<Object> get props => [];
}

class UpdatedUserState extends UserState {
  UpdatedUserState();

  @override
  List<Object> get props => [];
}

class DeletedUserState extends UserState {
  DeletedUserState();

  @override
  List<Object> get props => [];
}

/// PATIENT
class AddedPatientState extends UserState {
  AddedPatientState();

  @override
  List<Object> get props => [];
}

class UpdatedPatientState extends UserState {
  UpdatedPatientState();

  @override
  List<Object> get props => [];
}

class DeletedPatientState extends UserState {
  DeletedPatientState();

  @override
  List<Object> get props => [];
}

/// SUPER ADMIN ACTIONS/

class AdminAddedHPState extends UserState {
  AdminAddedHPState();

  @override
  List<Object> get props => [];
}

class AdminUpdatedHPState extends UserState {
  AdminUpdatedHPState();

  @override
  List<Object> get props => [];
}

class AdminDeletedHPState extends UserState {
  AdminDeletedHPState();

  @override
  List<Object> get props => [];
}

class AdminAddedInstitutionAdminState extends UserState {
  AdminAddedInstitutionAdminState();

  @override
  List<Object> get props => [];
}

class AdminUpdatedInstitutionAdminState extends UserState {
  AdminUpdatedInstitutionAdminState();

  @override
  List<Object> get props => [];
}

class AdminDeletedInstitutionAdminState extends UserState {
  AdminDeletedInstitutionAdminState();

  @override
  List<Object> get props => [];
}

/// INSTITUTSADMIN's ACTIONS

class AddedHPState extends UserState {
  AddedHPState();

  @override
  List<Object> get props => [];
}

class UpdatedHPState extends UserState {
  UpdatedHPState();

  @override
  List<Object> get props => [];
}

class DeletedHPState extends UserState {
  DeletedHPState();

  @override
  List<Object> get props => [];
}

class ChangedHealthcareProfessionalForPatientsState extends UserState {
  final String newHealthcareProfessionalName;
  final List<String> patientNames;

  ChangedHealthcareProfessionalForPatientsState({required this.newHealthcareProfessionalName, required this.patientNames});

  @override
  List<Object> get props => [this.newHealthcareProfessionalName, this.patientNames];
}
