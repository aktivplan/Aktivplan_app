// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'external_app_bloc.dart';

abstract class ExternalAppState extends Equatable {
  const ExternalAppState();
  @override
  List<Object> get props => [];
}

class ExternalAppInitial extends ExternalAppState {}

class ExternalAppErrorState extends ExternalAppState {
  final String message;
  ExternalAppErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchedExternalAppsState extends ExternalAppState {
  final List<ExternalAppDTO> externalApps;
  FetchedExternalAppsState({required this.externalApps});

  @override
  List<Object> get props => [externalApps];
}

class AddedExternalAppState extends ExternalAppState {
  AddedExternalAppState();

  @override
  List<Object> get props => [];
}

class UpdatedExternalAppState extends ExternalAppState {
  UpdatedExternalAppState();

  @override
  List<Object> get props => [];
}

class DeletedExternalAppState extends ExternalAppState {
  DeletedExternalAppState();

  @override
  List<Object> get props => [];
}

class OrderedExternalAppsState extends ExternalAppState {
  OrderedExternalAppsState();

  @override
  List<Object> get props => [];
}
