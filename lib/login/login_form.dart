// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:math';

import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/password_form_field.dart';
import 'package:beamer/beamer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function() login;

  LoginForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.login,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double containerWidth = min(500, width * 0.9);

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: containerWidth,
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              Image.asset(
                "assets/images/logo.png",
                height: 150,
              ),
              SizedBox(height: height * 0.1),
              Form(
                key: widget.formKey,
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        TextFormField(
                          key: Key(KEY_LOGIN_TEXT_EMAIL),
                          autofillHints: [AutofillHints.email],
                          controller: widget.emailController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? "").isEmpty || !EmailValidator.validate((value ?? "").trim())) {
                              return context.i18n.validationEmail;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: context.i18n.email,
                            labelText: context.i18n.email,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        PasswordFormField(
                          key: Key(KEY_LOGIN_TEXT_PASSWORD),
                          controller: widget.passwordController,
                          labelText: context.i18n.password,
                          onSubmitted: (val) => widget.login(),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: Key(KEY_LOGIN_BUTTON_SUBMIT),
                            onPressed: widget.login,
                            style: getElevatedButtonStyle(context),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: state is AuthenticationInProgress
                                  ? FittedBox(fit: BoxFit.scaleDown, child: CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.white))
                                  : Text(context.i18n.login.toUpperCase()),
                            ),
                          ),
                        ),
                        if (state is AuthenticationError)
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              context.i18n.validationWrongCredentials,
                              key: Key(KEY_LOGIN_TEXT_WRONG_CREDENTIALS),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: errorColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        SizedBox(height: 10),
                        TextButton(
                          key: Key(KEY_LOGIN_BUTTON_RESET_PASSWORD),
                          child: Text(context.i18n.resetPassword),
                          onPressed: () => {
                            context.beamToNamed('/resetPassword'),
                          },
                        ),
                        TextButton(
                          key: Key(KEY_BUTTON_LEGAL_NOTICE),
                          child: Text(context.i18n.legalNoticeTermsAndConditionsMenu),
                          onPressed: () => {
                            context.beamToNamed('/imprint'),
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
