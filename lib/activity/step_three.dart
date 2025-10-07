import 'package:apt_api/api.dart';
import 'package:aptapp/activity/widgets/weekday_options.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/widgets/date_picker_row.dart';
import 'package:aptapp/exercises/widgets/time_picker_row.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/exercise_time_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:aptapp/utils/enums.dart';

import 'widgets/back_next_buttons.dart';

class StepThree extends StatefulWidget {
  final plannedActivity;
  final Function() back;
  final Function(ExerciseTypeTimeData) planExercise;
  final DateTime selectedDay;
  final ActivityPostDTO? editActivity;
  final bool doEditSingleActivity;
  final ActivityType activityType;
  final bool isDuplication;
  final bool isTrainingPlan;
  final bool selectedTrainingPlan;
  final Function() onCancelled;

  StepThree({
    Key? key,
    required this.plannedActivity,
    required this.back,
    required this.planExercise,
    required this.selectedDay,
    this.editActivity,
    required this.activityType,
    this.isDuplication = false,
    this.isTrainingPlan = false,
    this.selectedTrainingPlan = false,
    this.doEditSingleActivity = false,
    required this.onCancelled,
  }) : super(key: key);

  @override
  _StepThreeState createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final _planFormKey = GlobalKey<FormState>();
  final repetitionAmountController = TextEditingController();

  ActivityRepeat repetition = ActivityRepeat.NEVER;
  int repetitionAmount = 1;
  DateTime? activityStart;
  DateTime? activityEnd;
  List<int> selectedDays = [];
  DateTime? selectedDay;
  DateTime? selectedEndDate;
  DateTime? realEnddate;
  bool hasChanges = false;
  double inputSpacing = 20;
  String time = "";
  bool validated = false;

  toggleDay(int value) {
    setState(() {
      if (selectedDays.contains(value)) {
        selectedDays.remove(value);
      } else {
        selectedDays.add(value);
      }
      selectedDays.sort();

      DateTime? date = selectedDay;

      if (selectedDays.isNotEmpty && date != null) {
        while (!selectedDays.contains(date!.weekday)) {
          date = date.add(Duration(days: 1));
        }
        activityStart = date;
        getLastDate(repetitionAmount, selectedDays, repetition);
      } else {
        activityStart = null;
      }
    });
  }

  getLastDate(repetitionAmount, selectedDays, ActivityRepeat repetition) {
    DateTime date = activityStart!;
    var reps = 1;
    if (selectedDays.isNotEmpty) {
      setState(() {
        if (repetition == ActivityRepeat.WEEKLY) {
          //if a calendar date chosen
          if (selectedEndDate != null) {
            activityEnd = selectedEndDate;
            while (!date.isAfter(activityEnd!)) {
              date = date.add(Duration(days: 1));
              if (selectedDays.contains(date.weekday)) {
                reps++;
              }
            }
            repetitionAmount = num.parse((reps / selectedDays.length).toStringAsFixed(1));
            repetitionAmountController.text = (reps ~/ selectedDays.length).toString();
          }
          // repetition amount given by user
          else {
            int max = repetitionAmount * selectedDays.length;
            //counting training days until given rep-amount to calculate enddate
            while (reps < max) {
              date = date.add(Duration(days: 1));
              if (selectedDays.contains(date.weekday)) {
                reps++;
              }
            }
            activityEnd = date;
          }
        } else if (repetition == ActivityRepeat.BIWEEKLY) {
          if (selectedEndDate != null) {
            activityEnd = selectedEndDate;

            int round = 1;

            while (!date.isAfter(activityEnd!)) {
              if (round == selectedDays.length) {
                date = date.add(Duration(days: 8)); //add a week
                round = 0;
              } else {
                date = date.add(Duration(days: 1));
              }
              if (selectedDays.contains(date.weekday)) {
                reps++;
                round++;
                realEnddate = date;
              }
            }
            repetitionAmount = num.parse((reps / selectedDays.length).toStringAsFixed(1));
            repetitionAmountController.text = (reps ~/ selectedDays.length).toString();
          }
          // repetition amount given by user
          else {
            int round = 1;
            //as long as smaller than selected repetitions
            int max = repetitionAmount * selectedDays.length;
            while (reps < max) {
              if (round == selectedDays.length) {
                date = date.add(Duration(days: 8)); //add a week
                round = 0;
              } else {
                date = date.add(Duration(days: 1));
              }
              if (selectedDays.contains(date.weekday)) {
                reps++;
                round++;
              }
            }
            activityEnd = date;
          }
        } else if (repetition == ActivityRepeat.NEVER) {
          final int startWeekday = date.weekday;
          DateTime lastFittingDate = date;
          do {
            if (selectedDays.contains(date.weekday)) {
              lastFittingDate = date;
            }
            date = date.add(Duration(days: 1));
          } while (date.weekday != startWeekday);
          activityEnd = lastFittingDate;
        }
      });
    }
    setRepetition();
  }

