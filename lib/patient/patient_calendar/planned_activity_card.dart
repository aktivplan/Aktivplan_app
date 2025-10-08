// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/activity/bloc/activity_repository.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/bloc/message_repository.dart';
import 'package:aptapp/patient/stats/activity_stats.dart';
import 'package:aptapp/patient/stats/extra_activity_stats.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PlannedActivityCard extends StatefulWidget {
  final ActivityOverviewDTO activity;
  final Function markAsDone;
  final Function addExtraActivity;
  final bool? onShowEvents;
  final ActiveMinutesOverviewDTO activeMinutes;
  final PatientGetDTO? patient;
  final Function deleteActivity;
  final ActivityBloc activityBloc;

  PlannedActivityCard({
    Key? key,
    required this.activity,
    required this.markAsDone,
    required this.addExtraActivity,
    required this.deleteActivity,
    this.onShowEvents,
    required this.activeMinutes,
    required this.activityBloc,
    this.patient,
  }) : super(key: key);

  @override
  _PlannedActivityCardCardState createState() => _PlannedActivityCardCardState();
}

class _PlannedActivityCardCardState extends State<PlannedActivityCard> {
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    isDone = widget.activity.rating?.done ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime date = DateTime.parse(widget.activity.date!);

    bool onEventList = widget.onShowEvents ?? false;
    var activeMin = widget.activeMinutes;
    final userRepository = KiwiContainer().resolve<UserRepository>();

    return ResponsiveBuilder(
      builder: (context, size) {
        return BlocBuilder<ActivityBloc, ActivityState>(
          buildWhen: (prev, current) {
            return prev != current;
          },
          builder: (context, state) {
            if (state is UpdatePatientActivityRatingState) {
              if (state.activityId == widget.activity.activityId && state.date == widget.activity.date) {
                isDone = state.rating.done ?? false;
              }
            }
            return Card(
              color: widget.activity.type == ActivityType.EXTRA ? extraActivityColor : accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (onEventList) Navigator.pop(context);
                          if (userRepository.userRole == UserRole.PATIENT) {
                            widget.addExtraActivity(date, widget.activity, activeMin);
                          } else {
                            widget.activity.type == ActivityType.EXTRA
                                ? showPlannedExtraActivity(widget.activity, width, height, widget.patient!.id!, size, context, widget.deleteActivity)
                                : showPlannedActivity(widget.activity, widget.patient!, size, context, widget.activityBloc);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: SelectableText(
                              getTranslatedText(widget.activity.name, context),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.05,
                                  ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  SelectableText(
                                    widget.activity.type == ActivityType.EXTRA
                                        ? "${widget.activity.durationMinutes} min, ${widget.activity.type!.value},"
                                        : "${widget.activity.plannedDurationMinutes} min, ${widget.activity.type!.value},",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              SelectableText(
                                date.isToday
                                    ? "${context.i18n.today}, ${DateFormat('dd.MMMM yyyy', 'de').format(date)}"
                                    : date.isTomorrow
                                        ? "${context.i18n.tomorrow}, ${DateFormat('dd.MMMM.yyyy', 'de').format(date)}"
                                        : "${DateFormat('dd.MMMM yyyy', 'de').format(date)}",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          if (onEventList) {
                            Navigator.pop(context);
                          }
                          widget.markAsDone(widget.activity, widget.activeMinutes);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check_circle,
                            color: isDone ? Colors.white : Colors.white54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showPlannedExtraActivity(
      ActivityOverviewDTO activity, double width, double height, String patientId, size, context, Function deleteActivity) async {
    double alertSizePadding = size.isMobile
        ? width * 0.02
        : size.isDesktop
            ? width * 0.34
            : width * 0.2;
    double containerWidth = size.isMobile
        ? width * 0.94
        : size.isDesktop
            ? width * 0.28
            : width * 0.5;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: alertSizePadding,
          ),
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 8, left: 20, right: 20),
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.close,
                        size: 24,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Text(
                  context.i18n.extraActivity,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                ),
              ],
            ),
          ),
          content: Container(
            width: containerWidth,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  BlocProvider(
                    create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                    child: ExtraActivityStats(
                      activity: activity,
                      patientId: patientId,
                      deleteActivity: deleteActivity,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showPlannedActivity(
      ActivityOverviewDTO activity, PatientGetDTO patient, SizingInformation size, context, ActivityBloc activityBloc) async {
    double width = MediaQuery.of(context).size.width;
    double alertSizePadding = size.isMobile
        ? width * 0.02
        : size.isDesktop
            ? width * 0.34
            : width * 0.2;
    double containerWidth = size.isMobile
        ? width * 0.94
        : size.isDesktop
            ? width * 0.28
            : width * 0.5;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: alertSizePadding,
          ),
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 8, left: 20, right: 20),
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.close,
                        size: 24,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.i18n.plannedActivity,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          content: Container(
            width: containerWidth,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  BlocProvider(
                    create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ActivityStats(
                          activity: activity,
                          patient: patient,
                          activityBloc: activityBloc,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
