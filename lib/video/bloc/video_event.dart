part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class FetchVideoTemplatesEvent extends VideoEvent {
  FetchVideoTemplatesEvent();

  @override
  List<Object> get props => [];
}

class UpdateVideoTemplatesOrderingEvent extends VideoEvent {
  final List<String> orderedIds;
  UpdateVideoTemplatesOrderingEvent({required this.orderedIds});

  @override
  List<Object> get props => [orderedIds];
}

class AddVideoTemplateEvent extends VideoEvent {
  final VideoTemplatePostDTO template;
  AddVideoTemplateEvent({required this.template});

  @override
  List<Object> get props => [template];
}

class DeleteVideoTemplateEvent extends VideoEvent {
  final String id;
  DeleteVideoTemplateEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateVideoTemplateEvent extends VideoEvent {
  final String id;
  final VideoTemplatePostDTO template;
  UpdateVideoTemplateEvent({required this.id, required this.template});

  @override
  List<Object> get props => [id, template];
}

class ReorderVideoTemplateEvent extends VideoEvent {
  final List<String> orderedIds;
  ReorderVideoTemplateEvent({required this.orderedIds});

  @override
  List<Object> get props => [orderedIds];
}
