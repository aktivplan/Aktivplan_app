import 'dart:core';

import 'package:apt_api/api.dart';
import 'package:aptapp/main.dart';

class MailRepository {
  final userApi = new UserControllerApi(apiClient);

  Future<void> sendWelcomeEmail({required String id}) async {
    await userApi.sendPatientWelcomeMail(id);
  }
}
