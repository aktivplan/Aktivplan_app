// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:math';

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/activity/widgets/back_next_buttons.dart';
import 'package:aptapp/activity/widgets/planning_progress.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/patient/conversation_guide/question_text.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/card_icon_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:styled_text/styled_text.dart';

class ConversationGuidePage extends StatefulWidget {
  final String patientId;
  final String patientNotes;
  final List<PersonalGoal>? personalGoals;
  final InstitutionFocus? institutionFocus;

  ConversationGuidePage({Key? key, required this.patientId, required this.patientNotes, required this.personalGoals, required this.institutionFocus})
      : super(key: key);

  @override
  _ConversationGuidePageState createState() => _ConversationGuidePageState();
}

class PersonalGoalInputController {
  final PersonalGoal personalGoal;
  final notesController = TextEditingController();
  final detailsController = TextEditingController();
  final dateController = MaskedTextController(mask: "00.00.0000");

  PersonalGoalInputController({required this.personalGoal}) {
    notesController.text = personalGoal.description ?? "";
    detailsController.text = personalGoal.details ?? "";
    if ((personalGoal.endDate ?? "").isNotEmpty) {
      dateController.text = germanDateFormat.format(DateTime.parse(personalGoal.endDate!));
    }
  }

  String formattedEndDate() {
    return englishDateFormat.format(germanDateFormat.parse(dateController.text));
  }

  bool hasChanges() {
    if (personalGoal.id == "") {
      return false;
    }
    return notesController.text != personalGoal.description ||
        detailsController.text != personalGoal.details ||
        personalGoal.endDate != formattedEndDate();
  }
}

class _ConversationGuidePageState extends State<ConversationGuidePage> {
  int progressLevel = -1;
  List<QuestionText> questionTexts = [];
  QuestionText? literatureText;
  TextEditingController notesController = TextEditingController();
  bool hasChanges = false;
  UserControllerApi userApi = new UserControllerApi(apiClient);
  ActivityControllerApi activityApi = new ActivityControllerApi(apiClient);
  List<PersonalGoalInputController> personalGoalControls = [];
  List<PersonalGoal> initialPersonalGoals = [];
  final _goalFormKey = GlobalKey<FormState>();
  InstitutionFocus? institutionFocus;

  @override
  void initState() {
    super.initState();
    notesController.text = widget.patientNotes;
    if (notesController.text.isEmpty) {
      userApi.getPatientNotes(widget.patientId).then((patientNotes) => setState(() {
            notesController.text = patientNotes!.notes ?? "";
            hasChanges = false;
          }));
    }
    personalGoalControls.clear();
    if (widget.personalGoals == null) {
      activityApi.getPersonalGoals(patientId: widget.patientId).then((goals) {
        initialPersonalGoals = goals!.where((element) => !(element.done ?? false)).toList();
        setState(() => personalGoalControls.addAll(initialPersonalGoals.map((e) => PersonalGoalInputController(personalGoal: e))));
      });
    } else {
      initialPersonalGoals = widget.personalGoals!.where((element) => !(element.done ?? false)).toList();
      personalGoalControls.addAll(initialPersonalGoals.map((e) => PersonalGoalInputController(personalGoal: e)));
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.institutionFocus != null) {
      institutionFocus = widget.institutionFocus;
      questionTexts = QuestionText.getQuestionTexts(context, progressLevel, institutionFocus!);
    } else {
      userApi.getPatientById(widget.patientId).then((patient) => setState(() {
            institutionFocus = patient!.institution!.institutionFocus;
            questionTexts = QuestionText.getQuestionTexts(context, progressLevel, institutionFocus!);
          }));
    }
    trackPageStep();
    literatureText = QuestionText(context.i18n.literature,
        '''Öffentliches Gesundheitsportal Österreichs (2022): Herz, Kreislauf und Gefäße [Webseite] Wien: Bundesministerium für Soziales, Gesundheit, Pflege und Konsumentenschutz. [https://www.gesundheit.gv.at/krankheiten/herz-kreislauf/herz-kreislauf-erkrankungen-vorbeugung.html]

Fonds Gesundes Österreich (Hrsg.) (2020): Österreichische Bewegungsempfehlungen (Wissensband 17), Wien. [https://fgoe.org/medien/reihewissen/bewegungsempfehlungen]''');
    super.didChangeDependencies();
  }

  void trackPageStep() {
    MatomoTracker.instance.trackPageViewWithName(
      actionName: "Visited Conversation Guide Page - Step ${progressLevel + 1}",
      path: getCurrentPath(context),
    );
  }

