import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FormFieldPadding extends StatelessWidget {
  final Widget child;
  FormFieldPadding({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return Padding(
          padding: EdgeInsets.only(
            top: size.isMobile ? 8 : 24,
            left: 0,
            // right: 8,
          ),
          child: child,
        );
      },
    );
  }
}
