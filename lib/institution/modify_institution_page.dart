import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/institution/bloc/institution_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apt_layout.dart';
import '../beamer/router_service.dart';
import '../main.dart';
import '../widget/form_field_padding.dart';

class ModifyInstitutionPage extends StatefulWidget {
  final bool edit;
  final InstitutionDTO? institution;
  final String? institutionId;

  ModifyInstitutionPage({
    Key? key,
    required this.edit,
    this.institution,
    this.institutionId,
  }) : super(key: key);

  @override
  _ModifyInstitutionPageState createState() => _ModifyInstitutionPageState();
}

class _ModifyInstitutionPageState extends State<ModifyInstitutionPage> with TraceablePageMixin {
  final _addInstitutFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final englishUrlController = TextEditingController();
  final emailUserQueriesController = TextEditingController();
  final phoneNumberUserQueriesController = TextEditingController();
  final availabilityPhoneController = TextEditingController();
  final englishAvailabilityPhoneController = TextEditingController();
  final getInTouchNotesController = TextEditingController();
  final englishGetInTouchNotesController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final photoController = TextEditingController();
  final minimumDaysBetweenInformationMessagesController = TextEditingController();
  bool showTrainingPlans = false;
  bool allowRescheduleActivities = false;
  bool enableSocialFeatures = false;
  InstitutionFocus institutionFocus = InstitutionFocus.CARDIOVASCULAR_REHABILITATION;
  InstitutionP2RFocus institutionP2RFocus = InstitutionP2RFocus.ORTHO_BV;
  InstitutionBloc? instBloc;
  InstitutionDTO? institution;
  bool hasChanges = false;

  final institutionApi = new InstitutionControllerApi(apiClient);
  InstitutionCountDTO userCount = new InstitutionCountDTO();

  @override
  void initState() {
    super.initState();
    instBloc = BlocProvider.of<InstitutionBloc>(context);
    if (widget.edit) {
      getInstitution();
    } else {
      showTrainingPlans = true;
      allowRescheduleActivities = false;
      enableSocialFeatures = false;
      minimumDaysBetweenInformationMessagesController.text = "3";
    }
  }

  getInstitutionPostDTO() {
    return InstitutionPostDTO(
      name: nameController.text.trim(),
      institutionFocus: institutionFocus,
      url: getTranslationObjectFromController(urlController, englishUrlController),
      email: emailController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      showTrainingPlans: showTrainingPlans,
      allowRescheduleActivities: allowRescheduleActivities,
      enableSocialFeatures: enableSocialFeatures,
      emailUserQueries: emailUserQueriesController.text.trim(),
      phoneNumberUserQueries: phoneNumberUserQueriesController.text.trim(),
      availabilityPhone: getTranslationObjectFromController(availabilityPhoneController, englishAvailabilityPhoneController),
      getInTouchNotes: getTranslationObjectFromController(getInTouchNotesController, englishGetInTouchNotesController),
      institutionP2RFocus: institutionP2RFocus,
      minimumDaysBetweenInformationMessages: int.tryParse(minimumDaysBetweenInformationMessagesController.text) ?? 0,
    );
  }

  addInstitution() {
    if (_addInstitutFormKey.currentState!.validate()) {
      this.institution = InstitutionDTO(
          name: nameController.text.trim(),
          institutionFocus: institutionFocus,
          url: getTranslationObjectFromController(urlController, englishUrlController),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          showTrainingPlans: showTrainingPlans,
          allowRescheduleActivities: allowRescheduleActivities,
          enableSocialFeatures: enableSocialFeatures,
          emailUserQueries: emailUserQueriesController.text.trim(),
          phoneNumberUserQueries: phoneNumberUserQueriesController.text.trim(),
          availabilityPhone: getTranslationObjectFromController(availabilityPhoneController, englishAvailabilityPhoneController),
          getInTouchNotes: getTranslationObjectFromController(getInTouchNotesController, englishGetInTouchNotesController),
          institutionP2RFocus: institutionP2RFocus,
          minimumDaysBetweenInformationMessages: int.tryParse(minimumDaysBetweenInformationMessagesController.text) ?? 0,
          id: null);
      instBloc!.add(AddInstitutionEvent(institution: getInstitutionPostDTO()));
      goBack();
    }
  }

