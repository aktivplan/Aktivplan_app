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

  ActiveMinutesPage({
    Key? key,
    required this.patient,
    required this.parentHeight,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TraceableWidget(
      actionName: "Visited Active Minutes Page",
      path: getCurrentPath(context),
      child: ResponsiveBuilder(
        builder: (context, size) {
          var appBar = AppBar(
            title: SelectableText(context.i18n.activeMinutes),
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
            child: Scaffold(
              appBar: appBar,
              body: TabBarView(
                children: [
                  BlocProvider(
                    create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                    child: ActiveMinutesDetail(
                      patient: patient,
                      timeframe: ActiveMinutesType.WEEK,
                      parentHeight: parentHeight,
                      selectedDate: this.selectedDate,
                    ),
                  ),
                  BlocProvider(
                    create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                    child: ActiveMinutesDetail(
                      patient: patient,
                      timeframe: ActiveMinutesType.MONTH,
                      parentHeight: parentHeight,
                      selectedDate: this.selectedDate,
                    ),
                  ),
                  BlocProvider(
                    create: (context) => ActivityBloc(activityRepository: ActivityRepository(), messageRepository: MessageRepository()),
                    child: ActiveMinutesDetail(
                      patient: patient,
                      timeframe: ActiveMinutesType.ALL,
                      parentHeight: parentHeight,
                      selectedDate: this.selectedDate,
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
