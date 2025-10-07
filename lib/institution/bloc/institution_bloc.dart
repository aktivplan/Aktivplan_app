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
