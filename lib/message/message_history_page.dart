import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/message/modify_personal_message_form.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MessageHistoryPage extends StatefulWidget {
  final String patientId;
  final String patientName;

  MessageHistoryPage({Key? key, this.patientId = "", this.patientName = ""}) : super(key: key);

  @override
  _MessageHistoryPageState createState() => _MessageHistoryPageState();
}

class MessageHelper {
  final String sendDate;
  final String sendToText;
  final String subject;
  final String senderName;
  final bool alreadySent;
  final MessageGetDTO? message;
  final MessageScheduleGetDTO? scheduledMessage;
  final bool editable;

  MessageHelper(
      {required this.sendDate,
      required this.sendToText,
      required this.subject,
      required this.senderName,
      required this.alreadySent,
      required this.editable,
      this.message,
      this.scheduledMessage});
}

class _MessageHistoryPageState extends State<MessageHistoryPage> with TraceablePageMixin {
  String patientName = "";
  final UserControllerApi userApi = new UserControllerApi(apiClient);
  MessageBloc? messageBloc;
  bool isAscending = false;
  int selectedColumn = 0;
  List<MessageHelper> messages = [];
  List<MessageReceiverNameDTO> receiverNames = [];

  @override
  void initState() {
    super.initState();
    patientName = widget.patientName;
    if (patientName.isEmpty && widget.patientId.isNotEmpty) {
      userApi
          .getPatientById(widget.patientId)
          .then((value) => setState(() => patientName = "${value!.user!.lastName ?? ""} ${value.user!.firstName ?? ""}"));
    }
    messageBloc = BlocProvider.of<MessageBloc>(context);
    messages = [];
    receiverNames = [];
    messageBloc!
      ..add(ResetMessageBlocEvent())
      ..add(FetchMessageHistoryEvent(patientId: widget.patientId));
  }

  goToMessage(MessageHelper message) {
    if (message.alreadySent) {
      messageBloc!.add(ShowEditSentMessageEvent(message: message.message!));
    } else {
      messageBloc!.add(ShowEditScheduledMessageEvent(message: message.scheduledMessage!));
    }
  }

  addMessage() {
    messageBloc!.add(ShowEditScheduledMessageEvent(
        message: MessageScheduleGetDTO(sendToType: widget.patientId.isEmpty ? MessageSendToType.ALL : MessageSendToType.ONE)));
  }

  getFormattedDateTime(String utcDateString) {
    DateTime utcDateTime = DateTime.utc(
      int.parse(utcDateString.substring(0, 4)), // Year
      int.parse(utcDateString.substring(5, 7)), // Month
      int.parse(utcDateString.substring(8, 10)), // Day
      int.parse(utcDateString.substring(11, 13)), // Hour
      int.parse(utcDateString.substring(14, 16)), // Minute
    );
    DateTime localDateTime = utcDateTime.toLocal();
    return DateFormat('dd.MM.yyyy, HH:mm').format(localDateTime);
  }

  sortColumn(int columnIndex, bool ascending) {
    setState(() {
      selectedColumn = columnIndex;
      isAscending = ascending;
    });
    sortMessages();
  }

