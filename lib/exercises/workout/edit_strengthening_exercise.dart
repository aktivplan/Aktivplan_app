// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditStrengtheningExercise extends StatefulWidget {
  final ExerciseType exerciseType;
  final exercise;
  final Function getHome;
  final Function goBack;
  final Function chooseStrengthExerciseType;
  final Function getChosenTypeExerciseTypes;
  final Function addStrengthExerciseType;
  final Function updateStrengthExerciseType;
  final bool editAlreadyChosen;
  final double containerWidth;

  EditStrengtheningExercise(
      {Key? key,
      required this.exerciseType,
      required this.exercise,
      required this.getHome,
      required this.goBack,
      required this.chooseStrengthExerciseType,
      required this.getChosenTypeExerciseTypes,
      required this.addStrengthExerciseType,
      required this.updateStrengthExerciseType,
      required this.editAlreadyChosen,
      required this.containerWidth})
      : super(key: key);

  @override
  _EditStrengtheningExerciseState createState() => _EditStrengtheningExerciseState();
}

class _EditStrengtheningExerciseState extends State<EditStrengtheningExercise> {
  final _exerciseFormKey = GlobalKey<FormState>();
  final intensityStartController = TextEditingController();
  final intensityEndController = TextEditingController();
  final durationController = TextEditingController();
  final repeatCountController = TextEditingController();
  final repeatSetController = TextEditingController();
  final breakBetweenSetsController = TextEditingController();
  final weightController = TextEditingController();
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    intensityStartController.text =
        widget.exercise.exerciseIntensityPercentageStart != null ? widget.exercise.exerciseIntensityPercentageStart.toString() : "";
    intensityEndController.text =
        widget.exercise.exerciseIntensityPercentageEnd != null ? widget.exercise.exerciseIntensityPercentageEnd.toString() : "";
    durationController.text = widget.exercise.exerciseDurationSeconds != 0 && widget.exercise.exerciseDurationSeconds != null
        ? Duration(seconds: widget.exercise?.exerciseDurationSeconds).inSeconds.toString()
        : "";
    repeatCountController.text = widget.exercise.exerciseRepeatCount == 0 ? "" : widget.exercise.exerciseRepeatCount.toString();
    repeatSetController.text = widget.exercise.exerciseRepeatSets.toString();
    if (widget.exercise?.exerciseBreakBetweenSetsDurationSeconds != null) {
      breakBetweenSetsController.text = (widget.exercise.exerciseBreakBetweenSetsDurationSeconds / 60).toString();
    } else {
      breakBetweenSetsController.text = "";
    }
    weightController.text = widget.exercise.weight.toString() == "0" ? "" : widget.exercise.weight.toString();
  }

  addExerciseType() {
    if (_exerciseFormKey.currentState!.validate()) {
      int? breakDuration = int.tryParse(breakBetweenSetsController.text);
      if (widget.editAlreadyChosen) {
        var old = widget.exercise;
        widget.exercise.exerciseDurationSeconds = durationController.text.isNotEmpty ? (int.tryParse(durationController.text)) : 0;
        widget.exercise.exerciseIntensityPercentageStart = int.tryParse(intensityStartController.text);
        widget.exercise.exerciseIntensityPercentageEnd = int.tryParse(intensityEndController.text);
        widget.exercise.exerciseRepeatCount = repeatCountController.text.isNotEmpty ? (int.tryParse(repeatCountController.text)) : 0;
        widget.exercise.exerciseRepeatSets = int.tryParse(repeatSetController.text) ?? 0;
        widget.exercise.exerciseBreakBetweenSetsDurationSeconds = breakDuration != null ? breakDuration * 60 : null;
        widget.exercise.weight = int.tryParse(weightController.text) ?? 0;
        widget.exercise.hasRepeatCount = repeatCountController.text.isNotEmpty;
        widget.updateStrengthExerciseType(old, widget.exercise);
      } else {
        StrengtheningExercisePostDTO exercise = StrengtheningExercisePostDTO.fromJson(widget.exercise.toJson())!;
        exercise.exerciseDurationSeconds = durationController.text.isNotEmpty ? (int.tryParse(durationController.text)) : 0;
        exercise.exerciseIntensityPercentageStart = int.tryParse(intensityStartController.text);
        exercise.exerciseIntensityPercentageEnd = int.tryParse(intensityEndController.text);
        exercise.exerciseRepeatCount = repeatCountController.text.isNotEmpty ? (int.tryParse(repeatCountController.text)) : 0;
        exercise.exerciseRepeatSets = int.tryParse(repeatSetController.text) ?? 0;
        exercise.exerciseBreakBetweenSetsDurationSeconds = breakDuration != null ? breakDuration * 60 : null;
        exercise.weight = int.tryParse(weightController.text) ?? 0;
        exercise.hasRepeatCount = repeatCountController.text.isNotEmpty;
        widget.addStrengthExerciseType(exercise);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(builder: (context, size) {
      double intensityWidth = size.isMobile
          ? width * 0.4
          : size.isTablet
              ? width * 0.38
              : width * 0.28;
      return Container(
        width: widget.containerWidth,
        child: Column(
          key: Key(KEY_WORKOUT_EXERCISE_SCROLL_VIEW),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFieldPadding(
              child: BreadCrumb(
                items: widget.editAlreadyChosen
                    ? [
                        BreadCrumbItem(
                          content: SelectableText(
                            context.i18n.exercise,
                            style: getBreadCrumbStyle(context),
                          ),
                        )
                      ]
                    : [
                        BreadCrumbItem(
                          onTap: () => widget.getHome(),
                          content: Text(
                            context.i18n.workout,
                            style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                        BreadCrumbItem(
                          onTap: () => widget.chooseStrengthExerciseType(),
                          content: Text(
                            context.i18n.exerciseWorkoutStrength,
                            key: Key(KEY_WORKOUT_BREAD_CRUMB_EXERCISES),
                            style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                        BreadCrumbItem(
                          content: SelectableText(
                            widget.exerciseType.getTranslatedText(context),
                            style: getBreadCrumbStyle(context),
                          ),
                        ),
                        BreadCrumbItem(
                          content: SelectableText(
                            getTranslatedText(widget.exercise.name, context),
                            style: getBreadCrumbStyle(context),
                          ),
                        )
                      ],
                divider: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: height * 0.03),
              child: Form(
                key: _exerciseFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!size.isMobile)
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
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 8),
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
                            SizedBox(
                              width: width * 0.02,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      //REPEATS;SETS;WEIGHT
                      if (!size.isMobile)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: TextFormField(
                                controller: durationController,
                                keyboardType: TextInputType.numberWithOptions(signed: true),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if ((value ?? "").isEmpty && repeatCountController.text.isEmpty) {
                                    return context.i18n.validationNotEmpty;
                                  } else if ((value ?? "").isNotEmpty &&
                                      (repeatCountController.text.isNotEmpty || repeatCountController.text != "")) {
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                          ],
                        ),
                      if (size.isMobile)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.95,
                              child: TextFormField(
                                controller: durationController,
                                keyboardType: TextInputType.numberWithOptions(signed: true),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if ((value ?? "").isEmpty && repeatCountController.text.isEmpty) {
                                    return context.i18n.validationNotEmpty;
                                  } else if ((value ?? "").isNotEmpty &&
                                      (repeatCountController.text.isNotEmpty || repeatCountController.text != "")) {
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
                              child: Text(context.i18n.or + " *", style: Theme.of(context).textTheme.bodyLarge),
                            ),
                            Container(
                              width: width * 0.95,
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Container(
                              width: width * 0.95,
                              child: TextFormField(
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
                            ),
                          ],
                        ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
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
                    ],
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
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => addExerciseType(),
                  child: Text(widget.editAlreadyChosen ? context.i18n.save.toUpperCase() : context.i18n.add.toUpperCase()),
                ),
                SizedBox(width: width * 0.01),
                CancelButton(
                  callback: () => widget.getHome(),
                  hasChanges: this.hasChanges,
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
