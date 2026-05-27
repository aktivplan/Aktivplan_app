part of 'institution_bloc.dart';

abstract class InstitutionEvent extends Equatable {
  const InstitutionEvent();

  @override
  List<Object> get props => [];
}

class FetchInstitutionsEvent extends InstitutionEvent {
  FetchInstitutionsEvent();

  @override
  List<Object> get props => [];
}

class ResetInstitutionEvent extends InstitutionEvent {
  ResetInstitutionEvent();

  @override
  List<Object> get props => [];
}

class FetchSpecificInstitutionsEvent extends InstitutionEvent {
  final String id;

  FetchSpecificInstitutionsEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AddInstitutionEvent extends InstitutionEvent {
  final InstitutionPostDTO institution;

  AddInstitutionEvent({required this.institution});

  @override
  List<Object> get props => [institution];
}

class UpdateInstitutionEvent extends InstitutionEvent {
  final String id;
  final InstitutionPostDTO institution;

  UpdateInstitutionEvent({required this.id, required this.institution});

  @override
  List<Object> get props => [id, institution];
}

class DeleteInstitutionEvent extends InstitutionEvent {
  final String id;

  DeleteInstitutionEvent({required this.id});

  @override
  List<Object> get props => [id];
}
