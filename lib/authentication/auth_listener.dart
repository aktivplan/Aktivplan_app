import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class AuthListener extends StatefulWidget {
  final Widget? child;

  AuthListener({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  _AuthListenerState createState() => _AuthListenerState();
}

class _AuthListenerState extends State<AuthListener> {
  @override
  Widget build(BuildContext context) {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) {
        return previous is AuthenticationWaitingState && current is AuthenticationLoggedInState;
      },
      listener: (context, state) async {
        if ((state is AuthenticationError || state is AuthenticationFailure || userRepository.currentUser == null)) {
          context.beamToReplacementNamed(
            '/login',
          );
        } else if (state is AuthenticationAdministrator) {
          context.beamToReplacementNamed(
            '/institutions',
          );
        } else if (state is AuthenticationInstitutionAdministrator) {
          context.beamToReplacementNamed(
            '/professionals',
            data: {'institutionId': userRepository.currentUser.institutionId},
          );
        } else if (state is AuthenticationHealthcareProfessional) {
          context.beamToReplacementNamed(
            '/patients',
          );
        } else if (state is AuthenticationPatient) {
          context.beamToReplacementNamed(
            '/calendar',
            data: {'patient': userRepository.currentUser, 'id': userRepository.currentUser.id},
          );
        } else if (userRepository.currentUser != null) {
          print("user check");
        }
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        if (state is AuthenticationInProgress || state is AuthenticationWaitingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return widget.child ?? Container();
        }
      },
    );
  }
}
