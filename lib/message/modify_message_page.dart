// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/image_form_field.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:http/http.dart';

import '../apt_layout.dart';
import '../main.dart';
import '../widget/form_field_padding.dart';

class ModifyMessagePage extends StatefulWidget {
  final MessageTemplateDTO? message;
  final String? messageId;

  ModifyMessagePage({Key? key, this.message, this.messageId}) : super(key: key);

  @override
  _ModifyMessagePageState createState() => _ModifyMessagePageState();
}

class _ModifyMessagePageState extends State<ModifyMessagePage> with TraceablePageMixin {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final pictureController = TextEditingController();
  final titleEnglishController = TextEditingController();
  final contentEnglishController = TextEditingController();
  final pictureEnglishController = TextEditingController();
  bool hasChanges = false;
  bool loading = true;

  final messageApi = new MessageControllerApi(apiClient);
  MessageBloc? messageBloc;

  FileGetDTO? messagePictureDE;
  String uploadedPicturePathDE = "";
  MultipartFile? pictureFileDE;
  String deletePictureIdDE = "";

  FileGetDTO? messagePictureEN;
  String uploadedPicturePathEN = "";
  MultipartFile? pictureFileEN;
  String deletePictureIdEN = "";

  @override
  void initState() {
    super.initState();
    messageBloc = BlocProvider.of<MessageBloc>(context);
    if (widget.messageId == null) {
      titleController.text = "";
      contentController.text = "";
      titleEnglishController.text = "";
      contentEnglishController.text = "";
      loading = false;
    } else if (widget.message == null) {
      loading = true;
      messageApi.getInformationTemplateById(widget.messageId!).then((value) {
        setState(() {
          initControllersFromMessage(value!);
          loading = false;
        });
      });
    } else {
      initControllersFromMessage(widget.message!);
      loading = false;
    }
  }

  void initControllersFromMessage(MessageTemplateDTO message) {
    titleController.text = message.title['DE']!;
    titleEnglishController.text = message.title['EN']!;
    contentController.text = message.text['DE']!;
    contentEnglishController.text = message.text['EN']!;
    pictureController.text = "";
    pictureEnglishController.text = "";

    if (message.pictureId.containsKey(TranslationLanguage.DE.toString())) {
      messageApi.getMessagePicture(MessageType.INFORMATION, message.pictureId[TranslationLanguage.DE.toString()]!).then((value) {
        setState(() {
          messagePictureDE = value;
          pictureController.text = value!.filename!;
        });
      });
    } else {
      setState(() {
        messagePictureDE = null;
      });
    }

    if (message.pictureId.containsKey(TranslationLanguage.EN.toString())) {
      messageApi.getMessagePicture(MessageType.INFORMATION, message.pictureId[TranslationLanguage.EN.toString()]!).then((value) {
        setState(() {
          messagePictureEN = value;
          pictureEnglishController.text = value!.filename!;
        });
      });
    } else {
      setState(() {
        messagePictureEN = null;
      });
    }
  }