  sortMessages() {
    if (selectedColumn == 0) {
      if (isAscending) {
        messages.sort((a, b) => a.sendDate.compareTo(b.sendDate));
      } else {
        messages.sort((a, b) => b.sendDate.compareTo(a.sendDate));
      }
    } else if (selectedColumn == 1) {
      if (isAscending) {
        messages.sort((a, b) => a.sendToText.compareTo(b.sendToText));
      } else {
        messages.sort((a, b) => b.sendToText.compareTo(a.sendToText));
      }
    } else if (selectedColumn == 2) {
      if (isAscending) {
        messages.sort((a, b) => a.subject.compareTo(b.subject));
      } else {
        messages.sort((a, b) => b.subject.compareTo(a.subject));
      }
    } else if (selectedColumn == 3) {
      if (isAscending) {
        messages.sort((a, b) => a.senderName.compareTo(b.senderName));
      } else {
        messages.sort((a, b) => b.senderName.compareTo(a.senderName));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ResponsiveBuilder(
      builder: (context, size) {
        return BlocConsumer<MessageBloc, MessageState>(
          listenWhen: (previous, state) {
            return true;
          },
          listener: (context, state) {
            if (state is UpdatedSentMessageState || state is UpdatedScheduledMessageState) {
              getSnackbar(context.i18n.updatedMessage, size.isMobile, context).show(context);
            } else if (state is DeletedSentMessageState || state is DeletedScheduledMessageState) {
              getSnackbar(context.i18n.deletedMessage, size.isMobile, context).show(context);
            } else if (state is AddedScheduledMessageState) {
              getSnackbar(context.i18n.addedMessage, size.isMobile, context).show(context);
            } else if (state is SentScheduledMessageState) {
              getSnackbar(context.i18n.sentMessage, size.isMobile, context).show(context);
            }
          },
          builder: (context, state) {
            bool showHistoryTable = state is FetchedMessageHistoryState || state is CanceledMessageEditState;
            return AptLayout(
                border: showHistoryTable,
                fixedHeight: showHistoryTable,
                breadCrumb: showHistoryTable
                    ? [
                        if (widget.patientId.isNotEmpty)
                          BreadCrumbItem(
                            content: TextButton(
                              key: Key(KEY_PATIENT_CALENDAR_BREAD_CRUMB_HEALTHCARE_PROFESSIONAL),
                              onPressed: () => context.beamToNamed("/patients"),
                              child: Text(
                                context.i18n.patientOverview,
                                style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        if (widget.patientId.isNotEmpty)
                          BreadCrumbItem(
                            content: TextButton(
                              child: Text(
                                patientName.isEmpty ? context.i18n.patient : patientName,
                                style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                              ),
                              onPressed: () => context.beamToNamed("/patients/${widget.patientId}/calendar"),
                            ),
                          ),
                        BreadCrumbItem(
                          content: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SelectableText(
                              context.i18n.messages,
                              style: getBreadCrumbStyle(context),
                            ),
                          ),
                        ),
                      ]
                    : [],
                addButton: showHistoryTable
                    ? RoundedIconButton(
                        key: Key(KEY_BUTTON_ADD),
                        title: context.i18n.addMessage,
                        callback: addMessage,
                      )
                    : null,
                subtitle: showHistoryTable
                    ? Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: infoIconColor,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: SelectableText(
                                widget.patientId.isEmpty ? context.i18n.messageHistoryHint : context.i18n.messageHistoryHintPatient,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.1, color: infoIconColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
                children: [
                  Builder(
                    builder: (context) {
                      if (state is EditSentMessageState) {
                        return ModifyPersonalMessageForm(
                          key: ValueKey(state),
                          patientId: widget.patientId,
                          message: state.message,
                          receiverNames: receiverNames,
                        );
                      } else if (state is EditScheduledMessageState) {
                        return ModifyPersonalMessageForm(
                          key: ValueKey(state),
                          patientId: widget.patientId,
                          scheduledMessage: state.message,
                          receiverNames: receiverNames,
                        );
                      } else if (state is CopyScheduledMessageState) {
                        return ModifyPersonalMessageForm(
                          key: ValueKey(state),
                          patientId: widget.patientId,
                          scheduledMessage: state.message,
                          receiverNames: receiverNames,
                          pictureFileDE: state.pictureFileDE,
                          pictureFileEN: state.pictureFileEN,
                        );
                      } else if (showHistoryTable) {
                        if (state is FetchedMessageHistoryState) {
                          messages = [
                            ...state.history.scheduledMessages.map((message) {
                              return MessageHelper(
                                sendDate: message.scheduleDateTime!,
                                sendToText: message.sendToType.getTranslatedText(patientName, context),
                                subject: getTranslatedText(message.subject, context),
                                senderName: message.senderName ?? "",
                                alreadySent: false,
                                scheduledMessage: message,
                                editable: message.senderId == userRepository.currentUser.id,
                              );
                            }),
                            ...state.history.sentMessages.map((message) {
                              return MessageHelper(
                                sendDate: message.sentDateTime!,
                                sendToText: message.sendToType.getTranslatedText(patientName, context),
                                subject: message.subject ?? "",
                                senderName: message.senderName ?? "",
                                alreadySent: true,
                                message: message,
                                editable: true,
                              );
                            })
                          ];
                          sortMessages();
                          receiverNames = state.receiverNames;
                        }
                        if (messages.isEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: height * 0.55,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SelectableText(
                                      context.i18n.noMessages,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: lightTextColor,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return DataTable(
                          showCheckboxColumn: false,
                          showBottomBorder: true,
                          sortAscending: isAscending,
                          sortColumnIndex: selectedColumn,
                          columns: [
                            AptDataColumn(
                              dataColoumnIndex: 0,
                              selectedColumnIndex: selectedColumn,
                              label: Text(
                                context.i18n.sendDate,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onSort: sortColumn,
                            ),
                            if (!size.isMobile)
                              AptDataColumn(
                                dataColoumnIndex: 1,
                                selectedColumnIndex: selectedColumn,
                                label: Text(
                                  context.i18n.recipients,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onSort: sortColumn,
                              ),
                            AptDataColumn(
                              dataColoumnIndex: 2,
                              selectedColumnIndex: selectedColumn + (size.isMobile ? 1 : 0),
                              label: Text(
                                context.i18n.subject,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onSort: sortColumn,
                            ),
                            if (!size.isMobile && userRepository.userRole != UserRole.HEALTHCARE_PROFESSIONAL)
                              AptDataColumn(
                                dataColoumnIndex: 3,
                                selectedColumnIndex: selectedColumn,
                                label: Text(
                                  context.i18n.createdBy,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onSort: sortColumn,
                              ),
                          ],
                          rows: messages
                              .map(
                                (message) => DataRow(
                                  onSelectChanged: message.editable ? (selected) => goToMessage(message) : null,
                                  color: WidgetStateProperty.resolveWith<Color?>(
                                    (Set<WidgetState> states) {
                                      if (message.alreadySent) return Theme.of(context).colorScheme.primary.withValues(alpha: 0.05);
                                      return null;
                                    },
                                  ),
                                  cells: [
                                    DataCell(
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              getFormattedDateTime(message.sendDate),
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!size.isMobile)
                                      DataCell(
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                message.sendToText,
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                              ),
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
                                              message.subject,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                            ),
                                          ),
                                          if (message.editable && (size.isMobile || userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL))
                                            IconButton(
                                              icon: Icon(Icons.arrow_forward_ios),
                                              onPressed: () => goToMessage(message),
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (!size.isMobile && userRepository.userRole != UserRole.HEALTHCARE_PROFESSIONAL)
                                      DataCell(
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                message.senderName,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                      letterSpacing: 1.1,
                                                    ),
                                              ),
                                            ),
                                            if (message.editable)
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios),
                                                onPressed: () => goToMessage(message),
                                              ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ]);
          },
        );
      },
    );
  }

  String get traceablePageName => "Message History Page";
}
