// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:math';

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';

class TextDotDrawer extends FlDotCirclePainter {
  final String text;

  TextDotDrawer({required Color color, required double radius, required Color strokeColor, required double strokeWidth, required this.text})
      : super(color: color, radius: radius, strokeColor: strokeColor, strokeWidth: strokeWidth);

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    final centerX = offsetInCanvas.dx;
    final centerY = offsetInCanvas.dy - radius - textPainter.height / 2 - 10;
    final rect = Rect.fromLTWH(
      centerX - textPainter.width / 2 - 4,
      centerY - 2,
      textPainter.width + 8,
      textPainter.height + 4,
    );
    final paint = Paint()..color = Colors.white.withAlpha(180);
    canvas.drawRect(rect, paint);
    textPainter.paint(canvas, Offset(centerX - textPainter.width / 2, centerY));
    super.draw(canvas, spot, offsetInCanvas);
  }
}

class PatientChartCard extends StatefulWidget {
  final PatientOverviewDTO patientOverview;
  final double height;
  final Jiffy startDate;

  PatientChartCard({Key? key, required this.patientOverview, required this.height, required this.startDate}) : super(key: key);

  @override
  _PatientChartCardState createState() => _PatientChartCardState();
}

class _PatientChartCardState extends State<PatientChartCard> {
  int? currentCalendarWeek;
  int? calendarWeek;
  int? activityPercentageLastFourWeeks;
  List<ActivityGraphDTO> activityGraphData = [];
  bool showPercentageGraph = true;

  @override
  void initState() {
    super.initState();
    currentCalendarWeek = Jiffy.now().weekOfYear;
    calendarWeek = currentCalendarWeek;
    activityPercentageLastFourWeeks = widget.patientOverview.user!.activityPercentageLastFourWeeks;
    activityGraphData = widget.patientOverview.activityPercentageGraphData;
    if (widget.patientOverview.institution?.institutionFocus != null) {
      showPercentageGraph = widget.patientOverview.institution!.institutionFocus != InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE;
    }
  }

