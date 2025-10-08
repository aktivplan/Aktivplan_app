// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/patient/bloc/mailrepository.dart';
import 'package:bloc/bloc.dart';
import 'package:kiwi/kiwi.dart';

import 'mailbloc.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  MailBloc() : super(MailInitial()) {
    final MailRepository mailRepo = KiwiContainer().resolve<MailRepository>();

    on<SendWelcomeEmailEvent>((event, emit) async {
      emit(MailWaiting());
      try {
        await mailRepo.sendWelcomeEmail(id: event.patientId);
        emit(MailSent());
      } catch (err) {
        emit(MailError());
      }
    });
  }
}
