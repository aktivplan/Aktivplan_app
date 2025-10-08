// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:core';

import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';

class VideoRepository {
  final videoApi = new VideoControllerApi(apiClient);

  Future<List<VideoTemplateDTO>?> getVideoTemplates() async {
    return videoApi.getVideoTemplates();
  }

  void updateVideoTemplateOrdering(OrderingDTO ordering) async {
    await videoApi.updateVideoTemplateOrdering(ordering);
  }

  Future<VideoTemplateDTO?> getVideoTemplate(String id) async {
    return videoApi.getVideoTemplateById(id);
  }

  Future<VideoTemplate?> addVideoTemplate(VideoTemplatePostDTO template) async {
    return videoApi.createVideoTemplate(template);
  }

  Future<VideoTemplate?> updateVideoTemplate(String id, VideoTemplatePostDTO template) async {
    return videoApi.updateVideoTemplate(id, template);
  }

  Future<void> deleteVideoTemplate(String id) async {
    return videoApi.deleteVideoTemplate(id);
  }
}
