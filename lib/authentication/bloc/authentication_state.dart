import 'package:apt_api/api.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

abstract class AuthenticationLoggedInState extends AuthenticationState {}

class AuthenticationAdministrator extends AuthenticationLoggedInState {
  final AdministratorGetDTO user;

  AuthenticationAdministrator(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationHealthcareProfessional extends AuthenticationLoggedInState {
  final HealthcareProfessionalGetDTO user;

  AuthenticationHealthcareProfessional(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationInstitutionAdministrator extends AuthenticationLoggedInState {
  final InstitutionAdministratorGetDTO user;

  AuthenticationInstitutionAdministrator(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationPatient extends AuthenticationLoggedInState {
  final PatientGetDTO user;

  AuthenticationPatient(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationWaitingState extends AuthenticationState {}

class AuthenticationConnectionError extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String error;
  AuthenticationError({required this.error});
  @override
  List<Object> get props => [error];
}
