import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/exercise_time_data.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'step_one.dart';
import 'step_three.dart';
import 'step_two.dart';
import 'widgets/planning_progress.dart';

class CreateActivityPage extends StatefulWidget {
  final PatientGetDTO? patient;
  final DateTime chosenDate;
  final int progressLevel;
  final ActivityPostDTO? editActivity;
  final ActivityType? activityType;
  final String? activityId;
  final bool isDuplication;
  final bool doEditSingleActivity;
  final bool isTrainingPlan;
  final bool showStepper;
  final Function(ActivityType, ActivityPostDTO)? onActivityCreated;
  final Function() onCancelled;

  CreateActivityPage(
      {Key? key,
      this.patient,
      required this.chosenDate,
      required this.progressLevel,
      this.editActivity,
      this.activityType,
      this.activityId,
      this.isDuplication = false,
      this.isTrainingPlan = false,
      this.showStepper = true,
      this.doEditSingleActivity = false,
      this.onActivityCreated,
      required this.onCancelled})
      : super(key: key);

  @override
  _CreateActivityPageState createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  ActivityType? activityType;
  var plannedActivity;
  int progressLevel = 0;
  bool selectedTrainingPlan = false;
  String selectedTrainingPlanId = "";

  @override
  void initState() {
    super.initState();
    if (widget.editActivity != null) {
      setState(() {
        activityType = widget.activityType;
        if (activityType == null) {
          if (widget.editActivity?.enduranceExercise != null) {
            activityType = ActivityType.ENDURANCE;
          } else if (widget.editActivity?.intervalExercise != null) {
            activityType = ActivityType.INTERVAL;
          } else if (widget.editActivity?.workout != null) {
            activityType = ActivityType.WORKOUT;
          } else if (widget.editActivity?.strengtheningExercise != null) {
            activityType = widget.editActivity?.strengtheningExercise?.type == ExerciseType.STRENGTHENING
                ? ActivityType.STRENGTHENING
                : ActivityType.HYPERTROPHY;
          } else if (widget.editActivity?.otherExercise != null) {
            activityType = ActivityType.OTHER;
          } else if (widget.editActivity?.appointment != null) {
            activityType = ActivityType.APPOINTMENT;
          } else if (widget.editActivity?.task != null) {
            activityType = ActivityType.TASK;
          }
        }
        if (activityType == ActivityType.ENDURANCE) {
          plannedActivity = widget.editActivity?.enduranceExercise;
        } else if (activityType == ActivityType.INTERVAL) {
          plannedActivity = widget.editActivity?.intervalExercise;
        } else if (activityType == ActivityType.WORKOUT) {
          plannedActivity = widget.editActivity?.workout;
        } else if (activityType == ActivityType.HYPERTROPHY || activityType == ActivityType.STRENGTHENING) {
          plannedActivity = widget.editActivity?.strengtheningExercise;
        } else if (activityType == ActivityType.OTHER) {
          plannedActivity = widget.editActivity?.otherExercise;
        } else if (activityType == ActivityType.APPOINTMENT) {
          plannedActivity = widget.editActivity?.appointment;
        } else if (activityType == ActivityType.TASK) {
          plannedActivity = widget.editActivity?.task;
        }
        progressLevel = widget.progressLevel;
      });
    }
  }

  planActivity(ActivityType type) {
    setState(() {
      selectedTrainingPlan = false;
      activityType = type;
      plannedActivity = null;
      progressLevel++;
    });
  }

  planTrainingPlan(String trainingPlanId) {
    setState(() {
      selectedTrainingPlan = true;
      selectedTrainingPlanId = trainingPlanId;
      activityType = ActivityType.EXTRA;
      plannedActivity = null;
      progressLevel++;
    });
  }

  backToStepOne() {
    setState(() {
      progressLevel--;
    });
  }

  backToStepTwo() {
    setState(() {
      progressLevel--;
    });
  }

  ActivityPostDTO getActivityDataFromTimeData(ExerciseTypeTimeData data) {
    var newActivity = ActivityPostDTO()
      ..days = data.selectedWeekdays
      ..repeatCount = data.repeatCount
      ..repeats = data.repeats
      ..time = data.time;

    if (widget.patient != null) {
      newActivity.patientId = widget.patient?.id;
    }
    newActivity.startDate = englishDateFormat.format(data.startDate);
    newActivity.endDate = englishDateFormat.format(data.endDate);

    if (activityType != ActivityType.APPOINTMENT && !selectedTrainingPlan) {
      newActivity.youTubeUrl = plannedActivity.youTubeUrl;
    }

    if (plannedActivity.name is String) {
      newActivity.name = getTranslationObjectFromText(plannedActivity.name, plannedActivity.name);
    } else {
      newActivity.name = plannedActivity.name;
    }

    if (plannedActivity is EnduranceExercisePostDTO) {
      newActivity.enduranceExercise = plannedActivity;
    } else if (plannedActivity is IntervalExercisePostDTO) {
      newActivity.intervalExercise = plannedActivity;
    } else if (plannedActivity is StrengtheningExercisePostDTO) {
      newActivity.strengtheningExercise = plannedActivity;
      newActivity.strengtheningExercise?.type = activityType == ActivityType.HYPERTROPHY ? ExerciseType.HYPERTROPHY : ExerciseType.STRENGTHENING;
    } else if (plannedActivity is WorkoutPostDTO) {
      newActivity.workout = plannedActivity;
    } else if (plannedActivity is OtherExercisePostDTO) {
      newActivity.otherExercise = plannedActivity;
    } else if (plannedActivity is AppointmentPostDTO) {
      newActivity.appointment = plannedActivity;
    } else if (plannedActivity is TrainingPlanPostDTO) {
      newActivity.trainingPlan = plannedActivity;
    } else if (plannedActivity is TaskPostDTO) {
      newActivity.task = plannedActivity;
    }
    return newActivity;
  }

