import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/borg_slider.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ActivityStats extends StatefulWidget {
  final ActivityOverviewDTO activity;
  final PatientGetDTO? patient;
  final ActivityBloc? activityBloc;
  final bool isTrainingPlan;
  final Function()? onDeleteAll;
  final Function()? onDeleteThis;
  final Function()? onEditThis;
  final Function()? onEditAll;
  final Function()? onDuplicate;

  const ActivityStats({
    Key? key,
    required this.activity,
    this.patient,
    this.activityBloc,
    this.isTrainingPlan = false,
    this.onDeleteThis,
    this.onDeleteAll,
    this.onEditThis,
    this.onEditAll,
    this.onDuplicate,
  }) : super(key: key);

  @override
  _ActivityStatsState createState() => _ActivityStatsState();
}

class ActivityStatPair {
  final String title;
  final String value;
  final bool appendColon;

  ActivityStatPair({this.title = "", this.value = "", this.appendColon = true});
}

class _ActivityStatsState extends State<ActivityStats> {
  List<ActivityStatPair> getStatPairs() {
    List<ActivityStatPair> toReturn = [];
    if (widget.activity.type == ActivityType.APPOINTMENT) {
      toReturn.add(ActivityStatPair(
          title: context.i18n.time, value: getTranslatedTimeString(widget.activity.time ?? "", widget.activity.endTime ?? "", context)));
      toReturn.add(ActivityStatPair(title: context.i18n.name, value: getTranslatedText(widget.activity.name, context)));
      if ((widget.activity.activity!.appointment!.location ?? "").isNotEmpty &&
          !(widget.activity.activity!.appointment!.useLocationCoordinates ?? false)) {
        toReturn.add(ActivityStatPair(title: context.i18n.location, value: widget.activity.activity!.appointment!.location!));
      } else if ((widget.activity.activity!.appointment!.locationAddress ?? "").isNotEmpty &&
          (widget.activity.activity!.appointment!.useLocationCoordinates ?? false)) {
        toReturn.add(ActivityStatPair(title: context.i18n.location, value: widget.activity.activity!.appointment!.locationAddress!));
      }
      if ((widget.activity.activity!.appointment!.details ?? "").isNotEmpty) {
        toReturn.add(ActivityStatPair(title: context.i18n.details, value: widget.activity.activity!.appointment!.details!));
      }
      if (widget.activity.activity!.startDate != widget.activity.activity!.endDate) {
        toReturn.add(ActivityStatPair());
        toReturn.add(ActivityStatPair(title: context.i18n.plannedOnDays, value: getWeekdayAbbr(widget.activity.activity!.days)));
        toReturn.add(ActivityStatPair(title: context.i18n.repeat, value: widget.activity.activity!.repeats!.getTranslatedText(context)));
        toReturn.add(ActivityStatPair(title: context.i18n.amountRepeats, value: widget.activity.activity!.repeatCount.toString()));
        final DateFormat dateFormat = DateFormat("EEEE, dd. MMMM yyyy", Localizations.localeOf(context).languageCode);
        toReturn.add(
            ActivityStatPair(title: context.i18n.firstAppointment, value: dateFormat.format(DateTime.parse(widget.activity.activity!.startDate!))));
        toReturn
            .add(ActivityStatPair(title: context.i18n.lastAppointment, value: dateFormat.format(DateTime.parse(widget.activity.activity!.endDate!))));
      }
      return toReturn;
    }

    toReturn.add(ActivityStatPair(title: context.i18n.trainingType, value: widget.activity.type!.getTranslatedText(context)));
    toReturn.add(ActivityStatPair(title: context.i18n.exercise, value: getActivityName(widget.activity, context)));
    toReturn
        .add(ActivityStatPair(title: context.i18n.state, value: widget.activity.rating!.done! ? context.i18n.executed : context.i18n.notExecuted));
    if (widget.activity.rating!.done!) {
      if ((widget.activity.rating!.heartrate ?? 0) != 0) {
        toReturn.add(ActivityStatPair(title: context.i18n.actualHeartFrequency, value: "${widget.activity.rating!.heartrate} bpm"));
      }
      if ((widget.activity.durationMinutes ?? 0) > 0)
        toReturn.add(ActivityStatPair(
            title: widget.activity.type == ActivityType.EXTRA ? context.i18n.duration : context.i18n.actualTotalDuration,
            value: "${widget.activity.durationMinutes} ${context.i18n.durationValueMinutes}"));
    }
    if (widget.activity.type != ActivityType.EXTRA) {
      toReturn.add(ActivityStatPair());
    }
    if (widget.activity.type == ActivityType.ENDURANCE) {
      final EnduranceExercisePostDTO exercise = widget.activity.activity!.enduranceExercise!;
      if ((exercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0 && (exercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0) {
        toReturn.add(ActivityStatPair(
            title: context.i18n.trainingHeartFrequency,
            value: "${exercise.exerciseTrainingHeartRateLowerLimit} - ${exercise.exerciseTrainingHeartRateUpperLimit} bpm"));
      }
      toReturn.add(ActivityStatPair(
          title: context.i18n.duration,
          value: "${Duration(seconds: exercise.exerciseDurationSeconds!).inMinutes} ${context.i18n.durationValueMinutes}"));
      final String youTubeUrl = getTranslatedText(widget.activity.activity!.youTubeUrl, context);
      if (youTubeUrl.isNotEmpty) {
        toReturn.add(ActivityStatPair(title: context.i18n.youTubeUrl, value: youTubeUrl));
      }
      toReturn.add(ActivityStatPair(title: context.i18n.notes, value: getTranslatedText(exercise.hint, context)));
    } else if (widget.activity.type == ActivityType.INTERVAL) {
      final IntervalExercisePostDTO exercise = widget.activity.activity!.intervalExercise!;
      toReturn.add(ActivityStatPair(title: context.i18n.exerciseIntensityPhase));
      if ((exercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0 && (exercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0) {
        toReturn.add(ActivityStatPair(
            title: context.i18n.trainingHeartFrequency,
            value: "${exercise.exerciseTrainingHeartRateLowerLimit} - ${exercise.exerciseTrainingHeartRateUpperLimit} bpm"));
      }
      toReturn.add(ActivityStatPair(
          title: context.i18n.duration,
          value:
              "${exercise.selectedExerciseSeconds ?? false ? exercise.exerciseDurationSeconds.toString() + ' ${context.i18n.durationValueSeconds}' : Duration(seconds: exercise.exerciseDurationSeconds!).inMinutes.toString() + ' ${context.i18n.durationValueMinutes}'}"));
      toReturn.add(ActivityStatPair());
      toReturn.add(ActivityStatPair(title: context.i18n.exerciseRecoveryPhase));
      if ((exercise.recoveryTrainingHeartRateLowerLimit ?? 0) > 0 && (exercise.recoveryTrainingHeartRateUpperLimit ?? 0) > 0) {
        toReturn.add(ActivityStatPair(
            title: context.i18n.trainingHeartFrequency,
            value: "${exercise.recoveryTrainingHeartRateLowerLimit} - ${exercise.recoveryTrainingHeartRateUpperLimit} bpm"));
      }
      toReturn.add(ActivityStatPair(
          title: context.i18n.duration,
          value:
              "${exercise.selectedRecoverySeconds ?? false ? exercise.recoveryDurationSeconds.toString() + ' ${context.i18n.durationValueSeconds}' : Duration(seconds: exercise.recoveryDurationSeconds!).inMinutes.toString() + ' ${context.i18n.durationValueMinutes}'}"));
      toReturn.add(ActivityStatPair());
      toReturn.add(ActivityStatPair(title: context.i18n.intervalCount, value: exercise.intervalCount.toString()));
      final String youTubeUrl = getTranslatedText(widget.activity.activity!.youTubeUrl, context);
      if (youTubeUrl.isNotEmpty) {
        toReturn.add(ActivityStatPair(title: context.i18n.youTubeUrl, value: youTubeUrl));
      }
      toReturn.add(ActivityStatPair(title: context.i18n.notes, value: getTranslatedText(exercise.hint, context)));
    } else if (widget.activity.type == ActivityType.STRENGTHENING || widget.activity.type == ActivityType.HYPERTROPHY) {
      toReturn.addAll(getStrenghteningStatPairs(widget.activity.activity!.strengtheningExercise!));
      final String youTubeUrl = getTranslatedText(widget.activity.activity!.youTubeUrl, context);
      if (youTubeUrl.isNotEmpty) {
        toReturn.add(ActivityStatPair(title: context.i18n.youTubeUrl, value: youTubeUrl));
      }
      toReturn
          .add(ActivityStatPair(title: context.i18n.notes, value: getTranslatedText(widget.activity.activity!.strengtheningExercise!.hint, context)));
    } else if (widget.activity.type == ActivityType.OTHER) {
      final OtherExercisePostDTO exercise = widget.activity.activity!.otherExercise!;
      if ((exercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0 && (exercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0) {
        toReturn.add(ActivityStatPair(
            title: context.i18n.trainingHeartFrequency,
            value: "${exercise.exerciseTrainingHeartRateLowerLimit} - ${exercise.exerciseTrainingHeartRateUpperLimit} bpm"));
      }
      toReturn.add(ActivityStatPair(
          title: context.i18n.duration,
          value: "${Duration(seconds: exercise.exerciseDurationSeconds!).inMinutes} ${context.i18n.durationValueMinutes}"));
      final String youTubeUrl = getTranslatedText(widget.activity.activity!.youTubeUrl, context);
      if (youTubeUrl.isNotEmpty) {
        toReturn.add(ActivityStatPair(title: context.i18n.youTubeUrl, value: youTubeUrl));
      }
      toReturn.add(ActivityStatPair(title: context.i18n.notes, value: getTranslatedText(exercise.hint, context)));
    } else if (widget.activity.type == ActivityType.TASK) {
      final TaskPostDTO task = widget.activity.activity!.task!;
      final String youTubeUrl = getTranslatedText(widget.activity.activity!.youTubeUrl, context);
      if (youTubeUrl.isNotEmpty) {
        toReturn.add(ActivityStatPair(title: context.i18n.youTubeUrl, value: youTubeUrl));
      }
      toReturn.add(ActivityStatPair(title: context.i18n.taskNotes, value: getTranslatedText(task.hint, context)));
    } else if (widget.activity.type == ActivityType.WORKOUT) {
      final WorkoutPostDTO workout = widget.activity.activity!.workout!;
      for (int i = 0; i < workout.exercises.length; i++) {
        toReturn.add(ActivityStatPair(
            title: "${i + 1}. ${context.i18n.exercise}: ${getTranslatedText(workout.exercises[i].name, context)}", appendColon: false));
        toReturn.addAll(getStrenghteningStatPairs(workout.exercises[i]));
        final String youTubeUrl = getTranslatedText(workout.exercises[i].youTubeUrl, context);
        if (youTubeUrl.isNotEmpty) {
          toReturn.add(ActivityStatPair(
            title: context.i18n.youTubeUrl,
            value: youTubeUrl,
          ));
        }
        toReturn.add(ActivityStatPair(
            title: context.i18n.notes,
            value: getTranslatedText(workout.exercises[i].hint, context).isEmpty ? "-" : getTranslatedText(workout.exercises[i].hint, context)));
        if (i < workout.exercises.length - 1) {
          toReturn.add(ActivityStatPair());
        }
      }
      final String notes = getTranslatedText(workout.notes, context);
      if (notes.isNotEmpty) {
        if (workout.exercises.isNotEmpty) {
          toReturn.add(ActivityStatPair());
        }
        final String youTubeUrl = getTranslatedText(workout.youTubeUrl, context);
        if (youTubeUrl.isNotEmpty) {
          toReturn.add(ActivityStatPair(title: context.i18n.youTubeUrl, value: youTubeUrl));
        }
        toReturn.add(ActivityStatPair(title: context.i18n.notes, value: notes));
      }
    } else if (widget.activity.type == ActivityType.PREDEFINED_ACTIVITY || widget.activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
      final PredefinedActivityPostDTO exercise = widget.activity.activity!.predefinedActivity!;
      toReturn.add(ActivityStatPair(title: context.i18n.duration, value: "${exercise.durationMinutes} ${context.i18n.durationValueMinutes}"));
      if (exercise.startLocationAddress?.isNotEmpty ?? false) {
        toReturn.add(ActivityStatPair(title: context.i18n.startLocation, value: exercise.startLocationAddress!));
      }
      if (exercise.endLocationAddress?.isNotEmpty ?? false) {
        toReturn.add(ActivityStatPair(title: context.i18n.endLocation, value: exercise.endLocationAddress!));
      }
    }
    toReturn.add(ActivityStatPair());
    toReturn.add(ActivityStatPair(title: context.i18n.plannedOnDays, value: getWeekdayAbbr(widget.activity.activity!.days)));
    if (widget.activity.type != ActivityType.EXTRA) {
      toReturn.add(ActivityStatPair(title: context.i18n.repeat, value: widget.activity.activity!.repeats!.getTranslatedText(context)));
      toReturn.add(ActivityStatPair(title: context.i18n.amountRepeats, value: widget.activity.activity!.repeatCount.toString()));
    }
    if (!widget.isTrainingPlan) {
      final DateFormat dateFormat = DateFormat("EEEE, dd. MMMM yyyy", Localizations.localeOf(context).languageCode);
      toReturn.add(
          ActivityStatPair(title: context.i18n.firstAppointment, value: dateFormat.format(DateTime.parse(widget.activity.activity!.startDate!))));
      toReturn
          .add(ActivityStatPair(title: context.i18n.lastAppointment, value: dateFormat.format(DateTime.parse(widget.activity.activity!.endDate!))));
    }

    if ((widget.activity.rating!.note ?? "").isNotEmpty) {
      toReturn.add(ActivityStatPair());
      toReturn.add(ActivityStatPair(title: context.i18n.patientNotes, value: widget.activity.rating!.note!));
    }
    return toReturn;
  }

  List<ActivityStatPair> getStrenghteningStatPairs(final StrengtheningExercisePostDTO exercise) {
    final List<ActivityStatPair> toReturn = [];
    if ((exercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0 && (exercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0) {
      toReturn.add(ActivityStatPair(
          title: context.i18n.trainingHeartFrequency,
          value: "${exercise.exerciseTrainingHeartRateLowerLimit} - ${exercise.exerciseTrainingHeartRateUpperLimit} bpm"));
    }
    toReturn.add(ActivityStatPair(title: context.i18n.execution, value: getStrengtheningExecutionString(exercise, context)));
    toReturn
        .add(ActivityStatPair(title: context.i18n.muscleGroups, value: exercise.muscleGroups.map((e) => e.getTranslatedText(context)).join(", ")));
    toReturn.add(
        ActivityStatPair(title: context.i18n.exerciseNeedsEquipment, value: (exercise.needsEquipment ?? false) ? context.i18n.yes : context.i18n.no));
    if ((exercise.weight ?? 0) > 0) {
      toReturn.add(ActivityStatPair(title: context.i18n.weight, value: "${exercise.weight} ${context.i18n.kg}"));
    }
    return toReturn;
  }

  getWeekdayAbbr(List<DayOfWeek> weekdays) {
    List<String> days = [];

    weekdays.forEach((day) {
      days.add(day.getTranslatedShortName(context));
    });

    return days.join(", ");
  }

  editActivity() {
    Navigator.pop(context);
    context.beamToNamed(
      "/patients/${widget.patient!.id}/calendar/add-activity",
      data: {
        "patient": widget.patient,
        "chosenDate": DateTime.parse(widget.activity.activity!.startDate!),
        "editActivity": widget.activity.activity,
        "progressLevel": 1,
        "activityId": widget.activity.activityId,
        "activityType": widget.activity.type,
      },
    );
  }

  editThisActivity() {
    Navigator.pop(context);
    context.beamToNamed(
      "/patients/${widget.patient!.id}/calendar/add-activity",
      data: {
        "patient": widget.patient,
        "chosenDate": DateTime.parse(widget.activity.date!),
        "editActivity": widget.activity.activity,
        "progressLevel": 1,
        "activityId": widget.activity.activityId,
        "activityType": widget.activity.type,
        "doEditSingleActivity": true,
      },
    );
  }

  duplicateActivity() {
    Navigator.pop(context);
    context.beamToNamed(
      "/patients/${widget.patient!.id}/calendar/add-activity",
      data: {
        "patient": widget.patient,
        "chosenDate": DateTime.parse(DateTime.now().toString()),
        "editActivity": widget.activity.activity,
        "progressLevel": 2,
        "activityId": widget.activity.activityId,
        "activityType": widget.activity.type,
        "isDuplication": true,
      },
    );
  }

  deleteThis() {
    widget.activityBloc!
      ..add(HideActivityEvent(
          currentDate: DateTime.parse(widget.activity.date!),
          patientId: widget.patient!.id!,
          hideActivity: HideActivityPostDTO(activityId: widget.activity.activityId!, hideDate: widget.activity.date!, hideAll: false)));
    Navigator.pop(context);
  }

  deleteAll() {
    widget.activityBloc!
      ..add(HideActivityEvent(
          currentDate: DateTime.parse(widget.activity.date!),
          patientId: widget.patient!.id!,
          hideActivity: HideActivityPostDTO(activityId: widget.activity.activityId!, hideDate: widget.activity.date!, hideAll: true)));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double gapHeight = height * 0.02;
    double _value = widget.activity.rating?.rating == null ? 6.0 : widget.activity.rating!.rating!.toDouble();
    bool isDone = widget.activity.rating?.done ?? false;
    DateFormat dateFormat = DateFormat("EEEE, dd. MMMM yyyy", Localizations.localeOf(context).languageCode);

    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getStatPairs()
              .map(
                (e) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SelectableText(
                      e.title.isNotEmpty ? e.title + (e.appendColon ? ": " : "") : "",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SelectableLinkify(
                      text: e.value,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                      onOpen: (link) async {
                        if (await canLaunchUrlString(link.url)) {
                          String cleanedUrl = link.url;
                          if (cleanedUrl.endsWith("!")) {
                            cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                          }
                          launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                  ],
                ),
              )
              .toList(),
          SizedBox(
            height: gapHeight,
          ),
          if (isDone && widget.activity.type != ActivityType.TASK)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SelectableText(
                      "${context.i18n.rating}: ${_value.truncate()}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                SelectableText("0 = ${context.i18n.ratingValue_0_1}", style: Theme.of(context).textTheme.bodyLarge),
                SelectableText("10 = ${context.i18n.ratingValue_10}", style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(
                  height: height * 0.07,
                ),
                BorgSlider(
                  value: _value,
                  onChanged: (value) => {},
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      BorgUtils.getLevelString(context, _value),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: BorgUtils.getColor(_value),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.01,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          if ((widget.activity.plannedBy ?? "") != SYSTEM_CREATED) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.activity.type != ActivityType.EXTRA)
                  Expanded(
                    child: SaveButton(
                      title: context.i18n.editThis.toUpperCase(),
                      callback: () {
                        if (widget.onEditThis != null) {
                          widget.onEditThis!();
                        } else {
                          editThisActivity();
                        }
                      },
                      disabled: widget.activity.rating!.done!,
                      tooltipText: widget.activity.rating!.done! ? context.i18n.editThisActivityTooltip : "",
                    ),
                  ),
                if (widget.activity.type != ActivityType.EXTRA) SizedBox(width: 15),
                Expanded(
                  child: DeleteButton(
                    label: context.i18n.deleteThis.toUpperCase(),
                    callback: () {
                      if (widget.onDeleteThis != null) {
                        widget.onDeleteThis!();
                      } else {
                        deleteThis();
                      }
                    },
                    confirmationTitle: widget.activity.type != ActivityType.APPOINTMENT
                        ? context.i18n.deleteMessageThisActivityTitle
                        : context.i18n.deleteMessageThisAppointmentTitle,
                    confirmationText: (widget.activity.type != ActivityType.APPOINTMENT
                            ? context.i18n.deleteMessageThisActivity
                            : context.i18n.deleteMessageThisAppointment) +
                        "\n\n${widget.activity.type!.getTranslatedText(context)} - ${getTranslatedText(widget.activity.name, context)}" +
                        ((widget.activity.date ?? '').isNotEmpty ? "\n${dateFormat.format(DateTime.parse(widget.activity.date!))}" : ""),
                    disabled: widget.activity.rating!.done!,
                    tooltipText: widget.activity.rating!.done! ? context.i18n.deleteMessageThisActivityTooltip : "",
                  ),
                ),
              ],
            ),
            if ((widget.isTrainingPlan && (widget.activity.activity!.repeatCount! > 1 || widget.activity.activity!.days.length > 1)) ||
                (widget.activity.activity!.startDate != widget.activity.activity!.endDate))
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SaveButton(
                        title: context.i18n.editAll.toUpperCase(),
                        callback: () {
                          if (widget.onEditAll != null) {
                            widget.onEditAll!();
                          } else {
                            editActivity();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: DeleteButton(
                        label: context.i18n.deleteAll.toUpperCase(),
                        callback: () {
                          if (widget.onDeleteAll != null) {
                            widget.onDeleteAll!();
                          } else {
                            deleteAll();
                          }
                        },
                        confirmationTitle: widget.activity.type != ActivityType.APPOINTMENT
                            ? context.i18n.deleteMessageThisActivityTitle
                            : context.i18n.deleteMessageThisAppointmentTitle,
                        confirmationText: widget.activity.type != ActivityType.APPOINTMENT
                            ? (widget.isTrainingPlan ? context.i18n.deleteMessageAllActivitiesTrainingPlan : context.i18n.deleteMessageAllActivities)
                            : context.i18n.deleteMessageAllAppointments,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 15),
            if (widget.activity.type != ActivityType.EXTRA)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SaveButton(
                      title: context.i18n.duplicate.toUpperCase(),
                      callback: () {
                        if (widget.onDuplicate != null) {
                          widget.onDuplicate!();
                        } else {
                          duplicateActivity();
                        }
                      },
                    ),
                  ),
                ],
              ),
          ]
        ],
      ),
    );
  }
}
