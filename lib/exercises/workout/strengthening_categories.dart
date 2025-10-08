// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/exercises/option.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StrengtheningCategories extends StatelessWidget {
  final Function(ExerciseType?, bool, bool) optionCallback;
  final Function() getHome;
  final double containerWidth;

  StrengtheningCategories({Key? key, required this.optionCallback, required this.getHome, required this.containerWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ResponsiveBuilder(builder: (context, size) {
      return Container(
        width: containerWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFieldPadding(
              child: BreadCrumb(
                items: [
                  BreadCrumbItem(
                    onTap: () => getHome(),
                    content: Text(
                      context.i18n.workout,
                      key: Key(KEY_WORKOUT_BREAD_CRUMB_WORKOUT),
                      style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                  BreadCrumbItem(
                    content: SelectableText(
                      context.i18n.exerciseWorkoutStrength,
                      style: getBreadCrumbStyle(context),
                    ),
                  )
                ],
                divider: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Option(
                  key: Key(KEY_WORKOUT_OPTION_STRENGTHENING),
                  exerciseType: ExerciseType.STRENGTHENING,
                  onClick: optionCallback,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Option(
                  key: Key(KEY_WORKOUT_OPTION_HYPERTROPHY),
                  exerciseType: ExerciseType.HYPERTROPHY,
                  onClick: optionCallback,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
