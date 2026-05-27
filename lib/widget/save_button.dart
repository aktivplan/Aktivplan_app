import 'package:aptapp/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SaveButton extends StatelessWidget {
  final String title;
  final Function callback;
  final bool disabled;
  final String tooltipText;

  SaveButton({Key? key, required this.title, required this.callback, this.disabled = false, this.tooltipText = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      Widget button = ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => disabled ? infoIconColor : primaryColor,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(title),
        ),
        onPressed: disabled
            ? null
            : () {
                callback();
              },
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
    });
  }
}
