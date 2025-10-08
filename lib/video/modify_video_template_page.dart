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
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/video/bloc/video_bloc.dart';
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

class ModifyVideoTemplatePage extends StatefulWidget {
  final VideoTemplateDTO? template;
  final String templateId;

  ModifyVideoTemplatePage({Key? key, this.template, this.templateId = ""}) : super(key: key);

  @override
  _ModifyVideoTemplatePageState createState() => _ModifyVideoTemplatePageState();
}

class _ModifyVideoTemplatePageState extends State<ModifyVideoTemplatePage> with TraceablePageMixin {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final youTubeUrlController = TextEditingController();
  final titleEnglishController = TextEditingController();
  final youTubeUrlEnglishController = TextEditingController();
  bool hasChanges = false;
  bool loading = true;

  final videoApi = new VideoControllerApi(apiClient);
  VideoBloc? videoBloc;

  @override
  void initState() {
    super.initState();
    videoBloc = BlocProvider.of<VideoBloc>(context);
    if (widget.templateId.isEmpty) {
      titleController.text = "";
      youTubeUrlController.text = "";
      titleEnglishController.text = "";
      youTubeUrlEnglishController.text = "";
      loading = false;
    } else if (widget.template == null) {
      loading = true;
      videoApi.getVideoTemplateById(widget.templateId).then((value) {
        setState(() {
          initControllersFromTemplate(value!);
          loading = false;
        });
      });
    } else {
      initControllersFromTemplate(widget.template!);
      loading = false;
    }
  }

  void initControllersFromTemplate(VideoTemplateDTO template) {
    initTextEditingControllerFromTranslationObject(template.title, titleController, titleEnglishController);
    initTextEditingControllerFromTranslationObject(template.youTubeLink, youTubeUrlController, youTubeUrlEnglishController);
  }

  @override
  void dispose() {
    titleController.dispose();
    youTubeUrlController.dispose();
    titleEnglishController.dispose();
    youTubeUrlEnglishController.dispose();
    super.dispose();
  }

  VideoTemplatePostDTO getVideoTemplatePostDTO() {
    return VideoTemplatePostDTO(
        title: getTranslationObjectFromController(titleController, titleEnglishController),
        youTubeLink: getTranslationObjectFromController(youTubeUrlController, youTubeUrlEnglishController));
  }

  addTemplate() {
    if (formKey.currentState!.validate()) {
      videoBloc!.add(AddVideoTemplateEvent(template: getVideoTemplatePostDTO()));
      goBack();
    }
  }

  updateTemplate() {
    if (formKey.currentState!.validate()) {
      videoBloc!.add(UpdateVideoTemplateEvent(id: widget.templateId, template: getVideoTemplatePostDTO()));
      goBack();
    }
  }

  deleteMessage() {
    videoBloc!.add(DeleteVideoTemplateEvent(id: widget.templateId));
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
            child: SelectableText(context.i18n.themeVideo, style: getBreadCrumbStyle(context)),
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
                        controller: youTubeUrlController,
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
                          hintText: context.i18n.youTubeUrl,
                          labelText: context.i18n.youTubeUrl + " *",
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
                          widget.templateId.isNotEmpty
                              ? SaveButton(title: context.i18n.save.toUpperCase(), callback: updateTemplate)
                              : SaveButton(title: context.i18n.create.toUpperCase(), callback: addTemplate),
                          SizedBox(width: 10),
                          CancelButton(
                            callback: () => goBack(),
                            hasChanges: this.hasChanges,
                          ),
                          if (widget.templateId.isNotEmpty)
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: DeleteButton(
                                  callback: deleteMessage,
                                  confirmationTitle: context.i18n.deleteMessageVideoTemplateTitle,
                                  confirmationText: context.i18n.deleteMessageVideoTemplate,
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
                        controller: youTubeUrlEnglishController,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: context.i18n.youTubeUrlEnglish,
                          labelText: context.i18n.youTubeUrlEnglish,
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

  String get traceablePageName => "Modify Message Page";
}
