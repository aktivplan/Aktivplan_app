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
    CustomSliderTickMarkShape.resetValue();
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
          showValueIndicator: ShowValueIndicator.onDrag),
      child: Container(
        height: 50,
        child: Slider(
          min: 0,
          max: 10,
          divisions: 10,
          label: value != null ? '${value!.round()}' : '',
          value: value ?? 5,
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
      case 0:
      case 1:
        return veryEasy;
      case 2:
      case 3:
        return easy;
      case 4:
      case 5:
        return medium; //grün
      case 6:
      case 7:
        return hardMedium;
      case 8:
      case 9:
        return hard;
      case 10:
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
      case 0:
      case 1:
        return "$val - ${context.i18n.ratingValue_0_1}";
      case 2:
      case 3:
        return "$val - ${context.i18n.ratingValue_2_3}";
      case 4:
      case 5:
        return "$val - ${context.i18n.ratingValue_4_5}";
      case 6:
      case 7:
        return "$val - ${context.i18n.ratingValue_6_7}";
      case 8:
      case 9:
        return "$val - ${context.i18n.ratingValue_8_9}";
      case 10:
        return "$val - ${context.i18n.ratingValue_10}";
      default:
        return "$val - ${context.i18n.ratingValue_4_5}";
    }
  }
}
