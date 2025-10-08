// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/active_minutes_card.dart';
import 'package:aptapp/patient/patient_calendar/patient_activity_list.dart';
import 'package:aptapp/patient/patient_calendar/patient_calendar.dart';
import 'package:aptapp/patient/patient_calendar/patient_chart_card.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:table_calendar/table_calendar.dart';

class ContactDetailPage extends StatefulWidget {
  final String userId;
  ContactDetailPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> with TraceablePageMixin, WidgetsBindingObserver {
  SocialBloc? socialBloc;
  DateTime selectedDay = DateTime.now();
  DateTime lowerBoundDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1 + 14)); // two weeks in the past
  DateTime upperBoundDate = DateTime.now().add(Duration(days: (7 - DateTime.now().weekday + 14))); // two weeks in the future
  Jiffy _currentDate = Jiffy.now().startOf(Unit.day);
  Map<String, List> _events = Map();
  // hast 5 entries, 2 past weeks, 2 future weeks, current week is index 2
  int _currentActiveMinutesIndex = 2;
  Key _activeMinutesKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    socialBloc = BlocProvider.of<SocialBloc>(context);
    socialBloc!.add(FetchContactDetailEvent(
        userId: widget.userId, startDate: englishDateFormat.format(lowerBoundDate), endDate: englishDateFormat.format(upperBoundDate)));
  }

  void changeCurrentDate(Jiffy date) {
    Jiffy startDate = Jiffy.now().startOf(Unit.day);
    Jiffy dateToCompare = date.clone().startOf(Unit.day);
    // relatively move the compare date so that they are in the same year
    while (startDate.year != dateToCompare.year) {
      startDate = startDate.add(weeks: 1);
      dateToCompare = dateToCompare.add(weeks: 1);
    }
    final weekDifference = dateToCompare.weekOfYear - startDate.weekOfYear;
    setState(() {
      _currentDate = date;
      _currentActiveMinutesIndex = 2 + weekDifference;
      _activeMinutesKey = UniqueKey();
    });
  }

  getLastOnlineText(Jiffy lastOnlineDate) {
    final Jiffy now = Jiffy.now();
    if (lastOnlineDate.isSame(now, unit: Unit.day)) {
      return context.i18n.lastOnlineTodayAt(lastOnlineDate.Hm);
    } else if (lastOnlineDate.isSame(now.subtract(days: 1), unit: Unit.day)) {
      return context.i18n.lastOnlineYesterdayAt(lastOnlineDate.Hm);
    } else {
      return context.i18n.lastOnlineAt(lastOnlineDate.format(pattern: 'dd.MM.yyyy'), lastOnlineDate.Hm);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      key: Key(KEY_PATIENT_DATA_SCROLL_VIEW),
      child: Center(
        child: ResponsiveBuilder(
          builder: (context, size) {
            final double containerWidth = size.isMobile ? width * 0.9 : width * 0.5;
            return Container(
              width: containerWidth,
              child: BlocConsumer<SocialBloc, SocialState>(
                listenWhen: (previous, state) {
                  return true;
                },
                listener: (context, state) {
                  var snackBar;
                  if (state is SentSocialMessageState) {
                    snackBar = getSnackbar(state.success ? context.i18n.sentMessage : context.i18n.sentMessageError, size.isMobile, context,
                        error: !state.success);
                    socialBloc!.add(FetchContactDetailEvent(
                        userId: widget.userId,
                        startDate: englishDateFormat.format(lowerBoundDate),
                        endDate: englishDateFormat.format(upperBoundDate)));
                  }
                  if (snackBar != null) {
                    snackBar.show(context);
                    snackBar = null;
                  }
                },
                builder: (context, state) {
                  if (state is FetchedContactDetail) {
                    String lastActiveTimeString = state.detail.lastActiveDateTime!;
                    // if no time zone info add Z for UTC
                    if (!lastActiveTimeString.contains('Z')) {
                      lastActiveTimeString = lastActiveTimeString + 'Z';
                    }
                    Jiffy lastOnlineDate = Jiffy.parseFromDateTime(DateTime.parse(lastActiveTimeString).toLocal());
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        state.detail.profilePicture?.exists ?? false
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(state.detail.profilePicture!.url!),
                                radius: 40,
                                backgroundColor: Colors.transparent,
                              )
                            : Icon(Icons.account_circle, color: Colors.grey, size: 80),
                        SelectableText(
                          state.detail.fullName!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, height: 1.3),
                        ),
                        SizedBox(height: 10),
                        if ((state.detail.statusMessage ?? "").isNotEmpty)
                          SelectableText(state.detail.statusMessage!,
                              textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                        SelectableText(getLastOnlineText(lastOnlineDate),
                            textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          style: getElevatedButtonStyle(context, backgroundColor: primaryColor),
                          onPressed: () {
                            context.beamToNamed("/contacts/${widget.userId}/message");
                          },
                          icon: Icon(Icons.message),
                          label: Text(
                            context.i18n.message.toUpperCase(),
                          ),
                        ),
                        if (state.detail.shareActivityData ?? false) ...[
                          SizedBox(height: 10),
                          PatientCalendar(
                            showWeekNavigation: true,
                            borderRadius: 4,
                            patientActivities: state.detail.activities,
                            personalGoals: state.detail.personalGoals,
                            focusedDay: selectedDay,
                            currentFormat: CalendarFormat.week,
                            lowerBound: lowerBoundDate,
                            upperBound: upperBoundDate,
                            changeCurrentDate: changeCurrentDate,
                            changeEvents: (events) {
                              _events = events;
                            },
                          ),
                          PatientActivityList(events: _events, currentDate: _currentDate),
                          if (state.detail.shareActiveMinutes ?? true) ...[
                            SizedBox(height: 10),
                            ActiveMinutesCard(
                              key: _activeMinutesKey,
                              activeMinutes: state.detail.activeMinutes[_currentActiveMinutesIndex],
                              startDate: _currentDate.clone(),
                              mobileOnly: true,
                              showCharts: false,
                            ),
                            SizedBox(height: 10),
                            PatientChartCard(
                              patientOverview: state.detail.patient!,
                              height: 170,
                              startDate: _currentDate.clone(),
                            ),
                          ],
                        ],
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                          onPressed: () {
                            DeleteButton.showDeleteConfirmationDialog(
                                context, context.i18n.removeContact, context.i18n.removeContactText(state.detail.fullName!), () {
                              socialBloc!.add(RemoveContactEvent(userId: widget.userId));
                              if (context.canBeamBack) {
                                context.beamBack();
                              } else {
                                context.beamToNamed('/contacts');
                              }
                            }, shortButtonTexts: true);
                          },
                          label: Text(
                            context.i18n.removeContact.toUpperCase(),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  String get traceablePageName => "Contact Detail Page";
}
