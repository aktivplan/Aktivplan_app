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
import 'package:aptapp/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Option extends StatelessWidget {
  final ExerciseType? exerciseType;
  final bool isWorkout;
  final bool isTrainingPlan;
  final Function(ExerciseType?, bool, bool) onClick;

  Option({
    Key? key,
    this.exerciseType,
    this.isWorkout = false,
    this.isTrainingPlan = false,
    required this.onClick,
  }) : super(key: key);

  String getOptionName(BuildContext context) {
    if (isTrainingPlan) {
      return context.i18n.trainingPlan;
    }
    if (isWorkout) {
      return context.i18n.workout;
    }
    return exerciseType!.getTranslatedText(context);
  }

  IconData getIconData() {
    if (isTrainingPlan) {
      return MdiIcons.calendarRange;
    }
    if (isWorkout) {
      return ActivityType.WORKOUT.iconData;
    }
    return exerciseType!.iconData;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.black;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: () => this.onClick(exerciseType, isWorkout, isTrainingPlan),
        leading: Icon(getIconData(), color: color),
        title: Text(
          getOptionName(context),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: color,
        ),
      ),
    );
  }
}
