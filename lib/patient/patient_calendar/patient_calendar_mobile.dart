import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/active_minutes_card.dart';
import 'package:aptapp/patient/patient_calendar/patient_activity_list.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar.dart';
import 'package:aptapp/patient/patient_calendar/patient_notes_card.dart';
import 'package:aptapp/patient/patient_calendar/patient_chart_card.dart';
import 'package:aptapp/patient/personal_goal_dialog.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:table_calendar/table_calendar.dart';

import '../activity_dialog.dart';
import 'patient_info_line.dart';

class PatientCalendarMobile extends StatefulWidget {
  final PatientOverviewDTO patientOverview;
  final PatientGetDTO patient;
  final ActiveMinutesOverviewDTO activeMinutes;
  final Function addExtraActivity;
  final List<ActivityOverviewDTO> patientActivities;
  final List<PersonalGoal> personalGoals;
  final Function(dynamic, ActiveMinutesOverviewDTO, bool) markAsDone;
  final Function addActivity;
  final Function(String, ActivityType) deleteActivity;
  final Function(DateTime) changeMonth;
  final Function(DateTime) changeDay;
  final Function(CalendarFormat) changeFormat;
  final FileGetDTO userPicture;
  final DateTime focusedDay;
  final CalendarFormat currentFormat;

  PatientCalendarMobile(
      {Key? key,
      required this.patient,
      required this.patientOverview,
      required this.addExtraActivity,
      required this.patientActivities,
      required this.activeMinutes,
      required this.personalGoals,
      required this.markAsDone,
      required this.addActivity,
      required this.deleteActivity,
      required this.changeMonth,
      required this.changeDay,
      required this.userPicture,
      required this.focusedDay,
      required this.currentFormat,
      required this.changeFormat})
      : super(key: key ?? Key(KEY_PATIENT_CALENDAR_SCROLL_VIEW));

  @override
  _PatientCalendarMobileState createState() => _PatientCalendarMobileState();
}

class ActivityOrGoal {
  final ActivityOverviewDTO? activity;
  final PersonalGoal? goal;

  ActivityOrGoal({this.activity, this.goal});
}

