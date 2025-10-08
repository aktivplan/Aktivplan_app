// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChooseButton extends StatelessWidget {
  final ActivityType activityType;
  final Function callback;

  ChooseButton({
    Key? key,
    required this.activityType,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(builder: (context, size) {
      return ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith((states) => secondaryColor[200])),
        child: Container(
          height: height * 0.05,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!size.isMobile)
                Text(
                  context.i18n.choose.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              Icon(Icons.keyboard_arrow_right, color: Colors.black),
            ],
          ),
        ),
        onPressed: () => callback(activityType),
      );
    });
  }
}