  planExercise(ExerciseTypeTimeData data) {
    ActivityBloc activityBloc = BlocProvider.of<ActivityBloc>(context);
    var newActivity = getActivityDataFromTimeData(data);
    if (widget.editActivity == null || widget.isDuplication) {
      activityBloc.add(AddActivityEvent(activity: newActivity, patientId: widget.patient?.id ?? "", type: activityType!));
    } else if (widget.doEditSingleActivity) {
      activityBloc.add(AddActivityEvent(activity: newActivity, patientId: widget.patient!.id!, type: activityType!));
      activityBloc.add(HideActivityEvent(
          currentDate: widget.chosenDate,
          patientId: widget.patient!.id!,
          hideActivity: HideActivityPostDTO(activityId: widget.activityId!, hideDate: englishDateFormat.format(widget.chosenDate), hideAll: false)));
    } else {
      activityBloc.add(UpdateActivityEvent(activity: newActivity, id: widget.activityId!, patientId: widget.patient!.id!, type: activityType!));
    }

    context.beamToNamed(
      "/patients/${widget.patient!.id!}/calendar",
      data: {
        "patient": widget.patient,
      },
    );
  }

  goToStepThree(var exercise) {
    setState(() {
      progressLevel++;
    });
    plannedActivity = exercise;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(builder: (context, size) {
      double widthForContainer = size.isMobile
          ? width * 0.95
          : size.isTablet
              ? width * 0.9
              : width * 0.65;
      return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                top: height * 0.02,
              ),
              width: widthForContainer,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showStepper)
                    FormFieldPadding(
                      child: Text(
                        (progressLevel == 0 || activityType != ActivityType.APPOINTMENT) ? context.i18n.activity : context.i18n.activity_APPOINTMENT,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.showStepper)
                        PlanningProgress(
                          progressLevel: progressLevel,
                          longTexts: [
                            context.i18n.activityPlanStep1,
                            ...(progressLevel == 0 || activityType != ActivityType.APPOINTMENT
                                ? [context.i18n.activityPlanStep2, context.i18n.activityPlanStep3]
                                : [context.i18n.activityPlanStep2Appointment, context.i18n.activityPlanStep3Appointment])
                          ],
                          shortTexts: [
                            context.i18n.activityPlanStep1Short,
                            ...(progressLevel == 0 || activityType != ActivityType.APPOINTMENT
                                ? [context.i18n.activityPlanStep2, context.i18n.activityPlanStep3]
                                : [context.i18n.activityPlanStep2Appointment, context.i18n.activityPlanStep3Appointment])
                          ],
                        ),
                      if (progressLevel == 0)
                        StepOne(
                          planActivity: planActivity,
                          planTrainingPlan: planTrainingPlan,
                          onCancelled: widget.onCancelled,
                          isTrainingPlan: widget.isTrainingPlan,
                        ),
                      if (progressLevel == 1)
                        StepTwo(
                          patient: widget.patient,
                          plannedActivity: plannedActivity,
                          activityType: activityType!,
                          back: backToStepOne,
                          next: goToStepThree,
                          onCancelled: widget.onCancelled,
                          isTrainingPlan: selectedTrainingPlan,
                          trainingPlanId: selectedTrainingPlanId,
                        ),
                      if (progressLevel == 2)
                        StepThree(
                          plannedActivity: plannedActivity,
                          back: backToStepTwo,
                          planExercise: (data) => widget.onActivityCreated != null
                              ? widget.onActivityCreated!(activityType!, getActivityDataFromTimeData(data))
                              : planExercise(data),
                          selectedDay: widget.chosenDate,
                          editActivity: widget.editActivity,
                          doEditSingleActivity: widget.doEditSingleActivity,
                          activityType: activityType!,
                          isDuplication: widget.isDuplication,
                          onCancelled: widget.onCancelled,
                          isTrainingPlan: widget.isTrainingPlan,
                          selectedTrainingPlan: selectedTrainingPlan,
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
