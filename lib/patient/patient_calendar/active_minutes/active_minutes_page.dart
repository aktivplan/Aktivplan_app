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
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/bloc/message_repository.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/active_minutes_detail.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: tabBar,
      );
}

class ActiveMinutesPage extends StatelessWidget {
  final PatientGetDTO patient;
  final double parentHeight;
  final Jiffy selectedDate;
  final bool isKlimafit;
  final bool isEmbedded;

  ActiveMinutesPage({
    Key? key,
    required this.patient,
    required this.parentHeight,
    required this.selectedDate,
    required this.isKlimafit,
    this.isEmbedded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TraceableWidget(
      actionName: "Visited Active Minutes Page",
      path: getCurrentPath(context),
      child: ResponsiveBuilder(
        builder: (context, size) {
          var appBar = AppBar(
            title: SelectableText(isKlimafit ? context.i18n.activeMinutesKlimafit : context.i18n.activeMinutes),
            automaticallyImplyLeading: false,
            leading: size.isMobile
                ? IconButton(
                    key: Key(KEY_BUTTON_CLOSE),
                    icon: Icon(Icons.chevron_left, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  )
                : Container(),
            actions: size.isMobile
                ? []
                : [
                    IconButton(
                      key: Key(KEY_BUTTON_CLOSE),
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
            bottom: ColoredTabBar(
              Theme.of(context).primaryColor,
              TabBar(
                labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                unselectedLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white60),
                indicatorColor: plannedActivityColor,
                onTap: (index) {
                  MatomoTracker.instance.trackEvent(
                    eventInfo: EventInfo(
                        category: EVENT_CATEGORY_ACTIVE_MINUTES,
                        name: EVENT_NAME_CHANGE_TAB,
                        action: "Selected ${index == 0 ? 'Week' : index == 1 ? 'Month' : 'Total'} Tab"),
                  );
                },
                tabs: [
                  Tab(text: context.i18n.week.toUpperCase()),
                  Tab(text: context.i18n.month.toUpperCase()),
                  Tab(text: context.i18n.total.toUpperCase()),
                ],
              ),
            ),
          );

          return DefaultTabController(
            length: 3,
            child: isEmbedded
                ? Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            children: [
                              BlocProvider(
                                create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                                child: ActiveMinutesDetail(
                                  patient: patient,
                                  timeframe: ActiveMinutesType.WEEK,
                                  parentHeight: parentHeight,
                                  selectedDate: this.selectedDate,
                                  isKlimafit: isKlimafit,
                                  isEmbedded: isEmbedded,
                                ),
                              ),
                              BlocProvider(
                                create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                                child: ActiveMinutesDetail(
                                  patient: patient,
                                  timeframe: ActiveMinutesType.MONTH,
                                  parentHeight: parentHeight,
                                  selectedDate: this.selectedDate,
                                  isKlimafit: isKlimafit,
                                  isEmbedded: isEmbedded,
                                ),
                              ),
                              BlocProvider(
                                create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                                child: ActiveMinutesDetail(
                                  patient: patient,
                                  timeframe: ActiveMinutesType.ALL,
                                  parentHeight: parentHeight,
                                  selectedDate: this.selectedDate,
                                  isKlimafit: isKlimafit,
                                  isEmbedded: isEmbedded,
                                ),
                              ),
                            ],
                          ),
                        ),
                        BottomAppBar(
                          elevation: 0,
                          color: Colors.white,
                          child: Builder(
                            builder: (context) {
                              final tabController = DefaultTabController.of(context);
                              Widget buildTabButton(int index, String label) {
                                final selected = tabController.index == index;
                                return TextButton(
                                  onPressed: () {
                                    if (tabController.index != index) {
                                      tabController.animateTo(index);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: tabController.index != index ? lightTextColor : extraActivityColor,
                                    textStyle: TextStyle(
                                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  child: Text(label.toUpperCase()),
                                );
                              }

                              return AnimatedBuilder(
                                animation: tabController,
                                builder: (context, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        buildTabButton(0, context.i18n.week),
                                        SizedBox(width: 20),
                                        buildTabButton(1, context.i18n.month),
                                        SizedBox(width: 20),
                                        buildTabButton(2, context.i18n.year),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Scaffold(
                    backgroundColor: Colors.white,
                    appBar: isKlimafit ? null : appBar,
                    bottomNavigationBar: isKlimafit
                        ? BottomAppBar(
                            elevation: 0,
                            color: Colors.white,
                            child: Builder(
                              builder: (context) {
                                final tabController = DefaultTabController.of(context);
                                Widget buildTabButton(int index, String label) {
                                  final selected = tabController.index == index;
                                  return TextButton(
                                    onPressed: () {
                                      if (tabController.index != index) {
                                        tabController.animateTo(index);
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: tabController.index != index ? lightTextColor : extraActivityColor,
                                      textStyle: TextStyle(
                                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    child: Text(label.toUpperCase()),
                                  );
                                }

                                return AnimatedBuilder(
                                  animation: tabController,
                                  builder: (context, child) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          buildTabButton(0, context.i18n.week),
                                          SizedBox(width: 20),
                                          buildTabButton(1, context.i18n.month),
                                          SizedBox(width: 20),
                                          buildTabButton(2, context.i18n.year),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : null,
                    body: TabBarView(
                      children: [
                        BlocProvider(
                          create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                          child: ActiveMinutesDetail(
                            patient: patient,
                            timeframe: ActiveMinutesType.WEEK,
                            parentHeight: parentHeight,
                            selectedDate: this.selectedDate,
                            isKlimafit: isKlimafit,
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                          child: ActiveMinutesDetail(
                            patient: patient,
                            timeframe: ActiveMinutesType.MONTH,
                            parentHeight: parentHeight,
                            selectedDate: this.selectedDate,
                            isKlimafit: isKlimafit,
                          ),
                        ),
                        BlocProvider(
                          create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                          child: ActiveMinutesDetail(
                            patient: patient,
                            timeframe: ActiveMinutesType.ALL,
                            parentHeight: parentHeight,
                            selectedDate: this.selectedDate,
                            isKlimafit: isKlimafit,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
