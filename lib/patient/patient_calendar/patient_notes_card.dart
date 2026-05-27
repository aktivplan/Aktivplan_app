import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/card_icon_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class PatientNotesCard extends StatelessWidget {
  final String patientId;
  final String patientNotes;
  final bool isMobile;
  PatientNotesCard({Key? key, required this.patientId, required this.isMobile, this.patientNotes = ""}) : super(key: key);

  editNotes(BuildContext context) {
    context.beamToNamed(
      "/patients/$patientId/calendar/notes",
      data: {"notes": patientNotes},
    );
  }

  @override
  Widget build(BuildContext context) {
    String notes = patientNotes;
    double cardHeight = isMobile ? 180 : 368;
    Widget content = Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Card(
            shape: RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(6))),
            semanticContainer: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 6),
                  child: Row(
                    children: [
                      SelectableText(
                        context.i18n.notesHealthExpert,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: lightTextColor,
                            ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: notes.isEmpty
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: cardHeight * 0.35),
                              child: SelectableText(
                                context.i18n.noPatientNotes,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: lightTextColor,
                                    ),
                              ),
                            ),
                          ],
                        )
                      : ListTile(title: SelectableText(notes, style: Theme.of(context).textTheme.titleMedium)),
                ),
              ],
            ),
          ),
        ),
        CardIconButton(key: Key(KEY_PATIENT_CALENDAR_BUTTON_EDIT_NOTES), iconData: Icons.edit, callback: () => editNotes(context))
      ],
    );
    return isMobile && notes.isNotEmpty ? content : SizedBox(height: cardHeight, child: content);
  }
}
