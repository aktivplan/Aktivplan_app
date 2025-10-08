// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PatientNotesPage extends StatefulWidget {
  final String patientId;
  final String patientNotes;

  PatientNotesPage({Key? key, required this.patientId, this.patientNotes = ""}) : super(key: key);

  @override
  _PatientNotesPageState createState() => _PatientNotesPageState();
}

class _PatientNotesPageState extends State<PatientNotesPage> with TraceablePageMixin {
  final notesController = TextEditingController();
  bool hasChanges = false;
  bool deleteDisabled = true;
  UserControllerApi userApi = new UserControllerApi(apiClient);

  @override
  void initState() {
    super.initState();
    notesController.text = widget.patientNotes;
    if (notesController.text.isEmpty) {
      userApi.getPatientNotes(widget.patientId).then((patientNotes) => setState(() {
            notesController.text = patientNotes!.notes ?? "";
            deleteDisabled = (patientNotes.notes ?? "").isEmpty;
          }));
    } else {
      deleteDisabled = notesController.text.isEmpty;
    }
  }

  saveNotes() async {
    if (hasChanges) {
      await userApi.storePatientNotes(widget.patientId, PatientNotesDTO(notes: notesController.text));
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT_NOTES, name: EVENT_NAME_UPDATE, action: "Updated Patient Notes"),
      );
    }
    context.beamBack();
  }

  deleteNotes() async {
    await userApi.storePatientNotes(widget.patientId, PatientNotesDTO(notes: ""));
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT_NOTES, name: EVENT_NAME_DELETE, action: "Deleted Patient Notes"),
    );
    context.beamBack();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(
      builder: (context, size) {
        double paddingHorizontal = size.isMobile
            ? width * 0.04
            : size.isTablet
                ? width * 0.2
                : width * 0.25;
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: height * 0.05,
              left: paddingHorizontal,
              right: paddingHorizontal,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFieldPadding(
                    child: SelectableText(
                      context.i18n.notesHealthExpert,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.top,
                          controller: notesController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          onChanged: (value) => {
                            setState(() {
                              this.hasChanges = true;
                            })
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: context.i18n.notesHealthExpert,
                            hintMaxLines: 1,
                            labelText: context.i18n.notesHealthExpert,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: datatableBorderColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SaveButton(
                              title: context.i18n.save.toUpperCase(),
                              callback: saveNotes,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            CancelButton(
                              callback: () => context.beamBack(),
                              hasChanges: this.hasChanges,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            DeleteButton(
                              callback: deleteNotes,
                              confirmationTitle: context.i18n.deleteMessageNotesTitle,
                              confirmationText: context.i18n.deleteMessageNotes,
                              disabled: deleteDisabled,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String get traceablePageName => "Patient Notes Page";
}
