import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/constants.dart';

class PersonalGoalDialog extends StatelessWidget {
  final PersonalGoal personalGoal;
  final bool isMobile;
  const PersonalGoalDialog({Key? key, required this.personalGoal, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      return Scaffold(
        appBar: AppBar(
          elevation: 20,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          children: <Widget>[
            SizedBox(height: 10),
            SelectableText(personalGoal.description ?? "", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, height: 1)),
            SizedBox(height: 10),
            SelectableText(context.i18n.personalGoal),
            Row(
              children: [
                SelectableText(context.i18n.achieveUntil + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
                SelectableText(germanDateFormat.format(DateTime.parse((personalGoal.endDate!))))
              ],
            ),
            if ((personalGoal.details ?? "").isNotEmpty)
              Row(
                children: [
                  SelectableText(context.i18n.details + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
                  SelectableText(personalGoal.details ?? "")
                ],
              ),
            if (isMobile &&
                userRepository.userRole == UserRole.PATIENT &&
                userRepository.currentInstitution?.institutionFocus == InstitutionFocus.PROMOTING_A_HEALTHY_LIFESTYLE)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: getElevatedButtonStyle(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.i18n.edit.toUpperCase()),
                    ],
                  ),
                  onPressed: () {
                    context.beamToNamed(
                      "/calendar/goal-setting",
                      data: {"editGoal": personalGoal},
                    );
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
}
