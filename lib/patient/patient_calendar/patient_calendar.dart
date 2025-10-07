import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientCalendar extends StatefulWidget {
  final List<ActivityOverviewDTO> patientActivities;
  final List<PersonalGoal> personalGoals;
  final Function(DateTime)? changeDay;
  final Function(DateTime)? changeMonth;
  final DateTime focusedDay;
  final CalendarFormat currentFormat;
  final showWeekNavigation;
  final Function(Jiffy)? changeCurrentDate;
  final Function(Map<String, List>)? changeEvents;
  final double maxHeight;
  final DateTime? lowerBound;
  final DateTime? upperBound;
  final double borderRadius;

  PatientCalendar({
    Key? key,
    required this.showWeekNavigation,
    required this.patientActivities,
    required this.personalGoals,
    required this.focusedDay,
    required this.currentFormat,
    this.changeDay,
    this.changeMonth,
    this.changeCurrentDate,
    this.changeEvents,
    this.maxHeight = double.infinity,
    this.lowerBound,
    this.upperBound,
    this.borderRadius = 0,
  }) : super(key: key ?? Key(KEY_PATIENT_CALENDAR_SCROLL_VIEW));

  @override
  _PatientCalendarState createState() => _PatientCalendarState();
}

class _PatientCalendarState extends State<PatientCalendar> {
  Map<String, List> _events = Map();
  Jiffy _currentDate = Jiffy.now().startOf(Unit.day);
  Jiffy _currentFocusedDate = Jiffy.now();
  int? currentMonth;
  PageController? pageController;

  get appBarHeight => null;

  @override
  void initState() {
    super.initState();
    _currentDate = Jiffy.parseFromDateTime(widget.focusedDay).startOf(Unit.day);
    _currentFocusedDate = Jiffy.parseFromDateTime(widget.focusedDay);
    currentMonth = _currentDate.month;
    if (widget.changeCurrentDate != null) {
      Future.delayed(Duration.zero, () {
        widget.changeCurrentDate!(_currentDate);
      });
    }
  }

