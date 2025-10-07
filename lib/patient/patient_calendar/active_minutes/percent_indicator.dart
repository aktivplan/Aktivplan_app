import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../colors.dart';

class PercentIndicator extends StatelessWidget {
  final double percentage;
  final int durationMinutesActive;
  final int durationMinutes;
  final double cardContainerHeight;

  PercentIndicator({
    Key? key,
    required this.percentage,
    required this.durationMinutesActive,
    required this.durationMinutes,
    required this.cardContainerHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double indicatorHeight = cardContainerHeight * 0.65;

    return ResponsiveBuilder(builder: (context, size) {
      double indicatorRadius = cardContainerHeight * 0.5;
      double lineWidth = indicatorRadius * 0.12;
      double checkCircleSize = size.isMobile
          ? lineWidth * 3.6
          : size.isTablet
              ? lineWidth * 3.6
              : lineWidth * 3.6;
      double descriptionSize = 35;
      double minuteSize = 80;
      return Container(
        width: indicatorHeight * 1.2,
        height: indicatorHeight,
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 12,
        ),
        child: FittedBox(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircularPercentIndicator(
                radius: indicatorRadius,
                lineWidth: lineWidth,
                progressColor: Theme.of(context).primaryColor,
                percent: percentage > 1.0 ? 1.0 : percentage,
                center: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        context.i18n.thisWeek,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: lightTextColor,
                              fontSize: descriptionSize,
                            ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "$durationMinutesActive",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.black,
                              fontSize: minuteSize,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "/ $durationMinutes ${context.i18n.minutes}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: lightTextColor,
                              fontSize: descriptionSize,
                            ),
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
              if (percentage >= 1 && durationMinutesActive > 0)
                Positioned(
                  bottom: cardContainerHeight * 0.07,
                  right: -indicatorHeight * 0.06,
                  child: Container(
                    width: checkCircleSize,
                    height: checkCircleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: goalColor,
                    ),
                    child: Center(
                      child: Icon(Icons.check, color: Colors.white, size: 30),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
