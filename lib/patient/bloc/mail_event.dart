import 'package:equatable/equatable.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object> get props => [];
}

class SendWelcomeEmailEvent extends MailEvent {
  final String patientId;

  SendWelcomeEmailEvent({required this.patientId});

  @override
  List<Object> get props => [patientId];
}
