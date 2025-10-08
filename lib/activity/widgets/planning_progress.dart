// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:math';

import 'package:aptapp/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timeline_tile/timeline_tile.dart';

class PlanningProgress extends StatefulWidget {
  final int progressLevel;
  final List<String> longTexts;
  final List<String> shortTexts;
  final Widget? preWidget;
  final bool clickable;
  final Function(int)? setProgressLevel;

  PlanningProgress(
      {Key? key,
      required this.progressLevel,
      required this.longTexts,
      required this.shortTexts,
      this.preWidget,
      this.clickable = false,
      this.setProgressLevel})
      : super(key: key);

  @override
  _PlanningProgressState createState() => _PlanningProgressState();
}

class _PlanningProgressState extends State<PlanningProgress> {
  Color first = primaryColor;
  Color second = primaryColor;
  Color third = primaryColor;
  double maxHeight = 100.0;

  setProgressColor() {
    switch (widget.progressLevel) {
      case 0:
        first = primaryColor;
        second = lightTextColor;
        third = lightTextColor;
        break;
      case 1:
        first = lightTextColor;
        second = primaryColor;
        third = lightTextColor;
        break;
      case 2:
        first = lightTextColor;
        second = lightTextColor;
        third = primaryColor;
        break;
      default:
        first = lightTextColor;
        second = lightTextColor;
        third = lightTextColor;
        break;
    }
  }

  Widget numberCircle(Color color, int number, double containerHeight, double circleHeight, double height, bool clickable) {
    return FittedBox(
      fit: BoxFit.contain,
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: primaryColor,
            onTap: clickable
                ? () {
                    if (widget.setProgressLevel != null) {
                      widget.setProgressLevel!(number - 1);
                    }
                  }
                : null,
            child: SizedBox(
              width: containerHeight < maxHeight ? circleHeight : height * 0.05,
              height: containerHeight < maxHeight ? circleHeight : height * 0.05,
              child: Center(
                child: Text(
                  number.toString(),
                  style: containerHeight < maxHeight
                      ? Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          )
                      : Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget adaptiveText(int progressLevel, SizingInformation size) {
    if (widget.clickable) {
      return FittedBox(
        fit: BoxFit.none,
        child: TextButton(
          onPressed: () {
            if (widget.setProgressLevel != null) {
              widget.setProgressLevel!(progressLevel);
            }
          },
          child: Text(
            size.isDesktop ? widget.longTexts[progressLevel] : widget.shortTexts[progressLevel],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: widget.progressLevel == progressLevel ? FontWeight.bold : FontWeight.normal,
                  letterSpacing: 1.03,
                  color: widget.progressLevel == progressLevel ? Colors.black : lightTextColor,
                  fontSize: size.localWidgetSize.width < 1000 ? 10 : 12,
                ),
          ),
        ),
      );
    }

    return FittedBox(
      fit: size.isDesktop ? BoxFit.none : BoxFit.fitWidth,
      child: Center(
        child: SelectableText(
          size.isDesktop ? widget.longTexts[progressLevel] : widget.shortTexts[progressLevel],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: widget.progressLevel == progressLevel ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 1.03,
                color: widget.progressLevel == progressLevel ? Colors.black : lightTextColor,
                fontSize: size.localWidgetSize.width < 1000 ? 10 : 12,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double circleHeight = 50;
    setProgressColor();

    return ResponsiveBuilder(builder: (context, size) {
      double widthForContainer = size.isMobile
          ? width * 0.95
          : size.isTablet
              ? width * 0.9
              : width * 0.65;
      double containerHeight = max(90, height * 0.1);
      bool isClickable = widget.clickable && !size.isMobile;
      return FittedBox(
        fit: BoxFit.contain,
        child: Container(
          padding: EdgeInsets.only(bottom: containerHeight * 0.15),
          height: containerHeight,
          width: widthForContainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              4.0,
            ),
            border: Border.all(
              color: datatableBorderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.preWidget != null) widget.preWidget!,
              if ((size.isMobile && widget.progressLevel <= 0) || !size.isMobile)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: TimelineTile(
                      isFirst: true,
                      beforeLineStyle: LineStyle(
                        thickness: 1,
                      ),
                      afterLineStyle: LineStyle(
                        thickness: 1,
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: containerHeight * 0.3,
                        height: containerHeight * 0.3,
                        padding: EdgeInsets.all(8.0),
                        indicator: numberCircle(first, 1, containerHeight, circleHeight, height, isClickable && widget.progressLevel != 0),
                      ),
                      axis: TimelineAxis.horizontal,
                      alignment: TimelineAlign.center,
                      endChild: adaptiveText(0, size),
                    ),
                  ),
                ),
              if (!size.isMobile)
                TimelineTile(
                  beforeLineStyle: LineStyle(
                    thickness: 1,
                  ),
                  afterLineStyle: LineStyle(
                    thickness: 1,
                  ),
                  hasIndicator: false,
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                ),
              if ((size.isMobile && widget.progressLevel == 1) || !size.isMobile)
                Expanded(
                  child: TimelineTile(
                    isFirst: false,
                    beforeLineStyle: LineStyle(
                      thickness: 1,
                    ),
                    afterLineStyle: LineStyle(
                      thickness: 1,
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: containerHeight * 0.3,
                      height: containerHeight * 0.3,
                      padding: EdgeInsets.all(8.0),
                      indicator: numberCircle(second, 2, containerHeight, circleHeight, height, isClickable && widget.progressLevel != 1),
                    ),
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.center,
                    endChild: adaptiveText(1, size),
                  ),
                ),
              if (!size.isMobile)
                TimelineTile(
                  beforeLineStyle: LineStyle(
                    thickness: 1,
                  ),
                  afterLineStyle: LineStyle(
                    thickness: 1,
                  ),
                  hasIndicator: false,
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                ),
              if ((size.isMobile && widget.progressLevel >= 2) || !size.isMobile)
                Expanded(
                  child: TimelineTile(
                    isLast: true,
                    beforeLineStyle: LineStyle(
                      thickness: 1,
                    ),
                    afterLineStyle: LineStyle(
                      thickness: 1,
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: containerHeight * 0.3,
                      height: containerHeight * 0.3,
                      padding: EdgeInsets.all(8.0),
                      indicator: numberCircle(third, 3, containerHeight, circleHeight, height, isClickable && widget.progressLevel != 2),
                    ),
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.center,
                    endChild: adaptiveText(2, size),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
