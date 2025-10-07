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
