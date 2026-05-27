import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:aptapp/widget/video_player_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../exercises/option.dart';
import '../theme.dart';

class EditWorkoutExercise extends StatefulWidget {
  final ExerciseType exerciseType;
  final exercise;
  final Function addExercise;
  final Function updateExercise;
  final onAll;
  final pageState;
  final PatientGetDTO? patient;

  EditWorkoutExercise({
    Key? key,
    required this.exerciseType,
    this.exercise,
    required this.addExercise,
    required this.updateExercise,
    this.onAll,
    this.pageState,
    this.patient,
  }) : super(key: key);

  @override
  _EditWorkoutExerciseState createState() => _EditWorkoutExerciseState();
}

class _EditWorkoutExerciseState extends State<EditWorkoutExercise> {
  final _editWorkoutKey = GlobalKey<FormState>();
  var plannedActivity;
  // List<StrengtheningExercise> exercises = [];
  final exerciseNameController = TextEditingController();
  final exerciseEnglishNameController = TextEditingController();
  //ENDURANCE, INTERVAL
  final durationController = TextEditingController();
  final heartRateLowerLimitController = TextEditingController();
  final heartRateUpperLimitController = TextEditingController();
  final intensityStartController = TextEditingController();
  final intensityEndController = TextEditingController();
  //STRENGTHENING
  final repeatCountController = TextEditingController();
  final repeatSetController = TextEditingController();
  final breakBetweenSetsController = TextEditingController();
  final weightController = TextEditingController();
  final youTubeUrlController = TextEditingController();
  final youTubeUrlEnglishController = TextEditingController();
  final hintController = TextEditingController();
  final hintEnglishController = TextEditingController();
  bool needsEquipment = false;
  List<StrengtheningExerciseMuscleGroup> muscleGroups = [];
  int pageState = 1;
  ExerciseBloc? exerciseBloc;
  ExerciseType? exerciseType;
  FocusNode dropDownDeFocusNode = FocusNode();
  FocusNode dropDownEnFocusNode = FocusNode();

  int intenseMin = 0;
  int intenseMax = 0;
  int recoveryIntenseMin = 0;
  int recoveryIntenseMax = 0;
  bool hasChanges = false;
  String videoSource = "";
  final FileControllerApi fileControllerApi = FileControllerApi(apiClient);

