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
import 'package:aptapp/widget/borg_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DoneSlider extends StatefulWidget {
  final ActivityOverviewDTO activity;
  final String patientId;
  final ActiveMinutesOverviewDTO activeMinutes;
  final Function rateActivity;
  final SizingInformation size;

  DoneSlider({Key? key, required this.activity, required this.patientId, required this.activeMinutes, required this.rateActivity, required this.size})
      : super(key: key);

  @override
  _DoneSliderState createState() => _DoneSliderState();
}

class _DoneSliderState extends State<DoneSlider> {
  double? _value;
  bool hasInitialValue = false;
  bool showValidationMessage = false;

  @override
  void initState() {
    super.initState();
    if (widget.activity.rating?.rating != null) {
      _value = widget.activity.rating!.rating!.toDouble();
      hasInitialValue = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  SelectableText(
                    context.i18n.ratingQuestion,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.01,
                          height: 1.8,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              SelectableText("6 = ${context.i18n.ratingValue_6_8}", style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: 8,
              ),
              SelectableText("20 = ${context.i18n.ratingValue_19_20}", style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
        BorgSlider(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: hasInitialValue ? EdgeInsets.zero : EdgeInsets.only(top: 20),
              child: showValidationMessage && _value == null
                  ? SelectableText(context.i18n.validationNotEmpty,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: errorColor,
                            fontWeight: FontWeight.w600,
                          ))
                  : SelectableText(
                      BorgUtils.getLevelString(context, _value),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: BorgUtils.getColor(_value),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.01,
                          ),
                    ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.05,
        ),
        ElevatedButton(
          onPressed: () {
            if (_value == null) {
              setState(() {
                showValidationMessage = true;
              });
            } else {
              widget.rateActivity(_value, hasInitialValue);
            }
          },
          style: getElevatedButtonStyle(context),
          child: Row(
            mainAxisSize: widget.size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(context.i18n.executeActivity.toUpperCase())],
          ),
        ),
      ],
    );
  }
}
