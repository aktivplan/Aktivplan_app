// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/push_notifications_manager.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageButton extends StatefulWidget {
  @override
  _MessageButtonState createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {
  int messageCount = 0;

  @override
  void initState() {
    super.initState();
    MessageBloc messageBloc = BlocProvider.of<MessageBloc>(context);
    PushNotificationsManager().setMessageBloc(messageBloc);
    messageBloc..add(FetchMessageCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      if (state is FetchedMessageCountState) {
        messageCount = state.count.unreadMessages ?? 0;
      }
      double size = messageCount < 10 ? 16 : 20;
      double fontSize = messageCount < 10 ? 12 : 13;

      return Padding(
        padding: EdgeInsets.only(right: 5),
        child: Align(
          alignment: Alignment.center,
          child: Stack(children: [
            IconButton(
              key: Key(KEY_BUTTON_NOTIFICATIONS),
              icon: Icon(Icons.notifications),
              onPressed: () {
                context.beamToNamed("/personal-messages");
              },
            ),
            if (messageCount > 0)
              Positioned(
                right: 3,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(size / 2),
                  ),
                  constraints: BoxConstraints(
                    minWidth: size + 1,
                    minHeight: size,
                  ),
                  child: new Text(
                    '$messageCount',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ]),
        ),
      );
    });
  }
}
