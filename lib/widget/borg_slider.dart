import 'package:aptapp/colors.dart';
import 'package:aptapp/custom_slider_shapes.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/widget/borg_slider_thumb_shape.dart';
import 'package:flutter/material.dart';

class BorgSlider<T extends double> extends StatelessWidget {
  final Function(double?) onChanged;
  final double? value;
  const BorgSlider({Key? key, required this.onChanged, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          activeTrackColor: datatableBorderColor,
          inactiveTrackColor: datatableBorderColor,
          overlayColor: primarySwatch[50],
          overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
          thumbShape: BorgSliderThumbShape(enabledThumbRadius: value != null ? 13 : 0),
          thumbColor: BorgUtils.getColor(value),
          tickMarkShape: CustomSliderTickMarkShape(),
          inactiveTickMarkColor: Colors.white,
          activeTickMarkColor: BorgUtils.getColor(value),
          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: BorgUtils.getColor(value),
          valueIndicatorTextStyle: const TextStyle(
            color: Colors.white,
          ),
          showValueIndicator: ShowValueIndicator.always),
      child: Container(
        height: 50,
        child: Slider(
          min: 6,
          max: 20,
          divisions: 14,
          label: value != null ? '${value!.truncate()}' : '',
          value: value ?? 13,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class BorgUtils {
  static Color getColor(double? value) {
    if (value == null) {
      return Colors.transparent;
    }
    int val = value.truncate();
    switch (val) {
      case 6:
      case 7:
      case 8:
        return veryEasy;
      case 9:
      case 10:
      case 11:
      case 12:
        return easy;
      case 13:
      case 14:
        return medium; //grün
      case 15:
      case 16:
        return hardMedium;
      case 17:
      case 18:
        return hard;
      case 19:
      case 20:
        return extrem;
      default:
        return medium;
    }
  }

  static getLevelString(BuildContext context, double? value) {
    if (value == null) {
      return "";
    }
    int val = value.truncate();
    switch (val) {
      case 6:
      case 7:
      case 8:
        return "$val - ${context.i18n.ratingValue_6_8}";
      case 9:
      case 10:
      case 11:
      case 12:
        return "$val - ${context.i18n.ratingValue_9_12}";
      case 13:
      case 14:
        return "$val - ${context.i18n.ratingValue_13_14}";
      case 15:
      case 16:
        return "$val - ${context.i18n.ratingValue_15_16}";
      case 17:
      case 18:
        return "$val - ${context.i18n.ratingValue_17_18}";
      case 19:
      case 20:
        return "$val - ${context.i18n.ratingValue_19_20}";
      default:
        return "$val - ${context.i18n.ratingValue_13_14}";
    }
  }
}
