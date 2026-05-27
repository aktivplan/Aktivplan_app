import 'package:aptapp/widget/borg_slider.dart';
import 'package:flutter/material.dart';

class CustomSliderTickMarkShape extends RoundSliderTickMarkShape {
  static double currentValue = 0;
  static void resetValue() {
    currentValue = 0;
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    required bool isEnabled,
  }) {
    final Paint paint = Paint();
    if (currentValue > 10) {
      currentValue = 0;
    }
    paint.color = BorgUtils.getColor(currentValue);
    ++currentValue;

    // The tick marks are tiny circles that are the same height as the track.
    final double tickMarkRadius = getPreferredSize(
          isEnabled: isEnabled,
          sliderTheme: sliderTheme,
        ).width /
        2;
    if (tickMarkRadius > 0) {
      context.canvas.drawCircle(center, 2.5, paint);
    }
  }
}
