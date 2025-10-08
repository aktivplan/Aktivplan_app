// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/activity_dialog.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/borg_slider.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:week_of_year/week_of_year.dart';

class AddExtraActivity extends StatefulWidget {
  final PatientGetDTO patient;
  final DateTime chosenDate;
  final ActivityOverviewDTO? plannedActivity;
  final ActiveMinutesOverviewDTO activeMinutes;

  AddExtraActivity({
    Key? key,
    required this.patient,
    required this.chosenDate,
    this.plannedActivity,
    required this.activeMinutes,
  }) : super(key: key);

  @override
  _AddExtraActivityState createState() => _AddExtraActivityState();
}

class _AddExtraActivityState extends State<AddExtraActivity> {
  final _extraFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final heartRateController = TextEditingController();
  final durationController = TextEditingController();
  final hintController = TextEditingController();
  bool isDone = false;
  bool showDurationHint = false;
  double _value = 6.0;
  ActivityBloc? activityBloc;
  List<String> suggestions = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String hint = "";
  ActivityPostDTO? activityStats;
  static const int MIN_HEARTRATE = 70;
  static const int MAX_HEARTRATE = 200;
  DateTime? rateTime;
  FocusNode dropDownFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    rateTime = DateTime.now();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    suggestions = [];
    activityBloc!.add(FetchAutocompleteEvent());
    checkForEdit();
  }

  checkForEdit() {
    if (widget.plannedActivity != null) {
      String heartRateString = widget.plannedActivity!.rating?.heartrate?.toString() ?? "0";
      String durationMinutesString = widget.plannedActivity!.durationMinutes?.toString() ?? "0";
      heartRateController.text = heartRateString == "0" ? "" : heartRateString;
      durationController.text = durationMinutesString == "0" ? "" : durationMinutesString;
      hintController.text = widget.plannedActivity!.rating?.note ?? "";
      isDone = widget.plannedActivity!.rating!.done ?? false;
      setState(() {
        showDurationHint = widget.plannedActivity!.durationMinutes != widget.plannedActivity!.plannedDurationMinutes;
      });
      if (isDone && widget.plannedActivity!.rating != null) {
        _value = widget.plannedActivity!.rating!.rating!.toDouble();
      }
    }
  }

  getBack() {
    Navigator.of(context).pop();
  }

  addActivity(width, height) {
    if (_extraFormKey.currentState!.validate()) {
      Map<String, dynamic> act = {
        "date": englishDateFormat.format(widget.chosenDate),
        "done": isDone,
        "durationMinutes": int.tryParse(durationController.text) ?? 0,
        "heartrate": int.tryParse(heartRateController.text) ?? 0,
        "name": nameController.text,
        "note": hintController.text,
        "rating": isDone ? _value.toInt() : null,
      };

      var extraActivity = ExtraActivityPostDTO.fromJson(act);

      activityBloc!.add(AddExtraActivityEvent(
        activity: extraActivity!,
        patientId: widget.patient.id!,
      ));
      getBack();
      checkIfActiveMinutesAchieved(width, height);
    }
  }

  updateActivityRating(double width, double height) {
    if (_extraFormKey.currentState!.validate()) {
      var rating = ActivityPatientRatingPostDTO()
        ..date = widget.plannedActivity!.date
        ..done = isDone
        ..durationMinutes = int.tryParse(durationController.text) ?? 0
        ..heartrate = int.tryParse(heartRateController.text) ?? 0
        ..note = hintController.text.isEmpty ? "" : hintController.text
        ..rating = _value.truncate();

      if (isDone) {
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(
              category: EVENT_CATEGORY_ACTIVITY,
              name: EVENT_NAME_RATE_ACTIVITY_TIME,
              action: "Rate Extra Activity",
              value: DateTime.now().difference(rateTime!).inSeconds),
        );
      }

      activityBloc!.add(UpdateActivityRatingEvent(
        activityType: ActivityType.EXTRA,
        rating: rating,
        id: widget.plannedActivity!.activityId!,
        date: widget.plannedActivity!.date!,
        patientId: widget.patient.id!,
      ));
      checkIfActiveMinutesAchieved(width, height);
      getBack();
    }
  }

  deleteExtraActivity(String id, ActivityPostDTO activity) {
    activityBloc!
        .add(DeleteActivityEvent(id: id, patientId: widget.patient.id!, activityDate: DateTime.parse(activity.startDate!), type: ActivityType.EXTRA));
    context.beamBack();
  }

  checkIfActiveMinutesAchieved(double width, double height) {
    var date = widget.plannedActivity == null
        ? DateTime.parse(englishDateFormat.format(widget.chosenDate)).weekOfYear
        : DateTime.parse(widget.plannedActivity!.date!).weekOfYear;
    bool isCurrentWeek = date == DateTime.now().toLocal().weekOfYear;

    // already done
    if (widget.activeMinutes.durationMinutesActive! >= widget.activeMinutes.durationMinutes!) {
      return;
    }
    //only check if activity is in current week
    if (isDone && isCurrentWeek) {
      bool goalAchieved =
          (widget.activeMinutes.durationMinutesActive! + (int.tryParse(durationController.text) ?? 0)) >= widget.activeMinutes.durationMinutes!;
      double percentage =
          widget.activeMinutes.durationMinutesActive! + (int.tryParse(durationController.text) ?? 0) / widget.activeMinutes.durationMinutes!;
      if (goalAchieved) {
        Navigator.pop(context);
        ActivityDialog.showActiveMinutesAchieved(
          context,
          percentage,
          widget.activeMinutes.durationMinutesActive! + (int.tryParse(durationController.text) ?? 0),
          widget.activeMinutes.durationMinutes!,
          height,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double horizontalPadding = width * 0.05;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          key: Key(KEY_BUTTON_CLOSE),
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            activityBloc!.add(FetchPatientActivitiesEvent(patientId: widget.patient.id!, date: widget.chosenDate));
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        heightFactor: 1.0,
        child: ResponsiveBuilder(builder: (context, size) {
          double widthForContainer = size.isMobile
              ? width * 0.95
              : size.isTablet
                  ? width * 0.9
                  : width * 0.65;
          return SingleChildScrollView(
            child: Container(
              width: widthForContainer,
              margin: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: height * 0.02,
              ),
              child: Form(
                key: _extraFormKey,
                child: Column(
                  children: [
                    FormFieldPadding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(context.i18n.extraActivity, style: Theme.of(context).textTheme.titleLarge),
                        ],
                      ),
                    ),
                    if (widget.plannedActivity == null)
                      FormFieldPadding(
                        child: Column(
                          children: [
                            BlocBuilder<ActivityBloc, ActivityState>(
                              buildWhen: (prev, current) {
                                return prev != current;
                              },
                              builder: (context, state) {
                                if (state is AutocompleteState) {
                                  suggestions = state.autocomplete.suggestions;
                                }
                                return TypeAheadField<String>(
                                  controller: nameController,
                                  focusNode: dropDownFocusNode,
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(suggestion),
                                    );
                                  },
                                  onSelected: (suggestion) {
                                    dropDownFocusNode.unfocus();
                                    nameController.text = suggestion;
                                  },
                                  suggestionsCallback: (pattern) {
                                    final toReturn = suggestions.where((element) => element.toLowerCase().contains(pattern.toLowerCase())).toList();
                                    return toReturn.isEmpty ? null : toReturn;
                                  },
                                  builder: (context, controller, focusNode) {
                                    return TextFormField(
                                      controller: nameController,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(
                                        hintText: context.i18n.activity,
                                        labelText: context.i18n.activity + " *",
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
                              },
                            ),
                          ],
                        ),
                      ),
                    if (widget.plannedActivity != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 12, top: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: extraActivityColor,
                              ),
                              width: 15,
                              height: 15,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    SelectableText(
                                      "${widget.plannedActivity!.name}, ${context.i18n.extraActivity}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.05, height: 1.5),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      controller: heartRateController,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return null;
                        } else if (int.parse(value!) < MIN_HEARTRATE || int.parse(value) > MAX_HEARTRATE) {
                          return context.i18n.validationInvalidValue;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: context.i18n.trainingHeartFrequencyBpm,
                        labelText: context.i18n.trainingHeartFrequencyBpm,
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
                      controller: durationController,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return context.i18n.validationNotEmpty;
                        }
                        if (int.parse(value!) < 1) {
                          return context.i18n.validationInvalidValue;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (widget.plannedActivity != null) {
                          setState(() {
                            showDurationHint = widget.plannedActivity!.plannedDurationMinutes.toString() != value;
                          });
                        }
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
                    if (showDurationHint)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                          top: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: lightTextColor,
                              size: 14,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            SelectableText(
                              context.i18n.plannedMinutes(widget.plannedActivity!.plannedDurationMinutes!),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: lightTextColor),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: height * 0.02,
                    ),
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
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isDone,
                      onChanged: (value) {
                        setState(() {
                          isDone = value ?? false;
                        });
                      },
                      title: Text(
                        context.i18n.executed,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: lightTextColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    if (isDone)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: SelectableText(
                              context.i18n.ratingQuestion,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.01,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SelectableText("6 = ${context.i18n.ratingValue_6_8}", style: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SelectableText("20 = ${context.i18n.ratingValue_19_20}", style: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          BorgSlider(value: _value, onChanged: (val) => setState(() => _value = val!))
                        ],
                      ),
                    if (isDone)
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
                    if (isDone)
                      SizedBox(
                        height: height * 0.08,
                      ),
                    Container(
                      alignment: size.isDesktop ? Alignment.centerLeft : Alignment.center,
                      child: Row(
                        mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () => widget.plannedActivity != null ? updateActivityRating(width, height) : addActivity(width, height),
                              style: getElevatedButtonStyle(context),
                              child: Row(
                                mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.plannedActivity != null ? context.i18n.save.toUpperCase() : context.i18n.add.toUpperCase(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.plannedActivity != null && widget.plannedActivity!.type == ActivityType.EXTRA) SizedBox(width: 8),
                          if (widget.plannedActivity != null && widget.plannedActivity!.type == ActivityType.EXTRA)
                            Flexible(
                              child: Row(
                                mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                                children: [
                                  if (size.isMobile || size.isTablet)
                                    Expanded(
                                      child: DeleteButton(
                                        callback: () =>
                                            deleteExtraActivity(widget.plannedActivity!.activityId!, widget.plannedActivity as ActivityPostDTO),
                                        confirmationTitle: getTranslatedText(widget.plannedActivity!.name, context),
                                        confirmationText:
                                            context.i18n.deleteMessageActivity(getTranslatedText(widget.plannedActivity!.name, context)),
                                      ),
                                    ),
                                  if (size.isDesktop)
                                    DeleteButton(
                                        callback: () =>
                                            deleteExtraActivity(widget.plannedActivity!.activityId!, widget.plannedActivity as ActivityPostDTO),
                                        confirmationTitle: getTranslatedText(widget.plannedActivity!.name, context),
                                        confirmationText:
                                            context.i18n.deleteMessageActivity(getTranslatedText(widget.plannedActivity!.name, context))),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
