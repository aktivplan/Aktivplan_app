import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/widget/borg_slider.dart';
import 'package:aptapp/widget/pesi_selector.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DoneSlider extends StatefulWidget {
  final ActivityOverviewDTO activity;
  final String patientId;
  final ActiveMinutesOverviewDTO activeMinutes;
  final Function(double?, int?, bool) rateActivity;
  final Function(double) onValueChanged;
  final SizingInformation size;
  final bool isKlimafit;

  DoneSlider(
      {Key? key,
      required this.activity,
      required this.patientId,
      required this.activeMinutes,
      required this.rateActivity,
      required this.onValueChanged,
      required this.size,
      required this.isKlimafit})
      : super(key: key);

  @override
  _DoneSliderState createState() => _DoneSliderState();
}

class _DoneSliderState extends State<DoneSlider> {
  double? _value;
  int? _pesiValue;
  bool hasInitialValue = false;
  bool showValidationMessage = false;
  bool showPesiValidationMessage = false;

  @override
  void initState() {
    super.initState();
    if (widget.activity.rating?.rating != null) {
      _value = widget.activity.rating!.rating!.toDouble();
      hasInitialValue = true;
    }
    _pesiValue = widget.activity.rating?.pesiRating;
  }

  @override
  Widget build(BuildContext context) {
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
              SelectableText("0 = ${context.i18n.ratingValue_0_1}", style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: 8,
              ),
              SelectableText("10 = ${context.i18n.ratingValue_10}", style: Theme.of(context).textTheme.bodyLarge),
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
              widget.onValueChanged(value ?? 0);
            });
          },
        ),
        Center(
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
        if (widget.isKlimafit)
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: 6),
            child: PesiSelector(
              initialValue: _pesiValue,
              onChanged: (value) {
                setState(() {
                  showPesiValidationMessage = false;
                  _pesiValue = value;
                });
              },
            ),
          ),
        if (showPesiValidationMessage)
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Center(
              child: SelectableText(
                context.i18n.validationNotEmpty,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: errorColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
          onPressed: () {
            if (_value == null) {
              setState(() {
                showValidationMessage = true;
              });
            }
            if (widget.isKlimafit && _pesiValue == null) {
              setState(() {
                showPesiValidationMessage = true;
              });
            }
            if (!showValidationMessage && !showPesiValidationMessage) {
              widget.rateActivity(_value, _pesiValue, hasInitialValue);
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
