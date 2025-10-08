// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/apt_beam_page.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/exercises/workout/workout_exercises_table.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../apt_scaffold.dart';
import '../authentication/bloc/authentication_bloc.dart';
import '../authentication/bloc/authentication_state.dart';
import 'edit_workout_exercises.dart';

class WorkoutTable extends StatefulWidget {
  final workout;
  final List fetchedExercises;
  final Function updateStepTwo;
  final Function back;
  final Function next;
  final Function(List<StrengtheningExercisePostDTO> exercises)? reorderExercises;
  final PatientGetDTO? patient;

  WorkoutTable({
    Key? key,
    required this.workout,
    required this.fetchedExercises,
    required this.updateStepTwo,
    required this.back,
    required this.next,
    this.reorderExercises,
    this.patient,
  }) : super(key: key);

  @override
  _WorkoutTableState createState() => _WorkoutTableState();
}

class _WorkoutTableState extends State<WorkoutTable> {
  bool isAscending = true;
  // TODO refactor this chaotic behavior...
  List<StrengtheningExercisePostDTO> workoutExercises = [];
  List<StrengtheningExercisePostDTO> initialExercises = [];

  addStrengthExercise(exercise) {
    setState(() {
      workoutExercises.add(exercise);
    });
    widget.workout.exercises = workoutExercises;
    widget.updateStepTwo(widget.workout);
  }

  updateStrengthExercise(oldExerciseType, updatedExerciseType) {
    setState(() {
      int idx = workoutExercises.indexOf(oldExerciseType);
      workoutExercises[idx] = updatedExerciseType;
      widget.workout.exercises = workoutExercises;
    });
    widget.updateStepTwo(widget.workout);
  }

  getPostDTO() {
    Map<String, dynamic> ex = {
      "exercises": widget.workout.exercises,
      "notes": widget.workout.notes,
    };
    var exercise = WorkoutPostDTO.fromJson(ex);
    return exercise;
  }

  deleteExercise(exercise) {
    setState(() {
      workoutExercises.remove(exercise);
    });
    widget.workout.exercises = workoutExercises;
    widget.updateStepTwo(widget.workout);
  }

  reorderExercises(oldIndex, newIndex) {
    setState(() {
      final row = workoutExercises.removeAt(oldIndex);
      workoutExercises.insert(newIndex, row);
    });
    widget.workout.exercises = workoutExercises;
    if (widget.reorderExercises != null) {
      widget.reorderExercises!(workoutExercises);
    }
  }

  addExercise() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => AptScaffold(
          body: EditWorkoutExercise(
            exerciseType: ExerciseType.STRENGTHENING,
            addExercise: addStrengthExercise,
            updateExercise: updateStrengthExercise,
            patient: widget.patient,
          ),
          drawer: AptBeamPage.getDrawerForState(state, context)!,
        ),
      );
    }));
  }

  editExercise(exercise) {
    BlocProvider.of<ExerciseBloc>(context).add(ResetExerciseBlocEvent());
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => AptScaffold(
          body: EditWorkoutExercise(
            exercise: exercise,
            exerciseType: exercise.type ?? ExerciseType.STRENGTHENING,
            addExercise: addStrengthExercise,
            updateExercise: updateStrengthExercise,
            pageState: 2,
            patient: widget.patient,
          ),
          drawer: AptBeamPage.getDrawerForState(state, context)!,
        ),
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    workoutExercises = [...widget.fetchedExercises];
    initialExercises = List<StrengtheningExercisePostDTO>.from(widget.fetchedExercises);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (initialExercises != widget.fetchedExercises) {
      initialExercises = List<StrengtheningExercisePostDTO>.from(widget.fetchedExercises);
      workoutExercises = [...widget.fetchedExercises];
    }

    return ResponsiveBuilder(builder: (context, size) {
      double widthForContainer = size.isMobile
          ? width * 0.95
          : size.isTablet
              ? width * 0.9
              : width * 0.65;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    width: widthForContainer,
                    height: height * 0.35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: datatableBorderColor,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (workoutExercises.isEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: widthForContainer * 0.95,
                                      height: height * 0.3,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SelectableText(
                                            context.i18n.noWorkoutExercise,
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: lightTextColor,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (workoutExercises.isNotEmpty)
                                Expanded(
                                  child: WorkoutExercisesTable(
                                    exercises: workoutExercises,
                                    editExercise: editExercise,
                                    deleteExercise: deleteExercise,
                                    reorderExercises: reorderExercises,
                                    parentWidth: widthForContainer,
                                  ),
                                )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.06,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -24,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedIconButton(
                      title: context.i18n.addExercise,
                      callback: addExercise,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
        ],
      );
    });
  }
}
