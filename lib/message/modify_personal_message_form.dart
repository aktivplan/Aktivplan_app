import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/widgets/date_picker_row.dart';
import 'package:aptapp/exercises/widgets/time_picker_row.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/delete_button_one_or_all.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/image_form_field.dart';
import 'package:aptapp/widget/language_tabs.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:dart_date/dart_date.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ModifyPersonalMessageForm extends StatefulWidget {
  final String patientId;
  final List<MessageReceiverNameDTO> receiverNames;
  final MessageGetDTO? message;
  final MessageScheduleGetDTO? scheduledMessage;
  final MultipartFile? pictureFileDE;
  final MultipartFile? pictureFileEN;

  ModifyPersonalMessageForm(
      {Key? key, required this.patientId, required this.receiverNames, this.message, this.scheduledMessage, this.pictureFileDE, this.pictureFileEN})
      : super(key: key);

  @override
  _ModifyPersonalMessageFormState createState() => _ModifyPersonalMessageFormState();
}

class _ModifyPersonalMessageFormState extends State<ModifyPersonalMessageForm> {
  bool hasChanges = false;
  bool hasPatientSelectChanges = false;
  bool isAscending = false;
  int selectedColumn = 0;
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final pictureController = TextEditingController();
  final subjectEnglishController = TextEditingController();
  final messageEnglishController = TextEditingController();
  final pictureEnglishController = TextEditingController();
  final _editMessageFormKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String selectedTime = "";
  bool isSaving = false;
  bool selectReceivers = false;
  List<String> selectedPatientIds = [];
  List<String> recipientIds = [];
  MessageBloc? messageBloc;
  MessageSendToType sendToType = MessageSendToType.ALL;

  final messageApi = new MessageControllerApi(apiClient);
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
    pictureController.text = "";
    pictureEnglishController.text = "";
    pictureFileDE = widget.pictureFileDE;
    pictureFileEN = widget.pictureFileEN;

    if (widget.message != null) {
      sendToType = widget.message!.sendToType;
    } else if (widget.scheduledMessage != null) {
      sendToType = widget.scheduledMessage!.sendToType;
    }

