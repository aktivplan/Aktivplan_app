import 'dart:convert';
import 'dart:math';

import 'package:apt_api/api.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:aptapp/activity/create_activity_page.dart';
import 'package:aptapp/activity/widgets/back_next_buttons.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/exercises/bloc/training_plan_repository.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/stats/activity_stats.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ModifyTrainingPlanPage extends StatefulWidget {
  final String trainingPlanId;
  final bool copyExisitingPlan;
  final TrainingPlanPostDTO? trainingPlanToEdit;
  final Function()? back;
  final Function(TrainingPlanPostDTO)? next;
  final Function()? onCancelled;

  ModifyTrainingPlanPage(
      {Key? key, this.trainingPlanId = "", this.copyExisitingPlan = false, this.trainingPlanToEdit, this.back, this.next, this.onCancelled})
      : super(key: key);

  @override
  _ModifyTrainingPlanPageState createState() => _ModifyTrainingPlanPageState();
}

class TrainingPlanDragData {
  int week = 0;
  DayOfWeek dayOfWeek = DayOfWeek.MONDAY;
  TrainingPlanExercisePostDTO training = TrainingPlanExercisePostDTO();
}

class _ModifyTrainingPlanPageState extends State<ModifyTrainingPlanPage> {
  TrainingPlanPostDTO? trainingPlan;
  ExerciseBloc? exerciseBloc;

  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _scrollController = ScrollController();
  bool hasChanges = false;
  bool addingActivity = false;
  bool loading = false;
  bool planForPatient = false;
  bool editThis = false;
  bool overrideTrainingPlan = false;
  List<TrainingPlanOverviewDTO> trainingPlans = [];
  int selectedWeekEntry = -1;
  bool isDuplication = false;
  ActivityPostDTO? activityToEdit;
  TrainingPlanExercisePostDTO? activityToEditTrainingPlanWeekEntry;
  int activityToEditProgressLevel = 0;
  DayOfWeek selectedDayOfWeek = DayOfWeek.MONDAY;
  String trainingPlanId = "";

  @override
  void initState() {
    super.initState();
    planForPatient = widget.back != null && widget.next != null && widget.onCancelled != null;
    exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
    trainingPlanId = widget.trainingPlanId;
    overrideTrainingPlan = widget.trainingPlanId.isNotEmpty && !widget.copyExisitingPlan;

    if (widget.trainingPlanId.isNotEmpty) {
      loadTrainingPlan(widget.trainingPlanId);
    } else if (widget.trainingPlanToEdit == null) {
      trainingPlan = TrainingPlanPostDTO()..numberOfWeeks = 1;
      _nameController.text = "";
      _descriptionController.text = "";
    } else {
      trainingPlan = widget.trainingPlanToEdit;
      _nameController.text = trainingPlan?.name ?? "";
      _descriptionController.text = trainingPlan?.description ?? "";
    }

    if (planForPatient) {
      TrainingPlanRepository().fetchTrainingPlans().then(
        (value) {
          setState(() {
            trainingPlans = value ?? [];
          });
        },
      );
    }
  }