  updateInstitution() {
    if (_addInstitutFormKey.currentState!.validate()) {
      this.institution = InstitutionDTO(
          name: nameController.text.trim(),
          institutionFocus: institutionFocus,
          url: getTranslationObjectFromController(urlController, englishUrlController),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          showTrainingPlans: showTrainingPlans,
          allowRescheduleActivities: allowRescheduleActivities,
          enableSocialFeatures: enableSocialFeatures,
          emailUserQueries: emailUserQueriesController.text.trim(),
          phoneNumberUserQueries: phoneNumberUserQueriesController.text.trim(),
          availabilityPhone: getTranslationObjectFromController(availabilityPhoneController, englishAvailabilityPhoneController),
          getInTouchNotes: getTranslationObjectFromController(getInTouchNotesController, englishGetInTouchNotesController),
          institutionP2RFocus: institutionP2RFocus,
          minimumDaysBetweenInformationMessages: int.tryParse(minimumDaysBetweenInformationMessagesController.text) ?? 0,
          id: institution!.id);
      instBloc!.add(UpdateInstitutionEvent(id: institution!.id!, institution: getInstitutionPostDTO()));
      goBack();
    }
  }

  deleteUser() {
    instBloc!.add(DeleteInstitutionEvent(id: institution!.id!));
    context.beamToNamed(RouterService.institutionsRoute());
  }

  getInstitution() async {
    if (widget.institution != null) {
      institution = widget.institution;
    } else {
      institution = await institutionApi.getInstitutionById(widget.institutionId!);
    }
    nameController.text = institution!.name ?? "";
    firstNameController.text = institution!.firstName ?? "";
    lastNameController.text = institution!.lastName ?? "";
    emailController.text = institution!.email ?? "";
    emailUserQueriesController.text = institution!.emailUserQueries ?? "";
    phoneNumberUserQueriesController.text = institution!.phoneNumberUserQueries ?? "";
    minimumDaysBetweenInformationMessagesController.text = institution!.minimumDaysBetweenInformationMessages?.toString() ?? "3";
    initTextEditingControllerFromTranslationObject(institution!.url, urlController, englishUrlController);
    initTextEditingControllerFromTranslationObject(institution!.availabilityPhone, availabilityPhoneController, englishAvailabilityPhoneController);
    initTextEditingControllerFromTranslationObject(institution!.getInTouchNotes, getInTouchNotesController, englishGetInTouchNotesController);

    setState(() {
      institutionFocus = institution!.institutionFocus!;
      showTrainingPlans = institution!.showTrainingPlans!;
      allowRescheduleActivities = institution!.allowRescheduleActivities ?? false;
      enableSocialFeatures = institution!.enableSocialFeatures ?? false;
      institutionP2RFocus = institution!.institutionP2RFocus ?? InstitutionP2RFocus.ORTHO_BV;
    });

    final counter = await institutionApi.getInstitutionUserCountById(institution!.id!);
    if (this.mounted) {
      setState(() {
        userCount = counter!;
      });
    }
  }

