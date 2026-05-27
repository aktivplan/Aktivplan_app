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
