import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/minutes_chart_card.dart';
import 'package:aptapp/patient/share_button.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/time_data.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:screenshot/screenshot.dart';
import 'package:week_of_year/week_of_year.dart';

class ActiveMinutesDetail extends StatefulWidget {
  final ActiveMinutesType timeframe;
  final PatientGetDTO patient;
  final double parentHeight;
  final Jiffy selectedDate;

  ActiveMinutesDetail({
    Key? key,
    required this.timeframe,
    required this.patient,
    required this.parentHeight,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _ActiveMinutesDetailState createState() => _ActiveMinutesDetailState();
}

class _ActiveMinutesDetailState extends State<ActiveMinutesDetail> {
  String dates = "";
  DateTime? start;
  DateTime? end;
  ActivityBloc? activityBloc;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    initializeTimes();
    var startingDate = start;
    var endingDate = end;

    if (widget.timeframe != ActiveMinutesType.WEEK) {
      startingDate = startingDate!.add(Duration(days: 1));
      endingDate = endingDate!.add(Duration(days: 1));
    }
    activityBloc!.add(FetchActiveMinutesEvent(
      endDate: endingDate!,
      startDate: startingDate!,
      type: widget.timeframe,
      patientId: widget.patient.id!,
    ));
  }

  updateTimes(bool getBefore) {
    if (widget.timeframe == ActiveMinutesType.WEEK) updateWeek(getBefore);
    if (widget.timeframe == ActiveMinutesType.MONTH) updateMonth(getBefore);
    if (widget.timeframe == ActiveMinutesType.ALL) updateTotal(getBefore);

    var startingDate = start;
    var endingDate = end;

    if (widget.timeframe != ActiveMinutesType.WEEK) {
      startingDate = startingDate!.add(Duration(days: 1));
      endingDate = endingDate!.add(Duration(days: 1));
    }
    activityBloc!.add(FetchActiveMinutesEvent(
      endDate: endingDate!,
      startDate: startingDate!,
      type: widget.timeframe,
      patientId: widget.patient.id!,
    ));
    MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
          category: EVENT_CATEGORY_ACTIVE_MINUTES,
          name: EVENT_NAME_CHANGE_TIME_SELECTION,
          action:
              "Changed Time for ${widget.timeframe == ActiveMinutesType.WEEK ? 'Week' : widget.timeframe == ActiveMinutesType.MONTH ? 'Month' : 'Total'} Tab",
        ),
        dimensions: {"Start Date": englishDateFormat.format(startingDate), "End Date": englishDateFormat.format(endingDate)});
  }

  initializeTimes() {
    DateTime now = widget.selectedDate.dateTime;

    if (widget.timeframe == ActiveMinutesType.WEEK) {
      int weekday = now.weekday;
      //get start and end of current week
      start = now.subtract(Duration(days: weekday - 1));
      end = now.add(Duration(days: 7 - weekday));
      String startString = DateFormat('dd.MM.yyyy', 'de').format(start!);
      String endString = DateFormat('dd.MM.yyyy', 'de').format(end!);
      dates = "$startString - $endString";
    } else if (widget.timeframe == ActiveMinutesType.MONTH) {
      start = DateTime(now.year, now.month, 1, 0, 0, 0, 0, 0);
      end = DateTime(now.year, now.month + 1, 0, 0, 0, 0, 0, 0);
      String startString = DateFormat('dd.MM.yyyy', 'de').format(start!);
      String endString = DateFormat('dd.MM.yyyy', 'de').format(end!);
      dates = "$startString - $endString";
    } else {
      start = DateTime(now.year, 1, 1, 0, 0, 0, 0, 0);
      end = DateTime(now.year, 12, 31, 0, 0, 0, 0, 0);
      dates = "01.01.${start!.year} - 31.12.${start!.year}";
    }
  }

  getTimeTitle() {
    if (widget.timeframe == ActiveMinutesType.WEEK) {
      var calendarWeek = start!.weekOfYear;
      return "${context.i18n.calendarWeek} $calendarWeek";
    } else if (widget.timeframe == ActiveMinutesType.MONTH) {
      return DateFormat('MMMM', Localizations.localeOf(context).languageCode).format(start!);
    } else {
      return DateFormat('yyyy', Localizations.localeOf(context).languageCode).format(start!);
    }
  }

  updateWeek(bool getBefore) {
    if (getBefore) {
      setState(() {
        start = start!.subtract(Duration(days: 7));
        end = end!.subtract(Duration(days: 7));
        String startString = DateFormat('dd.MM.yyyy', 'de').format(start!);
        String endString = DateFormat('dd.MM.yyyy', 'de').format(end!);
        dates = "$startString - $endString";
      });
    } else {
      setState(() {
        start = start!.add(Duration(days: 7));
        end = end!.add(Duration(days: 7));
        String startString = DateFormat('dd.MM.yyyy', 'de').format(start!);
        String endString = DateFormat('dd.MM.yyyy', 'de').format(end!);
        dates = "$startString - $endString";
      });
    }
  }

  updateMonth(bool getBefore) {
    if (getBefore) {
      setState(() {
        start = DateTime(start!.year, start!.month - 1, 1);
        end = DateTime(end!.year, end!.month, 0, 0, 0, 0, 0, 0);
        String startString = DateFormat('dd.MM.yyyy', 'de').format(start!);
        String endString = DateFormat('dd.MM.yyyy', 'de').format(end!);
        dates = "$startString - $endString";
      });
    } else {
      setState(() {
        start = DateTime(
          start!.year,
          start!.month + 1,
          1,
        );
        end = DateTime(end!.year, end!.month + 2, 0, 0, 0, 0, 0, 0);
        String startString = DateFormat('dd.MM.yyyy', 'de').format(start!);
        String endString = DateFormat('dd.MM.yyyy', 'de').format(end!);
        dates = "$startString - $endString";
      });
    }
  }

  updateTotal(bool getBefore) {
    if (getBefore) {
      setState(() {
        start = DateTime(start!.year - 1, 1, 1, 0, 0, 0, 0, 0);
        end = DateTime(end!.year - 1, 12, 31, 0, 0, 0, 0, 0);
        dates = "01.01.${start!.year} - 31.12.${start!.year}";
      });
    } else {
      setState(() {
        start = DateTime(start!.year + 1, 1, 1, 0, 0, 0, 0, 0);
        end = DateTime(end!.year + 1, 12, 31, 0, 0, 0, 0, 0);
        dates = "01.01.${start!.year} - 31.12.${start!.year}";
      });
    }
  }

  Widget getActiveMinutesHeader(Widget content, bool hasPreviousEntry, bool hasNextEntry, bool showShareButton) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
              ),
              onPressed: hasPreviousEntry ? () => updateTimes(true) : null,
            ),
            Column(
              children: [
                SelectableText(
                  getTimeTitle(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                ),
                SelectableText(dates, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: lightTextColor)),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
              ),
              onPressed: hasNextEntry ? () => updateTimes(false) : null,
            ),
          ],
        ),
        SizedBox(height: 15),
        content,
        if (showShareButton)
          Padding(
              padding: EdgeInsets.only(top: 10, left: 14, right: 14),
              child: ShareButton(screenshotController: screenshotController, shareContext: "Active Minutes")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = widget.parentHeight - (kIsWeb ? 200 : 300);
    return SingleChildScrollView(
      child: ResponsiveBuilder(
        builder: (context, size) {
          return BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              if (state is FetchedActiveMinutesState) {
                return getActiveMinutesHeader(
                    Container(
                      color: Colors.white,
                      child: Screenshot(
                        controller: screenshotController,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            MinutesChartCard(
                              minutes: state.activeMinutes,
                              patient: widget.patient,
                              time: TimeData(start: start!, end: end!, timeframe: widget.timeframe),
                              chartHeight: windowHeight - 180,
                            ),
                          ],
                        ),
                      ),
                    ),
                    state.activeMinutes.hasPreviousEntry ?? false,
                    state.activeMinutes.hasNextEntry ?? false,
                    !kIsWeb);
              }
              return getActiveMinutesHeader(Center(heightFactor: 5, child: CircularProgressIndicator()), false, false, false);
            },
          );
        },
      ),
    );
  }
}
