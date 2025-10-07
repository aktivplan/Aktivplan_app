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
