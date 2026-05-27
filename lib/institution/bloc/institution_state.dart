part of 'institution_bloc.dart';

abstract class InstitutionState extends Equatable {
  const InstitutionState();

  @override
  List<Object> get props => [];
}

class InstitutionInitial extends InstitutionState {}

class FetchedInstitutionsState extends InstitutionState {
  final List<InstitutionDTO> institutions;

  FetchedInstitutionsState({required this.institutions});

  @override
  List<Object> get props => [institutions];
}

class FetchedSpecificInstitutionsState extends InstitutionState {
  final InstitutionDTO institut;

  FetchedSpecificInstitutionsState({required this.institut});

  @override
  List<Object> get props => [institut];
}

class AddedInstitutionState extends InstitutionState {
  AddedInstitutionState();

  @override
  List<Object> get props => [];
}

class UpdatedInstitutionState extends InstitutionState {
  UpdatedInstitutionState();

  @override
  List<Object> get props => [];
}

class DeletedInstitutionState extends InstitutionState {
  DeletedInstitutionState();

  @override
  List<Object> get props => [];
}

class InstitutionErrorState extends InstitutionState {
  final String message;

  InstitutionErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
