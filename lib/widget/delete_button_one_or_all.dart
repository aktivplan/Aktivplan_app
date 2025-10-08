// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';

class DeleteButtonOneOrAll extends StatelessWidget {
  final Function(bool) callback;
  final String confirmationTitle;
  final String confirmationText;
  final String deleteThisText;
  final String deleteAllText;
  final String? label;
  final bool disabled;

  DeleteButtonOneOrAll({
    Key? key,
    required this.callback,
    required this.deleteThisText,
    required this.deleteAllText,
    this.confirmationTitle = "",
    this.confirmationText = "",
    this.label,
    this.disabled = false,
  }) : super(key: key);

  showDeleteConfirmationDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Wrap(
        children: [
          Text(confirmationTitle.isNotEmpty ? confirmationTitle : context.i18n.deleteObject),
        ],
      ),
      content: Text(confirmationText.isNotEmpty ? confirmationText : context.i18n.deleteObject),
      actions: [
        Padding(
          padding: EdgeInsets.all(5),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => errorColor,
                ),
              ),
              child: FittedBox(fit: BoxFit.contain, child: Text(deleteThisText)),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                callback(false);
              }),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => errorColor,
                ),
              ),
              child: FittedBox(fit: BoxFit.contain, child: Text(deleteAllText)),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                callback(true);
              }),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => primaryColor,
              ),
            ),
            child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.deleteNo)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => disabled ? infoIconColor : errorColor,
        ),
      ),
      child: FittedBox(fit: BoxFit.contain, child: Text(label ?? context.i18n.delete.toUpperCase())),
      onPressed: disabled ? null : () => showDeleteConfirmationDialog(context),
    );
  }
}
