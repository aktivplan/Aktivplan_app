import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:aptapp/widget/video_form_field.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ModifyExercisePage extends StatefulWidget {
  final ExerciseType exerciseType;
  final exercise;
  final edit;
  final String? exerciseId;
  final String? exerciseTypeString;

  ModifyExercisePage({Key? key, required this.exerciseType, this.exercise, this.edit, this.exerciseId, this.exerciseTypeString}) : super(key: key);

  @override
  _ModifyExercisePageState createState() => _ModifyExercisePageState();
}

class _ModifyExercisePageState extends State<ModifyExercisePage> with TraceablePageMixin {
  final double FIELD_SPACING = 16;
  final _exerciseFormKey = GlobalKey<FormState>();
  ExerciseBloc? exerciseBloc;

  final exerciseNameController = TextEditingController();
  final exerciseEnglishNameController = TextEditingController();
  //ENDURANCE, INTERVAL
  final durationController = TextEditingController();
  final intensityStartController = TextEditingController();
  final intensityEndController = TextEditingController();
  //INTERVAL
  final recoveryDurationController = TextEditingController();
  final recoveryStartController = TextEditingController();
  final recoveryEndController = TextEditingController();
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
  bool needsEquipment = false;
  List<StrengtheningExerciseMuscleGroup> muscleGroups = [];

  int intenseMin = 0;
  int intenseMax = 0;
  int recoveryIntenseMin = 0;
  int recoveryIntenseMax = 0;
  String selectedIntensityDurationUnit = "min";
  String selectedRecoveryDurationUnit = "min";

  ExerciseType exerciseType = ExerciseType.ENDURANCE;
  var exercise;
  bool hasChanges = false;
  bool didChangeVideoFile = false;
  MultipartFile? videoFile;

