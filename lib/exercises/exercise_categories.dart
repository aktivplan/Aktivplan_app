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
import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ExerciseCategories extends StatelessWidget {
  final Function(ExerciseType?, bool, bool) optionCallback;
  final Widget? additionalOption;
  final bool hideTrainingPlan;

  ExerciseCategories({
    Key? key,
    required this.optionCallback,
    this.additionalOption,
    this.hideTrainingPlan = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double spacing = 15;
    double horizontalColSpacing = MediaQuery.of(context).size.width >= ResponsiveGridBreakpoints.value.sm ? spacing / 2 : 0;
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: spacing),
        ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              md: 6,
              child: Padding(
                padding: EdgeInsets.only(bottom: spacing, right: horizontalColSpacing),
                child: Option(
                  key: Key(KEY_EXERCISES_OVERVIEW_OPTION_ENDURANCE),
                  exerciseType: ExerciseType.ENDURANCE,
                  onClick: optionCallback,
                ),
              ),
            ),
            ResponsiveGridCol(
              md: 6,
              child: Padding(
                padding: EdgeInsets.only(bottom: spacing, left: horizontalColSpacing),
                child: Option(
                  key: Key(KEY_EXERCISES_OVERVIEW_OPTION_INTERVAL),
                  exerciseType: ExerciseType.INTERVAL,
                  onClick: optionCallback,
                ),
              ),
            ),
          ],
        ),
        ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              md: 6,
              child: Padding(
                padding: EdgeInsets.only(bottom: spacing, right: horizontalColSpacing),
                child: Option(
                  key: Key(KEY_EXERCISES_OVERVIEW_OPTION_STRENGTHENING),
                  exerciseType: ExerciseType.STRENGTHENING,
                  onClick: optionCallback,
                ),
              ),
            ),
            ResponsiveGridCol(
              md: 6,
              child: Padding(
                padding: EdgeInsets.only(bottom: spacing, left: horizontalColSpacing),
                child: Option(
                  key: Key(KEY_EXERCISES_OVERVIEW_OPTION_HYPERTROPHY),
                  exerciseType: ExerciseType.HYPERTROPHY,
                  onClick: optionCallback,
                ),
              ),
            ),
          ],
        ),
        Option(key: Key(KEY_EXERCISES_OVERVIEW_OPTION_WORKOUT), isWorkout: true, onClick: optionCallback),
        SizedBox(height: spacing),
        Option(
          key: Key(KEY_EXERCISES_OVERVIEW_OPTION_OTHER),
          exerciseType: ExerciseType.OTHER,
          onClick: optionCallback,
        ),
        if (additionalOption != null)
          Padding(
            padding: EdgeInsets.only(top: spacing),
            child: additionalOption,
          ),
        if (!hideTrainingPlan)
          Padding(
            padding: EdgeInsets.only(top: spacing),
            child: Option(key: Key(KEY_EXERCISES_OVERVIEW_OPTION_TRAINING_PLAN), isTrainingPlan: true, onClick: optionCallback),
          ),
        SizedBox(height: spacing),
        Option(key: Key(KEY_EXERCISES_OVERVIEW_OPTION_TASK), exerciseType: ExerciseType.TASK, onClick: optionCallback),
      ],
    );
  }
}
