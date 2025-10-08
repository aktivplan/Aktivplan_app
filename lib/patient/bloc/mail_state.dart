// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
