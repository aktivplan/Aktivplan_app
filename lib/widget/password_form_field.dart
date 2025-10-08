// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String)? additionalValidations;
  PasswordFormField({Key? key, required this.controller, required this.labelText, this.onSubmitted, this.additionalValidations}) : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _hidePassword = true;
  String password = "";

  togglePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: [AutofillHints.password],
      controller: widget.controller,
      obscureText: _hidePassword,
      enableSuggestions: false,
      autocorrect: false,
      onFieldSubmitted: this.widget.onSubmitted,
      validator: (value) {
        if ((value ?? "").isEmpty) {
          return context.i18n.validationNotEmpty;
        } else if (value!.length < 8) {
          return context.i18n.validationPasswordLength;
        } else if (widget.additionalValidations != null) {
          return widget.additionalValidations!(value);
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: widget.labelText,
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        suffixIcon: _hidePassword
            ? IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () => togglePassword(),
              )
            : IconButton(
                icon: Icon(Icons.visibility_off),
                onPressed: () => togglePassword(),
              ),
      ),
    );
  }
}
