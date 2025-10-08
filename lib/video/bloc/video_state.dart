// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();
  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoErrorState extends VideoState {
  final String message;
  VideoErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchedVideoTemplatesState extends VideoState {
  final List<VideoTemplateDTO> templates;
  FetchedVideoTemplatesState({required this.templates});

  @override
  List<Object> get props => [templates];
}

class AddedVideoTemplateState extends VideoState {
  AddedVideoTemplateState();

  @override
  List<Object> get props => [];
}

class UpdatedVideoTemplateState extends VideoState {
  UpdatedVideoTemplateState();

  @override
  List<Object> get props => [];
}

class DeletedVideoTemplateState extends VideoState {
  DeletedVideoTemplateState();

  @override
  List<Object> get props => [];
}

class OrderedVideoTemplatesState extends VideoState {
  OrderedVideoTemplatesState();

  @override
  List<Object> get props => [];
}
