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

class MailRepository {
  final userApi = new UserControllerApi(apiClient);

  Future<void> sendWelcomeEmail({required String id}) async {
    await userApi.sendPatientWelcomeMail(id);
  }
}
