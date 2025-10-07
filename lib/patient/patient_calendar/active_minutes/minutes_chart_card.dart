import 'dart:math';

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/time_data.dart';
import 'package:dart_date/dart_date.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_of_year/week_of_year.dart';

class MinutesChartCard extends StatelessWidget {
  final ActiveMinutesOverviewDTO minutes;
  final TimeData time;
  final PatientGetDTO patient;
  final double chartHeight;

  MinutesChartCard({
    Key? key,
    required this.minutes,
    required this.time,
    required this.patient,
    required this.chartHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int activeMinutes = minutes.durationMinutesActive ?? 0;
    int totalMinutes = minutes.durationMinutes ?? 0;
    String statusValueText = "";
    String statusDetailText = "";
    if (time.timeframe == ActiveMinutesType.WEEK) {
      statusValueText = activeMinutes == 0 && totalMinutes == 0 ? "-" : "$activeMinutes";
      statusDetailText = "/$totalMinutes ${context.i18n.minutes}";
    } else {
      statusValueText = (minutes.averageMinutesPerWeek ?? 0) <= 0 ? "-" : "Ø ${minutes.averageMinutesPerWeek}";
      statusDetailText = context.i18n.perWeek;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            context.i18n.activeMinutes,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightTextColor, letterSpacing: 1.1),
          ),
          SelectableText(statusValueText, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black, fontSize: 30)),
          SelectableText(statusDetailText, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: lightTextColor, letterSpacing: 1.1)),
          SizedBox(height: 50),
          SizedBox(
            height: chartHeight,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
                ),
                gridData: FlGridData(show: false),
                barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (BarChartGroupData group) => Colors.transparent,
                        tooltipPadding: EdgeInsets.zero,
                        tooltipMargin: 0,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            rod.toY > 0 ? "${rod.toY.toInt()} min" : "",
                            Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black, fontSize: 12),
                          );
                        })),
                barGroups: getBarChartGroupData(context, min(width, 600)),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) => SideTitleWidget(child: Text(getBarTitle(context, value.toInt())), axisSide: meta.axisSide),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(shape: BoxShape.circle, color: plannedActivityColor),
              ),
              SizedBox(width: 15),
              SelectableText(context.i18n.plannedActivityPlural, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20)),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(shape: BoxShape.circle, color: extraActivityColor),
              ),
              SizedBox(width: 15),
              SelectableText(context.i18n.extraActivityPlural, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }

  List<String> getWeekList() {
    List<String> weeks = [];
    DateTime startDate = time.start;
    DateTime endDate = time.end;
    while (!startDate.isSameDay(endDate)) {
      weeks.add(startDate.weekOfYear.toString());
      startDate = startDate.add(Duration(days: 1));
    }
    return weeks.toSet().toList();
  }

  List<String> getMonthList() {
    List<String> months = [];
    int lastMonth = minutes.activeMinutes.keys.isNotEmpty ? max(4, int.parse(minutes.activeMinutes.keys.last)) : 4;
    for (int i = 1; i <= lastMonth; i++) {
      months.add(i.toString());
    }
    return months;
  }

  String getBarTitle(BuildContext context, int xValue) {
    if (time.timeframe == ActiveMinutesType.WEEK) {
      return DayOfWeek.values[xValue].getTranslatedShortName(context);
    }
    if (time.timeframe == ActiveMinutesType.MONTH) {
      return "${context.i18n.calendarWeekShort} ${getWeekList()[xValue]}";
    }
    if (time.timeframe == ActiveMinutesType.ALL) {
      return DateFormat.MMM(Localizations.localeOf(context).languageCode).format(DateTime.now().setMonth(xValue + 1));
    }
    return "";
  }

  List<BarChartGroupData> getBarChartGroupData(BuildContext context, double width) {
    List<String> keysToUse = [];
    if (time.timeframe == ActiveMinutesType.WEEK) {
      keysToUse = DayOfWeek.values.map((dayOfWeek) => dayOfWeek.value).toList();
    } else if (time.timeframe == ActiveMinutesType.MONTH) {
      keysToUse = getWeekList();
    } else {
      keysToUse = getMonthList();
    }

    return keysToUse.map((key) {
      int plannedMinutes = minutes.activeMinutes[key]?.durationMinutes ?? 0;
      int extraMinutes = minutes.activeMinutes[key]?.durationMinutesExtra ?? 0;
      return BarChartGroupData(
        x: keysToUse.indexOf(key),
        barRods: [
          BarChartRodData(
              toY: (plannedMinutes + extraMinutes).toDouble(),
              rodStackItems: [
                BarChartRodStackItem(0, plannedMinutes.toDouble(), plannedActivityColor),
                BarChartRodStackItem(plannedMinutes.toDouble(), (plannedMinutes + extraMinutes).toDouble(), extraActivityColor)
              ],
              borderRadius: BorderRadius.zero,
              width: width / (keysToUse.length + 2)),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }

  minutesStatsForWeek(int activeMinutes, int totalMinutes, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          activeMinutes == 0
              ? SelectableText("-", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black))
              : SelectableText("$activeMinutes", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black)),
          SizedBox(
            height: 10,
          ),
          SelectableText("/$totalMinutes ${context.i18n.minutes}",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: lightTextColor, letterSpacing: 1.1)),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
