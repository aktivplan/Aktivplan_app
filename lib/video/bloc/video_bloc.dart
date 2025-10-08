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

import 'video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;

  VideoBloc({
    required this.videoRepository,
  }) : super(VideoInitial()) {
    on<FetchVideoTemplatesEvent>((event, emit) async {
      List<VideoTemplateDTO>? templates = await videoRepository.getVideoTemplates();
      emit(FetchedVideoTemplatesState(templates: templates!));
    });
    on<UpdateVideoTemplatesOrderingEvent>((event, emit) async {
      videoRepository.updateVideoTemplateOrdering(OrderingDTO(orderedIds: event.orderedIds));
      emit(OrderedVideoTemplatesState());
    });
    on<AddVideoTemplateEvent>((event, emit) async {
      await videoRepository.addVideoTemplate(event.template);
      emit(AddedVideoTemplateState());
      add(FetchVideoTemplatesEvent());
    });
    on<UpdateVideoTemplateEvent>((event, emit) async {
      await videoRepository.updateVideoTemplate(event.id, event.template);
      emit(UpdatedVideoTemplateState());
      add(FetchVideoTemplatesEvent());
    });
    on<DeleteVideoTemplateEvent>((event, emit) async {
      await videoRepository.deleteVideoTemplate(event.id);
      emit(DeletedVideoTemplateState());
      add(FetchVideoTemplatesEvent());
    });
  }

  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    try {} catch (e) {
      yield VideoErrorState(message: e.toString());
    }
  }
}
