import 'dart:convert';

import 'package:apt_api/api.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/healthcare_professional_locations.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/activity_dialog.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/active_minutes_card.dart';
import 'package:aptapp/patient/patient_calendar/patient_info_line.dart';
import 'package:aptapp/patient/patient_calendar/patient_notes_card.dart';
import 'package:aptapp/patient/patient_calendar/patient_chart_card.dart';
import 'package:aptapp/patient/patient_calendar/personal_goals_card.dart';
import 'package:aptapp/patient/personal_goal_dialog.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:week_of_year/week_of_year.dart';

import '../../beamer/router_service.dart';

class PatientCalendarWeb extends StatefulWidget {
  final PatientGetDTO patient;
  final PatientOverviewDTO patientOverview;
  final ActiveMinutesOverviewDTO activeMinutes;
  final Function addActivity;
  final Function(dynamic, ActiveMinutesOverviewDTO, bool) markAsDone;
  final List<ActivityOverviewDTO> patientActivities;
  final List<PersonalGoal> personalGoals;
  final Function showEvents;
  final Function addExtraActivity;
  final Function(String, ActivityType) deleteActivity;
  final Function(MoveActivityPostDTO) moveActivity;
  final Function(MovePersonalGoalPostDTO) movePersonalGoal;
  final bool isTablet;
  final bool isDesktop;
  final Function(DateTime) changeMonth;
  final DateTime focusedDay;
  final FileGetDTO userPicture;

  PatientCalendarWeb(
      {Key? key,
      required this.patient,
      required this.patientOverview,
      required this.addActivity,
      required this.markAsDone,
      required this.patientActivities,
      required this.activeMinutes,
      required this.personalGoals,
      required this.showEvents,
      required this.addExtraActivity,
      required this.deleteActivity,
      required this.isTablet,
      required this.isDesktop,
      required this.changeMonth,
      required this.focusedDay,
      required this.userPicture,
      required this.moveActivity,
      required this.movePersonalGoal})
      : super(key: key ?? Key(KEY_PATIENT_CALENDAR_SCROLL_VIEW));

  @override
  _PatientCalendarWebState createState() => _PatientCalendarWebState();
}

class _PatientCalendarWebState extends State<PatientCalendarWeb> {
  Map<String, List> _events = Map();
  Map<String, bool> buttonVisible = {};
  DateTime lastFocusedDay = DateTime.now();
  bool cancelDrag = false;

  void initState() {
    super.initState();
    lastFocusedDay = widget.focusedDay;
    getActivites();
  }

  @override
  void didUpdateWidget(covariant PatientCalendarWeb oldWidget) {
    super.didUpdateWidget(oldWidget);
    getActivites();
  }

