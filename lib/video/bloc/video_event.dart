// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
