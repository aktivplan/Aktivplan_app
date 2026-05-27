import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:aptapp/colors.dart';

Flushbar getSnackbar(String content, bool isMobile, BuildContext context,
    {bool error = false,
    bool warning = false,
    String buttonTitle = "",
    Duration duration = const Duration(seconds: 3),
    Function()? buttonAction,
    Function(FlushbarStatus?)? onStatusChanged}) {
  double width = MediaQuery.of(context).size.width;
  double snackWidth = !isMobile ? width / 3 : width;
  var color = secondaryColor[500];

  return Flushbar(
    messageText: Text(
      content,
      style: TextStyle(color: color),
    ),
    icon: error
        ? Icon(
            Icons.error,
            color: Colors.red,
          )
        : warning
            ? Icon(Icons.warning, color: Colors.orange)
            : Icon(
                Icons.info_outline,
                color: color,
              ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    maxWidth: snackWidth,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
    duration: duration,
    backgroundColor: Colors.white,
    borderColor: color,
    borderWidth: 2,
    onStatusChanged: onStatusChanged,
    mainButton: buttonTitle.isNotEmpty && buttonAction != null
        ? OutlinedButton(
            child: Text(
              buttonTitle,
              style: TextStyle(color: color),
            ),
            onPressed: buttonAction,
            style: ButtonStyle(
              side: WidgetStateProperty.all(
                BorderSide(color: color!),
              ),
            ),
          )
        : Container(),
  ); //..show(context);
}
