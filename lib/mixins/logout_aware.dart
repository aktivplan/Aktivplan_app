// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/institution/bloc/institution_bloc.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin LogoutAware<T extends StatefulWidget> on State<T> {
  logout({bool navigateToHome = true}) async {
    APTApp.globalAptCubit.reset();
    BlocProvider.of<UserBloc>(context).add(ResetUserBlocEvent());
    BlocProvider.of<InstitutionBloc>(context).add(ResetInstitutionEvent());
    BlocProvider.of<ActivityBloc>(context).add(ResetActivityEvent());
    BlocProvider.of<ExerciseBloc>(context).add(ResetExerciseBlocEvent());

    await BlocProvider.of<AuthenticationBloc>(context).logout();

    if (navigateToHome) {
      context.beamToReplacementNamed("/");
    }
  }
}
