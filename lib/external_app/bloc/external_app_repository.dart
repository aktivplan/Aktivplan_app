import 'dart:core';

import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';

class ExternalAppRepository {
  final externalAppApi = new ExternalAppControllerApi(apiClient);

  Future<List<ExternalAppDTO>?> getExternalApps() async {
    return externalAppApi.getExternalApps();
  }

  void updateExternalAppOrdering(OrderingDTO ordering) async {
    await externalAppApi.updateExternalAppOrdering(ordering);
  }

  Future<ExternalAppDTO?> getExternalApp(String id) async {
    return externalAppApi.getExternalAppById(id);
  }

  Future<ExternalApp?> addExternalApp(ExternalAppPostDTO externalApp) async {
    return externalAppApi.createExternalApp(externalApp);
  }

  Future<ExternalApp?> updateExternalApp(String id, ExternalAppPostDTO externalApp) async {
    return externalAppApi.updateExternalApp(id, externalApp);
  }

  Future<void> deleteExternalApp(String id) async {
    return externalAppApi.deleteExternalApp(id);
  }
}