  void _onDaySelected(DateTime day) {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    List events = _events[day] ?? [];
    if (userRepository.userRole != UserRole.PATIENT) {
      widget.addActivity(day);
    } else {
      try {
        if (events.isEmpty) {
          widget.addExtraActivity(day, null, widget.activeMinutes);
        } else {
          widget.showEvents(day, events, widget.activeMinutes, widget.patient, widget.deleteActivity);
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  getActivites() {
    Map<String, List> map = {};
    List patientEvents = [
      ...widget.patientActivities.map((e) => ActivityOverviewDTO.fromJson(jsonDecode(jsonEncode(e.toJson())))).toList(),
      ...widget.personalGoals.map((e) => PersonalGoal.fromJson(jsonDecode(jsonEncode(e.toJson())))).toList(),
    ];

    patientEvents.forEach((elem) {
      var eventDate = elem is ActivityOverviewDTO ? elem.date : elem.endDate;
      Jiffy date = Jiffy.parse(eventDate);
      if (map[date.yMd] == null) {
        map[date.yMd] = [];
      }
      map[date.yMd]!.add(elem);
    });

    setState(() {
      _events = map;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    PatientGetDTO patient = widget.patientOverview.user ?? widget.patient;
    final userRepository = KiwiContainer().resolve<UserRepository>();
    return AptLayout(
      border: false,
      fixedHeight: false,
      breadCrumb: [
        if (userRepository.userRole == UserRole.ADMINISTRATOR)
          BreadCrumbItem(
            content: TextButton(
              onPressed: () => context.beamToNamed(RouterService.institutionsRoute()),
              child: Text(
                context.i18n.institutionOverview,
                style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ),
        if (userRepository.userRole == UserRole.ADMINISTRATOR)
          BreadCrumbItem(
            content: TextButton(
              onPressed: () =>
                  context.beamToNamed(RouterService.healthcareProfessionalsRoute(institutionId: widget.patientOverview.institution!.id!)),
              child: Text(
                widget.patientOverview.institution!.name ?? "",
                style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ),
        if (userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR)
          BreadCrumbItem(
            content: TextButton(
              onPressed: () => context.beamToNamed(RouterService.healthcareProfessionalsRoute()),
              child: Text(
                context.i18n.institutionOverview,
                style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ),
        if (userRepository.userRole != UserRole.PATIENT)
          BreadCrumbItem(
            content: TextButton(
              key: Key(KEY_PATIENT_CALENDAR_BREAD_CRUMB_HEALTHCARE_PROFESSIONAL),
              onPressed: () => context.beamToNamed(RouterService.patientsRoute(
                  healthcareProfessionalId: widget.patientOverview.healthcareProfessional!.id!,
                  institutionId: widget.patientOverview.institution!.id!)),
              child: Text(
                userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL
                    ? context.i18n.patientOverview
                    : "${widget.patientOverview.healthcareProfessional!.lastName ?? ""} ${widget.patientOverview.healthcareProfessional!.firstName ?? ""}",
                style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ),
        if (userRepository.userRole != UserRole.PATIENT)
          BreadCrumbItem(
            content: Text(
              "${patient.lastName} ${patient.firstName}",
              style: getBreadCrumbStyle(context),
            ),
          ),
      ],
      children: [
        if (userRepository.userRole != UserRole.PATIENT)
          PatientInfoLine(
            patient: patient,
            patientOverview: widget.patientOverview,
            personalGoals: widget.personalGoals,
            userPicture: widget.userPicture,
          ),
        ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              lg: 2,
              md: 12,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: ActiveMinutesCard(
                  activeMinutes: widget.activeMinutes,
                  patient: widget.patient,
                  startDate: Jiffy.now(),
                ),
              ),
            ),
            if (userRepository.userRole == UserRole.PATIENT)
              ResponsiveGridCol(
                lg: 5,
                md: 6,
                sm: 12,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: PatientChartCard(
                    patientOverview: widget.patientOverview,
                    height: 340,
                    startDate: Jiffy.now(),
                  ),
                ),
              ),
            ResponsiveGridCol(
              lg: 5,
              md: 6,
              sm: 12,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: PersonalGoalsCard(
                  patientId: widget.patient.id!,
                  institution: widget.patientOverview.institution!,
                ),
              ),
            ),
            if (userRepository.userRole != UserRole.PATIENT)
              ResponsiveGridCol(
                lg: 5,
                md: 6,
                sm: 12,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: PatientNotesCard(
                    patientId: widget.patient.id!,
                    patientNotes: widget.patientOverview.user!.patientNotes ?? "",
                    isMobile: false,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 4, right: 4, top: 10),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: _buildTableCalendar(height, widget.isTablet, widget.isDesktop),
          ),
        ),
        if (userRepository.userRole != UserRole.PATIENT)
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoIconColor,
                  size: 20,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: SelectableText(
                    context.i18n.activityMoveHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.1, color: infoIconColor),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTableCalendar(height, bool isTablet, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: datatableBorderColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: TableCalendar(
        eventLoader: (DateTime day) {
          final jiffyDay = Jiffy.parseFromDateTime(day);
          return _events[jiffyDay.yMd] ?? [];
        },
        onPageChanged: (focusedDay) {
          lastFocusedDay = focusedDay;
          widget.changeMonth(focusedDay);
        },
        focusedDay: widget.focusedDay,
        currentDay: widget.focusedDay,
        firstDay: DateTime.utc(2010),
        lastDay: DateTime.utc(2100),
        rowHeight: height * 0.18,
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        availableGestures: AvailableGestures.horizontalSwipe,
        availableCalendarFormats: const {
          CalendarFormat.month: '',
        },
        calendarStyle: CalendarStyle(
          cellMargin: EdgeInsets.zero,
          markersAlignment: Alignment.topCenter,
          outsideDaysVisible: true,
          isTodayHighlighted: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: lightTextColor, fontSize: 14),
          weekendStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: lightTextColor, fontSize: 14),
        ),
        calendarBuilders: CalendarBuilders(
          outsideBuilder: _dayBuilder,
          defaultBuilder: _dayBuilder,
          markerBuilder: (context, date, events) {
            return _markerBuilder(events, date);
          },
          headerTitleBuilder: (context, date) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (DateTime.now().month != widget.focusedDay.month)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                    child: InkWell(
                      key: Key(KEY_PATIENT_CALENDAR_BUTTON_TODAY),
                      onTap: () => widget.changeMonth(DateTime.now()),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.today,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            context.i18n.today.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontSize: 7, fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                  ),
                Text(
                  DateFormat("MMMM yyyy", Localizations.localeOf(context).languageCode).format(lastFocusedDay),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _markerBuilder(List<dynamic> events, DateTime date) {
    return DragTarget(
      onAcceptWithDetails: (DragTargetDetails<Object> dragTargetDetails) {
        final data = dragTargetDetails.data;
        var eventDate = data is ActivityOverviewDTO ? data.date : (data as PersonalGoal).endDate;
        var map = {..._events};
        var newDateKey = Jiffy.parseFromDateTime(date).yMd;
        map[Jiffy.parse(eventDate!).yMd]!.remove(data);
        if (map[newDateKey] == null) {
          map[newDateKey] = [];
        }
        if (data is ActivityOverviewDTO) {
          data.date = englishDateFormat.format(date);
        } else {
          (data as PersonalGoal).endDate = englishDateFormat.format(date);
        }
        map[newDateKey]!.add(data);
        setState(() {
          _events = {...map};
        });
        if (data is PersonalGoal) {
          widget.movePersonalGoal(MovePersonalGoalPostDTO(personalGoalId: data.id, toDate: englishDateFormat.format(date)));
        } else if (data is ActivityOverviewDTO) {
          if ((data.activity!.repeatCount ?? 1) <= 1 && data.activity!.days.length <= 1) {
            widget.moveActivity(MoveActivityPostDTO(activityId: data.activityId, fromDate: eventDate, toDate: englishDateFormat.format(date)));
          } else {
            Flushbar? snackbar;
            snackbar = getSnackbar(
              context.i18n.activityMoveWarning,
              false,
              context,
              warning: true,
              buttonTitle: context.i18n.undoMove,
              duration: Duration(seconds: 7),
              buttonAction: () {
                cancelDrag = true;
                snackbar!.dismiss();
                getActivites();
              },
              onStatusChanged: (status) {
                if (status == FlushbarStatus.DISMISSED) {
                  if (!cancelDrag) {
                    widget
                        .moveActivity(MoveActivityPostDTO(activityId: data.activityId, fromDate: eventDate, toDate: englishDateFormat.format(date)));
                  }
                  cancelDrag = false;
                }
              },
            );
            snackbar.show(context);
          }
        }
      },
      builder: (context, candidateData, rejectedData) => GestureDetector(
        onTap: () => _onDaySelected(date),
        onDoubleTap: () => _onDaySelected(date),
        child: Padding(
          padding: EdgeInsets.only(top: isOnFirstCalendarLine(date) ? 40 : 22),
          child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              Widget icon;
              if (event is ActivityOverviewDTO) {
                icon = Icon(event.type!.iconData, color: Colors.white);
              } else {
                icon = Icon(Icons.emoji_events, color: Colors.white);
              }
              final theme = Theme.of(context);
              Color backgroundColor = plannedActivityColor;
              String descriptionText = "";
              if (event is ActivityOverviewDTO) {
                final String timeString = getTranslatedTimeString(event.time ?? "", context);
                if (event.type == ActivityType.APPOINTMENT) {
                  backgroundColor = primaryColor;
                  descriptionText = timeString;
                } else if (event.type == ActivityType.TASK) {
                  backgroundColor = plannedTaskColor;
                  descriptionText = ActivityType.TASK.getTranslatedText(context);
                  if (timeString.isNotEmpty) {
                    descriptionText += ", $timeString";
                  }
                } else {
                  if (event.type == ActivityType.EXTRA) {
                    backgroundColor = extraActivityColor;
                  }
                  descriptionText = "";
                  int duration = event.durationMinutes ?? 0;
                  if (timeString.isNotEmpty) {
                    descriptionText += timeString;
                    if (duration > 0) {
                      descriptionText += ", ";
                    }
                  }
                  if (duration > 0) {
                    descriptionText += "$duration min";
                  }
                }
              } else {
                backgroundColor = goalColor;
                descriptionText = context.i18n.personalGoal;
              }

              Widget tile = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Container(
                  decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Transform.scale(scale: 0.75, child: icon),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event is ActivityOverviewDTO ? getTranslatedText(event.name, context) : event.description,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                descriptionText,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if ((event is PersonalGoal && (event.done ?? false)) || (event is ActivityOverviewDTO && (event.rating!.done ?? false)))
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            heightFactor: 0.7,
                            widthFactor: 0.7,
                            child: Icon(Icons.check, color: infoIconColor, size: 10),
                          ),
                        ),
                      SizedBox(
                        width: 4,
                      )
                    ],
                  ),
                ),
              );
              return GestureDetector(
                onTap: () {
                  if (event is PersonalGoal) {
                    showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return PersonalGoalDialog(
                            personalGoal: event,
                            isMobile: false,
                          );
                        });
                  } else if (event.type == ActivityType.APPOINTMENT && userRepository.userRole == UserRole.PATIENT) {
                    showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ActivityDialog(
                            patient: widget.patient,
                            activity: event,
                            activeMinutes: widget.activeMinutes,
                            rateActivity: false,
                            deleteActivity: widget.deleteActivity,
                            allowRescheduleActivities: widget.patientOverview.institution?.allowRescheduleActivities ?? false,
                          );
                        });
                  } else {
                    widget.markAsDone(event, widget.activeMinutes, widget.patientOverview.institution?.allowRescheduleActivities ?? false);
                  }
                },
                child: userRepository.userRole == UserRole.PATIENT || (event is ActivityOverviewDTO && (event.rating!.done ?? false))
                    ? tile
                    : LongPressDraggable(
                        child: tile,
                        data: event,
                        feedback: SizedBox(
                          width: 250,
                          child: Opacity(
                              opacity: 0.8, // Set the opacity to a value less than 1.0
                              child: tile),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _dayBuilder(BuildContext context, DateTime date, DateTime focusedDate) {
    return GestureDetector(
      onTap: () => _onDaySelected(date),
      onDoubleTap: () => _onDaySelected(date),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: datatableBorderColor, width: 0.5),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: isOnFirstCalendarLine(date) ? 54 : 22,
                    decoration: BoxDecoration(
                      color: isSameDay(DateTime.now(), date) ? Colors.black26 : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Column(children: [
                        if (isOnFirstCalendarLine(date)) Text(DayOfWeek.values[date.weekday - 1].getTranslatedShortName(context)),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            '${date.day}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOnFirstCalendarLine(DateTime date) {
    int firstWeekOfYear = lastFocusedDay.setDay(1).weekOfYear;
    if (firstWeekOfYear == 52 && date.weekOfYear < 52) {
      return false;
    }
    return date.weekOfYear <= firstWeekOfYear;
  }
}
