// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'edit_strengthening_exercise.dart';
import 'strengthening_categories.dart';
import 'strengthening_exercises_overview.dart';
import 'workout_form.dart';

class ModifyWorkoutPage extends StatefulWidget {
  final Workout workout;
  final bool edit;

  ModifyWorkoutPage({
    Key? key,
    required this.workout,
    required this.edit,
  }) : super(key: key);

  @override
  _ModifyWorkoutPageState createState() => _ModifyWorkoutPageState();
}

class _ModifyWorkoutPageState extends State<ModifyWorkoutPage> {
  ExerciseBloc? exerciseBloc;
  ExerciseType? chosenExerciseType;
  var chosenExercise;
  bool isChosen = false;
  int step = 1;

  addStrengthExerciseType(exercise) {
    setState(() {
      widget.workout.exercises = [...widget.workout.exercises, exercise];
      widget.workout.exerciseDurationSeconds = null;
      step = 1;
    });
    exerciseBloc!.add(ResetExerciseBlocEvent());
  }

  chooseStrengthExerciseType() {
    setState(() {
      step = 2;
    });
  }

  getOneStrengthExerciseType(ExerciseType? type, bool isWorkout, bool isTrainingPlan) {
    setState(() {
      step = 3;
      chosenExerciseType = type;
    });
    if (chosenExerciseType == ExerciseType.HYPERTROPHY) {
      exerciseBloc!.add(FetchHypertrophyExerciseEvent());
    } else {
      exerciseBloc!.add(FetchStrengtheningExercisesEvent());
    }
  }

  editChosenStrengthBeforeAdd(exercise, bool alreadyChosen) {
    setState(() {
      step = 4;
      chosenExercise = exercise;
      isChosen = alreadyChosen;
    });
  }

  goHome() {
    setState(() {
      step = 1;
    });
  }

  goStepBack() {
    setState(() {
      step--;
    });
  }

  updateStrengthExerciseType(oldExerciseType, updatedExerciseType) {
    setState(() {
      int idx = widget.workout.exercises.indexOf(oldExerciseType);
      widget.workout.exercises[idx] = updatedExerciseType;
      step = 1;
    });
    exerciseBloc!.add(ResetExerciseBlocEvent());
  }

  @override
  void initState() {
    super.initState();
    exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(builder: (context, size) {
      double mobileWidth = width * 0.95;
      double tabletWidth = width * 0.9;
      double containerWidth = size.isMobile
          ? mobileWidth
          : size.isTablet
              ? tabletWidth
              : width * 0.65;
      return ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.only(top: height * 0.02),
            width: size.isMobile
                ? mobileWidth
                : size.isTablet
                    ? tabletWidth
                    : width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (step == 1)
                  FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    child: WorkoutForm(
                      workout: widget.workout,
                      exercises: widget.workout.exercises,
                      chooseStrengthExercise: chooseStrengthExerciseType,
                      editAlreadyChosenExercise: (exercise) => editChosenStrengthBeforeAdd(exercise, true),
                      isEditing: widget.edit,
                      containerWidth: containerWidth,
                    ),
                  ),
                if (step == 2)
                  FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    child: StrengtheningCategories(
                      getHome: goHome,
                      optionCallback: getOneStrengthExerciseType,
                      containerWidth: containerWidth,
                    ),
                  ),
                if (step == 3)
                  FittedBox(
                    alignment: Alignment.center,
                    child: StrengtheningExercisesOverview(
                      exerciseType: chosenExerciseType!,
                      getHome: goHome,
                      chooseStrengthExerciseType: chooseStrengthExerciseType,
                      editExerciseType: editChosenStrengthBeforeAdd,
                      containerWidth: containerWidth,
                    ),
                  ),
                if (step == 4)
                  FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    child: EditStrengtheningExercise(
                      exerciseType: chosenExerciseType!,
                      exercise: chosenExercise,
                      getHome: goHome,
                      goBack: goStepBack,
                      chooseStrengthExerciseType: chooseStrengthExerciseType,
                      getChosenTypeExerciseTypes: getOneStrengthExerciseType,
                      addStrengthExerciseType: addStrengthExerciseType,
                      editAlreadyChosen: isChosen,
                      updateStrengthExerciseType: updateStrengthExerciseType,
                      containerWidth: containerWidth,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
