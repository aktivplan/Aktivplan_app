import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/personal_goal_dialog.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';

class PatientActivityList extends StatefulWidget {
  final Map<String, List> events;
  final Jiffy currentDate;

  final Function(dynamic)? markAsDone;
  final Function(ActivityOverviewDTO)? onTapActivity;
  final Function()? onAddActivity;

  PatientActivityList({
    Key? key,
    required this.events,
    required this.currentDate,
    this.markAsDone,
    this.onTapActivity,
    this.onAddActivity,
  }) : super(key: key);

  @override
  _PatientActivityListState createState() => _PatientActivityListState();
}

class _PatientActivityListState extends State<PatientActivityList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        if (widget.events[widget.currentDate.yMd] != null) ..._renderTodaysActivities(),
        if (widget.events[widget.currentDate.yMd] == null)
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              title: Center(
                child: SelectableText(
                  context.i18n.noPlannedActivities,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        if (widget.onAddActivity != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ElevatedButton.icon(
              style:
                  getElevatedButtonStyle(context, backgroundColor: userRepository.userRole == UserRole.PATIENT ? extraActivityColor : primaryColor),
              onPressed: widget.onAddActivity,
              icon: Icon(Icons.add),
              label: Text(
                KiwiContainer().resolve<UserRepository>().userRole == UserRole.PATIENT
                    ? context.i18n.extraActivity.toUpperCase()
                    : context.i18n.activityPlanStep3,
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _renderTodaysActivities() {
    return widget.events[widget.currentDate.yMd]!.map((item) {
      if (item is PersonalGoal) {
        return ActivityListTile(
          icon: Icon(Icons.flag, color: goalColor),
          color: goalColor,
          title: item.description ?? "",
          subtitle: context.i18n.goal,
          done: item.done ?? false,
          // when on tap activity not set read only is considered
          onTap: widget.onTapActivity != null
              ? () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => PersonalGoalDialog(
                      personalGoal: item,
                      isMobile: true,
                    ),
                  );
                }
              : null,
          markAsDone: this.widget.markAsDone != null ? () => this.widget.markAsDone!(item) : null,
        );
      } else if (item is ActivityOverviewDTO) {
        Color iconColor = plannedActivityColor;
        bool isCompletable = true;
        if (item.type == ActivityType.EXTRA) {
          iconColor = extraActivityColor;
        } else if (item.type == ActivityType.APPOINTMENT) {
          iconColor = primaryColor;
          if (userRepository.userRole == UserRole.PATIENT) {
            isCompletable = false;
          }
        } else if (item.type == ActivityType.TASK) {
          iconColor = plannedTaskColor;
        }
        String subtitle = item.type != ActivityType.OTHER ? item.type!.getTranslatedText(context) : "";
        final String timeString = getTranslatedTimeString(item.time ?? "", context);
        int duration = item.durationMinutes ?? 0;
        if (widget.onTapActivity != null && timeString.isNotEmpty) {
          if (subtitle.isNotEmpty) {
            subtitle += ", ";
          }
          subtitle += timeString;
        }
        if (widget.onTapActivity != null && duration > 0) {
          if (subtitle.isNotEmpty) {
            subtitle += ", ";
          }
          subtitle += "$duration ${context.i18n.durationValueMinutes}";
        }

        return ActivityListTile(
          icon: Icon(
            item.type!.iconData,
            color: iconColor,
            weight: 1000,
          ),
          color: iconColor,
          title: getTranslatedText(item.name, context),
          subtitle: subtitle,
          done: isCompletable ? item.rating!.done : null,
          onTap: widget.onTapActivity != null ? () => widget.onTapActivity!(item) : null,
          markAsDone: this.widget.markAsDone != null ? () => this.widget.markAsDone!(item) : null,
        );
      }
      return Container();
    }).toList();
  }
}

class ActivityListTile extends StatelessWidget {
  final Color color;
  final String title;
  final String? subtitle;
  final bool? done;
  final Icon? icon;
  final Function()? markAsDone;
  final Function()? onTap;
  const ActivityListTile({
    Key? key,
    required this.color,
    required this.title,
    required this.done,
    required this.markAsDone,
    this.onTap,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shadowColor: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 15, right: 5),
        onTap: onTap,
        horizontalTitleGap: 3,
        dense: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        leading: icon,
        trailing: done != null
            ? InkWell(
                onTap: markAsDone,
                child: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: done!
                        ? BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          )
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: color,
                              width: 2,
                            ),
                          ),
                    child: done!
                        ? Center(
                            heightFactor: 0.7,
                            widthFactor: 0.7,
                            child: Icon(Icons.check, color: Colors.white, size: 24),
                          )
                        : Container(),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
