import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';

class PersonalGoalActivityCard extends StatelessWidget {
  final PersonalGoal goal;

  PersonalGoalActivityCard({
    Key? key,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Card(
      color: goalColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (goal.done ?? false) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: Icon(Icons.emoji_events, color: Colors.white),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: SelectableText(
                      goal.description ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.05,
                          ),
                    ),
                  ),
                  SelectableText(
                    context.i18n.personalGoal,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(width: width * 0.01),
            InkWell(
              onTap: () => print(""),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: (goal.done ?? false) ? Colors.white : Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
