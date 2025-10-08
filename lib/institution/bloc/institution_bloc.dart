// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/institution/bloc/institution_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'institution_event.dart';
part 'institution_state.dart';

class InstitutionBloc extends Bloc<InstitutionEvent, InstitutionState> {
  final InstitutionRepository institutionRepository;

  InstitutionBloc({
    required this.institutionRepository,
  }) : super(InstitutionInitial()) {
    on<ResetInstitutionEvent>((event, emit) async {
      emit(InstitutionInitial());
    });
    on<FetchInstitutionsEvent>((event, emit) async {
      List<InstitutionDTO>? institutions = await institutionRepository.getInstitutions();
      emit(FetchedInstitutionsState(institutions: institutions!));
    });
    on<FetchSpecificInstitutionsEvent>((event, emit) async {
      InstitutionDTO? institut = await institutionRepository.getInstitutionbyId(id: event.id);
      emit(FetchedSpecificInstitutionsState(institut: institut!));
    });
    on<AddInstitutionEvent>((event, emit) async {
      await institutionRepository.addInstitution(institution: event.institution);
      emit(AddedInstitutionState());
      this.add(FetchInstitutionsEvent());
    });
    on<UpdateInstitutionEvent>((event, emit) async {
      await institutionRepository.updateInstitution(id: event.id, institution: event.institution);
      emit(UpdatedInstitutionState());
      this.add(FetchInstitutionsEvent());
    });
    on<DeleteInstitutionEvent>((event, emit) async {
      await institutionRepository.deleteInstitution(id: event.id);
      emit(DeletedInstitutionState());
      this.add(FetchInstitutionsEvent());
    });
  }
}
