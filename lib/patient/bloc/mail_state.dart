import 'package:equatable/equatable.dart';

abstract class MailState extends Equatable {
  const MailState();

  @override
  List<Object> get props => [];
}

class MailInitial extends MailState {}

class MailWaiting extends MailState {}

class MailSent extends MailState {}

class MailError extends MailState {}

// class MailError extends MailState {
//   final String error;

//   MailError({@required this.error});

//   @override
//   List<Object> get props => [error];
// }
