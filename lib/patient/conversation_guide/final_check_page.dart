// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/patient/conversation_guide/question_text.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:styled_text/styled_text.dart';

class FinalCheckPage extends StatefulWidget {
  final String patientId;

  FinalCheckPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _FinalCheckPageState createState() => _FinalCheckPageState();
}

class _FinalCheckPageState extends State<FinalCheckPage> with TraceablePageMixin {
  List<String> checkTexts = [];
  List<bool> checkValues = [false, false, false, false, false];
  QuestionText? literatureText;
  TextEditingController notesController = TextEditingController();
  bool hasChanges = false;
  UserControllerApi userApi = new UserControllerApi(apiClient);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loading = true;
    userApi.getPatientCheckMarks(widget.patientId).then((value) => setState(() {
          checkValues = value!;
          loading = false;
        }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkTexts = [context.i18n.finalCheck1, context.i18n.finalCheck2, context.i18n.finalCheck3, context.i18n.finalCheck4, context.i18n.finalCheck5];
  }

  checkValue(int index) {
    setState(() {
      checkValues[index] = !checkValues[index];
      hasChanges = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AptLayout(border: false, fixedHeight: false, breadCrumb: [
      BreadCrumbItem(
        content: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: SelectableText(
                context.i18n.finalCheck,
                style: getBreadCrumbStyle(context),
              ),
            ),
          ],
        ),
      ),
    ], children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: datatableBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: EdgeInsets.all(12.0),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    transform: Matrix4.translationValues(200, -30, 0),
                    child: SizedOverflowBox(
                      size: Size.zero,
                      child: SvgPicture.asset(
                        "assets/images/talk.svg",
                        height: 90,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 10),
                    child: StyledText(text: context.i18n.finalCheckText, style: Theme.of(context).textTheme.titleMedium, tags: {
                      'u': StyledTextTag(style: TextStyle(decoration: TextDecoration.underline)),
                    }),
                  ),
                  ...checkTexts
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: datatableBorderColor,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(6))),
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 2, bottom: 2),
                                  child: Row(children: [
                                    Checkbox(
                                        shape: CircleBorder(),
                                        splashRadius: 0,
                                        value: checkValues[checkTexts.indexOf(e)],
                                        onChanged: (value) => checkValue(checkTexts.indexOf(e))),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(e, style: Theme.of(context).textTheme.titleMedium),
                                      ),
                                    ),
                                  ]),
                                ),
                                onTap: () => checkValue(checkTexts.indexOf(e)),
                              )),
                        ),
                      )
                      .toList(),
                ],
              ),
      ),
      SizedBox(height: 15),
      Row(
        children: [
          SaveButton(
            title: context.i18n.save.toUpperCase(),
            callback: () {
              if (hasChanges) {
                MatomoTracker.instance.trackEvent(
                  eventInfo: EventInfo(
                    category: EVENT_CATEGORY_FINAL_CHECK,
                    name: EVENT_NAME_TICK_FINAL_CHECK,
                    action: "Ticked Final Check Checkboxes",
                    value: checkValues.where((element) => element).length,
                  ),
                );
                userApi.storePatientCheckMarks(widget.patientId, checkValues);
              }
              context.beamBack();
            },
          ),
          SizedBox(
            width: 10,
          ),
          CancelButton(
            callback: () {
              context.beamBack();
            },
            hasChanges: this.hasChanges,
          )
        ],
      )
    ]);
  }

  String get traceablePageName => "Final Check Page";
}
