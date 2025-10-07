import 'package:aptapp/colors.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RoundedIconButton extends StatelessWidget {
  final String title;
  final Function()? callback;
  final IconData? iconData;
  final double? fontSize;

  RoundedIconButton({Key? key, required this.title, this.callback, this.iconData, this.fontSize}) : super(key: key ?? Key(KEY_BUTTON_ADD));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(builder: (context, size) {
      String renderTitle = title;
      if (size.isMobile && renderTitle.length > 20) {
        renderTitle = renderTitle.replaceFirst(" ", "\n");
      }
      return ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          elevation: WidgetStateProperty.resolveWith((states) => 12),
          backgroundColor: WidgetStateProperty.resolveWith((states) => callback != null ? primarySwatch : infoIconColor),
        ),
        onPressed: callback,
        child: Container(
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(iconData ?? Icons.add, color: Colors.white, size: 25),
                    SizedBox(width: width * 0.005),
                    Flexible(
                      child: Text(
                        renderTitle.toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: fontSize ?? 14,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
