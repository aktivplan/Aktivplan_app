// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/workout_table.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/exercises/training_plan/modify_training_plan_page.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widgets/back_next_buttons.dart';

class StepTwo extends StatefulWidget {
  final PatientGetDTO? patient;
  final plannedActivity;
  final ActivityType activityType;
  final bool isTrainingPlan;
  final String trainingPlanId;
  final Function() back;
  final Function(dynamic) next;
  final Function() onCancelled;

  StepTwo({
    Key? key,
    this.patient,
    required this.plannedActivity,
    required this.activityType,
    required this.back,
    required this.next,
    required this.onCancelled,
    this.isTrainingPlan = false,
    this.trainingPlanId = "",
  }) : super(key: key);

  @override
  _StepTwoState createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  final _exerciseTwoFormKey = GlobalKey<FormState>();
  final exerciseNameController = TextEditingController();
  final exerciseNameEnglishController = TextEditingController();
  var plannedActivity;
  //ENDURANCE, INTERVAL
  final durationController = TextEditingController();
  final intensityStartController = TextEditingController();
  final intensityEndController = TextEditingController();
  final heartRateLowerLimitController = TextEditingController();
  final heartRateUpperLimitController = TextEditingController();
  //INTERVAL
  final recoveryDurationController = TextEditingController();
  final recoveryStartController = TextEditingController();
  final recoveryEndController = TextEditingController();
  final recoveryHeartRateLowerLimitController = TextEditingController();
  final recoveryHeartRateUpperLimitController = TextEditingController();
  final intervalCountController = TextEditingController();
  //STRENGTHENING
  final repeatCountController = TextEditingController();
  final repeatSetController = TextEditingController();
  final breakBetweenSetsController = TextEditingController();
  final weightController = TextEditingController();
  final youTubeUrlController = TextEditingController();
  final youTubeUrlEnglishController = TextEditingController();
  final hintController = TextEditingController();
  final hintEnglishController = TextEditingController();
  //APPOINTMENT
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final detailsController = TextEditingController();
  bool needsEquipment = false;

  List<StrengtheningExerciseMuscleGroup> muscleGroups = [];
  //Dropdown values
  List exercises = [];

  double inputSpacing = 15;

  String selectedIntensityDurationUnit = "min";
  String selectedRecoveryDurationUnit = "min";

  List fetchedWorkouts = [];
  List<StrengtheningExercisePostDTO> workoutExercises = [];

  bool hasChanges = false;

  FocusNode dropDownExerciseDeFocusNode = FocusNode();
  FocusNode dropDownExerciseEnFocusNode = FocusNode();
  FocusNode dropDownWorkoutDeFocusNode = FocusNode();
  FocusNode dropDownWorkoutEnFocusNode = FocusNode();

