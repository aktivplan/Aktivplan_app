// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInProgress()) {
    final UserRepository userRepository = KiwiContainer().resolve<UserRepository>();

    on<AuthenticationStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken(null);
      if (hasToken) {
        await userRepository.getCurrentUser();
        final state = yieldAccordingUserState(userRepository.user);
        emit(state);
      } else {
        emit(AuthenticationFailure());
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      bool resetDone = await userRepository.resetPassword(resetPassword: event.passwordDTO);
      if (resetDone) {
        print("Done");
        emit(AuthenticationFailure());
      } else {
        print("not working");
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      await userRepository.forgotPassword(forgotPassword: event.passwordDTO);
      emit(AuthenticationFailure());
    });
    on<AuthenticationLoginEvent>((event, emit) async {
      emit(AuthenticationWaitingState());
      try {
        await userRepository.deleteToken();
        final token = await userRepository.authenticate(email: event.email, password: event.password, language: event.language);
        //get user information
        await userRepository.getCurrentUser();
        this.add(AuthenticationLoggedIn(token: token));
      } on Exception catch (e) {
        emit(AuthenticationError(error: e.toString()));
      }
    });

    on<AuthenticationLoggedIn>((event, emit) async {
      try {
        await userRepository.getCurrentUser();
        final state = yieldAccordingUserState(userRepository.user);
        emit(state);
      } catch (err) {
        emit(AuthenticationFailure());
      }
    });
    on<AuthenticationLostConnection>((event, emit) => emit(AuthenticationConnectionError()));

    on<LoggedoutEvent>(((event, emit) => emit(AuthenticationFailure())));
  }

  AuthenticationState yieldAccordingUserState(CurrentUserDTO? user) {
    if (user?.userRole == UserRole.ADMINISTRATOR) {
      return AuthenticationAdministrator(user!.administrator!);
    } else if (user?.userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
      return AuthenticationInstitutionAdministrator(user!.institutionAdministrator!);
    } else if (user?.userRole == UserRole.HEALTHCARE_PROFESSIONAL) {
      return AuthenticationHealthcareProfessional(user!.healthcareProfessional!);
    } else if (user?.userRole == UserRole.PATIENT) {
      return AuthenticationPatient(user!.patient!);
    }
    return AuthenticationFailure();
  }

  logout() async {
    final UserRepository userRepository = KiwiContainer().resolve<UserRepository>();
    await userRepository.deleteToken();
    add(LoggedoutEvent());
  }
}