  buildExerciseType() {
    var exercise;
    exercise = StrengtheningExercisePostDTO();
    exercise.name = getTranslationObjectFromController(exerciseNameController, exerciseEnglishNameController);
    exercise.youTubeUrl = getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController);
    exercise.hint = getTranslationObjectFromController(hintController, hintEnglishController);
    exercise.type = exerciseType;
    //performance
    exercise.exerciseDurationSeconds = (int.tryParse(durationController.text) ?? 0);
    if (widget.patient == null) {
      exercise.exerciseIntensityPercentageStart = int.tryParse(intensityStartController.text);
      exercise.exerciseIntensityPercentageEnd = int.tryParse(intensityEndController.text);
    } else {
      exercise.exerciseTrainingHeartRateLowerLimit = int.tryParse(heartRateLowerLimitController.text);
      exercise.exerciseTrainingHeartRateUpperLimit = int.tryParse(heartRateUpperLimitController.text);
    }
    //strenghtening
    exercise.exerciseRepeatCount = int.tryParse(repeatCountController.text) ?? 0;
    exercise.exerciseRepeatSets = int.tryParse(repeatSetController.text) ?? 0;
    exercise.hasRepeatCount = exercise.exerciseRepeatCount != 0;
    int breakDuration = int.tryParse(breakBetweenSetsController.text) ?? 0;
    exercise.exerciseBreakBetweenSetsDurationSeconds = breakDuration;
    exercise.needsEquipment = needsEquipment;
    exercise.weight = int.tryParse(weightController.text) ?? 0;
    exercise.muscleGroups = muscleGroups;
    exercise.videoFileKey = widget.exercise?.videoFileKey ?? "";
    return exercise;
  }

  updateExerciseType() {
    if (_editWorkoutKey.currentState!.validate()) {
      var newExerciseType = buildExerciseType();
      widget.updateExercise(widget.exercise, newExerciseType);
    }
    Navigator.pop(context);
  }

  addExerciseType() {
    if (_editWorkoutKey.currentState!.validate()) {
      var newExerciseType = buildExerciseType();
      reset();
      widget.addExercise(newExerciseType);
      Navigator.pop(context);
    }
  }

  checkForEdit(bool overrideHeartRate) {
    if (widget.exercise != null) {
      exerciseType = widget.exercise?.type;
      muscleGroups = widget.exercise?.muscleGroups;
      initTextEditingControllerFromTranslationObject(widget.exercise.name, exerciseNameController, exerciseEnglishNameController);
      initTextEditingControllerFromTranslationObject(widget.exercise.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);
      initTextEditingControllerFromTranslationObject(widget.exercise.hint, hintController, hintEnglishController);
      durationController.text = Duration(seconds: widget.exercise?.exerciseDurationSeconds).inSeconds.toString() == "0"
          ? ""
          : Duration(seconds: widget.exercise?.exerciseDurationSeconds).inSeconds.toString();
      if (widget.patient == null) {
        intensityStartController.text =
            widget.exercise.exerciseIntensityPercentageStart != null ? widget.exercise.exerciseIntensityPercentageStart.toString() : "";
        intensityEndController.text =
            widget.exercise.exerciseIntensityPercentageEnd != null ? widget.exercise.exerciseIntensityPercentageEnd.toString() : "";
      } else {
        int maximumHeartRate = widget.patient?.maximumHeartRate ?? 0;
        if (maximumHeartRate > 0 &&
            widget.exercise.exerciseIntensityPercentageStart != null &&
            widget.exercise.exerciseIntensityPercentageEnd != null &&
            (widget.exercise.exerciseTrainingHeartRateLowerLimit == null || overrideHeartRate)) {
          heartRateLowerLimitController.text =
              (maximumHeartRate * (widget.exercise.exerciseIntensityPercentageStart / TO_PERCENT)).truncate().toString();
        } else {
          heartRateLowerLimitController.text =
              widget.exercise.exerciseTrainingHeartRateLowerLimit != null && widget.exercise.exerciseTrainingHeartRateLowerLimit > 0
                  ? widget.exercise.exerciseTrainingHeartRateLowerLimit.toString()
                  : "";
        }
        if (maximumHeartRate > 0 &&
            widget.exercise.exerciseIntensityPercentageStart != null &&
            widget.exercise.exerciseIntensityPercentageEnd != null &&
            (widget.exercise.exerciseTrainingHeartRateUpperLimit == null || overrideHeartRate)) {
          heartRateUpperLimitController.text =
              (maximumHeartRate * (widget.exercise.exerciseIntensityPercentageEnd / TO_PERCENT)).truncate().toString();
        } else {
          heartRateUpperLimitController.text =
              widget.exercise.exerciseTrainingHeartRateUpperLimit != null && widget.exercise.exerciseTrainingHeartRateUpperLimit > 0
                  ? widget.exercise.exerciseTrainingHeartRateUpperLimit.toString()
                  : "";
        }
      }

      String repeatCountText = widget.exercise?.exerciseRepeatCount?.toString() ?? "";
      repeatCountController.text = repeatCountText == "0" ? "" : repeatCountText;
      repeatSetController.text = widget.exercise?.exerciseRepeatSets?.toString() ?? "";
      if (widget.exercise?.exerciseBreakBetweenSetsDurationSeconds != null) {
        breakBetweenSetsController.text = widget.exercise.exerciseBreakBetweenSetsDurationSeconds.toString();
      } else {
        breakBetweenSetsController.text = "";
      }
      String weightText = widget.exercise?.weight?.toString() ?? "";
      weightController.text = weightText == "0" ? "" : weightText;
      needsEquipment = widget.exercise?.needsEquipment;

      if ((widget.exercise?.videoFileKey ?? "").isNotEmpty) {
        fileControllerApi.getFile(widget.exercise!.videoFileKey!).then((response) {
          setState(() {
            videoSource = response?.url ?? "";
          });
        }).catchError((error) {
          print("Error fetching initial video file: $error");
        });
      }
    }
    if (plannedActivity != null) {
      final strengtheningExercise = plannedActivity as StrengtheningExercise;
      exerciseType = strengtheningExercise.type;
      muscleGroups = strengtheningExercise.muscleGroups;
      initTextEditingControllerFromTranslationObject(plannedActivity.name, exerciseNameController, exerciseEnglishNameController);
      initTextEditingControllerFromTranslationObject(plannedActivity.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);
      initTextEditingControllerFromTranslationObject(plannedActivity.hint, hintController, hintEnglishController);
      durationController.text = Duration(seconds: plannedActivity.exerciseDurationSeconds).inSeconds.toString() == "0"
          ? ""
          : Duration(seconds: plannedActivity.exerciseDurationSeconds).inSeconds.toString();
      if (widget.patient == null) {
        intensityStartController.text =
            plannedActivity.exerciseIntensityPercentageStart != null ? plannedActivity.exerciseIntensityPercentageStart.toString() : "";
        intensityEndController.text =
            plannedActivity.exerciseIntensityPercentageEnd != null ? plannedActivity.exerciseIntensityPercentageEnd.toString() : "";
      } else {
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
      }
      repeatCountController.text = plannedActivity.exerciseRepeatCount.toString() == "0" ? "" : plannedActivity.exerciseRepeatCount.toString();
      repeatSetController.text = plannedActivity.exerciseRepeatSets.toString();
      if (plannedActivity.exerciseBreakBetweenSetsDurationSeconds != null) {
        breakBetweenSetsController.text = (plannedActivity.exerciseBreakBetweenSetsDurationSeconds).toString();
      } else {
        breakBetweenSetsController.text = "";
      }
      weightController.text = plannedActivity.weight.toString() == "0" ? "" : plannedActivity.weight.toString();
      needsEquipment = plannedActivity.needsEquipment;
    }
  }

  @override
  void initState() {
    super.initState();
    checkForEdit(false);
    exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
    pageState = widget.pageState == null ? 1 : widget.pageState;
    if (pageState > 1) {
      fetchCorrectStrengthType(widget.exerciseType, false, false);
    }
  }

  @override
  void dispose() {
    exerciseNameController.dispose();
    exerciseEnglishNameController.dispose();
    durationController.dispose();
    intensityStartController.dispose();
    intensityEndController.dispose();
    heartRateLowerLimitController.dispose();
    heartRateUpperLimitController.dispose();
    repeatCountController.dispose();
    repeatSetController.dispose();
    breakBetweenSetsController.dispose();
    weightController.dispose();
    hintController.dispose();
    super.dispose();
  }

  toggleMuscleGroup(StrengtheningExerciseMuscleGroup muscle) {
    if (muscleGroups.contains(muscle)) {
      muscleGroups = [...muscleGroups];
      muscleGroups.remove(muscle);
    } else {
      muscleGroups = [...muscleGroups, muscle];
    }
  }

  fetchCorrectStrengthType(ExerciseType? type, bool isWorkout, bool isTrainingPlan) {
    setState(() {
      exerciseType = type;
    });
    if (type == ExerciseType.STRENGTHENING) {
      exerciseBloc!.add(FetchStrengtheningExercisesEvent());
    } else {
      exerciseBloc!.add(FetchHypertrophyExerciseEvent());
    }
    setState(() {
      pageState = 2;
    });
  }

  goToChooseCategory() {
    exerciseBloc!.add(ResetExerciseBlocEvent());
    setState(() {
      pageState = 1;
    });
    reset();
  }

  reset() {
    setState(() {
      plannedActivity = null;
    });
    exerciseNameController.text = "";
    exerciseEnglishNameController.text = "";
    durationController.text = "";
    intensityStartController.text = "";
    intensityEndController.text = "";
    heartRateLowerLimitController.text = "";
    heartRateUpperLimitController.text = "";
    repeatCountController.text = "";
    repeatSetController.text = "";
    breakBetweenSetsController.text = "";
    weightController.text = "";
    youTubeUrlController.text = "";
    youTubeUrlEnglishController.text = "";
    hintController.text = "";
    hintEnglishController.text = "";
    muscleGroups = [];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double strengthWidth = width * 0.1;

    return ResponsiveBuilder(builder: (context, size) {
      double containerWidth = size.isMobile
          ? width * 0.95
          : size.isTablet
              ? width * 0.9
              : width * 0.65;
      double intensityWidth = size.isMobile
          ? width * 0.4
          : size.isTablet
              ? width * 0.38
              : width * 0.28;
      double muscleBoxSize = size.isMobile ? containerWidth / 2 : containerWidth / 3;
      return SingleChildScrollView(
        child: Center(
          child: Container(
            width: containerWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                FormFieldPadding(
                  child: BreadCrumb(
                    items: [
                      BreadCrumbItem(
                        onTap: () {
                          reset();
                          Navigator.pop(context);
                        },
                        content: Text(
                          context.i18n.activity,
                          style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                      if (pageState == 1)
                        BreadCrumbItem(
                          content: SelectableText(
                            context.i18n.exerciseWorkoutStrength,
                            style: getBreadCrumbStyle(context),
                          ),
                        ),
                      if (pageState == 2)
                        BreadCrumbItem(
                          onTap: goToChooseCategory,
                          content: Text(
                            context.i18n.exerciseWorkoutStrength,
                            style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      if (pageState == 2)
                        BreadCrumbItem(
                          content: SelectableText(
                            exerciseType!.getTranslatedText(context),
                            style: getBreadCrumbStyle(context),
                          ),
                        ),
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
                if (pageState == 1)
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Option(
                        exerciseType: ExerciseType.STRENGTHENING,
                        onClick: fetchCorrectStrengthType,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Option(
                        exerciseType: ExerciseType.HYPERTROPHY,
                        onClick: fetchCorrectStrengthType,
                      ),
                    ],
                  ),
                if (pageState == 2)
                  Form(
                      key: _editWorkoutKey,
                      child: LanguageTabs(germanFields: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
                          if (state is FetchedStrengtheningExercisesState || state is FetchedHypertrophyExerciseState) {
                            var exercises =
                                state is FetchedStrengtheningExercisesState ? state.exercises : (state as FetchedHypertrophyExerciseState).exercises;
                            return TypeAheadField<StrengtheningExercise>(
                              controller: exerciseNameController,
                              focusNode: dropDownDeFocusNode,
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.name['DE'] ?? ''),
                                );
                              },
                              onSelected: (suggestion) {
                                dropDownDeFocusNode.unfocus();
                                exerciseNameController.text = suggestion.name['DE'] ?? '';
                                setState(() {
                                  plannedActivity = suggestion;
                                  this.hasChanges = true;
                                  checkForEdit(true);
                                });
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
                                    hintText: exerciseType!.getTranslatedText(context),
                                    labelText: exerciseType!.getTranslatedText(context) + " *",
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
                          } else {
                            return Container();
                          }
                        }),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        //STRENGTHENING
                        _buildStrengthening(intensityWidth, strengthWidth, height, width, size.isTablet, size.isMobile, muscleBoxSize),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        //different button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SaveButton(
                              title: context.i18n.add.toUpperCase(),
                              callback: widget.exercise == null ? addExerciseType : updateExerciseType,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            CancelButton(
                              callback: () {
                                reset();
                                Navigator.pop(context);
                              },
                              hasChanges: this.hasChanges,
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.08,
                        ),
                      ], englishFields: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        BlocBuilder<ExerciseBloc, ExerciseState>(
                          builder: (context, state) {
                            if (state is FetchedStrengtheningExercisesState || state is FetchedHypertrophyExerciseState) {
                              var exercises = state is FetchedStrengtheningExercisesState
                                  ? state.exercises
                                  : (state as FetchedHypertrophyExerciseState).exercises;
                              return TypeAheadField<StrengtheningExercise>(
                                controller: exerciseEnglishNameController,
                                focusNode: dropDownEnFocusNode,
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion.name['EN'] ?? ''),
                                  );
                                },
                                onSelected: (suggestion) {
                                  dropDownEnFocusNode.unfocus();
                                  exerciseNameController.text = suggestion.name['EN'] ?? '';
                                  setState(() {
                                    plannedActivity = suggestion;
                                    this.hasChanges = true;
                                    checkForEdit(true);
                                  });
                                },
                                suggestionsCallback: (pattern) {
                                  final toReturn =
                                      exercises.where((element) => (element.name['EN'] ?? '').toLowerCase().contains(pattern.toLowerCase())).toList();
                                  return toReturn.isEmpty ? null : toReturn;
                                },
                                builder: (context, controller, focusNode) {
                                  return TextFormField(
                                    controller: exerciseEnglishNameController,
                                    focusNode: focusNode,
                                    decoration: InputDecoration(
                                      hintText: exerciseType!.getTranslatedText(context) + " ${context.i18n.englishTranslationNote}",
                                      labelText: exerciseType!.getTranslatedText(context) + " ${context.i18n.englishTranslationNote}",
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
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
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
                          height: height * 0.02,
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.top,
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
                      ])),
              ],
            ),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 4),
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
                    SizedBox(height: 4),
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
        if (widget.patient == null && (isMobile || isTablet))
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(context.i18n.till),
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
              SizedBox(
                width: width * 0.02,
              ),
            ],
          ),
        if (widget.patient != null && (isMobile || isTablet))
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
        if (widget.patient != null)
          SizedBox(
            height: height * 0.02,
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
          height: height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
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
                      setState(() {
                        toggleMuscleGroup(StrengtheningExerciseMuscleGroup.values[i]);
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
                    Text(context.i18n.or + " *", style: Theme.of(context).textTheme.bodyLarge),
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
          height: height * 0.02,
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
          height: height * 0.02,
        ),
        TextFormField(
          controller: breakBetweenSetsController,
          keyboardType: TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
        ),
        SizedBox(
          height: height * 0.02,
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
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
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
                height: height * 0.02,
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
          height: height * 0.02,
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
          height: height * 0.02,
        ),
        if (videoSource.isNotEmpty) VideoPlayerPreview(sources: [videoSource]),
        TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
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
}
