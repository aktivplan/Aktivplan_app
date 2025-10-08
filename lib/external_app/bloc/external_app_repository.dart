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
