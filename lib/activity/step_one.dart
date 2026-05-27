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
  final InstitutionDTO? institution;

  StepOne({
    Key? key,
    required this.planActivity,
    required this.planTrainingPlan,
    required this.onCancelled,
    required this.isTrainingPlan,
    this.institution,
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

  List<Widget> getAdditionalOptions(bool isKlimafit) {
    List<Widget> toReturn = [];
    if (isKlimafit) {
      toReturn.add(getOptionForActivityType(ActivityType.PREDEFINED_ACTIVITY));
      toReturn.add(getOptionForActivityType(ActivityType.PREDEFINED_ACTIVE_MOBILITY));
    }
    toReturn.add(getOptionForActivityType(ActivityType.APPOINTMENT));
    return toReturn;
  }

  getOptionForActivityType(ActivityType activityType) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: () => widget.planActivity(activityType),
        leading: Icon(activityType.iconData, color: Colors.black),
        title: Text(
          activityType.getTranslatedText(context),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isTrainingPlan && widget.institution == null) {
      return Center(child: CircularProgressIndicator());
    }
    bool isKlimafit = widget.isTrainingPlan ? false : widget.institution!.institutionFocus!.isKlimafit();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (trainingPlans.isEmpty)
          ExerciseCategories(
            optionCallback: exerciseChosen,
            isKlimafit: isKlimafit,
            hideTrainingPlan: widget.isTrainingPlan || !userRepository.showTrainingPlans || isKlimafit,
            additionalOptions: getAdditionalOptions(isKlimafit),
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
