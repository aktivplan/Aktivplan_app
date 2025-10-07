import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/apt_scaffold.dart';
import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/institution/bloc/institution_bloc.dart';
import 'package:aptapp/login/login_form.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TraceablePageMixin {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  resetBloc(context) {
    BlocProvider.of<UserBloc>(context).add(ResetUserBlocEvent());
    BlocProvider.of<InstitutionBloc>(context).add(ResetInstitutionEvent());
    BlocProvider.of<ActivityBloc>(context).add(ResetActivityEvent());
    BlocProvider.of<ExerciseBloc>(context).add(ResetExerciseBlocEvent());
    BlocProvider.of<MessageBloc>(context).add(ResetMessageBlocEvent());
  }

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
    resetBloc(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  login() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoginEvent(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          language: Localizations.localeOf(context).languageCode == 'de' ? TranslationLanguage.DE : TranslationLanguage.EN));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AptScaffold(
        body: LoginForm(
          formKey: _formKey,
          emailController: emailController,
          passwordController: passwordController,
          login: login,
        ),
      ),
    );
  }

  String get traceablePageName => "Login Page";
}
