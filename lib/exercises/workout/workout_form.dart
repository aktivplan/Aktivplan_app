import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/exercises/workout/workout_exercises_table.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:aptapp/widget/video_form_field.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:http/http.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WorkoutForm extends StatefulWidget {
  final List<dynamic> exercises;
  final Function() chooseStrengthExercise;
  final Function(dynamic) editAlreadyChosenExercise;
  final Function(MultipartFile?) updateVideoFile;
  final Workout workout;
  final bool isEditing;
  final double containerWidth;
  final MultipartFile? videoFile;

  WorkoutForm(
      {Key? key,
      required this.exercises,
      required this.chooseStrengthExercise,
      required this.editAlreadyChosenExercise,
      required this.isEditing,
      required this.workout,
      required this.containerWidth,
      required this.videoFile,
      required this.updateVideoFile})
      : super(key: key);

  @override
  _WorkoutFormState createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final double FIELD_SPACING = 16;
  final _addWorkoutFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nameEnglishController = TextEditingController();
  final durationController = TextEditingController();
  final notesController = TextEditingController();
  final notesEnglishController = TextEditingController();
  final youTubeUrlController = TextEditingController();
  final youTubeUrlEnglishController = TextEditingController();
  final videoWaitBetweenExercisesController = TextEditingController();
  ExerciseBloc? exerciseBloc;
  bool isAscending = true;
  List<StrengtheningExercisePostDTO> exercises = [];
  bool hasChanges = false;
  bool didChangeVideoFile = false;
  MultipartFile? videoFile;

  @override
  void initState() {
    super.initState();
    exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
    exercises = [...widget.exercises];
    exercises = [...widget.workout.exercises];
    initTextEditingControllerFromTranslationObject(widget.workout.name, nameController, nameEnglishController);
    initTextEditingControllerFromTranslationObject(widget.workout.notes, notesController, notesEnglishController);
    initTextEditingControllerFromTranslationObject(widget.workout.youTubeUrl, youTubeUrlController, youTubeUrlEnglishController);
    if ((widget.workout.exerciseDurationSeconds ?? 0) > 0) {
      durationController.text = Duration(seconds: widget.workout.exerciseDurationSeconds!).inMinutes.toString();
    } else {
      durationController.text = widget.workout.exercises.isNotEmpty ? getWorkoutExercisesDurationInMinutes(widget.workout.exercises).toString() : "";
    }
    videoWaitBetweenExercisesController.text =
        widget.workout.videoWaitBetweenExercisesSeconds != null ? widget.workout.videoWaitBetweenExercisesSeconds.toString() : "";
    if (widget.videoFile != null) {
      videoFile = widget.videoFile;
      didChangeVideoFile = true;
    }
  }

  deleteExerciseType(exercise) {
    setState(() {
      exercises = [...exercises];
      exercises.remove(exercise);
      durationController.text = exercises.isNotEmpty ? getWorkoutExercisesDurationInMinutes(exercises).toString() : "";
    });
    widget.workout.exercises = exercises;
  }

  addTraining() {
    widget.workout.name = getTranslationObjectFromController(nameController, nameEnglishController);
    widget.workout.youTubeUrl = getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController);
    widget.workout.exerciseDurationSeconds = durationController.text.isNotEmpty ? int.tryParse(durationController.text)! * MINUTES_TO_SECONDS : null;
    widget.chooseStrengthExercise();
  }

  createWorkout() {
    if (_addWorkoutFormKey.currentState!.validate()) {
      var workout = WorkoutPostDTO(
          exercises: exercises,
          name: getTranslationObjectFromController(nameController, nameEnglishController),
          exerciseDurationSeconds: durationController.text.isNotEmpty ? int.tryParse(durationController.text)! * MINUTES_TO_SECONDS : null,
          notes: getTranslationObjectFromController(notesController, notesEnglishController),
          youTubeUrl: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController),
          videoFileKey: widget.workout.videoFileKey ?? "",
          videoWaitBetweenExercisesSeconds:
              videoWaitBetweenExercisesController.text.isNotEmpty ? int.tryParse(videoWaitBetweenExercisesController.text) : null);

      if (widget.isEditing) {
        exerciseBloc!.add(UpdateWorkoutEvent(id: widget.workout.id!, workout: workout, videoFile: videoFile, didChangeVideoFile: didChangeVideoFile));
      } else {
        exerciseBloc!.add(SaveWorkoutEvent(workout: workout, videoFile: videoFile));
      }

      context.beamBack();
    }
  }

  deleteWorkout() {
    exerciseBloc!.add(DeleteWorkoutEvent(id: widget.workout.id!));
    context.beamBack();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(builder: (context, size) {
      return Container(
        width: widget.containerWidth,
        child: Form(
          key: _addWorkoutFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldPadding(
                child: BreadCrumb(
                  items: [
                    BreadCrumbItem(
                      content: SelectableText(
                        context.i18n.workout,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  ],
                  divider: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              LanguageTabs(
                germanFields: [
                  SizedBox(
                    height: FIELD_SPACING,
                  ),
                  Container(
                    child: TextFormField(
                      controller: nameController,
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
                  Padding(
                    padding: EdgeInsets.only(bottom: FIELD_SPACING),
                    child: VideoFormField(
                        initialFileKey: widget.workout.videoFileKey ?? "",
                        initialVideoFile: widget.videoFile,
                        onUpdateFile: (file) {
                          setState(() {
                            videoFile = file;
                            hasChanges = true;
                            didChangeVideoFile = true;
                          });
                          widget.updateVideoFile(videoFile);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: FIELD_SPACING),
                    child: TextFormField(
                      controller: videoWaitBetweenExercisesController,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => {
                        setState(() {
                          this.hasChanges = true;
                        })
                      },
                      decoration: InputDecoration(
                        hintText: context.i18n.videoWaitBetweenExercisesSeconds,
                        labelText: context.i18n.videoWaitBetweenExercisesSeconds,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: datatableBorderColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: FIELD_SPACING),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: datatableBorderColor,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(6))),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                WorkoutExercisesTable(
                                  deleteExercise: deleteExerciseType,
                                  editExercise: widget.editAlreadyChosenExercise,
                                  exercises: exercises,
                                  parentWidth: widget.containerWidth,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -8,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedIconButton(
                              title: context.i18n.addExercise,
                              callback: addTraining,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: FIELD_SPACING * 2,
                  ),
                  Container(
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
                  SizedBox(height: FIELD_SPACING),
                  Container(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      controller: notesController,
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
                  ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SaveButton(
                        title: widget.isEditing ? context.i18n.save.toUpperCase() : context.i18n.create.toUpperCase(),
                        callback: () => createWorkout(),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      CancelButton(
                        callback: () => context.beamBack(),
                        hasChanges: this.hasChanges,
                      ),
                      if (widget.isEditing)
                        SizedBox(
                          width: width * 0.01,
                        ),
                      if (widget.isEditing)
                        DeleteButton(
                          confirmationText: context.i18n.deleteMessageWorkout(getTranslatedText(widget.workout.name, context)),
                          callback: () => deleteWorkout(),
                        ),
                    ],
                  ),
                ],
                englishFields: [
                  SizedBox(
                    height: FIELD_SPACING,
                  ),
                  Container(
                    child: TextFormField(
                      controller: nameEnglishController,
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
                  SizedBox(height: FIELD_SPACING),
                  Container(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      controller: notesEnglishController,
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
                  ),
                ],
              ),
              SizedBox(
                height: FIELD_SPACING,
              ),
            ],
          ),
        ),
      );
    });
  }
}
