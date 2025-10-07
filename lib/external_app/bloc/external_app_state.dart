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
