// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/training_plan_repository.dart';
import 'package:aptapp/exercises/training_plans_table.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:flutter/material.dart';

import '../exercises/exercise_categories.dart';
import '../widget/cancel_button.dart';

class StepOne extends StatefulWidget {
  final Function(ActivityType) planActivity;
  final Function(String) planTrainingPlan;
  final Function() onCancelled;
  final bool isTrainingPlan;

  StepOne({
    Key? key,
    required this.planActivity,
    required this.planTrainingPlan,
    required this.onCancelled,
    required this.isTrainingPlan,
  }) : super(key: key);

  @override
  _StepOneState createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  List<TrainingPlanOverviewDTO> trainingPlans = [];

  exerciseChosen(ExerciseType? type, bool isWorkout, bool isTrainingPlan) {
    if (isTrainingPlan) {
      TrainingPlanRepository().fetchTrainingPlans().then((value) {
        setState(() {
          trainingPlans = value ?? [];
        });
        if (trainingPlans.isEmpty) {
          widget.planTrainingPlan("");
        }
      });
    } else if (isWorkout) {
      widget.planActivity(ActivityType.WORKOUT);
    } else {
      switch (type) {
        case ExerciseType.ENDURANCE:
          widget.planActivity(ActivityType.ENDURANCE);
          break;
        case ExerciseType.HYPERTROPHY:
          widget.planActivity(ActivityType.HYPERTROPHY);
          break;
        case ExerciseType.INTERVAL:
          widget.planActivity(ActivityType.INTERVAL);
          break;
        case ExerciseType.STRENGTHENING:
          widget.planActivity(ActivityType.STRENGTHENING);
          break;
        case ExerciseType.OTHER:
          widget.planActivity(ActivityType.OTHER);
          break;
        case ExerciseType.TASK:
          widget.planActivity(ActivityType.TASK);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (trainingPlans.isEmpty)
          ExerciseCategories(
            optionCallback: exerciseChosen,
            hideTrainingPlan: widget.isTrainingPlan || !userRepository.showTrainingPlans,
            additionalOption: Container(
              decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                onTap: () => widget.planActivity(ActivityType.APPOINTMENT),
                leading: Icon(ActivityType.APPOINTMENT.iconData, color: Colors.black),
                title: Text(
                  ActivityType.APPOINTMENT.getTranslatedText(context),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        if (trainingPlans.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(4)),
              child: TrainingPlansTable(
                  autosizeColumns: true,
                  fetchedTrainingPlans: trainingPlans,
                  editTrainingPlan: (trainingPlan, _) => widget.planTrainingPlan(trainingPlan.id!)),
            ),
          ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (trainingPlans.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: TextButton(
                  child: Text(
                    context.i18n.back,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  onPressed: () {
                    setState(() {
                      trainingPlans = [];
                    });
                  },
                ),
              ),
            CancelButton(
              callback: widget.onCancelled,
              hasChanges: false,
            )
          ],
        ),
      ],
    );
  }
}