  @override
  void didUpdateWidget(PatientCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusedDay != widget.focusedDay) {
      setState(() {
        _currentDate = Jiffy.parseFromDateTime(widget.focusedDay).startOf(Unit.day);
        _currentFocusedDate = Jiffy.parseFromDateTime(widget.focusedDay);
        currentMonth = _currentDate.month;
      });
    }
  }

  canNavigateBack() {
    if (widget.lowerBound == null) {
      return true;
    }
    return _currentDate.subtract(weeks: 1).isAfter(Jiffy.parseFromDateTime(widget.lowerBound!));
  }

  canNavigateForward() {
    if (widget.upperBound == null) {
      return true;
    }
    return _currentDate.add(weeks: 1).isBefore(Jiffy.parseFromDateTime(widget.upperBound!));
  }

  getActivites() {
    Map<String, List> map = {};
    List patientEvents = [...widget.patientActivities, ...widget.personalGoals];

    patientEvents.forEach((elem) {
      var eventDate = elem is ActivityOverviewDTO ? elem.date : elem.endDate;
      Jiffy date = Jiffy.parse(eventDate);
      if (map[date.yMd] == null) {
        map[date.yMd] = [];
      }
      map[date.yMd]!.add(elem);
    });

    _events = map;
    if (widget.changeEvents != null) {
      widget.changeEvents!(map);
    }
  }

  Widget getCalendar() {
    return TableCalendar(
      calendarFormat: widget.currentFormat,
      availableCalendarFormats: const {
        CalendarFormat.week: '',
        CalendarFormat.month: '',
      },
      onCalendarCreated: (controller) {
        pageController = controller;
      },
      onDaySelected: (selectedDay, focusedDay) => setState(() {
        _currentDate = Jiffy.parseFromDateTime(selectedDay);
        _currentFocusedDate = Jiffy.parseFromDateTime(focusedDay);
        if (widget.changeDay != null) {
          widget.changeDay!(_currentDate.dateTime);
        }
        if (widget.changeCurrentDate != null) {
          widget.changeCurrentDate!(_currentDate);
        }
      }),
      eventLoader: (DateTime day) {
        final jiffyDay = Jiffy.parseFromDateTime(day);
        return _events[jiffyDay.yMd] ?? [];
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      focusedDay: _currentFocusedDate.dateTime,
      currentDay: DateTime.now(),
      firstDay: DateTime.utc(2010),
      lastDay: DateTime.utc(2100),
      daysOfWeekVisible: false,
      headerVisible: false,
      availableGestures: AvailableGestures.none,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        markerSize: 12,
      ),
      rowHeight: widget.currentFormat == CalendarFormat.week ? kToolbarHeight : kToolbarHeight * .75,
      locale: context.i18n.localeName,
      calendarBuilders: CalendarBuilders(
        singleMarkerBuilder: (context, day, event) {
          Color shapeColor = plannedActivityColor;
          if (event is ActivityOverviewDTO) {
            if (event.type == ActivityType.EXTRA) {
              shapeColor = extraActivityColor;
            } else if (event.type == ActivityType.APPOINTMENT) {
              shapeColor = primaryColor;
            } else if (event.type == ActivityType.TASK) {
              shapeColor = plannedTaskColor;
            }
          } else {
            shapeColor = goalColor;
          }
          if ((event is PersonalGoal && (event.done ?? false)) || (event is ActivityOverviewDTO && (event.rating?.done ?? false))) {
            return Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: shapeColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                heightFactor: 0.7,
                widthFactor: 0.7,
                child: Icon(Icons.check, color: Colors.white, size: 10),
              ),
            );
          }
          final jiffyDay = Jiffy.parseFromDateTime(day);
          final eventsOfDay = _events[jiffyDay.yMd] ?? [];
          bool oneDoneOfDay = true;
          for (event in eventsOfDay) {
            if (event is PersonalGoal && (event.done ?? false)) {
              oneDoneOfDay = false;
              break;
            } else if (event is ActivityOverviewDTO && (event.rating?.done ?? false)) {
              oneDoneOfDay = false;
              break;
            }
          }
          return Padding(
            padding: EdgeInsets.only(top: oneDoneOfDay ? 2 : 0),
            child: Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 0.3),
              decoration: shapeColor == primaryColor || shapeColor == plannedTaskColor
                  ? BoxDecoration(
                      border: Border.all(color: shapeColor, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    )
                  : BoxDecoration(
                      color: shapeColor,
                      shape: BoxShape.circle,
                    ),
            ),
          );
        },
        defaultBuilder: _dayBuilder,
        outsideBuilder: _dayBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getActivites();
    if (widget.showWeekNavigation) {
      final double calendarNavigationWidth = MediaQuery.of(context).size.width / 10;
      final Jiffy dateToUse = _currentDate.clone();
      final yearMonthFormatter = DateFormat.yMMMM(context.i18n.localeName);
      final startOfWeek = dateToUse.clone().startOf(Unit.week);
      final endOfWeek = dateToUse.endOf(Unit.week).subtract(days: 1);
      String subtitle = yearMonthFormatter.format(startOfWeek.dateTime);
      if (startOfWeek.year != endOfWeek.year) {
        subtitle = "${yearMonthFormatter.format(startOfWeek.dateTime)}/${yearMonthFormatter.format(endOfWeek.dateTime)}";
      } else if (startOfWeek.month != endOfWeek.month) {
        subtitle = "${DateFormat.MMMM(context.i18n.localeName).format(startOfWeek.dateTime)}/${yearMonthFormatter.format(endOfWeek.dateTime)}";
      }
      final bool canNavigateBack = this.canNavigateBack();
      final bool canNavigateForward = this.canNavigateForward();
      return Container(
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5,
              spreadRadius: -5,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  key: Key(KEY_PATIENT_CALENDAR_BUTTON_PREVIOUS_WEEK),
                  onTap: !canNavigateBack
                      ? null
                      : () {
                          if (widget.showWeekNavigation) {
                            pageController?.previousPage(duration: Duration(microseconds: 300), curve: Curves.easeOut);
                          }
                          setState(() {
                            if (widget.currentFormat == CalendarFormat.month) {
                              _currentFocusedDate = _currentFocusedDate.subtract(months: 1);
                            } else {
                              _currentFocusedDate = _currentFocusedDate.subtract(weeks: 1);
                            }
                            _currentDate = _currentFocusedDate;
                            if (widget.changeDay != null) {
                              widget.changeDay!(_currentDate.dateTime);
                            }
                            if (_currentDate.month != currentMonth) {
                              currentMonth = _currentDate.month;
                              if (widget.changeMonth != null) {
                                widget.changeMonth!(_currentDate.dateTime);
                              }
                            }
                            if (widget.changeCurrentDate != null) {
                              widget.changeCurrentDate!(_currentDate);
                            }
                          });
                        },
                  child: Container(
                    height: 60,
                    width: calendarNavigationWidth,
                    child: Icon(
                      Icons.chevron_left,
                      color: canNavigateBack ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_currentFocusedDate.isSame(Jiffy.now(), unit: Unit.day))
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: InkWell(
                            key: Key(KEY_PATIENT_CALENDAR_BUTTON_TODAY),
                            onTap: () => setState(
                              () {
                                _currentDate = Jiffy.now();
                                _currentFocusedDate = Jiffy.now();
                                if (widget.changeDay != null) {
                                  widget.changeDay!(_currentDate.dateTime);
                                }
                                if (_currentDate.month != currentMonth) {
                                  currentMonth = _currentDate.month;
                                  if (widget.changeMonth != null) {
                                    widget.changeMonth!(_currentDate.dateTime);
                                  }
                                }
                                if (widget.changeCurrentDate != null) {
                                  widget.changeCurrentDate!(_currentDate);
                                }
                              },
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: mobileBackgroundColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  child: Text(
                                    context.i18n.today,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w900),
                                  )),
                            ),
                          ),
                        ),
                      StyledText(
                        text: widget.currentFormat == CalendarFormat.week
                            ? "${context.i18n.calendarWeek} ${dateToUse.weekOfYear == 0 ? dateToUse.startOf(Unit.week).weekOfYear : dateToUse.weekOfYear}\n<subtitle>$subtitle</subtitle>"
                            : "${subtitle.substring(0, subtitle.lastIndexOf(' '))}\n<subtitle>${subtitle.substring(subtitle.lastIndexOf(' '))}</subtitle>",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                        tags: {
                          'subtitle': StyledTextTag(
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        },
                      ),
                      if (!_currentFocusedDate.isSame(Jiffy.now(), unit: Unit.day))
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                child: Text(
                                  context.i18n.today,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.transparent, fontSize: 10, fontWeight: FontWeight.w900),
                                )),
                          ),
                        ),
                    ],
                  ),
                ),
                InkWell(
                  key: Key(KEY_PATIENT_CALENDAR_BUTTON_NEXT_WEEK),
                  onTap: !canNavigateForward
                      ? null
                      : () {
                          pageController?.nextPage(duration: Duration(microseconds: 300), curve: Curves.easeOut);
                          setState(() {
                            if (widget.currentFormat == CalendarFormat.month) {
                              _currentFocusedDate = _currentFocusedDate.add(months: 1);
                            } else {
                              _currentFocusedDate = _currentFocusedDate.add(weeks: 1);
                            }
                            _currentDate = _currentFocusedDate;
                            if (widget.changeDay != null) {
                              widget.changeDay!(_currentDate.dateTime);
                            }
                            if (_currentDate.month != currentMonth) {
                              currentMonth = _currentDate.month;
                              if (widget.changeMonth != null) {
                                widget.changeMonth!(_currentDate.dateTime);
                              }
                            }
                            if (widget.changeCurrentDate != null) {
                              widget.changeCurrentDate!(_currentDate);
                            }
                          });
                        },
                  child: Container(
                    height: 60,
                    width: calendarNavigationWidth,
                    child: Icon(
                      Icons.chevron_right,
                      color: canNavigateForward ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.currentFormat == CalendarFormat.week)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 10),
                  Flexible(child: getCalendar()),
                  SizedBox(width: 10),
                ],
              ),
          ],
        ),
      );
    }
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: List<Widget>.generate(7, (index) {
                final weekDay = DateTime(2021, 5, 3 + index); // May 3, 2021 is a Monday
                return Expanded(
                  child: Center(
                    child: Text(DateFormat.E(context.i18n.localeName).format(weekDay),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black)),
                  ),
                );
              }),
            ),
            SizedBox(height: 5),
            getCalendar(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _dayBuilder(BuildContext context, DateTime date, DateTime focusedDate) {
    Color backgroundColor = Jiffy.now().isSame(Jiffy.parseFromDateTime(date), unit: Unit.day) ? mobileBackgroundColor : Colors.white;
    var boxDecoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.all(
          Radius.circular(widget.currentFormat == CalendarFormat.week || Jiffy.now().isSame(Jiffy.parseFromDateTime(date), unit: Unit.day) ? 6 : 0)),
    );
    var padding = EdgeInsets.all(1.5);

    if (date.day == _currentDate.dateTime.day && date.month == _currentDate.dateTime.month && date.year == _currentDate.dateTime.year) {
      boxDecoration = BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(const Radius.circular(6)),
        border: Border.all(color: primaryColor, width: 2),
      );
      padding = EdgeInsets.zero;
    }

    final weekdayString = DateFormat.E(context.i18n.localeName).format(date);
    return GestureDetector(
      child: Container(
        decoration: boxDecoration,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.currentFormat == CalendarFormat.week)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    weekdayString,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.grey[700]),
                  ),
                ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    '${date.day}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.0, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
