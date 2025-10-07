import 'dart:async';

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/active_minutes_page.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/percent_indicator.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/card_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ActiveMinutesCard extends StatefulWidget {
  final ActiveMinutesOverviewDTO activeMinutes;
  final PatientGetDTO? patient;
  final Jiffy startDate;
  final bool mobileOnly;
  final bool showCharts;

  ActiveMinutesCard({
    Key? key,
    required this.activeMinutes,
    required this.startDate,
    this.patient,
    this.mobileOnly = false,
    this.showCharts = true,
  }) : super(key: key ?? Key(KEY_PATIENT_CALENDAR_CARD_ACTIVE_MINUTES));

  @override
  _ActiveMinutesCardState createState() => _ActiveMinutesCardState();
}

class _ActiveMinutesCardState extends State<ActiveMinutesCard> {
  int? currentCalendarWeek;
  int? calendarWeek;
  int? durationMinutes;
  int? durationMinutesActive;

  @override
  void initState() {
    super.initState();
    calendarWeek = Jiffy.parse(widget.activeMinutes.startDate!).weekOfYear;
    currentCalendarWeek = Jiffy.now().weekOfYear;
    durationMinutes = widget.activeMinutes.durationMinutes;
    durationMinutesActive = widget.activeMinutes.durationMinutesActive;
  }

  goToChartPage() {
    showDialog(
      context: context,
      builder: (context) {
        return ActiveMinutesPage(
          patient: widget.patient!,
          parentHeight: MediaQuery.of(context).size.height,
          selectedDate: widget.startDate,
        );
      },
    );
  }

  final List activities = List.empty();
  Timer? activeMinutesRequestTimer;

  @override
  Widget build(BuildContext context) {
    if (widget.startDate.weekOfYear != calendarWeek && widget.startDate.weekOfYear != currentCalendarWeek) {
      activeMinutesRequestTimer?.cancel();
      activeMinutesRequestTimer = Timer(Duration(milliseconds: 100), () {
        DateTime startDate = widget.startDate.dateTime;
        DateTime weekStart = startDate.subtract(Duration(days: startDate.weekday - 1));
        DateTime weekEnd = startDate.add(Duration(days: (7 - startDate.weekday)));
        KiwiContainer()
            .resolve<ActivityRepository>()
            .getActiveMinutes(weekEnd, weekStart, ActiveMinutesType.WEEK, patientId: widget.patient!.id)
            .then((value) {
          if ((value!.startDate ?? "").isNotEmpty) {
            Jiffy responseDate = Jiffy.parse(value.startDate!);
            if (responseDate.weekOfYear != widget.startDate.weekOfYear) {
              return;
            }
          }
          setState(() {
            durationMinutes = value.durationMinutes;
            durationMinutesActive = value.durationMinutesActive;
            calendarWeek = widget.startDate.weekOfYear;
          });
        });
      });
    } else if (widget.startDate.weekOfYear == currentCalendarWeek) {
      durationMinutes = widget.activeMinutes.durationMinutes;
      durationMinutesActive = widget.activeMinutes.durationMinutesActive;
    }

    double percentage = (durationMinutes ?? 0) > 0 ? durationMinutesActive! / durationMinutes! : 0;
    return ResponsiveBuilder(builder: (context, size) {
      if (size.isMobile || widget.mobileOnly) {
        return InkWell(
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$durationMinutesActive/$durationMinutes",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(widget.startDate.weekOfYear != currentCalendarWeek
                      ? context.i18n.activeMinutesInCalendarWeek(widget.startDate.weekOfYear)
                      : context.i18n.activeMinutesPerWeek),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: LinearProgressIndicator(
                      color: primaryColor,
                      backgroundColor: mobileBackgroundColor,
                      minHeight: 12,
                      value: (durationMinutes ?? 0) > 0 ? durationMinutesActive! / durationMinutes! : 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: widget.showCharts ? goToChartPage : null,
        );
      }
      return Container(
        height: 360,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: !widget.showCharts ? null : () => size.isDesktop || size.isTablet ? openPopUpChart() : goToChartPage(),
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(6))),
                  semanticContainer: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 6),
                        child: Row(
                          children: [
                            Text(
                              context.i18n.activeMinutes,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: lightTextColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 360 * 0.08),
                        child: PercentIndicator(
                          percentage: percentage,
                          durationMinutesActive: durationMinutesActive!,
                          durationMinutes: durationMinutes!,
                          cardContainerHeight: 360,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CardIconButton(iconData: Icons.bar_chart, callback: goToChartPage)
          ],
        ),
      );
    });
  }

  Future<void> openPopUpChart() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: EdgeInsets.all(30),
            contentPadding: EdgeInsets.all(0),
            content: AspectRatio(
              aspectRatio: 5 / 6,
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  return ActiveMinutesPage(patient: widget.patient!, parentHeight: boxConstraints.maxHeight, selectedDate: widget.startDate);
                },
              ),
            ));
      },
    );
  }
}