  Widget getPercentageGraphHeadline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText((activityPercentageLastFourWeeks ?? 0) >= 0 ? "$activityPercentageLastFourWeeks%" : "-",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
            SelectableText(
              widget.startDate.weekOfYear != currentCalendarWeek
                  ? context.i18n.adherenceToTrainingPlanInCalendarWeek(widget.startDate.weekOfYear)
                  : context.i18n.adherenceToTrainingPlan,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: lightTextColor,
                  ),
            ),
          ],
        ),
        if ((activityPercentageLastFourWeeks ?? 0) >= 80) Icon(Icons.check_circle, color: trafficLight3, size: 30),
        if ((activityPercentageLastFourWeeks ?? 0) >= 0 && (activityPercentageLastFourWeeks ?? 0) < 80)
          Container(
            width: 25,
            height: 25,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: (activityPercentageLastFourWeeks ?? 0) >= 50 ? trafficLight2 : trafficLight1,
            ),
            child: Center(
              child: Text("!", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
      ],
    );
  }

  LineChart getPercentageLineChart(int amountFutureWeeks) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 100,
        lineTouchData: LineTouchData(enabled: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 25,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300, width: 1)),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 25,
              reservedSize: 65,
              getTitlesWidget: (value, meta) => Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  "$value%",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: activityGraphData
                .map((e) => FlSpot(activityGraphData.indexOf(e).toDouble(), max(0, e.percentage!.toDouble())))
                .take(activityGraphData.length - amountFutureWeeks)
                .toList(),
            color: accentColor,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => getPercentageDotDrawer(context, activityGraphData[index]),
            ),
          ),
          if (amountFutureWeeks > 0)
            LineChartBarData(
              spots: activityGraphData.reversed
                  .take(amountFutureWeeks + 1)
                  .toList()
                  .reversed
                  .map((e) => FlSpot(activityGraphData.indexOf(e).toDouble(), max(0, e.percentage!.toDouble())))
                  .toList(),
              color: accentColor,
              dashArray: [3, 5],
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    getPercentageDotDrawer(context, activityGraphData[activityGraphData.length - (amountFutureWeeks + 1) + index]),
              ),
            ),
        ],
      ),
    );
  }

  Widget getActiveMinutesGraphHeadline() {
    int averageActiveMinutes = 0;
    if (activityGraphData.isNotEmpty) {
      List<int> filteredActivityGraphData =
          activityGraphData.sublist(0, activityGraphData.length - 1).map((e) => e.activeMinutes ?? 0).where((e) => e >= 0).toList();
      if (filteredActivityGraphData.isNotEmpty) {
        int sum = filteredActivityGraphData.reduce((a, b) => a + b);
        averageActiveMinutes = (sum / filteredActivityGraphData.length).round();
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText("⌀ $averageActiveMinutes",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
            SelectableText(
              context.i18n.activeMinutesPerWeek,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: lightTextColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  LineChart getActiveMinutesLineChart(int amountFutureWeeks) {
    return LineChart(
      LineChartData(
        minY: 0,
        lineTouchData: LineTouchData(enabled: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: false,
          verticalInterval: 1,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              left: BorderSide(color: Colors.grey.shade300, width: 1),
              right: BorderSide(color: Colors.grey.shade300, width: 1)),
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Container(),
              reservedSize: 10, // Adjust this value for left padding effect
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Container(),
              reservedSize: 20, // Adjust this value for left padding effect
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 20,
              getTitlesWidget: (value, meta) => Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "${context.i18n.calendarWeekShort} ${activityGraphData[value.toInt()].calendarWeek}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: lightTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: activityGraphData
                .map((e) => FlSpot(activityGraphData.indexOf(e).toDouble(), max(0, e.activeMinutes!.toDouble())))
                .take(activityGraphData.length - amountFutureWeeks)
                .toList(),
            color: accentColor,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => getActiveMinutesDotDrawer(context, activityGraphData[index]),
            ),
          ),
          if (amountFutureWeeks > 0)
            LineChartBarData(
              spots: activityGraphData.reversed
                  .take(amountFutureWeeks + 1)
                  .toList()
                  .reversed
                  .map((e) => FlSpot(activityGraphData.indexOf(e).toDouble(), max(0, e.activeMinutes!.toDouble())))
                  .toList(),
              color: accentColor,
              dashArray: [3, 5],
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    getActiveMinutesDotDrawer(context, activityGraphData[activityGraphData.length - (amountFutureWeeks + 1) + index]),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startDate.weekOfYear != calendarWeek && widget.startDate.weekOfYear != currentCalendarWeek) {
      KiwiContainer()
          .resolve<ActivityRepository>()
          .getActivityPercentageData(englishDateFormat.format(widget.startDate.dateTime), widget.patientOverview.user!.id!)
          .then((value) {
        setState(() {
          activityPercentageLastFourWeeks = value!.activityPercentageLastFourWeeks;
          activityGraphData = value.activityPercentageGraphData;
          calendarWeek = widget.startDate.weekOfYear;
        });
      });
    } else if (widget.startDate.weekOfYear == currentCalendarWeek) {
      activityPercentageLastFourWeeks = widget.patientOverview.user!.activityPercentageLastFourWeeks;
      activityGraphData = widget.patientOverview.activityPercentageGraphData;
    }

    int amountFutureWeeks = widget.startDate.endOf(Unit.week).diff(Jiffy.now().startOf(Unit.week), unit: Unit.week).toInt();
    if (amountFutureWeeks < 0) {
      amountFutureWeeks = 0;
    } else if (amountFutureWeeks > 3) {
      amountFutureWeeks = 3;
    }

    return Container(
      height: widget.height,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(6))),
        semanticContainer: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: showPercentageGraph ? getPercentageGraphHeadline() : getActiveMinutesGraphHeadline(),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 12, bottom: 12),
                child: showPercentageGraph ? getPercentageLineChart(amountFutureWeeks) : getActiveMinutesLineChart(amountFutureWeeks),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextDotDrawer getPercentageDotDrawer(BuildContext context, ActivityGraphDTO graphData) {
    return TextDotDrawer(
      text: context.i18n.calendarWeekShort + " ${graphData.calendarWeek}",
      radius: graphData.percentage! < 0 ? 3 : 2,
      color: graphData.percentage! < 0 ? Colors.white : accentColor,
      strokeWidth: graphData.percentage! < 0 ? 1.5 : 1,
      strokeColor: accentColor,
    );
  }

  TextDotDrawer getActiveMinutesDotDrawer(BuildContext context, ActivityGraphDTO graphData) {
    return TextDotDrawer(
      text: max(0, graphData.activeMinutes!).toString(),
      radius: graphData.activeMinutes! < 0 ? 3 : 2,
      color: graphData.activeMinutes! < 0 ? Colors.white : accentColor,
      strokeWidth: graphData.activeMinutes! < 0 ? 1.5 : 1,
      strokeColor: accentColor,
    );
  }
}