  loadTrainingPlan(String trainingPlanId) async {
    setState(() {
      loading = true;
    });
    final TrainingPlanPostDTO? value = await TrainingPlanRepository().fetchTrainingPlan(trainingPlanId);
    if (widget.copyExisitingPlan && value != null) {
      value.name = context.i18n.trainingPlanCopyOf(value.name ?? "");
    }
    setState(() {
      trainingPlan = value;
      _nameController.text = trainingPlan?.name ?? "";
      _descriptionController.text = trainingPlan?.description ?? "";
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (addingActivity) {
      DateTime startDate = DateTime.now();
      while (DayOfWeek.values[startDate.weekday - 1] != selectedDayOfWeek) {
        startDate = startDate.add(Duration(days: 1));
      }
      if (editThis) {
        activityToEdit!.startDate = startDate.toString();
        activityToEdit!.days = [DayOfWeek.values[startDate.weekday - 1]];
        activityToEdit!.repeatCount = 1;
        activityToEdit!.repeats = ActivityRepeat.NEVER;
      }
      return CreateActivityPage(
        isTrainingPlan: true,
        chosenDate: startDate,
        showStepper: !planForPatient,
        editActivity: activityToEdit,
        progressLevel: activityToEditProgressLevel,
        onActivityCreated: addedActivityToTrainingPlan,
        doEditSingleActivity: editThis && !isDuplication,
        onCancelled: () {
          setState(() {
            addingActivity = false;
          });
        },
      );
    }

    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Center(
        child: ResponsiveBuilder(builder: (context, size) {
          double containerWidth = size.isMobile
              ? width * 0.95
              : size.isTablet
                  ? width * 0.9
                  : width * 0.65;

          return Container(
            width: containerWidth,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!planForPatient)
                    FormFieldPadding(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              context.i18n.trainingPlan,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (planForPatient && trainingPlans.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: DropdownButtonFormField<TrainingPlanOverviewDTO?>(
                        decoration: InputDecoration(
                          labelText: context.i18n.trainingPlan,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                        initialValue: trainingPlans.firstWhere((element) => element.id == trainingPlanId, orElse: null),
                        items: trainingPlans.map((e) => DropdownMenuItem<TrainingPlanOverviewDTO>(value: e, child: Text(e.name ?? ""))).toList(),
                        onChanged: (value) {
                          setState(() {
                            trainingPlanId = value!.id!;
                            loadTrainingPlan(trainingPlanId);
                            setState(() {
                              this.hasChanges = true;
                            });
                          });
                        },
                      ),
                    ),
                  if (!planForPatient)
                    FormFieldPadding(
                      child: TextFormField(
                        controller: _nameController,
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
                  if (!planForPatient || trainingPlans.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: context.i18n.description,
                          hintMaxLines: 1,
                          labelText: context.i18n.description,
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
                  if (!planForPatient || trainingPlans.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: SelectableText(context.i18n.hintRequiredFields,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: lightTextColor,
                              )),
                    ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
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
                            context.i18n.activityMoveHint,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.1, color: infoIconColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: containerWidth,
                    child: Scrollbar(
                      controller: _scrollController,
                      scrollbarOrientation: ScrollbarOrientation.top,
                      interactive: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: GestureDetector(
                          onTap: containerWidth < 800 ? () => null : null,
                          onPanUpdate: (details) {
                            if (details.delta.dx > 0) {
                              _scrollController.jumpTo(max(0, _scrollController.offset - 20));
                            } else if (details.delta.dx < 0) {
                              _scrollController.jumpTo(min(_scrollController.position.maxScrollExtent, _scrollController.offset + 20));
                            }
                          },
                          child: renderWeekEntries(max(containerWidth, 800)),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: createNewWeek,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2, right: 5),
                          child: Icon(MdiIcons.plusBoxMultipleOutline, size: 15),
                        ),
                        Text(
                          context.i18n.newEmptyWeek,
                          style: getBreadCrumbStyle(context),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: canDeleteLastWeek() ? deleteLastWeek : null,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2, right: 5),
                          child: Icon(MdiIcons.minusBoxMultipleOutline, size: 15),
                        ),
                        Text(
                          context.i18n.deleteLastWeek,
                          style: canDeleteLastWeek() ? getBreadCrumbStyle(context) : getBreadCrumbStyle(context)?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  if (planForPatient)
                    BackNextButtons(
                      back: widget.back!,
                      next: goToStepThree,
                      nextButtonTitle: context.i18n.next,
                      hasChanges: hasChanges,
                      onCancelled: widget.onCancelled,
                    ),
                  if (!planForPatient)
                    Row(
                      children: [
                        SaveButton(
                          title: overrideTrainingPlan ? context.i18n.save.toUpperCase() : context.i18n.create.toUpperCase(),
                          callback: updateTrainingPlan,
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        CancelButton(
                          callback: () => context.beamToNamed('/training/plan'),
                          hasChanges: this.hasChanges,
                        ),
                        if (overrideTrainingPlan)
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.01),
                            child: DeleteButton(
                                confirmationTitle: context.i18n.deleteMessageExerciseTypeTitle(context.i18n.trainingPlan),
                                confirmationText: context.i18n.deleteMessageExerciseTypeTrainingPlan,
                                callback: deleteTrainingPlan),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget renderWeekEntries(double totalWidth) {
    List<Widget> weekEntries = [];
    for (int i = 1; i <= (trainingPlan?.numberOfWeeks ?? 0); ++i) {
      weekEntries.add(Container(
        width: totalWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: DayOfWeek.values.map((dayOfWeek) {
            final bool firstEntry = weekEntries.isEmpty;
            return DragTarget(
              onAcceptWithDetails: (DragTargetDetails<TrainingPlanDragData> dragTargetDetails) {
                final data = dragTargetDetails.data;
                if (data.dayOfWeek == dayOfWeek && data.week == i) {
                  return;
                }
                final oldExercises =
                    trainingPlan!.exercises.map((e) => TrainingPlanExercisePostDTO.fromJson(jsonDecode(jsonEncode(e.toJson())))).toList();
                final TrainingPlanExercisePostDTO newExercise = TrainingPlanExercisePostDTO()
                  ..startingWeek = i
                  ..type = data.training.type
                  ..time = data.training.time
                  ..appointment = data.training.appointment
                  ..enduranceExercise = data.training.enduranceExercise
                  ..intervalExercise = data.training.intervalExercise
                  ..strengtheningExercise = data.training.strengtheningExercise
                  ..workout = data.training.workout
                  ..otherExercise = data.training.otherExercise
                  ..task = data.training.task
                  ..days = [dayOfWeek]
                  ..repeats = ActivityRepeat.NEVER
                  ..repeatCount = 1;
                setState(() {
                  trainingPlan!.exercises = [...trainingPlan!.exercises, newExercise];
                });
                removedActivityFromTrainingPlan(false, data.training, data.week, data.dayOfWeek);
                if ((data.training.repeatCount ?? 1) > 1 || data.training.days.length > 1) {
                  Flushbar? snackbar;
                  snackbar = getSnackbar(
                    context.i18n.activityMoveWarning,
                    false,
                    context,
                    warning: true,
                    buttonTitle: context.i18n.undoMove,
                    duration: Duration(seconds: 7),
                    buttonAction: () {
                      setState(() {
                        trainingPlan!.exercises = oldExercises.cast<TrainingPlanExercisePostDTO>();
                      });
                      snackbar?.dismiss();
                    },
                  );
                  snackbar.show(context);
                }
              },
              builder: (context, candidateData, rejectedData) {
                return Column(
                  children: [
                    if (firstEntry)
                      Container(
                        height: 35,
                        width: totalWidth / 7,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: datatableBorderColor,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(dayOfWeek == DayOfWeek.MONDAY ? 5 : 0),
                              topRight: Radius.circular(dayOfWeek == DayOfWeek.SUNDAY ? 5 : 0)),
                        ),
                        child: Text(
                          dayOfWeek.getTranslatedShortName(context),
                          style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        addActivityToTrainingPlan(i, dayOfWeek);
                      },
                      child: Container(
                        height: 150,
                        width: totalWidth / 7,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: datatableBorderColor,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(dayOfWeek == DayOfWeek.MONDAY ? 5 : 0),
                              bottomRight: Radius.circular(dayOfWeek == DayOfWeek.SUNDAY ? 5 : 0)),
                        ),
                        child: getPlanEntriesForDay(i, dayOfWeek),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ));
    }
    return Column(
      children: weekEntries,
    );
  }

  int getEndWeekOfTrainingPlanExercise(TrainingPlanExercisePostDTO exercise) {
    switch (exercise.repeats) {
      case ActivityRepeat.NEVER:
        return exercise.startingWeek!;
      case ActivityRepeat.WEEKLY:
        return exercise.startingWeek! + (exercise.repeatCount ?? 1) - 1;
      case ActivityRepeat.BIWEEKLY:
        return exercise.startingWeek! + ((exercise.repeatCount ?? 1) - 1) * 2;
    }
    return exercise.startingWeek!;
  }

  Widget getPlanEntriesForDay(int selectedWeek, DayOfWeek dayOfWeek) {
    final List<TrainingPlanExercisePostDTO> trainingPlansForDay = [];
    trainingPlan!.exercises.forEach((element) {
      if (!element.days.contains(dayOfWeek)) {
        return;
      }
      if (element.datesToHide.contains("$selectedWeek-${dayOfWeek.getWeekday()}")) {
        return;
      }
      List<int> activeInWeeks = [];
      activeInWeeks.add(element.startingWeek!);
      if (element.repeats != ActivityRepeat.NEVER) {
        for (int i = 1; i < (element.repeatCount ?? 1); ++i) {
          activeInWeeks.add(element.startingWeek! + i * (element.repeats == ActivityRepeat.WEEKLY ? 1 : 2));
        }
      }
      if (!activeInWeeks.contains(selectedWeek)) {
        return;
      }
      trainingPlansForDay.add(element);
    });

    return ListView.builder(
      itemCount: trainingPlansForDay.length,
      itemBuilder: (context, index) {
        final training = trainingPlansForDay[index];
        Widget icon = Icon(training.type!.iconData, color: Colors.white);
        final theme = Theme.of(context);
        final String timeText = getTranslatedTimeString(training.time ?? "", "", context);
        String? nameText;
        int durationMinutes = -1;
        final List<String> descriptionTexts = [];

        switch (training.type) {
          case ActivityType.APPOINTMENT:
            nameText = training.appointment!.name ?? "";
            break;
          case ActivityType.ENDURANCE:
            nameText = getTranslatedText(training.enduranceExercise!.name, context);
            durationMinutes = getEnduranceExerciseDurationMinutes(training.enduranceExercise!);
            break;
          case ActivityType.HYPERTROPHY:
          case ActivityType.STRENGTHENING:
            nameText = getTranslatedText(training.strengtheningExercise!.name, context);
            durationMinutes = getStrengtheningExerciseDurationMinutes(training.strengtheningExercise!);
            break;
          case ActivityType.INTERVAL:
            nameText = getTranslatedText(training.intervalExercise!.name, context);
            durationMinutes = getIntervalExerciseDurationMinutes(training.intervalExercise!);
            break;
          case ActivityType.WORKOUT:
            nameText = getTranslatedText(training.workout!.name, context);
            durationMinutes = training.workout?.exerciseDurationSeconds != null
                ? Duration(seconds: training.workout!.exerciseDurationSeconds!).inMinutes
                : getWorkoutExercisesDurationInMinutes(training.workout!.exercises);
            break;
          case ActivityType.OTHER:
            nameText = getTranslatedText(training.otherExercise!.name, context);
            durationMinutes = getOtherExerciseDurationMinutes(training.otherExercise!);
            break;
          case ActivityType.TASK:
            descriptionTexts.add(ActivityType.TASK.getTranslatedText(context));
            nameText = getTranslatedText(training.task!.name, context);
            durationMinutes = 0;
            break;
        }

        if (timeText.isNotEmpty) {
          descriptionTexts.add(timeText);
        }
        if (durationMinutes > 0) {
          descriptionTexts.add("$durationMinutes min");
        }

        final Widget tile = GestureDetector(
          onTap: () {
            setState(() {
              selectedWeekEntry = selectedWeek;
              selectedDayOfWeek = dayOfWeek;
            });
            showPlannedActivity(training);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Container(
              decoration: BoxDecoration(color: training.type!.backgroundColor, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Transform.scale(scale: 0.75, child: icon),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nameText ?? "",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            descriptionTexts.join(", "),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  )
                ],
              ),
            ),
          ),
        );

        return LongPressDraggable(
          child: tile,
          data: new TrainingPlanDragData()
            ..training = training
            ..week = selectedWeek
            ..dayOfWeek = dayOfWeek,
          feedback: SizedBox(
            width: 200,
            child: Opacity(opacity: 0.8, child: tile),
          ),
        );
      },
    );
  }

  bool canDeleteLastWeek() {
    return (trainingPlan?.numberOfWeeks ?? 1) > 1;
  }

  createNewWeek() {
    setState(() {
      trainingPlan!.numberOfWeeks = trainingPlan!.numberOfWeeks! + 1;
      hasChanges = true;
    });
  }

  deleteLastWeek() {
    DeleteButton.showDeleteConfirmationDialog(
      context,
      "",
      "",
      () {
        setState(() {
          trainingPlan!.numberOfWeeks = trainingPlan!.numberOfWeeks! - 1;
          hasChanges = true;
          trainingPlan!.exercises.forEach((element) {
            if (getEndWeekOfTrainingPlanExercise(element) > trainingPlan!.numberOfWeeks!) {
              element.repeatCount = element.repeatCount! - 1;
            }
          });
          trainingPlan!.exercises = trainingPlan!.exercises.where((element) => (element.repeatCount ?? 0) > 0).toList();
        });
      },
    );
  }

  addActivityToTrainingPlan(int selectedWeek, DayOfWeek dayOfWeek) {
    setState(() {
      selectedWeekEntry = selectedWeek;
      selectedDayOfWeek = dayOfWeek;
      activityToEditProgressLevel = 0;
      activityToEdit = null;
      addingActivity = true;
    });
  }

  addedActivityToTrainingPlan(ActivityType type, ActivityPostDTO activity) {
    final TrainingPlanExercisePostDTO exercise = TrainingPlanExercisePostDTO()
      ..startingWeek = selectedWeekEntry
      ..type = type
      ..time = activity.time
      ..appointment = activity.appointment
      ..enduranceExercise = activity.enduranceExercise
      ..intervalExercise = activity.intervalExercise
      ..strengtheningExercise = activity.strengtheningExercise
      ..workout = activity.workout
      ..otherExercise = activity.otherExercise
      ..task = activity.task
      ..days = activity.days
      ..repeats = activity.repeats
      ..repeatCount = activity.repeatCount;
    if (activityToEditTrainingPlanWeekEntry != null) {
      exercise.datesToHide = activityToEditTrainingPlanWeekEntry?.datesToHide ?? [];
    }
    int endWeek = getEndWeekOfTrainingPlanExercise(exercise);
    setState(() {
      if (endWeek > trainingPlan!.numberOfWeeks!) {
        trainingPlan!.numberOfWeeks = endWeek;
      }
      trainingPlan!.exercises = [...trainingPlan!.exercises, exercise];
      addingActivity = false;
      hasChanges = true;
    });
    if (!this.isDuplication && activityToEditTrainingPlanWeekEntry != null) {
      removedCurrentActivityFromTrainingPlan(!this.editThis);
    }
  }

  removedCurrentActivityFromTrainingPlan(bool removeAll) {
    removedActivityFromTrainingPlan(removeAll, activityToEditTrainingPlanWeekEntry!, selectedWeekEntry, selectedDayOfWeek);
  }

  removedActivityFromTrainingPlan(bool removeAll, TrainingPlanExercisePostDTO exercise, int selectedWeek, DayOfWeek dayOfWeek) {
    setState(() {
      var temporaryExercises = [...trainingPlan!.exercises];
      temporaryExercises.remove(exercise);
      trainingPlan!.exercises = temporaryExercises;
    });
    if (!removeAll) {
      int occurences = exercise.days.length * (exercise.repeatCount ?? 0);
      if (exercise.datesToHide.length + 1 < occurences) {
        exercise.datesToHide = [...exercise.datesToHide, "$selectedWeek-${dayOfWeek.getWeekday()}"];
        setState(() {
          trainingPlan!.exercises = [...trainingPlan!.exercises, exercise];
        });
      }
    }
  }

  updateTrainingPlan() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    trainingPlan!.name = _nameController.text;
    trainingPlan!.description = _descriptionController.text;
    if (!overrideTrainingPlan) {
      exerciseBloc!.add(SaveTrainingPlanEvent(trainingPlan!));
    } else {
      exerciseBloc!.add(UpdateTrainingPlanEvent(widget.trainingPlanId, trainingPlan!));
    }
    context.beamToNamed('/training/plan');
  }

  goToStepThree() {
    if (formKey.currentState!.validate()) {
      trainingPlan!.name = _nameController.text;
      trainingPlan!.description = _descriptionController.text;
      widget.next!(trainingPlan!);
    }
  }

  deleteTrainingPlan() {
    exerciseBloc!.add(DeleteTrainingPlanEvent(widget.trainingPlanId));
    context.beamToNamed('/training/plan');
  }

  ActivityPostDTO trainingPlanWeekEntryToActivity(TrainingPlanExercisePostDTO trainingPlanWeekEntry) {
    final ActivityPostDTO activity = ActivityPostDTO()
      ..time = trainingPlanWeekEntry.time
      ..appointment = trainingPlanWeekEntry.appointment
      ..enduranceExercise = trainingPlanWeekEntry.enduranceExercise
      ..intervalExercise = trainingPlanWeekEntry.intervalExercise
      ..strengtheningExercise = trainingPlanWeekEntry.strengtheningExercise
      ..workout = trainingPlanWeekEntry.workout
      ..otherExercise = trainingPlanWeekEntry.otherExercise
      ..task = trainingPlanWeekEntry.task
      ..days = trainingPlanWeekEntry.days
      ..repeats = trainingPlanWeekEntry.repeats
      ..repeatCount = trainingPlanWeekEntry.repeatCount;
    return activity;
  }

  Future<void> showPlannedActivity(TrainingPlanExercisePostDTO trainingPlanWeekEntry) async {
    final ActivityOverviewDTO activity = ActivityOverviewDTO()
      ..type = trainingPlanWeekEntry.type
      ..time = trainingPlanWeekEntry.time
      ..repeats = trainingPlanWeekEntry.repeats;
    activity.activity = trainingPlanWeekEntryToActivity(trainingPlanWeekEntry);
    if (trainingPlanWeekEntry.enduranceExercise != null) {
      activity.name = trainingPlanWeekEntry.enduranceExercise!.name;
      activity.activity!.youTubeUrl = trainingPlanWeekEntry.enduranceExercise!.youTubeUrl;
      activity.activity!.videoFileKey = trainingPlanWeekEntry.enduranceExercise!.videoFileKey;
    } else if (trainingPlanWeekEntry.intervalExercise != null) {
      activity.name = trainingPlanWeekEntry.intervalExercise!.name;
      activity.activity!.youTubeUrl = trainingPlanWeekEntry.intervalExercise!.youTubeUrl;
      activity.activity!.videoFileKey = trainingPlanWeekEntry.intervalExercise!.videoFileKey;
    } else if (trainingPlanWeekEntry.strengtheningExercise != null) {
      activity.name = trainingPlanWeekEntry.strengtheningExercise!.name;
      activity.activity!.youTubeUrl = trainingPlanWeekEntry.strengtheningExercise!.youTubeUrl;
      activity.activity!.videoFileKey = trainingPlanWeekEntry.strengtheningExercise!.videoFileKey;
    } else if (trainingPlanWeekEntry.workout != null) {
      activity.name = trainingPlanWeekEntry.workout!.name;
      activity.activity!.youTubeUrl = trainingPlanWeekEntry.workout!.youTubeUrl;
      activity.activity!.videoFileKey = trainingPlanWeekEntry.workout!.videoFileKey;
    } else if (trainingPlanWeekEntry.otherExercise != null) {
      activity.name = trainingPlanWeekEntry.otherExercise!.name;
      activity.activity!.youTubeUrl = trainingPlanWeekEntry.otherExercise!.youTubeUrl;
      activity.activity!.videoFileKey = trainingPlanWeekEntry.otherExercise!.videoFileKey;
    } else if (trainingPlanWeekEntry.appointment != null) {
      activity.name = getTranslationObjectFromText(trainingPlanWeekEntry.appointment!.name, trainingPlanWeekEntry.appointment!.name);
    } else if (trainingPlanWeekEntry.task != null) {
      activity.name = trainingPlanWeekEntry.task!.name;
    }

    activity.rating = ActivityPatientRatingPostDTO()..done = false;
    activityToEditTrainingPlanWeekEntry = trainingPlanWeekEntry;
    setState(() {
      activityToEdit = activity.activity;
    });

    double width = MediaQuery.of(context).size.width;
    String dialogTitle = context.i18n.plannedActivity;
    if (trainingPlanWeekEntry.type == ActivityType.APPOINTMENT || trainingPlanWeekEntry.type == ActivityType.TASK) {
      dialogTitle = trainingPlanWeekEntry.type!.getTranslatedText(context);
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ResponsiveBuilder(
          builder: (context, size) {
            double alertSizePadding = size.isMobile
                ? width * 0.02
                : size.isDesktop
                    ? width * 0.34
                    : width * 0.2;
            double containerWidth = size.isMobile ? width * 0.94 : 400;
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: alertSizePadding,
              ),
              contentPadding: EdgeInsets.only(top: 15.0, bottom: 8, left: 20, right: 20),
              title: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.close,
                            size: 24,
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dialogTitle, style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                width: containerWidth,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      ActivityStats(
                        activity: activity,
                        isTrainingPlan: true,
                        onEditAll: () {
                          Navigator.pop(context);
                          setState(() {
                            activityToEditProgressLevel = 1;
                            isDuplication = false;
                            addingActivity = true;
                            editThis = false;
                          });
                        },
                        onEditThis: () {
                          Navigator.pop(context);
                          setState(() {
                            activityToEditProgressLevel = 1;
                            isDuplication = false;
                            addingActivity = true;
                            editThis = true;
                          });
                        },
                        onDuplicate: () {
                          Navigator.pop(context);
                          setState(() {
                            activityToEditProgressLevel = 2;
                            isDuplication = true;
                            addingActivity = true;
                          });
                        },
                        onDeleteAll: () {
                          Navigator.pop(context);
                          removedCurrentActivityFromTrainingPlan(true);
                        },
                        onDeleteThis: () {
                          Navigator.pop(context);
                          removedCurrentActivityFromTrainingPlan(false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