class _PatientCalendarMobileState extends State<PatientCalendarMobile> {
  Map<String, List> _events = Map();
  Jiffy _currentDate = Jiffy.now().startOf(Unit.day);
  ScrollController _scrollController = ScrollController();
  Jiffy? _lastSelectedDate;
  CalendarFormat? _lastSelectedFormat;
  Key _refreshKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _currentDate = Jiffy.parseFromDateTime(widget.focusedDay).startOf(Unit.day);
    _lastSelectedFormat = widget.currentFormat;
  }

  void changeCurrentDate(Jiffy date) {
    setState(() {
      _currentDate = date;
    });
  }

  void changeEvents(Map<String, List> events) {
    _events = events;
  }

  void initAptBar() {
    if (_lastSelectedDate == null || !_lastSelectedDate!.isSame(_currentDate)) {
      setState(() {
        _lastSelectedDate = _currentDate.clone();
      });
    } else if (_lastSelectedFormat == widget.currentFormat) {
      return;
    }
    _lastSelectedFormat = widget.currentFormat;
    double appBarHeight = kToolbarHeight + 5;
    if (widget.currentFormat == CalendarFormat.week) {
      appBarHeight += kToolbarHeight;
    }
    APTApp.globalAptCubit.setAppBarWidgets(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: OutlinedButton(
                onPressed: () {
                  if (widget.currentFormat != CalendarFormat.week) {
                    widget.changeFormat(CalendarFormat.week);
                    setState(() {
                      _refreshKey = UniqueKey();
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  backgroundColor: widget.currentFormat == CalendarFormat.week ? primaryColor.withAlpha(50) : Colors.transparent,
                ),
                child: Text(context.i18n.week,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor, fontWeight: FontWeight.w900))),
          ),
          Expanded(
            child: OutlinedButton(
                onPressed: () {
                  if (widget.currentFormat != CalendarFormat.month) {
                    widget.changeFormat(CalendarFormat.month);
                    setState(() {
                      _refreshKey = UniqueKey();
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    side: BorderSide(
                      color: Colors.transparent, // This will hide the left border
                      width: 0, // This will hide the left border
                    ),
                  ),
                  backgroundColor: widget.currentFormat == CalendarFormat.month ? primaryColor.withAlpha(50) : Colors.transparent,
                ),
                child: Text(context.i18n.month,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor, fontWeight: FontWeight.w900))),
          ),
        ],
      ),
      PatientCalendar(
        key: _refreshKey,
        showWeekNavigation: true,
        patientActivities: widget.patientActivities,
        personalGoals: widget.personalGoals,
        changeDay: widget.changeDay,
        focusedDay: widget.focusedDay,
        changeMonth: widget.changeMonth,
        currentFormat: widget.currentFormat,
        changeCurrentDate: changeCurrentDate,
        changeEvents: changeEvents,
        maxHeight: appBarHeight,
      ),
      appBarHeight,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    APTApp.globalAptCubit.reset();
  }

  void _addActivity() {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    if (userRepository.userRole != UserRole.PATIENT) {
      widget.addActivity(_currentDate.dateTime);
    } else {
      widget.addExtraActivity(_currentDate.dateTime, null, widget.activeMinutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    initAptBar();
    final userRepository = KiwiContainer().resolve<UserRepository>();
    return SafeArea(
      child: Scrollbar(
        controller: _scrollController,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: mobileBackgroundColor,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              shrinkWrap: true,
              controller: _scrollController,
              children: [
                if (widget.currentFormat == CalendarFormat.month)
                  PatientCalendar(
                    key: _refreshKey,
                    showWeekNavigation: false,
                    patientActivities: widget.patientActivities,
                    personalGoals: widget.personalGoals,
                    changeDay: widget.changeDay,
                    changeMonth: widget.changeMonth,
                    focusedDay: widget.focusedDay,
                    currentFormat: widget.currentFormat,
                    changeCurrentDate: changeCurrentDate,
                    changeEvents: changeEvents,
                  ),
                if (userRepository.userRole != UserRole.PATIENT)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: PatientInfoLine(
                      patient: widget.patient,
                      patientOverview: widget.patientOverview,
                      personalGoals: widget.personalGoals,
                      userPicture: widget.userPicture,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: PatientActivityList(
                    events: _events,
                    currentDate: _currentDate,
                    markAsDone: (item) =>
                        widget.markAsDone(item, widget.activeMinutes, widget.patientOverview.institution?.allowRescheduleActivities ?? false),
                    onTapActivity: (item) => showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ActivityDialog(
                            patient: widget.patient,
                            activity: item,
                            activeMinutes: widget.activeMinutes,
                            rateActivity: false,
                            deleteActivity: widget.deleteActivity,
                            allowRescheduleActivities: widget.patientOverview.institution?.allowRescheduleActivities ?? false,
                          );
                        }),
                    onAddActivity: this._addActivity,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: ActiveMinutesCard(
                    activeMinutes: widget.activeMinutes,
                    patient: widget.patient,
                    startDate: _currentDate.clone(),
                  ),
                ),
                SizedBox(height: 5),
                if (userRepository.userRole == UserRole.PATIENT)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: PatientChartCard(
                      patientOverview: widget.patientOverview,
                      height: 170,
                      startDate: _currentDate.clone(),
                    ),
                  ),
                if (userRepository.userRole != UserRole.PATIENT)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: PatientNotesCard(
                      patientId: widget.patient.id!,
                      patientNotes: widget.patientOverview.user!.patientNotes ?? "",
                      isMobile: true,
                    ),
                  ),
                SizedBox(height: 5),
                ..._renderPersonalGoals(),
                if (userRepository.userRole != UserRole.PATIENT ||
                    widget.patientOverview.institution!.institutionFocus == InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: ElevatedButton.icon(
                      key: Key(KEY_PATIENT_CALENDAR_BUTTON_ADD_PERSONAL_GOAL),
                      style: getElevatedButtonStyle(context, backgroundColor: goalColor),
                      onPressed: () {
                        if (userRepository.userRole == UserRole.PATIENT) {
                          context.beamToNamed("/calendar/goal-setting", data: {"editGoal": null});
                        } else {
                          context.beamToNamed("/patients/${widget.patient.id}/calendar/goal-setting", data: {"editGoal": null});
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text(context.i18n.personalGoal.toUpperCase()),
                    ),
                  ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _renderPersonalGoals() {
    return widget.personalGoals
        .map((entry) => ActivityListTile(
              icon: Icon(Icons.flag, color: goalColor),
              color: goalColor,
              title: entry.description ?? "",
              subtitle: "${context.i18n.goal}, ${germanDateFormat.format(DateTime.parse(entry.endDate!))}",
              done: entry.done ?? false,
              onTap: () => showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => PersonalGoalDialog(
                  personalGoal: entry,
                  isMobile: true,
                ),
              ),
              markAsDone: () =>
                  this.widget.markAsDone(entry, widget.activeMinutes, widget.patientOverview.institution?.allowRescheduleActivities ?? false),
            ))
        .toList();
  }
}
