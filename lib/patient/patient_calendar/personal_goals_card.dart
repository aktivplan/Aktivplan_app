import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/personal_goal_dialog.dart';
import 'package:aptapp/patient/share_button.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/card_icon_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:screenshot/screenshot.dart';

class PersonalGoalsCard extends StatefulWidget {
  final String patientId;
  final InstitutionDTO institution;

  PersonalGoalsCard({
    Key? key,
    required this.patientId,
    required this.institution,
  }) : super(key: key);

  @override
  _PersonalGoalsCardState createState() => _PersonalGoalsCardState();

  static Future<void> showGoalAchieved(BuildContext context, PersonalGoal goal) async {
    final ScreenshotController screenshotController = ScreenshotController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 20.0, bottom: 35, left: 20, right: 20),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              FittedBox(
                child: SelectableText(
                  context.i18n.achievedActivityShort,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Screenshot(
                  controller: screenshotController,
                  child: ListBody(
                    children: <Widget>[
                      SelectableText(
                        context.i18n.personalGoalReachedPart1,
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.2),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          SelectableText(
                            '\"${goal.description}\"',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600, height: 1.2),
                          ),
                        ],
                      ),
                      DateTime.now().toLocal().isBefore(DateTime.parse(goal.endDate!))
                          ? SelectableText(
                              context.i18n.personalGoalReachedPart2earlier,
                              textAlign: TextAlign.center,
                            )
                          : SelectableText(
                              context.i18n.personalGoalReachedPart2,
                              textAlign: TextAlign.center,
                            ),
                      SizedBox(height: 15),
                      Icon(Icons.emoji_events, color: goalColor, size: 35)
                    ],
                  ),
                ),
                if (!kIsWeb)
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ShareButton(screenshotController: screenshotController, shareContext: "Personal Goal"),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PersonalGoalsCardState extends State<PersonalGoalsCard> {
  List<String> goalsChecked = [];
  ActivityBloc? activityBloc;
  int personalGoalsCount = -1;
  final userRepository = KiwiContainer().resolve<UserRepository>();
  FetchedPatientActivitiesState? lastFetchedState;

  @override
  void initState() {
    super.initState();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
  }

  addGoal() {
    if (userRepository.userRole == UserRole.PATIENT) {
      context.beamToNamed(
        "/calendar/goal-setting",
        data: {"editGoal": null},
      );
    } else {
      context.beamToNamed(
        "/patients/${widget.patientId}/calendar/goal-setting",
        data: {"editGoal": null},
      );
    }
  }

  editGoal(PersonalGoal goal) {
    if (userRepository.userRole == UserRole.PATIENT) {
      context.beamToNamed(
        "/calendar/goal-setting",
        data: {"editGoal": goal},
      );
    } else {
      context.beamToNamed(
        "/patients/${widget.patientId}/goal-setting",
        data: {"editGoal": goal},
      );
    }
  }

  parseDate(String date) {
    return germanDateFormat.format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    return BlocBuilder<ActivityBloc, ActivityState>(builder: (context, state) {
      if (state is FetchedPatientActivitiesState) {
        lastFetchedState = state;
      }
      if (lastFetchedState == null) {
        return CircularProgressIndicator();
      }
      personalGoalsCount = lastFetchedState!.personalGoals.length;
      List<String> goalsChecked = lastFetchedState!.personalGoals.where((g) => (g.done ?? false)).map((g) => g.id!).toList();
      return Container(
        height: 360,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(6))),
                semanticContainer: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 6),
                      child: Row(
                        children: [
                          SelectableText(
                            context.i18n.personalGoals,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: lightTextColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: lastFetchedState!.personalGoals.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
                          crossAxisAlignment: lastFetchedState!.personalGoals.isEmpty ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                            if (lastFetchedState!.personalGoals.isEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: 360 * 0.35),
                                child: SelectableText(
                                  context.i18n.noPersonalGoals,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: lightTextColor,
                                      ),
                                ),
                              ),
                            if (lastFetchedState!.personalGoals.isNotEmpty)
                              for (PersonalGoal goal in lastFetchedState!.personalGoals)
                                InkWell(
                                  child: Row(children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15, right: 10),
                                      child: Checkbox(
                                          shape: CircleBorder(),
                                          activeColor: goalColor,
                                          value: goalsChecked.contains(goal.id),
                                          onChanged: (value) {
                                            if (value ?? false) {
                                              PersonalGoalsCard.showGoalAchieved(context, goal);
                                              setState(() => goalsChecked.add(goal.id!));
                                            } else {
                                              setState(() => goalsChecked.remove(goal.id));
                                            }
                                            MatomoTracker.instance.trackEvent(
                                              eventInfo: EventInfo(
                                                  category: EVENT_CATEGORY_PERSONAL_GOAL,
                                                  name: (value ?? false) ? EVENT_NAME_DONE : EVENT_NAME_UNDONE,
                                                  action: "Set Personal Goal to ${(value ?? false) ? 'Done' : 'Undone'}"),
                                            );
                                            activityBloc!.add(UpdatePersonalGoalEvent(
                                                id: goal.id!,
                                                goal: PersonalGoalPostDTO(
                                                    description: goal.description,
                                                    done: value,
                                                    endDate: englishDateFormat.format(DateTime.parse(goal.endDate!)),
                                                    patientId: widget.patientId),
                                                patientId: widget.patientId));
                                          }),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              goal.description ?? "",
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                            Text(
                                              parseDate(goal.endDate!),
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: lightTextColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (userRepository.userRole != UserRole.PATIENT ||
                                        widget.institution.institutionFocus == InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE)
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: IconButton(
                                            icon: Icon(Icons.edit), color: lightTextColor, padding: EdgeInsets.zero, onPressed: () => editGoal(goal)),
                                      ),
                                  ]),
                                  onTap: () => showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) => PersonalGoalDialog(
                                      personalGoal: goal,
                                      isMobile: false,
                                    ),
                                  ),
                                ),
                            SizedBox(height: 34)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (userRepository.userRole != UserRole.PATIENT || widget.institution.institutionFocus == InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE)
              CardIconButton(key: Key(KEY_PATIENT_CALENDAR_BUTTON_ADD_PERSONAL_GOAL), iconData: Icons.add, callback: addGoal)
          ],
        ),
      );
    });
  }
}
