import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final Function() callback;
  final String confirmationTitle;
  final String confirmationText;
  final String? label;
  final String tooltipText;
  final bool disabled;

  DeleteButton(
      {Key? key,
      required this.callback,
      this.confirmationTitle = "",
      this.confirmationText = "",
      this.label,
      this.disabled = false,
      this.tooltipText = ""})
      : super(key: key);

  static showDeleteConfirmationDialog(BuildContext context, String confirmationTitle, String confirmationText, Function callback,
      {bool shortButtonTexts = false}) {
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
              child: FittedBox(fit: BoxFit.contain, child: Text(shortButtonTexts ? context.i18n.yes : context.i18n.deleteYes)),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                callback();
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
            child: FittedBox(fit: BoxFit.contain, child: Text(shortButtonTexts ? context.i18n.no : context.i18n.deleteNo)),
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
    Widget button = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => disabled ? infoIconColor : errorColor,
        ),
      ),
      child: FittedBox(fit: BoxFit.contain, child: Text(label ?? context.i18n.delete.toUpperCase())),
      onPressed: disabled ? null : () => showDeleteConfirmationDialog(context, confirmationTitle, confirmationText, callback),
    );

    if (tooltipText.isNotEmpty) {
      return Tooltip(
          padding: EdgeInsets.all(8.0),
          message: tooltipText,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium,
          child: button);
    }
    return button;
  }
}