  updatePicture(TranslationLanguage language) async {
    try {
      final List<PlatformFile> _paths = (await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
          ))
              ?.files ??
          [];
      if (_paths.isEmpty) {
        return;
      }
      final PlatformFile _file = _paths.first;
      if (language == TranslationLanguage.DE) {
        pictureFileDE = _file.bytes != null
            ? MultipartFile.fromBytes(
                "pictureFile",
                _file.bytes!,
                filename: _file.name,
              )
            : await MultipartFile.fromPath("pictureFile", _file.path!, filename: _file.name);
        if (pictureFileDE!.length > ImageFormField.MAX_FILESIZE) {
          ImageFormField.showFileTooBigDialog(context);
          return;
        }
        setState(() {
          deletePictureIdDE = "";
          pictureController.text = _file.name;
          uploadedPicturePathDE = _file.path ?? "";
          hasChanges = true;
        });
      } else if (language == TranslationLanguage.EN) {
        pictureFileEN = _file.bytes != null
            ? MultipartFile.fromBytes(
                "pictureFile",
                _file.bytes!,
                filename: _file.name,
              )
            : await MultipartFile.fromPath("pictureFile", _file.path!, filename: _file.name);
        if (pictureFileEN!.length > ImageFormField.MAX_FILESIZE) {
          ImageFormField.showFileTooBigDialog(context);
          return;
        }
        setState(() {
          deletePictureIdEN = "";
          pictureEnglishController.text = _file.name;
          uploadedPicturePathEN = _file.path ?? "";
          hasChanges = true;
        });
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }

    if (language == TranslationLanguage.DE) {
      return messagePictureDE;
    } else {
      return messagePictureEN;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    titleEnglishController.dispose();
    contentEnglishController.dispose();
    super.dispose();
  }

  MessageTemplatePostDTO getMessagePostDTO() {
    return MessageTemplatePostDTO(
        title: {"DE": titleController.text, "EN": titleEnglishController.text},
        text: {"DE": contentController.text, "EN": contentEnglishController.text});
  }

  addMessage() {
    if (formKey.currentState!.validate()) {
      messageBloc!.add(AddMessageTemplateEvent(message: getMessagePostDTO(), picture: pictureFileDE, pictureEnglish: pictureFileEN));
      goBack();
    }
  }

  updateMessage() {
    if (formKey.currentState!.validate()) {
      messageBloc!.add(UpdateMessageTemplateEvent(
          id: widget.messageId!,
          message: getMessagePostDTO(),
          picture: pictureFileDE,
          pictureEnglish: pictureFileEN,
          deletePictureId: deletePictureIdDE,
          deletePictureEnglishId: deletePictureIdEN));
      goBack();
    }
  }

  deleteMessage() {
    messageBloc!.add(DeleteMessageTemplateEvent(id: widget.messageId!));
    goBack();
  }

  goBack() {
    if (context.canBeamBack) {
      context.beamBack();
    } else {
      context.beamToNamed("/messages");
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
            child: SelectableText(context.i18n.message, style: getBreadCrumbStyle(context)),
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
                    ImageFormField(
                        controller: pictureController,
                        callback: () => updatePicture(TranslationLanguage.DE),
                        deleteCallback: pictureController.text.isNotEmpty
                            ? () {
                                setState(() {
                                  hasChanges = true;
                                  pictureController.text = "";
                                  uploadedPicturePathDE = "";
                                  pictureFileDE = null;
                                  deletePictureIdDE = widget.message?.pictureId[TranslationLanguage.DE.toString()] ?? "";
                                  messagePictureDE?.exists = false;
                                });
                              }
                            : null),
                    if ((messagePictureDE?.exists ?? false) || uploadedPicturePathDE.isNotEmpty)
                      FormFieldPadding(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: uploadedPicturePathDE.isNotEmpty
                              ? kIsWeb
                                  ? Image.network(
                                      uploadedPicturePathDE,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(uploadedPicturePathDE),
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                              : Image.network(
                                  messagePictureDE!.url!,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    FormFieldPadding(
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: contentController,
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
                          hintText: context.i18n.content,
                          hintMaxLines: 1,
                          labelText: context.i18n.content + " *",
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
                          (widget.messageId ?? "").isNotEmpty
                              ? SaveButton(title: context.i18n.save.toUpperCase(), callback: updateMessage)
                              : SaveButton(title: context.i18n.create.toUpperCase(), callback: addMessage),
                          SizedBox(width: 10),
                          CancelButton(
                            callback: () => goBack(),
                            hasChanges: this.hasChanges,
                          ),
                          if (widget.messageId != null)
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: DeleteButton(
                                  callback: deleteMessage,
                                  confirmationTitle: context.i18n.deleteMessageMessageTemplateTitle,
                                  confirmationText: context.i18n.deleteMessageMessageTemplate,
                                )),
                        ],
                      ),
                    )
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
                    ImageFormField(
                        controller: pictureEnglishController,
                        callback: () => updatePicture(TranslationLanguage.EN),
                        deleteCallback: pictureEnglishController.text.isNotEmpty
                            ? () {
                                setState(() {
                                  hasChanges = true;
                                  pictureEnglishController.text = "";
                                  uploadedPicturePathEN = "";
                                  pictureFileEN = null;
                                  deletePictureIdEN = widget.message?.pictureId[TranslationLanguage.EN.toString()] ?? "";
                                  messagePictureEN?.exists = false;
                                });
                              }
                            : null),
                    if ((messagePictureEN?.exists ?? false) || uploadedPicturePathEN.isNotEmpty)
                      FormFieldPadding(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: uploadedPicturePathEN.isNotEmpty
                              ? kIsWeb
                                  ? Image.network(
                                      uploadedPicturePathEN,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(uploadedPicturePathEN),
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                              : Image.network(
                                  messagePictureEN!.url!,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    FormFieldPadding(
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: contentEnglishController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        onChanged: (value) => {
                          setState(() {
                            this.hasChanges = true;
                          })
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: context.i18n.contentEnglish,
                          hintMaxLines: 1,
                          labelText: context.i18n.contentEnglish,
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
