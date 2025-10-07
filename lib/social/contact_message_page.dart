import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/image_form_field.dart';
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

class ContactMessagePage extends StatefulWidget {
  final String userId;

  ContactMessagePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ContactMessagePageState createState() => _ContactMessagePageState();
}

class _ContactMessagePageState extends State<ContactMessagePage> with TraceablePageMixin {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final pictureController = TextEditingController();
  bool hasChanges = false;
  bool loading = true;

  final messageApi = new MessageControllerApi(apiClient);
  MessageBloc? messageBloc;

  String uploadedPicturePath = "";
  MultipartFile? pictureFile;

  @override
  void initState() {
    super.initState();
    messageBloc = BlocProvider.of<MessageBloc>(context);
    titleController.text = "";
    contentController.text = "";
    pictureController.text = "";
    loading = false;
  }

  updatePicture() async {
    PlatformFile _file;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
      );
      if ((result?.files ?? []).isEmpty) {
        return;
      }
      _file = result!.files.first;
      uploadedPicturePath = _file.path ?? "";
      if (uploadedPicturePath.isEmpty) {
        return;
      }
      pictureFile = _file.bytes != null
          ? MultipartFile.fromBytes(
              "pictureFile",
              _file.bytes!,
              filename: _file.name,
            )
          : await MultipartFile.fromPath("pictureFile", uploadedPicturePath, filename: _file.name);
      setState(() {
        pictureController.text = _file.name;
        hasChanges = true;
      });
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
  }

  sendMessage() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<SocialBloc>(context).add(SendSocialMessageEvent(
        message: SocialMessagePostDTO(
          subject: titleController.text,
          text: contentController.text,
          recipientId: widget.userId,
          hasPicture: pictureController.text.isNotEmpty,
        ),
        picture: pictureFile,
      ));
      goBack();
    }
  }

  goBack() {
    if (context.canBeamBack) {
      context.beamBack();
    } else {
      context.beamToNamed("/contacts/${widget.userId}");
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
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        callback: () => updatePicture(),
                        deleteCallback: pictureController.text.isNotEmpty
                            ? () {
                                setState(() {
                                  hasChanges = true;
                                  pictureController.text = "";
                                  uploadedPicturePath = "";
                                  pictureFile = null;
                                });
                              }
                            : null),
                    if (uploadedPicturePath.isNotEmpty)
                      FormFieldPadding(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: kIsWeb
                                ? Image.network(
                                    uploadedPicturePath,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(uploadedPicturePath),
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )),
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
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: ElevatedButton.icon(
                        style: getElevatedButtonStyle(context, backgroundColor: primaryColor),
                        onPressed: sendMessage,
                        icon: Icon(Icons.send),
                        label: Text(
                          context.i18n.send.toUpperCase(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: ElevatedButton.icon(
                        style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                        onPressed: () {
                          if (this.hasChanges) {
                            CancelButton.showAlertDialog(context, goBack);
                          } else {
                            goBack();
                          }
                        },
                        label: Text(
                          context.i18n.cancel.toUpperCase(),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  String get traceablePageName => "Send Contact Message Page";
}
