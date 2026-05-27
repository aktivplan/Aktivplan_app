import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GoalSettingPage extends StatefulWidget {
  final String? patientId;
  final PersonalGoal? editGoal;
  final bool isPatient;

  GoalSettingPage({Key? key, this.patientId, required this.editGoal, this.isPatient = false}) : super(key: key);

  @override
  _GoalSettingPageState createState() => _GoalSettingPageState();
}

class _GoalSettingPageState extends State<GoalSettingPage> {
  final _goalFormKey = GlobalKey<FormState>();
  final notesController = TextEditingController();
  final detailsController = TextEditingController();
  final dateController = MaskedTextController(mask: "00.00.0000");
  ActivityBloc? activityBloc;
  bool hasChanges = false;
  String? patientId;

  @override
  void initState() {
    super.initState();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    patientId = widget.patientId ?? userRepository.currentUser.id;
    if (widget.editGoal != null) {
      notesController.text = widget.editGoal!.description ?? "";
      detailsController.text = widget.editGoal!.details ?? "";
      final goalDate = DateTime.parse(widget.editGoal!.endDate!);
      dateController.text = germanDateFormat.format(goalDate);
    } else {
      notesController.text = "";
      detailsController.text = "";
      dateController.text = "";
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime initialDate = dateController.text.length == 10 ? germanDateFormat.parse(dateController.text) : DateTime.now().toLocal();
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('de'),
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year),
      lastDate: DateTime(initialDate.year + 10),
    );
    if (picked != null) {
      setState(() {
        dateController.text = germanDateFormat.format(picked);
      });
    }
  }

  setGoal() {
    if (_goalFormKey.currentState!.validate()) {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_CREATE, action: "Created Personal Goal"),
      );
      activityBloc!.add(AddPersonalGoalEvent(
          goal: PersonalGoalPostDTO(
              description: notesController.text,
              details: detailsController.text,
              done: false,
              endDate: englishDateFormat.format(germanDateFormat.parse(dateController.text)),
              patientId: patientId),
          patientId: patientId!));
      context.beamBack();
    }
  }

  updateGoal() {
    if (_goalFormKey.currentState!.validate()) {
      MatomoTracker.instance.trackEvent(
        eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_UPDATE, action: "Updated Personal Goal"),
      );
      activityBloc!.add(UpdatePersonalGoalEvent(
          goal: PersonalGoalPostDTO(
              description: notesController.text,
              details: detailsController.text,
              done: widget.editGoal!.done ?? false,
              endDate: englishDateFormat.format(germanDateFormat.parse(dateController.text)),
              patientId: patientId),
          id: widget.editGoal!.id!,
          patientId: patientId!));
      context.beamBack();
    }
  }

  deleteGoal() {
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: EVENT_CATEGORY_PERSONAL_GOAL, name: EVENT_NAME_DELETE, action: "Deleted Personal Goal"),
    );
    activityBloc!.add(DeletePersonalGoalEvent(id: widget.editGoal!.id!, patientId: patientId!));
    context.beamBack();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(
      builder: (context, size) {
        Widget patientEditButton = ElevatedButton(
          onPressed: () => widget.editGoal != null ? updateGoal() : setGoal(),
          style: getElevatedButtonStyle(context),
          child: Row(
            mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.editGoal != null ? context.i18n.save.toUpperCase() : context.i18n.create.toUpperCase(),
              ),
            ],
          ),
        );
        Widget patientDeleteButton = ElevatedButton(
          onPressed: () {
            DeleteButton.showDeleteConfirmationDialog(context, context.i18n.deleteMessagePersonalGoalTitle, context.i18n.deleteMessagePersonalGoal,
                () {
              deleteGoal();
            });
          },
          style: getElevatedButtonStyle(context, backgroundColor: errorColor),
          child: Row(
            mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.i18n.delete.toUpperCase(),
              ),
            ],
          ),
        );

        double paddingHorizontal = size.isMobile
            ? width * 0.04
            : size.isTablet
                ? width * 0.2
                : width * 0.25;
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: paddingHorizontal,
              right: paddingHorizontal,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFieldPadding(
                    child: SelectableText(
                      context.i18n.personalGoal,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Form(
                    key: _goalFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.top,
                          controller: notesController,
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
                            hintText: context.i18n.title,
                            hintMaxLines: 1,
                            labelText: context.i18n.title + " *",
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
                        TextFormField(
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.top,
                          controller: detailsController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
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
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          controller: dateController,
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
                              onPressed: () => _selectDate(context),
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
                        SizedBox(
                          height: height * 0.02,
                        ),
                        if (widget.isPatient) ...[
                          Container(
                            alignment: size.isDesktop ? Alignment.centerLeft : Alignment.center,
                            child: Row(
                              mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                              children: [
                                if (size.isMobile) Flexible(child: patientEditButton),
                                if (!size.isMobile) patientEditButton,
                                if (widget.editGoal != null && !size.isMobile)
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: patientDeleteButton,
                                  ),
                              ],
                            ),
                          ),
                          if (widget.editGoal != null && size.isMobile)
                            Container(
                              alignment: size.isDesktop ? Alignment.centerLeft : Alignment.center,
                              padding: EdgeInsets.only(top: height * 0.01),
                              child: Row(
                                mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: patientDeleteButton,
                                  ),
                                ],
                              ),
                            ),
                        ],
                        if (!widget.isPatient)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (widget.editGoal == null)
                                SaveButton(
                                  title: context.i18n.create.toUpperCase(),
                                  callback: setGoal,
                                ),
                              if (widget.editGoal != null)
                                SaveButton(
                                  title: context.i18n.save.toUpperCase(),
                                  callback: updateGoal,
                                ),
                              if (!widget.isPatient)
                                SizedBox(
                                  width: width * 0.01,
                                ),
                              if (!widget.isPatient)
                                CancelButton(
                                  callback: () => context.beamBack(),
                                  hasChanges: this.hasChanges,
                                ),
                              if (widget.editGoal != null)
                                SizedBox(
                                  width: width * 0.01,
                                ),
                              if (widget.editGoal != null)
                                DeleteButton(
                                  callback: deleteGoal,
                                  confirmationTitle: context.i18n.deleteMessagePersonalGoalTitle,
                                  confirmationText: context.i18n.deleteMessagePersonalGoal,
                                ),
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
}
