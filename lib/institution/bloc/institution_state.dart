// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