  buildExerciseType() {
    var exercise;
    if (widget.activityType == ActivityType.ENDURANCE) {
      exercise = EnduranceExercisePostDTO(
          exerciseDurationSeconds: (int.tryParse(durationController.text) ?? 0) * MINUTES_TO_SECONDS,
          exerciseTrainingHeartRateLowerLimit: int.tryParse(heartRateLowerLimitController.text),
          exerciseTrainingHeartRateUpperLimit: int.tryParse(heartRateUpperLimitController.text),
          exerciseIntensityPercentageStart: int.tryParse(intensityStartController.text),
          exerciseIntensityPercentageEnd: int.tryParse(intensityEndController.text),
          hint: getTranslationObjectFromController(hintController, hintEnglishController),
          name: getTranslationObjectFromController(exerciseNameController, exerciseNameEnglishController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController));
      return exercise;
    } else if (widget.activityType == ActivityType.INTERVAL) {
      exercise = IntervalExercisePostDTO(
        exerciseDurationSeconds: (int.tryParse(durationController.text) ?? 0) * (selectedIntensityDurationUnit == "min" ? MINUTES_TO_SECONDS : 1),
        exerciseTrainingHeartRateLowerLimit: int.tryParse(heartRateLowerLimitController.text),
        exerciseTrainingHeartRateUpperLimit: int.tryParse(heartRateUpperLimitController.text),
        exerciseIntensityPercentageStart: int.tryParse(intensityStartController.text),
        exerciseIntensityPercentageEnd: int.tryParse(intensityEndController.text),
        intervalCount: int.tryParse(intervalCountController.text) ?? 0,
        recoveryDurationSeconds:
            (int.tryParse(recoveryDurationController.text) ?? 0) * (selectedRecoveryDurationUnit == "min" ? MINUTES_TO_SECONDS : 1),
        recoveryTrainingHeartRateLowerLimit: int.tryParse(recoveryHeartRateLowerLimitController.text),
        recoveryTrainingHeartRateUpperLimit: int.tryParse(recoveryHeartRateUpperLimitController.text),
        recoveryIntensityPercentageStart: int.tryParse(recoveryStartController.text),
        recoveryIntensityPercentageEnd: int.tryParse(recoveryEndController.text),
        selectedExerciseSeconds: selectedIntensityDurationUnit == "sec",
        selectedRecoverySeconds: selectedRecoveryDurationUnit == "sec",
        hint: getTranslationObjectFromController(hintController, hintEnglishController),
        name: getTranslationObjectFromController(exerciseNameController, exerciseNameEnglishController),
        youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
      );
      return exercise;
    } else if (widget.activityType == ActivityType.STRENGTHENING || widget.activityType == ActivityType.HYPERTROPHY) {
      exercise = StrengtheningExercisePostDTO(
        exerciseDurationSeconds: int.tryParse(durationController.text) ?? 0,
        exerciseTrainingHeartRateLowerLimit: int.tryParse(heartRateLowerLimitController.text),
        exerciseTrainingHeartRateUpperLimit: int.tryParse(heartRateUpperLimitController.text),
        exerciseRepeatCount: int.tryParse(repeatCountController.text) ?? 0,
        exerciseRepeatSets: int.tryParse(repeatSetController.text) ?? 0,
        exerciseBreakBetweenSetsDurationSeconds: int.tryParse(breakBetweenSetsController.text) ?? 0,
        hasRepeatCount: repeatCountController.text.isNotEmpty,
        muscleGroups: muscleGroups,
        needsEquipment: needsEquipment,
        weight: int.tryParse(weightController.text) ?? 0,
        hint: getTranslationObjectFromController(hintController, hintEnglishController),
        name: getTranslationObjectFromController(exerciseNameController, exerciseNameEnglishController),
        youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
      );
      return exercise;
    } else if (widget.activityType == ActivityType.WORKOUT) {
      List exercises = [];
      if (plannedActivity != null) {
        plannedActivity.exercises.forEach((exercise) {
          exercises.add(getMapsOfExerciseTypes(exercise));
        });
      }
      Map<String, dynamic> ex = {
        "exercises": exercises,
        "name": getTranslationObjectFromController(exerciseNameController, exerciseNameEnglishController),
        "exerciseDurationSeconds": (int.tryParse(durationController.text) ?? 0) * MINUTES_TO_SECONDS,
        "youTubeUrl": getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
        "notes": getTranslationObjectFromController(hintController, hintEnglishController),
      };
      exercise = WorkoutPostDTO.fromJson(ex);
      return exercise;
    } else if (widget.activityType == ActivityType.OTHER) {
      exercise = OtherExercisePostDTO(
        exerciseDurationSeconds: (int.tryParse(durationController.text) ?? 0) * MINUTES_TO_SECONDS,
        exerciseTrainingHeartRateLowerLimit: int.tryParse(heartRateLowerLimitController.text),
        exerciseTrainingHeartRateUpperLimit: int.tryParse(heartRateUpperLimitController.text),
        hint: getTranslationObjectFromController(hintController, hintEnglishController),
        name: getTranslationObjectFromController(exerciseNameController, exerciseNameEnglishController),
        youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
      );
      return exercise;
    } else if (widget.activityType == ActivityType.APPOINTMENT) {
      return AppointmentPostDTO(name: nameController.text, location: locationController.text, details: detailsController.text);
    } else if (widget.activityType == ActivityType.TASK) {
      return TaskPostDTO(
          name: getTranslationObjectFromController(exerciseNameController, exerciseNameEnglishController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
          hint: getTranslationObjectFromController(hintController, hintEnglishController));
    }
  }

  getMapsOfExerciseTypes(exercise) {
    Map<String, dynamic> ex = {
      "exerciseDurationSeconds": exercise.exerciseDurationSeconds,
      "exerciseIntensityPercentageEnd": exercise.exerciseIntensityPercentageEnd,
      "exerciseIntensityPercentageStart": exercise.exerciseIntensityPercentageStart,
      "exerciseTrainingHeartRateLowerLimit": exercise.exerciseTrainingHeartRateLowerLimit,
      "exerciseTrainingHeartRateUpperLimit": exercise.exerciseTrainingHeartRateUpperLimit,
      "exerciseBreakBetweenSetsDurationSeconds": exercise.exerciseBreakBetweenSetsDurationSeconds,
      "exerciseRepeatCount": exercise.exerciseRepeatCount,
      "exerciseRepeatSets": exercise.exerciseRepeatSets,
      "hasRepeatCount": exercise.exerciseRepeatCount != 0,
      "hint": exercise.hint,
      "muscleGroups": exercise.muscleGroups,
      "type": exercise.type.value,
      "name": exercise.name,
      "needsEquipment": exercise.needsEquipment,
      "weight": exercise.weight,
      "youTubeUrl": exercise.youTubeUrl
    };
    return ex;
  }

  updateStepTwo(exercise) {
    setState(() {
      plannedActivity = exercise;
      durationController.text = "";
      if (plannedActivity.exercises != null) {
        workoutExercises = plannedActivity.exercises;
        if (plannedActivity.exercises.isNotEmpty) {
          durationController.text = getWorkoutExercisesDurationInMinutes(plannedActivity.exercises).toString();
        }
      }
    });
  }

  validate() {
    if (_exerciseTwoFormKey.currentState!.validate()) {
      var exercise = buildExerciseType();
      widget.next(exercise);
    }
  }

  checkForEdit(bool overrideHeartRate) {
    if (plannedActivity != null && !widget.isTrainingPlan) {
      if (widget.activityType == ActivityType.APPOINTMENT) {
        nameController.text = plannedActivity.name;
        locationController.text = plannedActivity.location;
        detailsController.text = plannedActivity.details;
        return;
      }

      initTextEditingControllerFromTranslationObject(plannedActivity.name, exerciseNameController, exerciseNameEnglishController);
      initTextEditingControllerFromTranslationObject(plannedActivity?.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);

      if (widget.activityType != ActivityType.WORKOUT) {
        initTextEditingControllerFromTranslationObject(plannedActivity?.hint, hintController, hintEnglishController);
        if (widget.patient != null) {
          int maximumHeartRate = widget.patient?.maximumHeartRate ?? 0;
          if (maximumHeartRate > 0 &&
              plannedActivity.exerciseIntensityPercentageStart != null &&
              plannedActivity.exerciseIntensityPercentageEnd != null &&
              (plannedActivity.exerciseTrainingHeartRateLowerLimit == null || overrideHeartRate)) {
            heartRateLowerLimitController.text =
                (maximumHeartRate * (plannedActivity.exerciseIntensityPercentageStart / TO_PERCENT)).truncate().toString();
          } else {
            heartRateLowerLimitController.text = plannedActivity.exerciseTrainingHeartRateLowerLimit?.toString() ?? "";
          }
          if (maximumHeartRate > 0 &&
              plannedActivity.exerciseIntensityPercentageStart != null &&
              plannedActivity.exerciseIntensityPercentageEnd != null &&
              (plannedActivity.exerciseTrainingHeartRateUpperLimit == null || overrideHeartRate)) {
            heartRateUpperLimitController.text =
                (maximumHeartRate * (plannedActivity.exerciseIntensityPercentageEnd / TO_PERCENT)).truncate().toString();
          } else {
            heartRateUpperLimitController.text = plannedActivity.exerciseTrainingHeartRateUpperLimit?.toString() ?? "";
          }
        } else {
          intensityStartController.text =
              plannedActivity.exerciseIntensityPercentageStart != null ? plannedActivity.exerciseIntensityPercentageStart.toString() : "";
          intensityEndController.text =
              plannedActivity.exerciseIntensityPercentageEnd != null ? plannedActivity.exerciseIntensityPercentageEnd.toString() : "";
        }
      }

      if (widget.activityType == ActivityType.ENDURANCE || widget.activityType == ActivityType.OTHER) {
        durationController.text = Duration(seconds: plannedActivity?.exerciseDurationSeconds).inMinutes.toString();
      } else if (widget.activityType == ActivityType.INTERVAL) {
        if (plannedActivity.selectedExerciseSeconds ?? false) {
          durationController.text = plannedActivity?.exerciseDurationSeconds.toString() ?? "";
          setState(() {
            selectedIntensityDurationUnit = "sec";
          });
        } else {
          durationController.text = Duration(seconds: plannedActivity?.exerciseDurationSeconds).inMinutes.toString();
          setState(() {
            selectedIntensityDurationUnit = "min";
          });
        }

        if (plannedActivity.selectedRecoverySeconds ?? false) {
          recoveryDurationController.text = plannedActivity?.recoveryDurationSeconds.toString() ?? "";
          setState(() {
            selectedRecoveryDurationUnit = "sec";
          });
        } else {
          recoveryDurationController.text = Duration(seconds: plannedActivity?.recoveryDurationSeconds).inMinutes.toString();
          setState(() {
            selectedRecoveryDurationUnit = "min";
          });
        }

        if (widget.patient != null) {
          int maximumHeartRate = widget.patient?.maximumHeartRate ?? 0;
          if (maximumHeartRate > 0 &&
              plannedActivity.recoveryIntensityPercentageStart != null &&
              plannedActivity.recoveryIntensityPercentageEnd != null &&
              (plannedActivity.recoveryTrainingHeartRateLowerLimit == null || overrideHeartRate)) {
            recoveryHeartRateLowerLimitController.text =
                (maximumHeartRate * (plannedActivity.recoveryIntensityPercentageStart / TO_PERCENT)).truncate().toString();
          } else {
            recoveryHeartRateLowerLimitController.text = plannedActivity.recoveryTrainingHeartRateLowerLimit?.toString() ?? "";
          }

          if (maximumHeartRate > 0 &&
              plannedActivity.recoveryIntensityPercentageStart != null &&
              plannedActivity.recoveryIntensityPercentageEnd != null &&
              (plannedActivity.recoveryTrainingHeartRateUpperLimit == null || overrideHeartRate)) {
            recoveryHeartRateUpperLimitController.text =
                (maximumHeartRate * (plannedActivity.recoveryIntensityPercentageEnd / TO_PERCENT)).truncate().toString();
          } else {
            recoveryHeartRateUpperLimitController.text = plannedActivity.recoveryTrainingHeartRateUpperLimit?.toString() ?? "";
          }
        } else {
          recoveryStartController.text = plannedActivity.recoveryIntensityPercentageStart?.toString() ?? "";
          recoveryEndController.text = plannedActivity.recoveryIntensityPercentageEnd?.toString() ?? "";
        }

        intervalCountController.text = plannedActivity?.intervalCount.toString() ?? "";
      } else if (widget.activityType == ActivityType.STRENGTHENING || widget.activityType == ActivityType.HYPERTROPHY) {
        durationController.text =
            plannedActivity?.exerciseDurationSeconds != 0 ? Duration(seconds: plannedActivity?.exerciseDurationSeconds).inSeconds.toString() : "";
        repeatCountController.text = (plannedActivity?.exerciseRepeatCount ?? 0) != 0 ? plannedActivity!.exerciseRepeatCount!.toString() : "";
        repeatSetController.text = plannedActivity?.exerciseRepeatSets.toString() ?? "";
        if (plannedActivity?.exerciseBreakBetweenSetsDurationSeconds != null) {
          breakBetweenSetsController.text = plannedActivity.exerciseBreakBetweenSetsDurationSeconds.toString();
        } else {
          breakBetweenSetsController.text = "";
        }
        String weightString = plannedActivity?.weight.toString() ?? "";
        weightController.text = weightString == "0" ? "" : weightString;
        needsEquipment = plannedActivity?.needsEquipment;
        muscleGroups = plannedActivity?.muscleGroups;
      } else if (widget.activityType == ActivityType.WORKOUT) {
        initTextEditingControllerFromTranslationObject(plannedActivity?.notes, hintController, hintEnglishController);
        setState(() {
          workoutExercises = plannedActivity?.exercises;
          if (widget.patient != null) {
            workoutExercises.forEach((exercise) {
              if (exercise.exerciseIntensityPercentageStart != null && exercise.exerciseIntensityPercentageEnd != null) {
                if (exercise.exerciseTrainingHeartRateLowerLimit == null || overrideHeartRate) {
                  exercise.exerciseTrainingHeartRateLowerLimit =
                      ((widget.patient?.maximumHeartRate ?? 0) * (exercise.exerciseIntensityPercentageStart! / TO_PERCENT)).truncate();
                }
                if (exercise.exerciseTrainingHeartRateUpperLimit == null || overrideHeartRate) {
                  exercise.exerciseTrainingHeartRateUpperLimit =
                      ((widget.patient?.maximumHeartRate ?? 0) * (exercise.exerciseIntensityPercentageEnd! / TO_PERCENT)).truncate();
                }
              }
            });
          }
          if (plannedActivity.exerciseDurationSeconds != null) {
            durationController.text = Duration(seconds: plannedActivity.exerciseDurationSeconds).inMinutes.toString();
          } else {
            durationController.text = workoutExercises.isNotEmpty ? getWorkoutExercisesDurationInMinutes(workoutExercises).toString() : "";
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.activityType != ActivityType.WORKOUT && widget.activityType != ActivityType.APPOINTMENT && !widget.isTrainingPlan) {
      BlocProvider.of<ExerciseBloc>(context).addTypeEvent(ExerciseType.fromJson(widget.activityType.value)!);
    }
    if (widget.activityType == ActivityType.WORKOUT) {
      BlocProvider.of<ExerciseBloc>(context)..add(FetchWorkoutExerciseEvent());
    }
    plannedActivity = widget.plannedActivity;
    checkForEdit(false);
  }

  @override
  void dispose() {
    durationController.dispose();
    heartRateLowerLimitController.dispose();
    heartRateUpperLimitController.dispose();
    recoveryDurationController.dispose();
    recoveryHeartRateLowerLimitController.dispose();
    recoveryHeartRateUpperLimitController.dispose();
    intervalCountController.dispose();
    repeatCountController.dispose();
    repeatSetController.dispose();
    breakBetweenSetsController.dispose();
    weightController.dispose();
    super.dispose();
  }

  toggleMuscleGroup(StrengtheningExerciseMuscleGroup muscle) {
    setState(() {
      if (muscleGroups.contains(muscle)) {
        muscleGroups = [...muscleGroups];
        muscleGroups.remove(muscle);
      } else {
        muscleGroups = [...muscleGroups, muscle];
      }
    });
  }

  setExercisesBasedOnState(ExerciseState state) {
    exercises = [];
    if (state is FetchedIntervalExerciseState) {
      exercises.addAll(state.exercises);
    } else if (state is FetchedEnduranceExercisesState) {
      exercises.addAll(state.exercises);
    } else if (state is FetchedStrengtheningExercisesState) {
      exercises.addAll(state.exercises);
    } else if (state is FetchedHypertrophyExerciseState) {
      exercises.addAll(state.exercises);
    } else if (state is FetchedOtherExerciseState) {
      exercises.addAll(state.exercises);
    } else if (state is FetchedTasksState) {
      exercises.addAll(state.tasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (widget.isTrainingPlan) {
      return ModifyTrainingPlanPage(
        back: widget.back,
        next: widget.next,
        onCancelled: widget.onCancelled,
        trainingPlanToEdit: plannedActivity,
        trainingPlanId: widget.trainingPlanId,
      );
    }

    return ResponsiveBuilder(builder: (context, size) {
      double widthForContainer = size.isMobile
          ? width * 0.95
          : size.isTablet
              ? width * 0.9
              : width * 0.65;
      double intensityWidth = size.isMobile
          ? width * 0.4
          : size.isTablet
              ? width * 0.38
              : width * 0.28;
      double strengthWidth = size.isMobile
          ? width * 0.25
          : size.isTablet
              ? width * 0.15
              : width * 0.1;
      double muscleBoxSize = size.isMobile ? widthForContainer / 2 : widthForContainer / 3;
      return Container(
        child: Form(
          key: _exerciseTwoFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.activityType != ActivityType.APPOINTMENT)
                Padding(
                  padding: EdgeInsets.only(top: inputSpacing),
                  child: LanguageTabs(germanFields: [
                    Padding(
                      padding: EdgeInsets.only(top: inputSpacing),
                      child: BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
                        if (widget.activityType != ActivityType.WORKOUT &&
                            (state is FetchedIntervalExerciseState ||
                                state is FetchedEnduranceExercisesState ||
                                state is FetchedStrengtheningExercisesState ||
                                state is FetchedHypertrophyExerciseState ||
                                state is FetchedOtherExerciseState ||
                                state is FetchedTasksState)) {
                          setExercisesBasedOnState(state);
                          return TypeAheadField(
                            controller: exerciseNameController,
                            focusNode: dropDownExerciseDeFocusNode,
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name['DE'] ?? ''),
                              );
                            },
                            onSelected: (suggestion) {
                              dropDownExerciseDeFocusNode.unfocus();
                              exerciseNameController.text = suggestion.name['DE'] ?? '';
                              setState(() {
                                plannedActivity = suggestion;
                                this.hasChanges = true;
                              });
                              checkForEdit(true);
                            },
                            suggestionsCallback: (pattern) {
                              final toReturn =
                                  exercises.where((element) => (element.name['DE'] ?? '').toLowerCase().contains(pattern.toLowerCase())).toList();
                              return toReturn.isEmpty ? null : toReturn;
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: exerciseNameController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: widget.activityType.getExerciseText(context),
                                  labelText: widget.activityType.getExerciseText(context) + " *",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: datatableBorderColor,
                                    ),

                                  ),
                                ),
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return context.i18n.validationNotEmpty;
                                  }
                                  return null;
                                },
                              );
                            },
                          );
                        } else if (widget.activityType == ActivityType.WORKOUT || state is FetchedWorkoutExerciseState) {
                          if (state is FetchedWorkoutExerciseState) {
                            exercises = [];
                            exercises.addAll(state.workouts);
                          }
                          return TypeAheadField(
                            controller: exerciseNameController,
                            focusNode: dropDownWorkoutDeFocusNode,
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name['DE'] ?? ''),
                              );
                            },
                            onSelected: (suggestion) {
                              dropDownWorkoutDeFocusNode.unfocus();
                              exerciseNameController.text = suggestion.name['DE'] ?? '';
                              setState(() {
                                plannedActivity = suggestion;
                                workoutExercises = plannedActivity?.exercises;
                                this.hasChanges = true;
                              });
                              checkForEdit(true);
                            },
                            suggestionsCallback: (pattern) {
                              final toReturn =
                                  exercises.where((element) => (element.name['DE'] ?? '').toLowerCase().contains(pattern.toLowerCase())).toList();
                              return toReturn.isEmpty ? null : toReturn;
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: exerciseNameController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: context.i18n.workout,
                                  labelText: context.i18n.workout + " *",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: datatableBorderColor,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return context.i18n.validationNotEmpty;
                                  }
                                  return null;
                                },
                              );
                            },
                          );
                        }
                        return Container();
                      }),
                    ),
                    SizedBox(height: inputSpacing),
                    // ENDURANCE
                    if (widget.activityType == ActivityType.ENDURANCE || widget.activityType == ActivityType.OTHER)
                      _buildEndurance(intensityWidth, height, width, size.isTablet, size.isMobile),
                    // INTERVALL
                    if (widget.activityType == ActivityType.INTERVAL)
                      _buildInterval(intensityWidth, height, width, size.isTablet, size.isMobile, widthForContainer),
                    // STRENGTHENING
                    if (widget.activityType == ActivityType.STRENGTHENING || widget.activityType == ActivityType.HYPERTROPHY)
                      _buildStrengthening(intensityWidth, strengthWidth, height, width, size.isTablet, size.isMobile, muscleBoxSize),
                    if (widget.activityType == ActivityType.TASK) _buildTask(),
                    if (widget.activityType == ActivityType.WORKOUT)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            controller: youTubeUrlController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: context.i18n.youTubeUrl,
                              labelText: context.i18n.youTubeUrl,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: inputSpacing,
                          ),
                          WorkoutTable(
                            workout: plannedActivity ?? WorkoutPostDTO.fromJson({"exercises": workoutExercises}),
                            fetchedExercises: workoutExercises,
                            updateStepTwo: updateStepTwo,
                            back: widget.back,
                            next: validate,
                            reorderExercises: (exercises) => setState(() {
                              workoutExercises = exercises;
                              this.hasChanges = true;
                            }),
                            patient: widget.patient,
                          ),
                          TextFormField(
                            controller: durationController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return context.i18n.validationNotEmpty;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintText: context.i18n.exerciseDurationMinutes,
                              labelText: context.i18n.exerciseDurationMinutes + " *",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: infoIconColor,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: SelectableText(
                                    context.i18n.workoutDurationHint,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.1, color: infoIconColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: inputSpacing,
                          ),
                          TextFormField(
                            textAlign: TextAlign.start,
                            controller: hintController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: context.i18n.notes,
                              hintMaxLines: 1,
                              labelText: context.i18n.notes,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: inputSpacing,
                    ),
                    BackNextButtons(
                      back: widget.back,
                      next: validate,
                      nextButtonTitle: context.i18n.next,
                      hasChanges: this.hasChanges,
                      onCancelled: widget.onCancelled,
                    ),
                    SizedBox(
                      height: inputSpacing,
                    ),
                  ], englishFields: [
                    Padding(
                      padding: EdgeInsets.only(top: inputSpacing),
                      child: BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
                        if (state is FetchedIntervalExerciseState ||
                            state is FetchedEnduranceExercisesState ||
                            state is FetchedStrengtheningExercisesState ||
                            state is FetchedHypertrophyExerciseState ||
                            state is FetchedOtherExerciseState ||
                            state is FetchedTasksState) {
                          setExercisesBasedOnState(state);
                          return TypeAheadField(
                            controller: exerciseNameEnglishController,
                            focusNode: dropDownExerciseEnFocusNode,
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name['EN'] ?? ''),
                              );
                            },
                            onSelected: (suggestion) {
                              dropDownExerciseEnFocusNode.unfocus();
                              setState(() {
                                this.exerciseNameController.text = suggestion.name['EN'] ?? '';
                                plannedActivity = suggestion;
                                this.hasChanges = true;
                              });
                              checkForEdit(true);
                            },
                            suggestionsCallback: (pattern) {
                              final toReturn =
                                  exercises.where((element) => (element.name['EN'] ?? '').toLowerCase().contains(pattern.toLowerCase())).toList();
                              return toReturn.isEmpty ? null : toReturn;
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: exerciseNameEnglishController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: widget.activityType.getExerciseText(context) + " ${context.i18n.englishTranslationNote}",
                                  labelText: widget.activityType.getExerciseText(context) + " ${context.i18n.englishTranslationNote}",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: datatableBorderColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is FetchedWorkoutExerciseState) {
                          exercises = [];
                          exercises.addAll(state.workouts);
                          return TypeAheadField(
                            controller: exerciseNameEnglishController,
                            focusNode: dropDownWorkoutEnFocusNode,
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.name['EN'] ?? ''),
                              );
                            },
                            onSelected: (suggestion) {
                              dropDownWorkoutEnFocusNode.unfocus();
                              exerciseNameController.text = suggestion.name['EN'] ?? '';
                              setState(() {
                                plannedActivity = suggestion;
                                workoutExercises = plannedActivity?.exercises;
                                if (plannedActivity.exerciseDurationSeconds != null) {
                                  durationController.text = Duration(seconds: plannedActivity.exerciseDurationSeconds).inMinutes.toString();
                                } else {
                                  durationController.text =
                                      workoutExercises.isNotEmpty ? getWorkoutExercisesDurationInMinutes(workoutExercises).toString() : "";
                                }
                                this.hasChanges = true;
                              });
                              checkForEdit(true);
                            },
                            suggestionsCallback: (pattern) {
                              final toReturn =
                                  exercises.where((element) => (element.name['EN'] ?? '').toLowerCase().contains(pattern.toLowerCase())).toList();
                              return toReturn.isEmpty ? null : toReturn;
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: exerciseNameEnglishController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: context.i18n.workout + " ${context.i18n.englishTranslationNote}",
                                  labelText: context.i18n.workout + " ${context.i18n.englishTranslationNote}",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: datatableBorderColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      }),
                    ),
                    SizedBox(
                      height: inputSpacing,
                    ),
                    TextFormField(
                      textAlign: TextAlign.start,
                      controller: youTubeUrlEnglishController,
                      onChanged: (value) => {
                        setState(() {
                          this.hasChanges = true;
                        })
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: context.i18n.youTubeUrlEnglish,
                        labelText: context.i18n.youTubeUrlEnglish,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: datatableBorderColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: inputSpacing,
                    ),
                    TextFormField(
                      textAlign: TextAlign.start,
                      controller: hintEnglishController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      onChanged: (value) => {
                        setState(() {
                          this.hasChanges = true;
                        })
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: context.i18n.notesEnglish,
                        hintMaxLines: 1,
                        labelText: context.i18n.notesEnglish,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: datatableBorderColor,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              if (widget.activityType == ActivityType.APPOINTMENT) _buildAppointment(),
            ],
          ),
        ),
      );
    });
  }

  _buildStrengthening(intensityWidth, strengthWidth, height, width, isTablet, isMobile, muscleBoxSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile && !isTablet && widget.patient != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Belastung
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: heartRateLowerLimitController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                  validator: (value) {
                    if ((value ?? "").isEmpty) {
                      return null;
                    } else if (heartRateUpperLimitController.value.text.isNotEmpty &&
                        int.parse(heartRateUpperLimitController.value.text) < int.parse(value!)) {
                      return context.i18n.validationInvalidValue;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                    labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.remove),
                  ],
                ),
              ),
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: heartRateUpperLimitController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                  validator: (value) {
                    if ((value ?? "").isEmpty) {
                      return null;
                    } else if (heartRateLowerLimitController.value.text.isNotEmpty &&
                        int.parse(heartRateLowerLimitController.value.text) > int.parse(value!)) {
                      return context.i18n.validationInvalidValue;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                    labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (!isMobile && !isTablet && widget.patient == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Belastung
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: intensityStartController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                  validator: (value) {
                    if ((value ?? "").isEmpty) {
                      return null;
                    } else if (int.parse(value!) > 100) {
                      return context.i18n.validationInvalidValue;
                    } else if (intensityEndController.value.text.isNotEmpty && int.parse(intensityEndController.value.text) < int.parse(value)) {
                      return context.i18n.validationInvalidValue;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintText: context.i18n.exerciseIntensity,
                    labelText: context.i18n.exerciseIntensity,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Icon(Icons.remove),
                  ],
                ),
              ),
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: intensityEndController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                  validator: (value) {
                    if ((value ?? "").isEmpty) {
                      return null;
                    } else if (int.parse(value!) > 100) {
                      return context.i18n.validationInvalidValue;
                    } else if (intensityStartController.value.text.isNotEmpty && int.parse(intensityStartController.value.text) > int.parse(value)) {
                      return context.i18n.validationInvalidValue;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    hintText: context.i18n.exerciseIntensity,
                    labelText: context.i18n.exerciseIntensity,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        if ((isMobile || isTablet) && widget.patient != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Belastung
              TextFormField(
                controller: heartRateLowerLimitController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (heartRateUpperLimitController.value.text.isNotEmpty &&
                      int.parse(heartRateUpperLimitController.value.text) < int.parse(value!)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                  labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(context.i18n.till),
                  ],
                ),
              ),
              TextFormField(
                controller: heartRateUpperLimitController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (heartRateLowerLimitController.value.text.isNotEmpty &&
                      int.parse(heartRateLowerLimitController.value.text) > int.parse(value!)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                  labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
            ],
          ),
        if ((isMobile || isTablet) && widget.patient == null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Belastung
              TextFormField(
                controller: intensityStartController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (int.parse(value!) > 100) {
                    return context.i18n.validationInvalidValue;
                  } else if (intensityEndController.value.text.isNotEmpty && int.parse(intensityEndController.value.text) < int.parse(value)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: context.i18n.exerciseIntensity,
                  labelText: context.i18n.exerciseIntensity,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.i18n.till),
                      ],
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: intensityEndController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (int.parse(value!) > 100) {
                    return context.i18n.validationInvalidValue;
                  } else if (intensityStartController.value.text.isNotEmpty && int.parse(intensityStartController.value.text) > int.parse(value)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintText: context.i18n.exerciseIntensity,
                  labelText: context.i18n.exerciseIntensity,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (widget.patient != null)
          SizedBox(
            height: inputSpacing,
          ),
        if ((widget.patient?.maximumHeartRate ?? 0) > 0)
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: lightTextColor,
                size: 14,
              ),
              SizedBox(
                width: width * 0.005,
              ),
              Text(
                context.i18n.patientMaximumHeartRate(widget.patient!.maximumHeartRate!),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: lightTextColor,
                      letterSpacing: 1.1,
                    ),
              ),
            ],
          ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: inputSpacing,
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              for (int i = 0; i < StrengtheningExerciseMuscleGroup.values.length; i++)
                Container(
                  width: muscleBoxSize,
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: muscleGroups.contains(StrengtheningExerciseMuscleGroup.values[i]),
                    onChanged: (value) {
                      toggleMuscleGroup(StrengtheningExerciseMuscleGroup.values[i]);
                      setState(() {
                        this.hasChanges = true;
                      });
                    },
                    title: Text(StrengtheningExerciseMuscleGroup.values[i].getTranslatedText(context),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: lightTextColor,
                            )),
                  ),
                ),
            ],
          ),
        ),
        //REPEATS;SETS;WEIGHT
        if (!isMobile)
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: durationController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if ((value ?? "").isEmpty && repeatCountController.text.isEmpty) {
                      return context.i18n.validationNotEmpty;
                    } else if ((value ?? "").isNotEmpty && (repeatCountController.text.isNotEmpty || repeatCountController.text != "")) {
                      return context.i18n.validationNotEmpty;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    hintText: context.i18n.exerciseDurationSeconds,
                    labelText: context.i18n.exerciseDurationSeconds,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(context.i18n.or + " *", style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: repeatCountController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if ((value ?? "").isEmpty && durationController.text.isEmpty) {
                      return context.i18n.validationNotEmpty;
                    } else if ((value ?? "").isNotEmpty && (durationController.text.isNotEmpty || durationController.text != "")) {
                      return context.i18n.validationNotEmpty;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    hintText: context.i18n.exerciseRepeats,
                    labelText: context.i18n.exerciseRepeats,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (isMobile)
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: durationController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if ((value ?? "").isEmpty && repeatCountController.text.isEmpty) {
                    return context.i18n.validationNotEmpty;
                  } else if ((value ?? "").isNotEmpty && (repeatCountController.text.isNotEmpty || repeatCountController.text != "")) {
                    return context.i18n.validationNotEmpty;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintText: context.i18n.exerciseDurationSeconds,
                  labelText: context.i18n.exerciseDurationSeconds,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(context.i18n.or, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              TextFormField(
                controller: repeatCountController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if ((value ?? "").isEmpty && durationController.text.isEmpty) {
                    return context.i18n.validationNotEmpty;
                  } else if ((value ?? "").isNotEmpty && (durationController.text.isNotEmpty || durationController.text != "")) {
                    return context.i18n.validationNotEmpty;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintText: context.i18n.exerciseRepeats,
                  labelText: context.i18n.exerciseRepeats,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          controller: repeatSetController,
          keyboardType: TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if ((value ?? "").isEmpty) {
              return context.i18n.validationNotEmpty;
            } else {
              return null;
            }
          },
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            hintText: context.i18n.exerciseNumberOfSets,
            labelText: context.i18n.exerciseNumberOfSets + " *",
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          controller: breakBetweenSetsController,
          keyboardType: TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            hintText: context.i18n.exerciseBreakBetweenSets,
            labelText: context.i18n.exerciseBreakBetweenSets,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        if (!isMobile)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if ((value ?? "").isEmpty) {
                      weightController.text = "0";
                      return null;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    hintText: context.i18n.weightKg,
                    labelText: context.i18n.weightKg,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(context.i18n.or, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.transparent)),
                  ],
                ),
              ),
              Container(
                width: intensityWidth,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: needsEquipment,
                  onChanged: (value) {
                    setState(() {
                      needsEquipment = value ?? false;
                      this.hasChanges = true;
                    });
                  },
                  title: Text(
                    context.i18n.exerciseNeedsEquipment,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: lightTextColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        if (isMobile)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    weightController.text = "0";
                    return null;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintText: context.i18n.weightKg,
                  labelText: context.i18n.weightKg,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: inputSpacing,
              ),
              Container(
                width: intensityWidth * 2,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: needsEquipment,
                  onChanged: (value) {
                    setState(() {
                      needsEquipment = value ?? false;
                    });
                  },
                  title: Text(
                    context.i18n.exerciseNeedsEquipment,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: lightTextColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          controller: youTubeUrlController,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.youTubeUrl,
            labelText: context.i18n.youTubeUrl,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          controller: hintController,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.notes,
            hintMaxLines: 1,
            labelText: context.i18n.notes,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildInterval(intensityWidth, height, width, isTablet, isMobile, containerWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: isMobile ? 290 : 205,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffe8e8e8), width: 1), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(3)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile && widget.patient != null)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: heartRateLowerLimitController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (heartRateUpperLimitController.value.text.isNotEmpty &&
                                  int.parse(heartRateUpperLimitController.value.text) < int.parse(value!)) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                              labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              Icon(Icons.remove),
                            ],
                          ),
                        ),
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: heartRateUpperLimitController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (heartRateLowerLimitController.value.text.isNotEmpty &&
                                  int.parse(heartRateLowerLimitController.value.text) > int.parse(value!)) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                              labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!isMobile && widget.patient == null)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: intensityStartController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (int.parse(value!) > 100) {
                                return context.i18n.validationInvalidValue;
                              } else if (intensityEndController.value.text.isNotEmpty &&
                                  int.parse(intensityEndController.value.text) < int.parse(value)) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: context.i18n.exerciseIntensity,
                              labelText: context.i18n.exerciseIntensity,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              Icon(Icons.remove),
                            ],
                          ),
                        ),
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: intensityEndController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (int.parse(value!) > 100) {
                                return context.i18n.validationInvalidValue;
                              } else if (intensityStartController.value.text.isNotEmpty &&
                                  int.parse(intensityStartController.value.text) > int.parse(value)) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintText: context.i18n.exerciseIntensity,
                              labelText: context.i18n.exerciseIntensity,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (isMobile && widget.patient != null)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        TextFormField(
                          controller: heartRateLowerLimitController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (heartRateUpperLimitController.value.text.isNotEmpty &&
                                int.parse(heartRateUpperLimitController.value.text) < int.parse(value!)) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintMaxLines: 1,
                            hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                            labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context.i18n.till),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: heartRateUpperLimitController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (heartRateLowerLimitController.value.text.isNotEmpty &&
                                int.parse(heartRateLowerLimitController.value.text) > int.parse(value!)) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                            labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (isMobile && widget.patient == null)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        TextFormField(
                          controller: intensityStartController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (int.parse(value!) > 100) {
                              return context.i18n.validationInvalidValue;
                            } else if (intensityEndController.value.text.isNotEmpty &&
                                int.parse(intensityEndController.value.text) < int.parse(value)) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintMaxLines: 1,
                            hintText: context.i18n.exerciseIntensity,
                            labelText: context.i18n.exerciseIntensity,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context.i18n.till),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: intensityEndController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (int.parse(value!) > 100) {
                              return context.i18n.validationInvalidValue;
                            } else if (intensityStartController.value.text.isNotEmpty &&
                                int.parse(intensityStartController.value.text) > int.parse(value)) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintText: context.i18n.exerciseIntensity,
                            labelText: context.i18n.exerciseIntensity,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (widget.patient != null)
                    SizedBox(
                      height: inputSpacing,
                    ),
                  if ((widget.patient?.maximumHeartRate ?? 0) > 0)
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: lightTextColor,
                          size: 14,
                        ),
                        SizedBox(
                          width: width * 0.005,
                        ),
                        Text(
                          context.i18n.patientMaximumHeartRate(widget.patient!.maximumHeartRate!),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: lightTextColor,
                                letterSpacing: 1.1,
                              ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: inputSpacing,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: containerWidth - 135,
                        child: TextFormField(
                          controller: durationController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return context.i18n.validationNotEmpty;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintText: context.i18n.duration,
                            labelText: context.i18n.duration + " *",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        child: DropdownButtonFormField(
                          value: selectedIntensityDurationUnit,
                          onChanged: (value) {
                            setState(() {
                              selectedIntensityDurationUnit = value?.toString() ?? "min";
                              this.hasChanges = true;
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text(context.i18n.durationValueSeconds),
                              value: "sec",
                            ),
                            DropdownMenuItem(
                              child: Text(context.i18n.durationValueMinutes),
                              value: "min",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                left: 10,
                top: 0,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    context.i18n.exerciseIntensityPhase,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: inputSpacing,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: isMobile ? 290 : 205,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffe8e8e8), width: 1), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(3)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile && widget.patient != null)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: recoveryHeartRateLowerLimitController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (recoveryHeartRateUpperLimitController.value.text.isNotEmpty &&
                                  int.parse(recoveryHeartRateUpperLimitController.value.text) < int.parse(value!)) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                              labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              Icon(Icons.remove),
                            ],
                          ),
                        ),
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: recoveryHeartRateUpperLimitController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (recoveryHeartRateLowerLimitController.value.text.isNotEmpty &&
                                  int.parse(recoveryHeartRateLowerLimitController.value.text) > int.parse(value!)) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                              labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!isMobile && widget.patient == null)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: recoveryStartController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (int.parse(value!) > 100) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: context.i18n.exerciseIntensity,
                              labelText: context.i18n.exerciseIntensity,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              Icon(Icons.remove),
                            ],
                          ),
                        ),
                        Container(
                          width: intensityWidth,
                          child: TextFormField(
                            controller: recoveryEndController,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return null;
                              } else if (int.parse(value!) > 100) {
                                return context.i18n.validationInvalidValue;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) => {
                              setState(() {
                                this.hasChanges = true;
                              })
                            },
                            decoration: InputDecoration(
                              hintText: context.i18n.exerciseIntensity,
                              labelText: context.i18n.exerciseIntensity,
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (isMobile && widget.patient != null)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        TextFormField(
                          controller: recoveryHeartRateLowerLimitController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (recoveryHeartRateUpperLimitController.value.text.isNotEmpty &&
                                int.parse(recoveryHeartRateUpperLimitController.value.text) < int.parse(value!)) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintMaxLines: 1,
                            hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                            labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context.i18n.till),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: recoveryHeartRateUpperLimitController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (recoveryHeartRateLowerLimitController.value.text.isNotEmpty &&
                                int.parse(recoveryHeartRateLowerLimitController.value.text) > int.parse(value!)) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                            labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (isMobile && widget.patient == null)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Belastung
                        TextFormField(
                          controller: recoveryStartController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (int.parse(value!) > 100) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintMaxLines: 1,
                            hintText: context.i18n.exerciseIntensity,
                            labelText: context.i18n.exerciseIntensity,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context.i18n.till),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: recoveryEndController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (int.parse(value!) > 100) {
                              return context.i18n.validationInvalidValue;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintText: context.i18n.exerciseIntensity,
                            labelText: context.i18n.exerciseIntensity,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (widget.patient != null)
                    SizedBox(
                      height: inputSpacing,
                    ),
                  if ((widget.patient?.maximumHeartRate ?? 0) > 0)
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: lightTextColor,
                          size: 14,
                        ),
                        SizedBox(
                          width: width * 0.005,
                        ),
                        Text(
                          context.i18n.patientMaximumHeartRate(widget.patient!.maximumHeartRate!),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: lightTextColor,
                                letterSpacing: 1.1,
                              ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: inputSpacing,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: containerWidth - 135,
                        child: TextFormField(
                          controller: recoveryDurationController,
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return context.i18n.validationNotEmpty;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            hintText: context.i18n.duration,
                            labelText: context.i18n.duration + " *",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        child: DropdownButtonFormField(
                          value: selectedRecoveryDurationUnit,
                          onChanged: (value) {
                            setState(() {
                              selectedRecoveryDurationUnit = value?.toString() ?? "min";
                              this.hasChanges = true;
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text(context.i18n.durationValueSeconds),
                              value: "sec",
                            ),
                            DropdownMenuItem(
                              child: Text(context.i18n.durationValueMinutes),
                              value: "min",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                left: 10,
                top: 0,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    context.i18n.exerciseRecoveryPhase,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: inputSpacing,
        ),
        //Dauer
        TextFormField(
          controller: intervalCountController,
          keyboardType: TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if ((value ?? "").isEmpty) {
              return context.i18n.validationNotEmpty;
            } else {
              return null;
            }
          },
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            hintText: context.i18n.exerciseNumberOfIntervals,
            labelText: context.i18n.exerciseNumberOfIntervals + " *",
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          controller: youTubeUrlController,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.youTubeUrl,
            labelText: context.i18n.youTubeUrl,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: hintController,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.notes,
            hintMaxLines: 1,
            labelText: context.i18n.notes,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildEndurance(intensityWidth, height, width, isTablet, isMobile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.patient != null)
                Container(
                  width: intensityWidth,
                  child: TextFormField(
                    controller: heartRateLowerLimitController,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return null;
                      } else if (heartRateUpperLimitController.value.text.isNotEmpty &&
                          int.parse(heartRateUpperLimitController.value.text) < int.parse(value!)) {
                        return context.i18n.validationInvalidValue;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        this.hasChanges = true;
                      })
                    },
                    decoration: InputDecoration(
                      hintMaxLines: 1,
                      hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                      labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: datatableBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              if (widget.patient == null)
                Container(
                  width: intensityWidth,
                  child: TextFormField(
                    controller: intensityStartController,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return null;
                      } else if (int.parse(value!) > 100) {
                        return context.i18n.validationInvalidValue;
                      } else if (intensityEndController.value.text.isNotEmpty && int.parse(intensityEndController.value.text) < int.parse(value)) {
                        return context.i18n.validationInvalidValue;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        this.hasChanges = true;
                      })
                    },
                    decoration: InputDecoration(
                      hintMaxLines: 1,
                      hintText: context.i18n.exerciseIntensity,
                      labelText: context.i18n.exerciseIntensity,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: datatableBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 4),
                    Icon(Icons.remove),
                  ],
                ),
              ),
              if (widget.patient != null)
                Container(
                  width: intensityWidth,
                  child: TextFormField(
                    controller: heartRateUpperLimitController,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return null;
                      } else if (heartRateLowerLimitController.value.text.isNotEmpty &&
                          int.parse(heartRateLowerLimitController.value.text) > int.parse(value!)) {
                        return context.i18n.validationInvalidValue;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        this.hasChanges = true;
                      })
                    },
                    decoration: InputDecoration(
                      hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                      labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: datatableBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              if (widget.patient == null)
                Container(
                  width: intensityWidth,
                  child: TextFormField(
                    controller: intensityEndController,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return null;
                      } else if (int.parse(value!) > 100) {
                        return context.i18n.validationInvalidValue;
                      } else if (intensityStartController.value.text.isNotEmpty &&
                          int.parse(intensityStartController.value.text) > int.parse(value)) {
                        return context.i18n.validationInvalidValue;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        this.hasChanges = true;
                      })
                    },
                    decoration: InputDecoration(
                      hintText: context.i18n.exerciseIntensity,
                      labelText: context.i18n.exerciseIntensity,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: datatableBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        if (isMobile && widget.patient != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: heartRateLowerLimitController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (heartRateUpperLimitController.value.text.isNotEmpty &&
                      int.parse(heartRateUpperLimitController.value.text) < int.parse(value!)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                  labelText: context.i18n.exerciseTrainingHeartRateLowerLimit,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.i18n.till),
              ),
              TextFormField(
                controller: heartRateUpperLimitController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (heartRateLowerLimitController.value.text.isNotEmpty &&
                      int.parse(heartRateLowerLimitController.value.text) > int.parse(value!)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                  labelText: context.i18n.exerciseTrainingHeartRateUpperLimit,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (isMobile && widget.patient == null)
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Belastung
              TextFormField(
                controller: intensityStartController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (int.parse(value!) > 100) {
                    return context.i18n.validationInvalidValue;
                  } else if (intensityEndController.value.text.isNotEmpty && int.parse(intensityEndController.value.text) < int.parse(value)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: context.i18n.exerciseIntensity,
                  labelText: context.i18n.exerciseIntensity,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.i18n.till),
                      ],
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: intensityEndController,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return null;
                  } else if (int.parse(value!) > 100) {
                    return context.i18n.validationInvalidValue;
                  } else if (intensityStartController.value.text.isNotEmpty && int.parse(intensityStartController.value.text) > int.parse(value)) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintText: context.i18n.exerciseIntensity,
                  labelText: context.i18n.exerciseIntensity,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (widget.patient != null)
          SizedBox(
            height: inputSpacing,
          ),
        if ((widget.patient?.maximumHeartRate ?? 0) > 0)
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: lightTextColor,
                size: 14,
              ),
              SizedBox(
                width: width * 0.005,
              ),
              Text(
                context.i18n.patientMaximumHeartRate(widget.patient!.maximumHeartRate!),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: lightTextColor,
                      letterSpacing: 1.1,
                    ),
              ),
            ],
          ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          controller: durationController,
          keyboardType: TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if ((value ?? "").isEmpty) {
              return context.i18n.validationNotEmpty;
            } else {
              return null;
            }
          },
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            hintText: context.i18n.exerciseDurationMinutes,
            labelText: context.i18n.exerciseDurationMinutes + " *",
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          controller: youTubeUrlController,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.youTubeUrl,
            labelText: context.i18n.youTubeUrl,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: hintController,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.notes,
            hintMaxLines: 1,
            labelText: context.i18n.notes,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildTask() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          controller: youTubeUrlController,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.youTubeUrl,
            labelText: context.i18n.youTubeUrl,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: hintController,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.notes,
            hintMaxLines: 1,
            labelText: context.i18n.notes,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildAppointment() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: inputSpacing),
        TextFormField(
          controller: nameController,
          validator: (value) {
            if ((value ?? "").isEmpty) {
              return context.i18n.validationNotEmpty;
            } else {
              return null;
            }
          },
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            hintText: context.i18n.name,
            labelText: context.i18n.name + " *",
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(height: inputSpacing),
        TextFormField(
          controller: locationController,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            hintText: context.i18n.location,
            labelText: context.i18n.location,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(height: inputSpacing),
        TextFormField(
          textAlign: TextAlign.start,
          controller: detailsController,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: context.i18n.details,
            hintMaxLines: 1,
            labelText: context.i18n.details,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: datatableBorderColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: inputSpacing,
        ),
        BackNextButtons(
          back: widget.back,
          next: validate,
          nextButtonTitle: context.i18n.next,
          hasChanges: this.hasChanges,
          onCancelled: widget.onCancelled,
        ),
        SizedBox(
          height: inputSpacing,
        ),
      ],
    );
  }
}
