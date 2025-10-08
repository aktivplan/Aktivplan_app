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
import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatefulWidget {
  final Function callback;
  final bool hasChanges;

  CancelButton({Key? key, required this.callback, required this.hasChanges}) : super(key: key ?? Key(KEY_BUTTON_CANCEL));

  static showAlertDialog(BuildContext context, Function callback) {
    AlertDialog alert = AlertDialog(
      title: Wrap(
        children: [
          Text(context.i18n.cancel),
        ],
      ),
      content: Text(context.i18n.cancelText),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => primaryColor,
              ),
            ),
            child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.cancelYes)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              callback();
            }),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => errorColor,
            ),
          ),
          child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.no)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
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
  _CancelButtonState createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => errorColor,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(context.i18n.cancel.toUpperCase()),
        //child: Text(widget.hasChanges.toString()),
      ),
      onPressed: () {
        if (widget.hasChanges) {
          CancelButton.showAlertDialog(context, widget.callback);
        } else {
          widget.callback();
        }
      },
    );
  }
}
