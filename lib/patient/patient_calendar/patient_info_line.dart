import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/string_extension.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:styled_text/styled_text.dart';

class PatientInfoLine extends StatefulWidget {
  final PatientGetDTO patient;
  final PatientOverviewDTO patientOverview;
  final List<PersonalGoal> personalGoals;
  final FileGetDTO userPicture;

  PatientInfoLine({Key? key, required this.patient, required this.patientOverview, required this.personalGoals, required this.userPicture})
      : super(key: key);

  @override
  _PatientInfoLineState createState() => _PatientInfoLineState();
}

class _PatientInfoLineState extends State<PatientInfoLine> {
  @override
  Widget build(BuildContext context) {
    bool showThreeWeekState = showThreeWeekStateForPatient(widget.patientOverview.institution!);
    int activityPercentage = showThreeWeekState
        ? widget.patientOverview.user!.activityPercentageLastThreeWeeks!
        : widget.patientOverview.user!.activityPercentageLastFourWeeks!;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: ResponsiveGridRow(
        children: [
          ResponsiveGridCol(
            lg: 4,
            md: 12,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: (widget.userPicture.exists ?? false)
                        ? CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(widget.userPicture.url!),
                          )
                        : Icon(
                            Icons.account_circle,
                            color: Colors.black,
                            size: 56,
                          ),
                    title: Text(
                      "${widget.patient.lastName} ${widget.patient.firstName}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text((widget.patient.lastActiveDate ?? "").isNotEmpty
                        ? "${context.i18n.lastActiveAt}: ${germanDateFormat.format(englishDateFormat.parse(widget.patient.lastActiveDate!))}"
                        : context.i18n.inactive.capitalize()),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    key: Key(KEY_PATIENT_CALENDAR_BUTTON_EDIT),
                    onPressed: () {
                      context.beamToNamed(
                          RouterService.patientsEditRoute(
                              patientId: widget.patient.id!,
                              institutionId: widget.patientOverview.institution!.id!,
                              healthcareProfessionalId: widget.patient.healthcareProfessionalId!),
                          data: {"patient": widget.patient, "healthcareProfessionalId": widget.patient.healthcareProfessionalId});
                    },
                    child: Text(context.i18n.editPatient.toUpperCase()),
                  ),
                ],
              ),
            ),
          ),
          ResponsiveGridCol(
            lg: 4,
            md: 6,
            sm: 12,
            child: Container(
              height: 110,
              child: Card(
                shape: RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(6))),
                semanticContainer: true,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide(color: datatableBorderColor)),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Opacity(
                              opacity: activityPercentage >= 0 && activityPercentage < 50 ? 1 : .2,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: trafficLight1,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Opacity(
                              opacity: activityPercentage >= 50 && activityPercentage < 80 ? 1 : .2,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: trafficLight2,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Opacity(
                              opacity: activityPercentage >= 80 ? 1 : .2,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: trafficLight3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StyledText(
                                text: (activityPercentage >= 0
                                        ? (showThreeWeekState
                                            ? context.i18n.calendarInfoActiveMinutesThreeWeeks(
                                                activityPercentage, widget.patient.activityPercentageLastThreeWeeksPlanned!)
                                            : context.i18n.calendarInfoActiveMinutes(activityPercentage))
                                        : (showThreeWeekState
                                            ? context.i18n.calendarInfoActiveMinutesNoTrainingThreeWeeks
                                            : context.i18n.calendarInfoActiveMinutesNoTraining)) +
                                    (widget.patient.patientState != null && widget.patient.patientState != PatientState.NO_STATE
                                        ? "\n\n<b>${context.i18n.state}:</b> ${widget.patient.patientState!.getTranslatedText(context)}"
                                        : ""),
                                style: Theme.of(context).textTheme.bodyLarge,
                                tags: {
                                  'color': StyledTextTag(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: activityPercentage < 50
                                              ? trafficLight1
                                              : activityPercentage < 80
                                                  ? trafficLight2
                                                  : trafficLight3)),
                                  'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ResponsiveGridCol(
            lg: 4,
            md: 6,
            sm: 12,
            child: Padding(
              padding: EdgeInsets.only(right: 4),
              child: Column(
                children: [
                  InkWell(
                    key: Key(KEY_PATIENT_CALENDAR_BUTTON_CONVERSATION_GUIDE),
                    child: Card(
                      shape:
                          RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(3))),
                      semanticContainer: true,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 4, left: 20, right: 10),
                            child: Icon(Icons.supervisor_account, color: primaryColor, size: 20.5),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Text(
                                context.i18n.conversationGuide.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => context.beamToNamed(
                      "/patients/${widget.patient.id}/conversation-guide",
                      data: {
                        "notes": widget.patientOverview.user!.patientNotes ?? "",
                        "personalGoals": widget.personalGoals,
                        "institutionFocus": widget.patientOverview.institution!.institutionFocus
                      },
                    ),
                  ),
                  InkWell(
                    key: Key(KEY_PATIENT_CALENDAR_BUTTON_FINAL_CHECK),
                    child: Card(
                      shape:
                          RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(3))),
                      semanticContainer: true,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 4, left: 20, right: 10),
                            child: Icon(Icons.check_circle, color: primaryColor, size: 20.5),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Text(
                                context.i18n.finalCheck.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => context.beamToNamed("/patients/${widget.patient.id}/final-check"),
                  ),
                  InkWell(
                    key: Key(KEY_PATIENT_CALENDAR_BUTTON_MESSAGE),
                    child: Card(
                      shape:
                          RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(3))),
                      semanticContainer: true,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 4, left: 20, right: 10),
                            child: Icon(Icons.message, color: primaryColor, size: 20.5),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Text(
                                context.i18n.messages.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => context.beamToNamed(
                      "/patients/${widget.patient.id}/message-history",
                      data: {"patientName": "${widget.patient.lastName} ${widget.patient.firstName}"},
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
}