    if (widget.message != null) {
      subjectController.text = widget.message!.subject ?? "";
      messageController.text = widget.message!.text ?? "";
      initByDateTimeString(widget.message!.sentDateTime ?? "");
      if ((widget.message!.pictureId ?? "").isNotEmpty) {
        messageApi.getMessagePicture(MessageType.PERSONAL, widget.message!.pictureId!).then((value) {
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
    } else if (widget.scheduledMessage != null) {
      initTextEditingControllerFromTranslationObject(widget.scheduledMessage!.subject, subjectController, subjectEnglishController);
      initTextEditingControllerFromTranslationObject(widget.scheduledMessage!.text, messageController, messageEnglishController);
      initByDateTimeString(widget.scheduledMessage!.scheduleDateTime ?? "");
      recipientIds = widget.scheduledMessage?.recipientIds ?? [];

      if (widget.scheduledMessage!.pictureId.containsKey(TranslationLanguage.DE.toString()) &&
          widget.scheduledMessage!.pictureId[TranslationLanguage.DE.toString()]!.isNotEmpty) {
        messageApi.getMessagePicture(MessageType.PERSONAL, widget.scheduledMessage!.pictureId[TranslationLanguage.DE.toString()]!).then((value) {
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

      if (widget.scheduledMessage!.pictureId.containsKey(TranslationLanguage.EN.toString()) &&
          widget.scheduledMessage!.pictureId[TranslationLanguage.EN.toString()]!.isNotEmpty) {
        messageApi.getMessagePicture(MessageType.PERSONAL, widget.scheduledMessage!.pictureId[TranslationLanguage.EN.toString()]!).then((value) {
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
    sortColumn(0, false);
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

  void initByDateTimeString(String dateTime) {
    if (dateTime.isEmpty) {
      selectedDate = null;
      selectedTime = "";
    } else {
      DateTime utcDateTime = DateTime.utc(
        int.parse(dateTime.substring(0, 4)), // Year
        int.parse(dateTime.substring(5, 7)), // Month
        int.parse(dateTime.substring(8, 10)), // Day
        int.parse(dateTime.substring(11, 13)), // Hour
        int.parse(dateTime.substring(14, 16)), // Minute
      );
      selectedDate = utcDateTime.toLocal();
      selectedTime = DateFormat.Hm().format(selectedDate!);
    }
  }

  sortColumn(int columnIndex, bool ascending) {
    setState(() {
      selectedColumn = columnIndex;
      isAscending = ascending;
    });

    if (columnIndex == 0) {
      if (isAscending) {
        widget.receiverNames.sort((a, b) => a.userName!.toLowerCase().compareTo(b.userName!.toLowerCase()));
      } else {
        widget.receiverNames.sort((a, b) => b.userName!.toLowerCase().compareTo(a.userName!.toLowerCase()));
      }
    } else if (columnIndex == 1) {
      if (isAscending) {
        widget.receiverNames.sort((a, b) => a.email!.toLowerCase().compareTo(b.email!.toLowerCase()));
      } else {
        widget.receiverNames.sort((a, b) => b.email!.toLowerCase().compareTo(a.email!.toLowerCase()));
      }
    }
  }

  toggleSelection(MessageReceiverNameDTO user) {
    setState(() {
      if (selectedPatientIds.indexOf(user.id!) > -1) {
        selectedPatientIds = [...selectedPatientIds];
        selectedPatientIds.remove(user.id!);
      } else {
        selectedPatientIds = [...selectedPatientIds, user.id!];
      }
      hasPatientSelectChanges = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (selectReceivers) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            context.i18n.recipients,
            style: getBreadCrumbStyle(context),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: CheckboxListTile(
                activeColor: Colors.black,
                title: Text(
                  context.i18n.selectAll,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: selectedPatientIds.length == widget.receiverNames.length,
                onChanged: (selected) {
                  setState(() {
                    if (selectedPatientIds.length == widget.receiverNames.length) {
                      selectedPatientIds = [];
                    } else {
                      selectedPatientIds = widget.receiverNames.map((e) => e.id!).toList();
                    }
                    hasPatientSelectChanges = true;
                  });
                }),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: height * 0.6,
            decoration: BoxDecoration(
              border: Border.all(
                color: datatableBorderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                showBottomBorder: true,
                sortAscending: isAscending,
                sortColumnIndex: selectedColumn,
                columns: [
                  AptDataColumn(
                    dataColoumnIndex: 0,
                    selectedColumnIndex: selectedColumn,
                    label: Text(
                      context.i18n.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onSort: sortColumn,
                  ),
                  AptDataColumn(
                    dataColoumnIndex: 1,
                    selectedColumnIndex: selectedColumn,
                    label: Text(
                      context.i18n.email,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onSort: sortColumn,
                  ),
                ],
                rows: widget.receiverNames
                    .map(
                      (user) => DataRow(
                        onSelectChanged: (selected) {
                          toggleSelection(user);
                        },
                        cells: [
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: CheckboxListTile(
                                      activeColor: Colors.black,
                                      title: Text(
                                        user.userName ?? "",
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                      ),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      value: selectedPatientIds.indexOf(user.id!) > -1,
                                      onChanged: (selected) {
                                        toggleSelection(user);
                                      }),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Text(
                                    user.email ?? "",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SizedBox(height: 15),
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                child: SaveButton(
                  title: context.i18n.save.toUpperCase(),
                  callback: () {
                    setState(() {
                      recipientIds = selectedPatientIds;
                      selectReceivers = false;
                      hasChanges = true;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: CancelButton(
                    callback: () {
                      setState(() {
                        selectReceivers = false;
                      });
                    },
                    hasChanges: hasPatientSelectChanges),
              ),
            ],
          ),
        ],
      );
    }

    bool isSendNow = selectedDate == null && selectedTime.isEmpty;
    bool canEditMessage = widget.scheduledMessage != null || widget.message?.sendToType == MessageSendToType.ONE;
    final List<Widget> messageFields = [
      TextFormField(
        controller: subjectController,
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
        enabled: canEditMessage,
        decoration: InputDecoration(
          hintMaxLines: 1,
          hintText: context.i18n.subject,
          labelText: context.i18n.subject + ' *',
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: datatableBorderColor,
            ),
          ),
        ),
      ),
      ImageFormField(
          controller: pictureController,
          enabled: canEditMessage,
          callback: () => updatePicture(TranslationLanguage.DE),
          deleteCallback: pictureController.text.isNotEmpty
              ? () {
                  setState(() {
                    hasChanges = true;
                    pictureController.text = "";
                    uploadedPicturePathDE = "";
                    pictureFileDE = null;
                    if (widget.message != null) {
                      deletePictureIdDE = widget.message?.pictureId ?? "";
                    } else {
                      deletePictureIdDE = widget.scheduledMessage?.pictureId[TranslationLanguage.DE.toString()] ?? "";
                    }
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
      SizedBox(height: 20),
      TextFormField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        controller: messageController,
        keyboardType: TextInputType.multiline,
        maxLines: 6,
        enabled: canEditMessage,
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
          hintText: context.i18n.message,
          hintMaxLines: 1,
          labelText: context.i18n.message + " *",
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: datatableBorderColor,
            ),
          ),
        ),
      ),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.patientId.isEmpty) ...[
        SelectableText(
          context.i18n.recipients,
          style: getBreadCrumbStyle(context),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            OutlinedButton(
              onPressed: widget.scheduledMessage != null
                  ? () {
                      setState(() {
                        sendToType = MessageSendToType.ALL;
                      });
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1, color: widget.scheduledMessage != null ? primaryColor : infoIconColor),
                backgroundColor:
                    sendToType == MessageSendToType.ALL ? (widget.scheduledMessage != null ? primaryColor : infoIconColor).withOpacity(.2) : null,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(context.i18n.messageSendToType_ALL, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(width: 10),
            OutlinedButton(
              onPressed: widget.scheduledMessage != null
                  ? () {
                      setState(() {
                        sendToType = MessageSendToType.SOME;
                        selectedPatientIds = recipientIds;
                        selectReceivers = true;
                        hasPatientSelectChanges = false;
                      });
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1, color: widget.scheduledMessage != null ? primaryColor : infoIconColor),
                backgroundColor:
                    sendToType == MessageSendToType.SOME ? (widget.scheduledMessage != null ? primaryColor : infoIconColor).withOpacity(.2) : null,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(context.i18n.messageSendToType_SOME, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
      SelectableText(
        context.i18n.message,
        style: getBreadCrumbStyle(context),
      ),
      Form(
        key: _editMessageFormKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: infoIconColor,
                size: 20,
              ),
              SizedBox(width: 10),
              Flexible(
                child: SelectableText(
                  context.i18n.sendMessageHint,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.1, color: infoIconColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          if (sendToType == MessageSendToType.ONE || widget.scheduledMessage == null) ...messageFields,
          if (sendToType != MessageSendToType.ONE && widget.scheduledMessage != null)
            LanguageTabs(germanFields: [
              SizedBox(height: 20),
              ...messageFields
            ], englishFields: [
              SizedBox(height: 20),
              TextFormField(
                controller: subjectEnglishController,
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: context.i18n.subject + " " + context.i18n.englishTranslationNote,
                  labelText: context.i18n.subject + " " + context.i18n.englishTranslationNote,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
              ImageFormField(
                  controller: pictureEnglishController,
                  enabled: canEditMessage,
                  callback: () => updatePicture(TranslationLanguage.EN),
                  deleteCallback: pictureEnglishController.text.isNotEmpty
                      ? () {
                          setState(() {
                            hasChanges = true;
                            pictureEnglishController.text = "";
                            uploadedPicturePathEN = "";
                            pictureFileEN = null;
                            if (widget.message != null) {
                              deletePictureIdEN = widget.message?.pictureId ?? "";
                            } else {
                              deletePictureIdEN = widget.scheduledMessage?.pictureId[TranslationLanguage.EN.toString()] ?? "";
                            }
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
              SizedBox(height: 20),
              TextFormField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                controller: messageEnglishController,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                onChanged: (value) => {
                  setState(() {
                    this.hasChanges = true;
                  })
                },
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: context.i18n.message + " " + context.i18n.englishTranslationNote,
                  hintMaxLines: 1,
                  labelText: context.i18n.message + " " + context.i18n.englishTranslationNote,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ]),
          SizedBox(height: 15),
          SelectableText(
            context.i18n.sendTime,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              OutlinedButton(
                onPressed: widget.scheduledMessage != null
                    ? () {
                        _editMessageFormKey.currentState!.reset();
                        setState(() {
                          selectedDate = null;
                          selectedTime = "";
                        });
                      }
                    : null,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1, color: widget.scheduledMessage != null ? primaryColor : infoIconColor),
                  backgroundColor: isSendNow ? (widget.scheduledMessage != null ? primaryColor : infoIconColor).withOpacity(.2) : null,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(context.i18n.now.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 150,
                child: DatePickerRow(
                  startDate: selectedDate,
                  labelText: context.i18n.day,
                  isRequired: !isSendNow,
                  selected: !isSendNow,
                  disabled: widget.message != null,
                  firstDate: DateTime.now(),
                  selectDate: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                      hasChanges = true;
                    });
                  },
                ),
              ),
              SizedBox(width: 15),
              Container(
                width: 150,
                child: TimePickerRow(
                  requiredField: !isSendNow,
                  initialTime: selectedTime,
                  selected: !isSendNow,
                  disabled: widget.message != null,
                  selectTime: (String time) {
                    setState(() {
                      selectedTime = time;
                      hasChanges = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
      SizedBox(height: 15),
      if (!isSaving)
        Wrap(
          children: [
            if (canEditMessage)
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                child: SaveButton(
                  title: (widget.message != null || !isSendNow ? context.i18n.saveAndUpdate : context.i18n.saveAndSend).toUpperCase(),
                  callback: () {
                    if (_editMessageFormKey.currentState!.validate()) {
                      setState(() {
                        isSaving = true;
                      });
                      if (widget.message != null) {
                        messageBloc!.add(
                          UpdateSentMessageEvent(
                            patientId: widget.patientId,
                            message: MessagePutDTO(
                              id: widget.message!.id,
                              subject: subjectController.text,
                              text: messageController.text,
                            ),
                            picture: pictureFileDE,
                            deletePictureId: deletePictureIdDE,
                          ),
                        );
                      } else {
                        MessageSchedulePutDTO messageToUpdate = MessageSchedulePutDTO(
                          id: widget.scheduledMessage?.id ?? "",
                          subject: getTranslationObjectFromController(subjectController, subjectEnglishController),
                          text: getTranslationObjectFromController(messageController, messageEnglishController),
                        );
                        if (sendToType == MessageSendToType.ALL) {
                          messageToUpdate.recipientIds = widget.receiverNames.map((e) => e.id!).toList();
                          if ((widget.scheduledMessage!.recipientsOfInstitutionId ?? "").isNotEmpty) {
                            messageToUpdate.recipientsOfInstitutionId = widget.scheduledMessage!.recipientsOfInstitutionId;
                          } else if ((widget.scheduledMessage!.recipientsOfHealthcareProfessionalId ?? "").isNotEmpty) {
                            messageToUpdate.recipientsOfHealthcareProfessionalId = widget.scheduledMessage!.recipientsOfHealthcareProfessionalId;
                          } else if (userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
                            messageToUpdate.recipientsOfInstitutionId = userRepository.currentInstitution!.id!;
                          } else if (userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL) {
                            messageToUpdate.recipientsOfHealthcareProfessionalId = userRepository.currentUser.id!;
                          }
                        } else if (sendToType == MessageSendToType.SOME) {
                          messageToUpdate.recipientIds = recipientIds;
                        } else {
                          messageToUpdate.recipientIds = [widget.patientId];
                        }
                        if (!isSendNow) {
                          final String convertedDateTimeString = DateFormat('yyyy-MM-ddTHH:mm').format(
                              selectedDate!.setHour(int.parse(selectedTime.split(":")[0])).setMinute(int.parse(selectedTime.split(":")[1])).toUtc());
                          messageToUpdate.scheduleDateTime = convertedDateTimeString;
                        }
                        if ((messageToUpdate.id ?? "").isEmpty) {
                          messageBloc!.add(
                            AddScheduledMessageEvent(
                              patientId: widget.patientId,
                              message: MessageSchedulePostDTO(
                                recipientIds: messageToUpdate.recipientIds,
                                subject: messageToUpdate.subject,
                                text: messageToUpdate.text,
                                scheduleDateTime: messageToUpdate.scheduleDateTime,
                                recipientsOfHealthcareProfessionalId: messageToUpdate.recipientsOfHealthcareProfessionalId,
                                recipientsOfInstitutionId: messageToUpdate.recipientsOfInstitutionId,
                              ),
                              picture: pictureFileDE,
                              pictureEnglish: pictureFileEN,
                            ),
                          );
                        } else {
                          messageBloc!.add(
                            UpdateScheduledMessageEvent(
                              patientId: widget.patientId,
                              message: messageToUpdate,
                              picture: pictureFileDE,
                              pictureEnglish: pictureFileEN,
                              deletePictureId: deletePictureIdDE,
                              deletePictureEnglishId: deletePictureIdEN,
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            if ((widget.scheduledMessage?.id ?? "").isNotEmpty || (widget.message?.id ?? "").isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                child: SaveButton(
                    title: context.i18n.copy.toUpperCase(),
                    callback: () {
                      if (widget.scheduledMessage != null) {
                        messageBloc!.add(CopyScheduledMessageEvent(
                          message: MessageScheduleGetDTO(
                            id: "",
                            sendToType: widget.patientId.isEmpty ? MessageSendToType.ALL : MessageSendToType.ONE,
                            pictureId: widget.scheduledMessage!.pictureId,
                            subject: widget.scheduledMessage!.subject,
                            text: widget.scheduledMessage!.text,
                            recipientIds: widget.patientId.isEmpty ? [] : [widget.patientId],
                          ),
                          pictureDE: messagePictureDE,
                          pictureEN: messagePictureEN,
                        ));
                      } else {
                        messageBloc!.add(CopyScheduledMessageEvent(
                          message: MessageScheduleGetDTO(
                            id: "",
                            sendToType: widget.patientId.isEmpty ? MessageSendToType.ALL : MessageSendToType.ONE,
                            pictureId: getTranslationObjectFromText(widget.message!.pictureId, ""),
                            subject: getTranslationObjectFromText(widget.message!.subject, ""),
                            text: getTranslationObjectFromText(widget.message!.text, ""),
                            recipientIds: widget.patientId.isEmpty ? [] : [widget.patientId],
                          ),
                          pictureDE: messagePictureDE,
                          pictureEN: messagePictureEN,
                        ));
                      }
                    }),
              ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
              child: CancelButton(
                callback: () {
                  messageBloc!.add(CancelMessageEditEvent());
                },
                hasChanges: this.hasChanges,
              ),
            ),
            if ((widget.scheduledMessage?.id ?? "").isNotEmpty && (widget.scheduledMessage?.recipientIds.length == 1 || widget.patientId.isEmpty))
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: DeleteButton(
                    confirmationTitle: context.i18n.deleteMessageMessageTemplateTitle,
                    confirmationText: context.i18n.deleteMessageMessagePersonal,
                    callback: () {
                      messageBloc!.add(
                        DeleteScheduledMessageEvent(
                          patientId: widget.patientId,
                          messageId: widget.scheduledMessage?.id ?? "",
                          deleteAll: false,
                        ),
                      );
                    }),
              ),
            if ((widget.scheduledMessage?.recipientIds.length ?? 0) > 1 && widget.patientId.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: DeleteButtonOneOrAll(
                    confirmationTitle: context.i18n.deleteMessageMessageTemplateTitle,
                    confirmationText: context.i18n.deleteMessageMessagePersonal,
                    deleteThisText: context.i18n.deleteForThisRecipient,
                    deleteAllText: context.i18n.deleteForAllRecipients,
                    callback: (deleteAll) {
                      messageBloc!.add(
                        DeleteScheduledMessageEvent(
                          patientId: widget.patientId,
                          messageId: widget.scheduledMessage?.id ?? "",
                          deleteAll: deleteAll,
                        ),
                      );
                    }),
              ),
          ],
        ),
      if (isSaving) CircularProgressIndicator(),
    ]);
  }
}
