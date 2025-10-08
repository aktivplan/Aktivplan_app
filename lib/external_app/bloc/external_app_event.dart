// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'external_app_bloc.dart';

abstract class ExternalAppEvent extends Equatable {
  const ExternalAppEvent();

  @override
  List<Object> get props => [];
}

class FetchExternalAppsEvent extends ExternalAppEvent {
  FetchExternalAppsEvent();

  @override
  List<Object> get props => [];
}

class UpdateExternalAppsOrderingEvent extends ExternalAppEvent {
  final List<String> orderedIds;
  UpdateExternalAppsOrderingEvent({required this.orderedIds});

  @override
  List<Object> get props => [orderedIds];
}

class AddExternalAppEvent extends ExternalAppEvent {
  final ExternalAppPostDTO externalApp;
  AddExternalAppEvent({required this.externalApp});

  @override
  List<Object> get props => [externalApp];
}

class DeleteExternalAppEvent extends ExternalAppEvent {
  final String id;
  DeleteExternalAppEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateExternalAppEvent extends ExternalAppEvent {
  final String id;
  final ExternalAppPostDTO externalApp;
  UpdateExternalAppEvent({required this.id, required this.externalApp});

  @override
  List<Object> get props => [id, externalApp];
}

class ReorderExternalAppEvent extends ExternalAppEvent {
  final List<String> orderedIds;
  ReorderExternalAppEvent({required this.orderedIds});

  @override
  List<Object> get props => [orderedIds];
}