  getQuestionHeadline() {
    switch (progressLevel) {
      case 0:
        return context.i18n.conversationGuideStep1Headline;
      case 1:
        return context.i18n.conversationGuideStep2Headline;
      case 2:
        return context.i18n.conversationGuideStep3Headline;
      default:
        return "";
    }
  }

  getQuestionEntry(QuestionText entry) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: datatableBorderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.question,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(entry.showAnswer ? context.i18n.less : context.i18n.more,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                  ),
                ],
              ),
              if (entry.showAnswer)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: datatableBorderColor))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (entry.showMore1 || entry.showMore2)
                            IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  entry.showMore1 = false;
                                  entry.showMore2 = false;
                                });
                              },
                            ),
                          Expanded(
                            child: StyledText(
                              text: entry.getAnswerText(),
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(height: 1.4),
                              tags: {
                                'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
                                'more1': StyledTextActionTag(
                                    (text, attrs) => setState(() {
                                          entry.showMore1 = true;
                                        }),
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                                'more2': StyledTextActionTag(
                                    (text, attrs) => setState(() {
                                          entry.showMore2 = true;
                                        }),
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            entry.showAnswer = !entry.showAnswer;
            if (!entry.showAnswer) {
              entry.showMore1 = false;
              entry.showMore2 = false;
            }
          });
        },
      ),
    );
  }

  addGoalEntry() {
    if (!_goalFormKey.currentState!.validate()) {
      return;
    }
    setState(() {
      personalGoalControls.add(PersonalGoalInputController(personalGoal: PersonalGoal(id: "")));
    });
  }

  getGoalEntry() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 10),
          child: InputDecorator(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: context.i18n.personalGoals,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: datatableBorderColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: datatableBorderColor,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Form(
                key: _goalFormKey,
                child: Column(
                  children: personalGoalControls
                      .map(
                        (e) => ResponsiveGridRow(
                          children: [
                            ResponsiveGridCol(
                              lg: 4,
                              md: 12,
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: e.notesController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  validator: (value) {
                                    if ((value ?? "").trim().isEmpty) {
                                      return context.i18n.validationNotEmpty;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) => {
                                    setState(() {
                                      this.hasChanges = true;
                                    })
                                  },
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: context.i18n.descriptionShort,
                                    hintMaxLines: 1,
                                    labelText: context.i18n.descriptionShort + " *",
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: datatableBorderColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              lg: 4,
                              md: 12,
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: e.detailsController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (value) => {
                                    setState(() {
                                      this.hasChanges = true;
                                    })
                                  },
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: context.i18n.details,
                                    hintMaxLines: 1,
                                    labelText: context.i18n.details,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: datatableBorderColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              lg: 4,
                              md: 12,
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: e.dateController,
                                        keyboardType: TextInputType.numberWithOptions(signed: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        validator: (value) {
                                          if (value == null || value.length < 10) {
                                            return context.i18n.validationInvalidValue;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) => {
                                          setState(() {
                                            this.hasChanges = true;
                                          })
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: IconButton(
                                            icon: Icon(Icons.date_range),
                                            color: lightTextColor,
                                            onPressed: () => _selectDate(e.dateController),
                                          ),
                                          hintText: "01.01.2000",
                                          labelText: context.i18n.achieveUntil + " *",
                                          border: OutlineInputBorder(),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: datatableBorderColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: datatableBorderColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: DeleteButton(
                                          confirmationTitle: context.i18n.deleteMessagePersonalGoalTitle,
                                          confirmationText: context.i18n.deleteMessagePersonalGoal,
                                          callback: () {
                                            setState(() {
                                              personalGoalControls.remove(e);
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
        CardIconButton(key: Key(KEY_PATIENT_CALENDAR_BUTTON_ADD_PERSONAL_GOAL), iconData: Icons.add, callback: addGoalEntry)
      ],
    );
  }

  setProgressLevel(int level) {
    setState(() {
      progressLevel = level;
      questionTexts = QuestionText.getQuestionTexts(context, min(2, progressLevel), institutionFocus!);
      trackPageStep();
      saveNotes();
    });
  }

  nextStep() {
    setProgressLevel(progressLevel + 1);
  }

  finalStep() {
    if (!_goalFormKey.currentState!.validate()) {
      return;
    }
    savePersonalGoals();
    saveNotes();
    context.beamBack();
  }

  previousStep() {
    setProgressLevel(progressLevel - 1);
  }

  saveNotes() {
    if (!hasChanges) {
      return;
    }
    userApi.storePatientNotes(widget.patientId, PatientNotesDTO(notes: notesController.text));
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT_NOTES, name: EVENT_NAME_UPDATE, action: "Updated Patient Notes"),
    );
    hasChanges = false;
  }

  savePersonalGoals() async {
    final apiOperations = <Future>[];
    List<PersonalGoal> personalGoalsToDelete =
        initialPersonalGoals.where((element) => personalGoalControls.where((newEntry) => newEntry.personalGoal.id == element.id).isEmpty).toList();
    final personalGoalsToUpdate = personalGoalControls.where((element) => element.hasChanges());
    final personalGoalsToCreate = personalGoalControls.where((element) => element.personalGoal.id == "");
    apiOperations.addAll(personalGoalsToDelete.map((e) => activityApi.deletePersonalGoal(e.id!)));
    apiOperations.addAll(personalGoalsToUpdate.map((e) => activityApi.updatePersonalGoal(
        e.personalGoal.id!,
        PersonalGoalPostDTO(
            patientId: widget.patientId,
            description: e.notesController.text,
            details: e.detailsController.text,
            endDate: e.formattedEndDate(),
            done: false))));
    apiOperations.addAll(personalGoalsToCreate.map((e) => activityApi.createPersonalGoal(PersonalGoalPostDTO(
        patientId: widget.patientId,
        description: e.notesController.text,
        details: e.detailsController.text,
        endDate: e.formattedEndDate(),
        done: false))));
    Future.wait(apiOperations).then((value) => BlocProvider.of<ActivityBloc>(context)
      ..add(ResetActivityEvent())
      ..add(
        FetchPatientActivitiesEvent(patientId: widget.patientId, date: DateTime.now()),
      ));

    if (personalGoalsToDelete.isNotEmpty) {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
            category: EVENT_CATEGORY_PERSONAL_GOAL,
            name: EVENT_NAME_DELETE,
          action: "Deleted Multiple Personal Goals in Conversation Guide",
            value: personalGoalsToDelete.length),
      );
    }
    if (personalGoalsToUpdate.isNotEmpty) {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
            category: EVENT_CATEGORY_PERSONAL_GOAL,
            name: EVENT_NAME_UPDATE,
          action: "Updated Multiple Personal Goals in Conversation Guide",
            value: personalGoalsToUpdate.length),
      );
    }
    if (personalGoalsToCreate.isNotEmpty) {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(
            category: EVENT_CATEGORY_PERSONAL_GOAL,
            name: EVENT_NAME_CREATE,
          action: "Created Multiple Personal Goals in Conversation Guide",
            value: personalGoalsToCreate.length),
      );
    }
  }

  Future<Null> _selectDate(TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('de'),
      initialDate: dateController.text.length == 10 ? germanDateFormat.parse(dateController.text) : DateTime.now().toLocal(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null) {
      setState(() {
        dateController.text = germanDateFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String questionHeadline = getQuestionHeadline();
    return AptLayout(border: false, fixedHeight: false, breadCrumb: [
      BreadCrumbItem(
        content: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: SelectableText(
                context.i18n.conversationGuide,
                style: getBreadCrumbStyle(context),
              ),
            ),
          ],
        ),
      ),
    ], children: [
      PlanningProgress(
        clickable: true,
        setProgressLevel: setProgressLevel,
        progressLevel: progressLevel,
        longTexts: [context.i18n.conversationGuideStep1, context.i18n.conversationGuideStep2, context.i18n.conversationGuideStep3],
        shortTexts: [context.i18n.conversationGuideStep1Short, context.i18n.conversationGuideStep2Short, context.i18n.conversationGuideStep3Short],
        preWidget: progressLevel < 0
            ? Container(
                transform: Matrix4.translationValues(250, -25, 0),
                child: SizedOverflowBox(
                  size: Size.zero,
                  child: SvgPicture.asset(
                    "assets/images/talk.svg",
                    height: 90,
                  ),
                ),
              )
            : null,
      ),
      SizedBox(height: 5),
      if (questionHeadline.isNotEmpty)
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                questionHeadline,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            )),
      SizedBox(height: 5),
      ...questionTexts.map((entry) => getQuestionEntry(entry)),
      if (progressLevel == 2) getGoalEntry(),
      SizedBox(height: 10),
      TextFormField(
        textAlign: TextAlign.start,
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
      SizedBox(height: 10),
      if (progressLevel < 0)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SaveButton(
              title: context.i18n.next.toUpperCase(),
              callback: nextStep,
              key: Key(KEY_PATIENT_CALENDAR_CONVERSATION_GUIDE_BUTTON_START),
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
        ),
      if (progressLevel >= 0)
        BackNextButtons(
          back: previousStep,
          next: progressLevel != 2 ? nextStep : finalStep,
          hasChanges: hasChanges,
          nextButtonTitle: progressLevel != 2 ? context.i18n.next : context.i18n.save,
        ),
      if (progressLevel >= 0 && progressLevel < 2)
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: getQuestionEntry(literatureText!),
        ),
    ]);
  }
}