  _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: Localizations.localeOf(context),
      initialDate: DateTime.now().toLocal(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        repetitionAmount = 1;
        repetitionAmountController.text = "";
        getLastDate(repetitionAmount, selectedDays, repetition);
      });
    }
  }

  selectStartDate(DateTime startDate) async {
    setState(() {
      selectedDay = startDate;
      activityStart = startDate;
      if (selectedDays.contains(activityStart!.weekday)) {
        selectedDays.remove(activityStart!.weekday);
      }
      selectedDays.add(activityStart!.weekday);
      selectedDays.sort();
      getLastDate(repetitionAmount, selectedDays, repetition);
    });
  }

  @override
  void initState() {
    super.initState();
    validated = false;
    repetitionAmountController.addListener(() => setRepetition);
    selectedDay = widget.selectedDay;
    //get stats from activity to edit
    if (!widget.isDuplication) {
      if ((widget.editActivity?.repeatCount ?? 0) > 0) {
        repetitionAmount = widget.editActivity!.repeatCount!;
        repetitionAmountController.text = repetitionAmount.toString();
      }
      if (!widget.doEditSingleActivity) {
        (widget.editActivity?.days ?? []).forEach((element) {
          selectedDays.add(element.getWeekday());
        });
        if (widget.editActivity?.repeats != null) {
          repetition = widget.editActivity!.repeats!;
        }
      } else {
        selectedDays = [widget.selectedDay.weekday];
        repetitionAmount = 1;
        repetition = ActivityRepeat.NEVER;
      }
      selectedDays.sort();
      DateTime date = widget.selectedDay;
      if (selectedDays.isNotEmpty) {
        while (!selectedDays.contains(date.weekday)) {
          date = date.add(Duration(days: 1));
        }
        activityStart = date;
        getLastDate(repetitionAmount, selectedDays, repetition);
      } else {
        activityStart = date;
        toggleDay(date.weekday);
      }
      time = widget.editActivity?.time ?? "";
    } else if (!widget.isDuplication) {
      toggleDay(widget.selectedDay.weekday);
    }
  }

  setRepetition() {
    setState(() {
      if (repetitionAmountController.text != "") repetitionAmount = int.parse(repetitionAmountController.text);
      selectedEndDate = null;
    });
  }

  @override
  void dispose() {
    repetitionAmountController.dispose();
    super.dispose();
  }

  finishPlanning() {
    setState(() {
      validated = true;
    });
    if (_planFormKey.currentState!.validate() && selectedDays.isNotEmpty) {
      List<DayOfWeek> days = selectedDays.map((e) => DayOfWeek.values[e - 1]).toList();
      DateTime? end = realEnddate ?? activityEnd;
      widget.planExercise(ExerciseTypeTimeData(activityStart!, end!, days, repetitionAmount, repetition, time));
    }
  }

  List<Widget> getActivityPlanningWidgets() {
    bool repetitionChosen = selectedDays.isNotEmpty;
    double infoMargin = 5;
    return [
      if (!widget.selectedTrainingPlan)
        Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  enabled: false,
                  onChanged: (value) => {
                    setState(() {
                      this.hasChanges = true;
                    })
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: context.i18n.planOnDays + " *",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: datatableBorderColor,
                      ),
                    ),
                  ),
                ),
                WeekdayOptions(
                  selectedDays: selectedDays,
                  toggleDay: toggleDay,
                  invalidInput: selectedDays.isEmpty && validated,
                ),
              ],
            ),
            if (activityStart != null && !widget.isTrainingPlan && !widget.selectedTrainingPlan)
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: 2.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: lightTextColor,
                      size: 14,
                    ),
                    SizedBox(width: infoMargin),
                    FittedBox(
                      child: SelectableText(
                        "${context.i18n.firstAppointment}: ${DateFormat('EEEE, dd.MMMM yyyy', 'de').format(activityStart!)}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: lightTextColor,
                              letterSpacing: 1.1,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      SizedBox(height: inputSpacing),
      DropdownButtonFormField(
          focusColor: Colors.white,
          onChanged: (value) {
            setState(() {
              repetition = value as ActivityRepeat;
              getLastDate(repetitionAmount, selectedDays, repetition);
              this.hasChanges = true;
            });
          },
          decoration: InputDecoration(
            hintText: context.i18n.repeat,
            labelText: context.i18n.repeat,
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
          value: repetition,
          validator: (value) => value == null ? context.i18n.validationNotEmpty : null,
          items: ActivityRepeat.values
              .map((value) => DropdownMenuItem<ActivityRepeat>(
                    child: Text(value.getTranslatedText(context)),
                    value: value,
                  ))
              .toList()),
      if (repetitionChosen && repetition != ActivityRepeat.NEVER)
        Padding(
          padding: EdgeInsets.only(top: inputSpacing),
          child: TextFormField(
            controller: repetitionAmountController,
            keyboardType: TextInputType.numberWithOptions(signed: true),
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
            onEditingComplete: () {},
            onChanged: (value) {
              setRepetition();
              getLastDate(repetitionAmount, selectedDays, repetition);
              setState(() {
                this.hasChanges = true;
              });
            },
            validator: (value) {
              if ((value ?? "").isEmpty) {
                return context.i18n.validationNotEmpty;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: Icon(Icons.date_range),
                color: lightTextColor,
                onPressed: widget.isTrainingPlan
                    ? null
                    : () {
                        _selectEndDate();
                      },
              ),
              hintText: context.i18n.amountRepeats,
              labelText: context.i18n.amountRepeats,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: datatableBorderColor,
                ),
              ),
            ),
          ),
        ),
      if (repetitionChosen && activityEnd != null && !widget.isTrainingPlan && !widget.selectedTrainingPlan)
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 2.0),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: lightTextColor,
                size: 14,
              ),
              SizedBox(width: infoMargin),
              FittedBox(
                child: SelectableText(
                  "${context.i18n.lastAppointment}: ${DateFormat('EEEE, dd.MMMM yyyy', 'de').format(activityEnd!)};",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: lightTextColor,
                        letterSpacing: 1.1,
                      ),
                ),
              ),
            ],
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _planFormKey,
        child: Column(
          children: [
            if (!widget.isTrainingPlan) SizedBox(height: inputSpacing),
            if (!widget.isTrainingPlan)
              DatePickerRow(
                startDate: widget.isDuplication ? null : selectedDay,
                selectDate: selectStartDate,
                labelText: widget.activityType == ActivityType.APPOINTMENT ? context.i18n.date : null,
              ),
            if (!widget.selectedTrainingPlan) SizedBox(height: inputSpacing),
            if (!widget.selectedTrainingPlan)
              TimePickerRow(
                initialTime: time,
                requiredField: widget.activityType == ActivityType.APPOINTMENT,
                selectTime: (selectedTime) {
                  time = selectedTime;
                },
              ),
            if (!widget.selectedTrainingPlan) SizedBox(height: inputSpacing),
            ...getActivityPlanningWidgets(),
            SizedBox(height: inputSpacing),
            BackNextButtons(
              back: widget.back,
              next: finishPlanning,
              nextButtonTitle: context.i18n.plan.toUpperCase(),
              hasChanges: this.hasChanges,
              onCancelled: widget.onCancelled,
            ),
          ],
        ),
      ),
    );
  }
}
