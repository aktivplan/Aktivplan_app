import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/external_app/bloc/external_app_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

import '../apt_layout.dart';
import '../main.dart';
import '../widget/form_field_padding.dart';

class ModifyExternalAppPage extends StatefulWidget {
  final ExternalAppDTO? externalApp;
  final String externalAppId;

  ModifyExternalAppPage({Key? key, this.externalApp, this.externalAppId = ""}) : super(key: key);

  @override
  _ModifyExternalAppPageState createState() => _ModifyExternalAppPageState();
}

class _ModifyExternalAppPageState extends State<ModifyExternalAppPage> with TraceablePageMixin {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final titleEnglishController = TextEditingController();
  final descriptionEnglishController = TextEditingController();
  final webUrlController = TextEditingController();
  final androidUrlController = TextEditingController();
  final iOSUrlController = TextEditingController();
  bool hasChanges = false;
  bool loading = true;

  final externalAppApi = new ExternalAppControllerApi(apiClient);
  ExternalAppBloc? externalAppBloc;

  @override
  void initState() {
    super.initState();
    externalAppBloc = BlocProvider.of<ExternalAppBloc>(context);
    if (widget.externalAppId.isEmpty) {
      titleController.text = "";
      descriptionController.text = "";
      titleEnglishController.text = "";
      descriptionEnglishController.text = "";
      webUrlController.text = "";
      androidUrlController.text = "";
      iOSUrlController.text = "";
      loading = false;
    } else if (widget.externalApp == null) {
      loading = true;
      externalAppApi.getExternalAppById(widget.externalAppId).then((value) {
        setState(() {
          initControllersFromTemplate(value!);
          loading = false;
        });
      });
    } else {
      initControllersFromTemplate(widget.externalApp!);
      loading = false;
    }
  }

  void initControllersFromTemplate(ExternalAppDTO externalApp) {
    initTextEditingControllerFromTranslationObject(externalApp.title, titleController, titleEnglishController);
    initTextEditingControllerFromTranslationObject(externalApp.description, descriptionController, descriptionEnglishController);
    webUrlController.text = externalApp.webUrl ?? "";
    androidUrlController.text = externalApp.androidUrl ?? "";
    iOSUrlController.text = externalApp.iosurl ?? "";
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    titleEnglishController.dispose();
    descriptionEnglishController.dispose();
    webUrlController.dispose();
    androidUrlController.dispose();
    iOSUrlController.dispose();
    super.dispose();
  }

  ExternalAppPostDTO getExternalAppPostDTO() {
    return ExternalAppPostDTO(
        title: getTranslationObjectFromController(titleController, titleEnglishController),
        description: getTranslationObjectFromController(descriptionController, descriptionEnglishController),
        webUrl: webUrlController.text,
        androidUrl: androidUrlController.text,
        iosurl: iOSUrlController.text);
  }

  addTemplate() {
    if (formKey.currentState!.validate()) {
      externalAppBloc!.add(AddExternalAppEvent(externalApp: getExternalAppPostDTO()));
      goBack();
    }
  }

  updateTemplate() {
    if (formKey.currentState!.validate()) {
      externalAppBloc!.add(UpdateExternalAppEvent(id: widget.externalAppId, externalApp: getExternalAppPostDTO()));
      goBack();
    }
  }

  deleteMessage() {
    externalAppBloc!.add(DeleteExternalAppEvent(id: widget.externalAppId));
    goBack();
  }

  goBack() {
    if (context.canBeamBack) {
      context.beamBack();
    } else {
      context.beamToNamed("/video-templates");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AptLayout(
      border: false,
      fixedHeight: false,
      breadCrumb: [
        BreadCrumbItem(
          content: Padding(
            padding: EdgeInsets.only(left: 10),
            child: SelectableText(context.i18n.additionalApp, style: getBreadCrumbStyle(context)),
          ),
        )
      ],
      children: [
        Form(
          key: formKey,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : LanguageTabs(
                  germanFields: [
                    FormFieldPadding(
                      child: TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return context.i18n.validationNotEmpty;
                          }
                          return null;
                        },
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.title,
                          labelText: context.i18n.title + ' *',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        validator: (value) {
                          if ((value ?? "").trim().isEmpty) {
                            return context.i18n.validationNotEmpty;
                          }
                          return null;
                        },
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: context.i18n.description,
                          hintMaxLines: 1,
                          labelText: context.i18n.description + " *",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: iOSUrlController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: "Apple App Store Link",
                          labelText: "Apple App Store Link",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: androidUrlController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: "Google Play Store Link",
                          labelText: "Google Play Store Link",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: webUrlController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: "Website Link",
                          labelText: "Website Link",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
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
                          widget.externalAppId.isNotEmpty
                              ? SaveButton(title: context.i18n.save.toUpperCase(), callback: updateTemplate)
                              : SaveButton(title: context.i18n.create.toUpperCase(), callback: addTemplate),
                          SizedBox(width: 10),
                          CancelButton(
                            callback: () => goBack(),
                            hasChanges: this.hasChanges,
                          ),
                          if (widget.externalAppId.isNotEmpty)
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: DeleteButton(
                                  callback: deleteMessage,
                                  confirmationTitle: context.i18n.deleteMessageAdditionalAppTitle,
                                  confirmationText: context.i18n.deleteMessageAdditionalApp,
                                )),
                        ],
                      ),
                    ),
                  ],
                  englishFields: [
                    FormFieldPadding(
                      child: TextFormField(
                        controller: titleEnglishController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: context.i18n.titleEnglish,
                          labelText: context.i18n.titleEnglish,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: descriptionEnglishController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: context.i18n.description + ' ' + context.i18n.englishTranslationNote,
                          labelText: context.i18n.description + ' ' + context.i18n.englishTranslationNote,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  String get traceablePageName => "Modify External App Page";
}
