import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/app_localizations_de.dart';
import 'package:aptapp/l10n/app_localizations_en.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/push_notifications_manager.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with TraceablePageMixin, WidgetsBindingObserver {
  ScrollController _scrollController = ScrollController();
  Map<String, FileGetDTO> pictures = {};
  final messageApi = new MessageControllerApi(apiClient);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    PushNotificationsManager().setReceivedNotification(false);
    SharedPreferences.getInstance().then((value) => value.setBool("receivedNotification", false));
    BlocProvider.of<MessageBloc>(context)..add(FetchMessagesEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<MessageBloc>(context)..add(FetchMessagesEvent());
    }
  }

  void getMessagePictures(final MessageOverviewDTO messages) async {
    [...messages.unreadMessages, ...messages.readMessages].forEach((message) {
      if ((message.pictureId ?? "").isNotEmpty && !pictures.containsKey(message.pictureId!)) {
        messageApi.getMessagePicture(message.type!, message.pictureId!).then((value) {
          setState(() {
            pictures[message.pictureId!] = value!;
          });
        });
      }
    });
  }

  Widget renderMessage(MessageDTO message) {
    final bool showSenderName =
        message.type!.value.startsWith('REMIND') || message.type == MessageType.PERSONAL || message.type == MessageType.SOCIAL;
    String subjectText = message.subject ?? "";
    if (message.type == MessageType.ACHIEVED_ACTIVE_MINUTES || message.type == MessageType.ACHIEVED_GOAL) {
      subjectText =
          message.language == TranslationLanguage.DE ? AppLocalizationsDe().achievedActivityShort : AppLocalizationsEn().achievedActivityShort;
    } else if (message.type == MessageType.REMIND_ACTIVITY) {
      subjectText = message.language == TranslationLanguage.DE ? AppLocalizationsDe().reminderActivity : AppLocalizationsEn().reminderActivity;
    } else if (message.type == MessageType.ACHIEVED_REMAINING_ACTIVE_MINUTES) {
      subjectText = message.language == TranslationLanguage.DE ? AppLocalizationsDe().yourWeeklyGoal : AppLocalizationsEn().yourWeeklyGoal;
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, right: 15),
              child: Icon(
                Icons.circle,
                size: 10,
                color: message.type == MessageType.INFORMATION
                    ? extraActivityColor
                    : message.type!.value.startsWith('ACHIEVED') ||
                            message.type == MessageType.REMIND_GOAL ||
                            message.type == MessageType.REMIND_GOAL_MULTIPLE
                        ? goalColor
                        : accentColor,
              ),
            ),
            Flexible(
              child: SelectableText(subjectText.isNotEmpty ? subjectText : (message.text ?? ""),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, height: 1.5)),
            ),
          ],
        ),
        if (pictures.containsKey(message.pictureId ?? "") && (pictures[message.pictureId]!.exists ?? false))
          Padding(
            padding: EdgeInsets.only(top: 5, left: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.network(
                pictures[message.pictureId]!.url ?? "",
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(height: 5),
        if (subjectText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: Row(
              children: [
                SizedBox(width: 25),
                Flexible(
                  child: SelectableLinkify(
                    text: message.text ?? "",
                    onOpen: (link) async {
                      if (await canLaunchUrlString(link.url)) {
                        String cleanedUrl = link.url;
                        if (cleanedUrl.endsWith("!")) {
                          cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                        }
                        launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        Row(
          children: [
            SizedBox(width: 25),
            SelectableText(germanDateFormat.format(DateTime.parse(message.sendDate!)) + (showSenderName ? ',' : ''),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: infoIconColor)),
            // TODO no link to profile when bool not set
            if (showSenderName)
              TextButton(
                style: TextButton.styleFrom(minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () {
                  context.beamToNamed(
                      message.type == MessageType.SOCIAL ? '/contacts/${message.senderId}' : '/my-healthcare-professional/${message.senderId}');
                },
                child: Text(message.senderName ?? "",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.normal,
                          color: infoIconColor,
                        )),
              )
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.i18n.notifications,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            key: Key(KEY_BUTTON_CLOSE),
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              BlocProvider.of<MessageBloc>(context)..add(MarkMessagesReadEvent());
              context.beamToNamed("/calendar");
            },
          ),
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ResponsiveBuilder(
            builder: (context, size) {
              final double containerWidth = size.isMobile ? width * 0.8 : width * 0.5;
              return Center(
                heightFactor: 1.1,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Container(
                      padding: EdgeInsets.only(top: size.isMobile ? 30 : 80),
                      width: containerWidth,
                      child: BlocBuilder<MessageBloc, MessageState>(
                        builder: (context, state) {
                          if (state is FetchedMessagesState) {
                            getMessagePictures(state.messages);
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: containerWidth,
                                    padding: EdgeInsets.only(bottom: 5),
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: accentColor))),
                                    child: SelectableText(context.i18n.newValue,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                  ),
                                  for (var message in state.messages.unreadMessages) renderMessage(message),
                                  if (state.messages.unreadMessages.length == 0)
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: SelectableText(
                                        context.i18n.noNewNotifications,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: lightTextColor,
                                            ),
                                      ),
                                    ),
                                  Container(
                                    width: containerWidth,
                                    padding: EdgeInsets.only(top: 30, bottom: 5),
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: accentColor))),
                                    child: SelectableText(context.i18n.older,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                  ),
                                  for (var message in state.messages.readMessages
                                      .sublist(0, state.messages.readMessages.length > 50 ? 50 : state.messages.readMessages.length))
                                    renderMessage(message),
                                ],
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String get traceablePageName => "Messages Page";
}
