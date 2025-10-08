// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

//import 'dart:html';

import 'package:apt_api/api.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final TranslationLanguage language;

  AuthenticationLoginEvent({required this.email, required this.password, required this.language});

  @override
  List<Object> get props => [email, password, language];
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final AccessTokenDTO token;

  AuthenticationLoggedIn({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class ResetPasswordEvent extends AuthenticationEvent {
  final ResetPasswordDTO passwordDTO;

  ResetPasswordEvent({required this.passwordDTO});

  @override
  List<Object> get props => [passwordDTO];
}

class ForgotPasswordEvent extends AuthenticationEvent {
  final ForgotPasswordDTO passwordDTO;

  ForgotPasswordEvent({required this.passwordDTO});

  @override
  List<Object> get props => [passwordDTO];
}

class AuthenticationLostConnection extends AuthenticationEvent {}

class LoggedoutEvent extends AuthenticationEvent {}
