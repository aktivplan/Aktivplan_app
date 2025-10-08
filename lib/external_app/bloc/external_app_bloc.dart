// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:async';

import 'package:apt_api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'external_app_repository.dart';

part 'external_app_event.dart';
part 'external_app_state.dart';

class ExternalAppBloc extends Bloc<ExternalAppEvent, ExternalAppState> {
  final ExternalAppRepository externalAppRepository;

  ExternalAppBloc({
    required this.externalAppRepository,
  }) : super(ExternalAppInitial()) {
    on<FetchExternalAppsEvent>((event, emit) async {
      List<ExternalAppDTO>? templates = await externalAppRepository.getExternalApps();
      emit(FetchedExternalAppsState(externalApps: templates!));
    });
    on<UpdateExternalAppsOrderingEvent>((event, emit) async {
      externalAppRepository.updateExternalAppOrdering(OrderingDTO(orderedIds: event.orderedIds));
      emit(OrderedExternalAppsState());
    });
    on<AddExternalAppEvent>((event, emit) async {
      await externalAppRepository.addExternalApp(event.externalApp);
      emit(AddedExternalAppState());
      add(FetchExternalAppsEvent());
    });
    on<UpdateExternalAppEvent>((event, emit) async {
      await externalAppRepository.updateExternalApp(event.id, event.externalApp);
      emit(UpdatedExternalAppState());
      add(FetchExternalAppsEvent());
    });
    on<DeleteExternalAppEvent>((event, emit) async {
      await externalAppRepository.deleteExternalApp(event.id);
      emit(DeletedExternalAppState());
      add(FetchExternalAppsEvent());
    });
  }

  Stream<ExternalAppState> mapEventToState(
    ExternalAppEvent event,
  ) async* {
    try {} catch (e) {
      yield ExternalAppErrorState(message: e.toString());
    }
  }
}
