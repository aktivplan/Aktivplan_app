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
import 'package:http/http.dart';

class SocialControllerRepository {
  final socialApi = new SocialControllerApi(apiClient);
  final messageApi = new MessageControllerApi(apiClient);

  Future<bool?> addContact({required String userId}) async {
    return socialApi.addContact(userId);
  }

  Future<bool?> removeContact({required String userId}) async {
    return socialApi.removeContact(userId);
  }

  Future<UserContactOverviewDTO?> getContactOverview() async {
    return socialApi.getContactOverview();
  }

  Future<void> updateContactOrdering(List<String> orderedIds) async {
    return socialApi.updateContactOrdering(OrderingDTO(orderedIds: orderedIds));
  }

  Future<UserContactDetailDTO?> getContactDetail({required String userId, required String startDate, required String endDate}) async {
    return socialApi.getContactDetail(userId, startDate, endDate);
  }

  Future<void> sendSocialMessage({required SocialMessagePostDTO message, MultipartFile? picture}) async {
    var createdMessage = await messageApi.sendSocialMessage(message);
    if (message.hasPicture ?? false) {
      await messageApi.uploadSocialMessagePictureById(createdMessage!.id, picture!);
    }
  }

  Future<List<StatusFileDTO>?> getStatusFiles({required String userId}) async {
    return await socialApi.getStatusFiles(userId);
  }

  Future<StatusFileDTO?> uploadStatusText({required StatusTextPostDTO message}) async {
    return await socialApi.uploadStatusText(message);
  }

  Future<bool?> uploadStatusPictures({required List<MultipartFile> files}) async {
    for (var file in files) {
      try {
        await socialApi.uploadStatusPicture(file);
      } catch (e) {
        rethrow;
      }
    }
    return true;
  }
  
  Future<bool?> deleteStatusFile({required String id}) async {
    return await socialApi.deleteStatusFile(id);
  }

  Future<StatusFileDTO?> markStoryItemAsSeen({required String id}) async {
    return await socialApi.markStatusFileSeen(id);
  }

}