  goBack() {
    if (context.canBeamBack) {
      context.beamBack();
    } else {
      context.beamToNamed(
          institution != null ? RouterService.healthcareProfessionalsRoute(institutionId: institution!.id!) : RouterService.institutionsRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AptLayout(
      key: Key(KEY_INSTITUTION_SCROLL_VIEW),
      border: false,
      fixedHeight: false,
      breadCrumb: [],
      children: [
        FormFieldPadding(
          child: SelectableText(context.i18n.institution, style: getBreadCrumbStyle(context)),
        ),
        SizedBox(height: 15),
        Form(
          key: _addInstitutFormKey,
          child: widget.edit && institution == null
              ? Center(child: CircularProgressIndicator())
              : LanguageTabs(
                  germanFields: [
                    FormFieldPadding(
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return context.i18n.validationNotEmpty;
                          } else if (value!.length < 2 || value.length > 100) {
                            return context.i18n.validationDefaultLength;
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
                          hintText: context.i18n.name,
                          labelText: context.i18n.name + ' *',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: DropdownButtonFormField(
                        initialValue: institutionFocus,
                        onChanged: (value) {
                          setState(() {
                            institutionFocus = value as InstitutionFocus;
                            this.hasChanges = true;
                          });
                        },
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: context.i18n.institutionFocus + ' *',
                          border: const OutlineInputBorder(),
                        ),
                        focusColor: Colors.transparent,
                        validator: (value) => value == null ? context.i18n.validationNotEmpty : null,
                        items: InstitutionFocus.values.map((value) {
                          return DropdownMenuItem<InstitutionFocus>(
                            child: FittedBox(child: Text(value.getTranslatedText(context))),
                            value: value,
                          );
                        }).toList(),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: urlController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionUrl,
                          labelText: context.i18n.institutionUrl,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: Column(
                        children: [
                          if (institutionFocus != InstitutionFocus.KLIMAFIT)
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: Colors.black,
                              controlAffinity: ListTileControlAffinity.leading,
                              value: showTrainingPlans,
                              onChanged: (value) {
                                setState(() {
                                  showTrainingPlans = value ?? false;
                                  this.hasChanges = true;
                                });
                              },
                              title: Text(context.i18n.allowTrainingPlans),
                            ),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: Colors.black,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: allowRescheduleActivities,
                            onChanged: (value) {
                              setState(() {
                                allowRescheduleActivities = value ?? false;
                                this.hasChanges = true;
                              });
                            },
                            title: Text(context.i18n.allowRescheduleActivities),
                          ),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: Colors.black,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: enableSocialFeatures,
                            onChanged: (value) {
                              setState(() {
                                enableSocialFeatures = value ?? false;
                                this.hasChanges = true;
                              });
                            },
                            title: Text(context.i18n.enableSocialFeatures),
                          ),
                          if (institutionFocus == InstitutionFocus.PREHAB_TO_REHAB)
                            DropdownButtonFormField(
                              initialValue: institutionP2RFocus,
                              onChanged: (value) {
                                setState(() {
                                  institutionP2RFocus = value as InstitutionP2RFocus;
                                  this.hasChanges = true;
                                });
                              },
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: context.i18n.prehab2RehabFocus + ' *',
                                border: const OutlineInputBorder(),
                              ),
                              focusColor: Colors.transparent,
                              validator: (value) => value == null ? context.i18n.validationNotEmpty : null,
                              items: InstitutionP2RFocus.values.map((value) {
                                return DropdownMenuItem<InstitutionP2RFocus>(
                                  child: FittedBox(child: Text(value.getText(context))),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: minimumDaysBetweenInformationMessagesController,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
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
                        hintText: context.i18n.minimumDaysBetweenInformationMessages,
                        labelText: context.i18n.minimumDaysBetweenInformationMessages + " *",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: datatableBorderColor,
                          ),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: emailUserQueriesController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionEmailUserQueries,
                          labelText: context.i18n.institutionEmailUserQueries,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: phoneNumberUserQueriesController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionPhoneNumberUserQueries,
                          labelText: context.i18n.institutionPhoneNumberUserQueries,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: availabilityPhoneController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionAvailabilityPhone,
                          labelText: context.i18n.institutionAvailabilityPhone,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: getInTouchNotesController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionGetInTouchNotes,
                          labelText: context.i18n.institutionGetInTouchNotes,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: SelectableText(context.i18n.institutionAdministrator, style: getBreadCrumbStyle(context)),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: firstNameController,
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return context.i18n.validationNotEmpty;
                          } else if (value!.length < 2 || value.length > 100) {
                            return context.i18n.validationDefaultLength;
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
                          hintText: context.i18n.firstNameAdministrator,
                          labelText: context.i18n.firstNameAdministrator + ' *',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: lastNameController,
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return context.i18n.validationNotEmpty;
                          } else if (value!.length < 2 || value.length > 100) {
                            return context.i18n.validationDefaultLength;
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
                          hintText: context.i18n.lastNameAdministrator,
                          labelText: context.i18n.lastNameAdministrator + ' *',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if ((value ?? "").isEmpty || !EmailValidator.validate((value ?? "").trim())) {
                            return context.i18n.validationEmail;
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
                          hintText: context.i18n.emailAdministrator,
                          labelText: context.i18n.emailAdministrator + ' *',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SelectableText(context.i18n.hintRequiredFields,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: lightTextColor,
                                  ))
                        ],
                      ),
                    ),
                    FormFieldPadding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.edit
                              ? SaveButton(title: context.i18n.save.toUpperCase(), callback: updateInstitution)
                              : SaveButton(title: context.i18n.create.toUpperCase(), callback: addInstitution),
                          SizedBox(width: width * 0.01),
                          CancelButton(
                            callback: () => goBack(),
                            hasChanges: this.hasChanges,
                          ),
                          if (widget.edit) SizedBox(width: width * 0.01),
                          if (widget.edit)
                            DeleteButton(
                              callback: deleteUser,
                              confirmationTitle: context.i18n.deleteMessageInstitutionsTitle,
                              confirmationText: context.i18n.deleteMessageInstitutions(
                                  institution!.name!, userCount.healthcareProfessionalCount ?? 0, userCount.patientCount ?? 0),
                            )
                        ],
                      ),
                    )
                  ],
                  englishFields: [
                    FormFieldPadding(
                      child: TextFormField(
                        controller: englishUrlController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionUrl,
                          labelText: context.i18n.institutionUrl,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: englishAvailabilityPhoneController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionAvailabilityPhoneEnglish,
                          labelText: context.i18n.institutionAvailabilityPhoneEnglish,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: englishGetInTouchNotesController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.institutionGetInTouchNotesEnglish,
                          labelText: context.i18n.institutionGetInTouchNotesEnglish,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  String get traceablePageName => "Modify Institution Page";
}