  buildExerciseType() {
    if (exerciseType == ExerciseType.ENDURANCE) {
      return EnduranceExercisePostDTO(
          name: getTranslationObjectFromController(exerciseNameController, exerciseEnglishNameController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
          hint: getTranslationObjectFromController(hintController, hintEnglishController),
          type: exerciseType,
          exerciseDurationSeconds: (int.tryParse(durationController.text) ?? 0) * MINUTES_TO_SECONDS,
          exerciseIntensityPercentageStart: int.tryParse(intensityStartController.text),
          exerciseIntensityPercentageEnd: int.tryParse(intensityEndController.text),
          videoFileKey: exercise?.videoFileKey ?? "");
    } else if (exerciseType == ExerciseType.INTERVAL) {
      return IntervalExercisePostDTO(
          name: getTranslationObjectFromController(exerciseNameController, exerciseEnglishNameController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
          hint: getTranslationObjectFromController(hintController, hintEnglishController),
          type: exerciseType,
          exerciseDurationSeconds: (int.tryParse(durationController.text) ?? 0) * MINUTES_TO_SECONDS,
          exerciseIntensityPercentageStart: int.tryParse(intensityStartController.text),
          exerciseIntensityPercentageEnd: int.tryParse(intensityEndController.text),
          intervalCount: int.tryParse(intervalCountController.text) ?? 0,
          recoveryDurationSeconds:
              (int.tryParse(recoveryDurationController.text) ?? 0) * (selectedRecoveryDurationUnit == "min" ? MINUTES_TO_SECONDS : 1),
          recoveryIntensityPercentageStart: int.tryParse(recoveryStartController.text),
          recoveryIntensityPercentageEnd: int.tryParse(recoveryEndController.text),
          selectedExerciseSeconds: selectedIntensityDurationUnit == "sec",
          selectedRecoverySeconds: selectedRecoveryDurationUnit == "sec",
          videoFileKey: exercise?.videoFileKey ?? "");
    } else if (exerciseType == ExerciseType.STRENGTHENING || exerciseType == ExerciseType.HYPERTROPHY) {
      return StrengtheningExercisePostDTO(
          name: getTranslationObjectFromController(exerciseNameController, exerciseEnglishNameController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
          hint: getTranslationObjectFromController(hintController, hintEnglishController),
          exerciseDurationSeconds: durationController.text.isNotEmpty ? (int.tryParse(durationController.text)) : 0,
          exerciseIntensityPercentageEnd: int.tryParse(intensityEndController.text),
          exerciseIntensityPercentageStart: int.tryParse(intensityStartController.text),
          exerciseRepeatCount: repeatCountController.text.isNotEmpty ? (int.tryParse(repeatCountController.text)) : 0,
          exerciseRepeatSets: int.tryParse(repeatSetController.text) ?? 0,
          exerciseBreakBetweenSetsDurationSeconds: int.tryParse(breakBetweenSetsController.text),
          hasRepeatCount: repeatCountController.text.isNotEmpty,
          muscleGroups: muscleGroups,
          type: exerciseType,
          needsEquipment: needsEquipment,
          weight: int.tryParse(weightController.text) ?? 0,
          videoFileKey: exercise?.videoFileKey ?? "");
    } else if (exerciseType == ExerciseType.OTHER) {
      return OtherExercisePostDTO(
          name: getTranslationObjectFromController(exerciseNameController, exerciseEnglishNameController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
          hint: getTranslationObjectFromController(hintController, hintEnglishController),
          type: exerciseType,
          exerciseDurationSeconds: (int.tryParse(durationController.text) ?? 0) * MINUTES_TO_SECONDS,
          exerciseIntensityPercentageStart: int.tryParse(intensityStartController.text),
          exerciseIntensityPercentageEnd: int.tryParse(intensityEndController.text),
          videoFileKey: exercise?.videoFileKey ?? "");
    } else if (exerciseType == ExerciseType.TASK) {
      return TaskPostDTO(
          name: getTranslationObjectFromController(exerciseNameController, exerciseEnglishNameController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
          hint: getTranslationObjectFromController(hintController, hintEnglishController),
          type: exerciseType,
          videoFileKey: exercise?.videoFileKey ?? "");
    }
  }

  deleteExerciseType() {
    exerciseBloc!.add(DeleteExerciseEvent(
      type: exercise.type,
      id: exercise.id,
    ));
    context.beamToNamed('/training/${exerciseType.value.toLowerCase()}');
  }

  saveExerciseType() {
    if (_exerciseFormKey.currentState!.validate()) {
      var exercise = buildExerciseType();
      exerciseBloc!.add(
        SaveExerciseEvent(
          type: exerciseType,
          exercise: exercise,
          videoFile: videoFile,
        ),
      );
      context.beamToNamed('/training/${exerciseType.value.toLowerCase()}');
    }
  }

  updateExerciseType() {
    if (_exerciseFormKey.currentState!.validate()) {
      var exercise = buildExerciseType();
      exerciseBloc!.add(
        UpdateExerciseEvent(
          id: this.exercise.id,
          type: exerciseType,
          exercise: exercise,
          videoFile: videoFile,
          didChangeVideoFile: didChangeVideoFile,
        ),
      );
      context.beamToNamed('/training/${exerciseType.value.toLowerCase()}');
    }
  }

  getExercise() async {
    if (widget.exercise == null) {
      final exerciseApi = new ExerciseControllerApi(apiClient);
      exerciseType = ExerciseType.values.firstWhere((element) => element.toString().toLowerCase() == widget.exerciseTypeString!.toLowerCase());
      final exercises = (await exerciseApi.getExercises(exerciseType)) ?? [];
      for (var element in exercises) {
        if (exerciseType == ExerciseType.ENDURANCE && element.enduranceExercise!.id == widget.exerciseId) {
          exercise = element.enduranceExercise;
          break;
        } else if ((exerciseType == ExerciseType.HYPERTROPHY || exerciseType == ExerciseType.STRENGTHENING) &&
            element.strengtheningExercise!.id == widget.exerciseId) {
          exercise = element.strengtheningExercise;
          break;
        } else if (exerciseType == ExerciseType.INTERVAL && element.intervalExercise!.id == widget.exerciseId) {
          exercise = element.intervalExercise;
          break;
        } else if (exerciseType == ExerciseType.OTHER && element.otherExercise!.id == widget.exerciseId) {
          exercise = element.otherExercise;
          break;
        } else if (exerciseType == ExerciseType.TASK && element.task!.id == widget.exerciseId) {
          exercise = element.task;
          break;
        }
      }
    } else {
      exercise = widget.exercise;
      exerciseType = widget.exerciseType;
    }
    if (exercise is EnduranceExercise || exercise is OtherExercise) {
      initTextEditingControllerFromTranslationObject(exercise.name, exerciseNameController, exerciseEnglishNameController);
      initTextEditingControllerFromTranslationObject(exercise.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);
      initTextEditingControllerFromTranslationObject(exercise.hint, hintController, hintEnglishController);
      durationController.text = Duration(seconds: exercise?.exerciseDurationSeconds).inMinutes.toString();
      intensityStartController.text = exercise.exerciseIntensityPercentageStart != null ? exercise.exerciseIntensityPercentageStart.toString() : "";
      intensityEndController.text = exercise.exerciseIntensityPercentageEnd != null ? exercise.exerciseIntensityPercentageEnd.toString() : "";
    } else if (exercise is IntervalExercise) {
      initTextEditingControllerFromTranslationObject(exercise.name, exerciseNameController, exerciseEnglishNameController);
      initTextEditingControllerFromTranslationObject(exercise.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);
      initTextEditingControllerFromTranslationObject(exercise.hint, hintController, hintEnglishController);
      if (exercise.selectedExerciseSeconds ?? false) {
        durationController.text = exercise.exerciseDurationSeconds != null ? exercise.exerciseDurationSeconds.toString() : "";
        setState(() {
          selectedIntensityDurationUnit = "sec";
        });
      } else {
        durationController.text = Duration(seconds: exercise?.exerciseDurationSeconds).inMinutes.toString();
      }
      intensityStartController.text = exercise?.exerciseIntensityPercentageStart?.toString() ?? "";
      intensityEndController.text = exercise?.exerciseIntensityPercentageEnd?.toString() ?? "";
      if (exercise.selectedRecoverySeconds ?? false) {
        recoveryDurationController.text = exercise.recoveryDurationSeconds != null ? exercise.recoveryDurationSeconds.toString() : "";
        setState(() {
          selectedRecoveryDurationUnit = "sec";
        });
      } else {
        recoveryDurationController.text = Duration(seconds: exercise?.recoveryDurationSeconds).inMinutes.toString();
      }
      recoveryStartController.text = exercise.recoveryIntensityPercentageStart?.toString() ?? "";
      recoveryEndController.text = exercise.recoveryIntensityPercentageEnd?.toString() ?? "";
      intervalCountController.text = exercise.intervalCount?.toString() ?? "";
    } else if (exercise is StrengtheningExercise) {
      initTextEditingControllerFromTranslationObject(exercise.name, exerciseNameController, exerciseEnglishNameController);
      initTextEditingControllerFromTranslationObject(exercise.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);
      initTextEditingControllerFromTranslationObject(exercise.hint, hintController, hintEnglishController);
      muscleGroups = exercise?.muscleGroups ?? List.empty();
      durationController.text =
          exercise?.exerciseDurationSeconds != 0 ? Duration(seconds: exercise?.exerciseDurationSeconds).inSeconds.toString() : "";
      intensityStartController.text = exercise.exerciseIntensityPercentageStart != null ? exercise.exerciseIntensityPercentageStart.toString() : "";
      intensityEndController.text = exercise.exerciseIntensityPercentageEnd != null ? exercise.exerciseIntensityPercentageEnd.toString() : "";
      String repeatCountText = exercise.exerciseRepeatCount?.toString() ?? "0";
      repeatCountController.text = repeatCountText != "0" ? repeatCountText : "";
      repeatSetController.text = exercise.exerciseRepeatSets?.toString() ?? "";
      if (exercise?.exerciseBreakBetweenSetsDurationSeconds != null) {
        breakBetweenSetsController.text = exercise.exerciseBreakBetweenSetsDurationSeconds.toString();
      } else {
        breakBetweenSetsController.text = "";
      }
      String weightText = exercise.weight?.toString() ?? "0";
      weightController.text = weightText != "0" ? weightText : "";
      needsEquipment = exercise?.needsEquipment;
    } else if (exercise is Task) {
      initTextEditingControllerFromTranslationObject(exercise.name, exerciseNameController, exerciseEnglishNameController);
      initTextEditingControllerFromTranslationObject(exercise.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);
      initTextEditingControllerFromTranslationObject(exercise.hint, hintController, hintEnglishController);
    } else if (exercise is Workout) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getExercise();
    exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
  }

  @override
  void dispose() {
    exerciseNameController.dispose();
    exerciseEnglishNameController.dispose();
    durationController.dispose();
    intensityStartController.dispose();
    intensityEndController.dispose();
    recoveryDurationController.dispose();
    recoveryEndController.dispose();
    recoveryStartController.dispose();
    intervalCountController.dispose();
    repeatCountController.dispose();
    repeatSetController.dispose();
    breakBetweenSetsController.dispose();
    weightController.dispose();
    youTubeUrlController.dispose();
    youTubeUrlEnglishController.dispose();
    hintController.dispose();
    hintEnglishController.dispose();
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

  _getVideoFormField() {
    return Padding(
      padding: EdgeInsets.only(bottom: FIELD_SPACING),
      child: VideoFormField(
          initialFileKey: widget.exercise?.videoFileKey ?? "",
          onUpdateFile: (file) {
            setState(() {
              videoFile = file;
              hasChanges = true;
              didChangeVideoFile = true;
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
        child: ResponsiveBuilder(builder: (context, size) {
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
          double strengthWidth = size.isMobile
              ? width * 0.25
              : size.isTablet
                  ? width * 0.15
                  : width * 0.1;

          double muscleBoxSize = size.isMobile ? containerWidth / 2 : containerWidth / 3;

          return Container(
            width: containerWidth,
            child: Form(
              key: _exerciseFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFieldPadding(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            exerciseType.getTranslatedText(context),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  LanguageTabs(
                    germanFields: [
                      FormFieldPadding(
                        child: TextFormField(
                          controller: exerciseNameController,
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return context.i18n.validationNotEmpty;
                            } else if (value!.length < 2 || value.length > 100) {
                              return context.i18n.validationDefaultLength;
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
                            hintText: context.i18n.name,
                            labelText: context.i18n.name + ' *',
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: FIELD_SPACING,
                      ),
                      if (exerciseType == ExerciseType.ENDURANCE || exerciseType == ExerciseType.OTHER) _buildEndurance(intensityWidth, width, size),
                      if (exerciseType == ExerciseType.INTERVAL) _buildInterval(intensityWidth, width, size, containerWidth),
                      if (exerciseType == ExerciseType.STRENGTHENING || exerciseType == ExerciseType.HYPERTROPHY)
                        _buildStrengthening(intensityWidth, strengthWidth, width, size, muscleBoxSize),
                      if (exerciseType == ExerciseType.TASK) _buildTask(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SelectableText(context.i18n.hintRequiredFields,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: lightTextColor,
                                    ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: FIELD_SPACING,
                      ),
                      Row(
                        children: [
                          SaveButton(
                            title: widget.edit ? context.i18n.save.toUpperCase() : context.i18n.create.toUpperCase(),
                            callback: widget.edit ? updateExerciseType : saveExerciseType,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          CancelButton(
                            callback: () => context.beamToNamed('/training/${exerciseType.value.toLowerCase()}'),
                            hasChanges: this.hasChanges,
                          ),
                          if (exercise != null)
                            SizedBox(
                              width: width * 0.01,
                            ),
                          if (exercise != null)
                            DeleteButton(
                                confirmationTitle: context.i18n.deleteMessageExerciseTypeTitle(exerciseType.getTranslatedText(context)),
                                confirmationText: exerciseType == ExerciseType.OTHER
                                    ? context.i18n.deleteMessageExerciseTypeOther
                                    : exerciseType == ExerciseType.ENDURANCE
                                        ? context.i18n.deleteMessageExerciseTypeEndurance
                                        : context.i18n.deleteMessageExerciseType(exerciseType.getTranslatedText(context)),
                                callback: deleteExerciseType),
                        ],
                      ),
                      SizedBox(
                        height: FIELD_SPACING,
                      ),
                    ],
                    englishFields: [
                      FormFieldPadding(
                        child: TextFormField(
                          controller: exerciseEnglishNameController,
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return null;
                            } else if (value!.length < 2 || value.length > 100) {
                              return context.i18n.validationDefaultLength;
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
                            hintText: context.i18n.nameEnglish,
                            labelText: context.i18n.nameEnglish,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: FIELD_SPACING,
                      ),
                      TextFormField(
                        textAlign: TextAlign.start,
                        controller: youTubeUrlEnglishController,
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
                        height: FIELD_SPACING,
                      ),
                      TextFormField(
                        textAlign: TextAlign.start,
                        controller: hintEnglishController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
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
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _buildStrengthening(intensityWidth, strengthWidth, width, size, muscleBoxSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!size.isMobile)
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
        if (size.isMobile)
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
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: FIELD_SPACING,
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
                )
            ],
          ),
        ),
        //REPEATS;SETS;WEIGHT
        if (!size.isMobile)
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
        if (size.isMobile)
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
          height: FIELD_SPACING,
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
          height: FIELD_SPACING,
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
          height: FIELD_SPACING,
        ),
        if (!size.isMobile)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: intensityWidth,
                child: TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
        if (size.isMobile)
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
                height: FIELD_SPACING,
              ),
              Container(
                width: intensityWidth * 2,
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
        SizedBox(
          height: FIELD_SPACING,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: youTubeUrlController,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
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
        _getVideoFormField(),
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

  _buildInterval(intensityWidth, width, size, containerWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.isMobile ? 275 : 170,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffe8e8e8), width: 1), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(3)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!size.isMobile)
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
                  if (size.isMobile)
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
                  SizedBox(
                    height: FIELD_SPACING,
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
                          initialValue: selectedIntensityDurationUnit,
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
          height: FIELD_SPACING,
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.isMobile ? 275 : 170,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffe8e8e8), width: 1), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(3)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!size.isMobile)
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
                  if (size.isMobile)
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
                  SizedBox(
                    height: FIELD_SPACING,
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
                          initialValue: selectedRecoveryDurationUnit,
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
          height: FIELD_SPACING,
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
          height: FIELD_SPACING,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: youTubeUrlController,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
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
        _getVideoFormField(),
        TextFormField(
          textAlign: TextAlign.start,
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

  _buildEndurance(intensityWidth, width, size) {
    //ENDURANCE
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!size.isMobile)
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
        if (size.isMobile)
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
        SizedBox(
          height: FIELD_SPACING,
        ),
        //Dauer
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
          height: FIELD_SPACING,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: youTubeUrlController,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
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
        _getVideoFormField(),
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
        SizedBox(
          height: FIELD_SPACING,
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
          controller: youTubeUrlController,
          onChanged: (value) => {
            setState(() {
              this.hasChanges = true;
            })
          },
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
        _getVideoFormField(),
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
        SizedBox(
          height: FIELD_SPACING,
        ),
      ],
    );
  }

  String get traceablePageName => "Modify Exercise Page";
}
