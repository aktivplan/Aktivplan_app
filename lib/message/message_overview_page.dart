// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/message/bloc/message_bloc.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MessageOverviewPage extends StatefulWidget {
  MessageOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _MessageOverviewPageState createState() => _MessageOverviewPageState();
}

class _MessageOverviewPageState extends State<MessageOverviewPage> with TraceablePageMixin {
  bool isAscending = true;
  int selectedColumn = 0;
  bool isHome = true;
  List<MessageTemplateDTO> messageTemplates = [];

  sortColumn(int columnIndex, bool ascending, bool numeric) {
    setState(() {
      isAscending = ascending;
      selectedColumn = columnIndex;
    });
    if (columnIndex == 1) {
      if (ascending) {
        messageTemplates.sort((a, b) => getTranslatedText(a.text, context).toLowerCase().compareTo(getTranslatedText(b.text, context).toLowerCase()));
      } else {
        messageTemplates.sort((a, b) => getTranslatedText(b.text, context).toLowerCase().compareTo(getTranslatedText(a.text, context).toLowerCase()));
      }
    } else {
      if (ascending) {
        messageTemplates
            .sort((a, b) => getTranslatedText(a.title, context).toLowerCase().compareTo(getTranslatedText(b.title, context).toLowerCase()));
      } else {
        messageTemplates
            .sort((a, b) => getTranslatedText(b.title, context).toLowerCase().compareTo(getTranslatedText(a.title, context).toLowerCase()));
      }
    }
  }

  goToMessage(MessageTemplateDTO template) {
    context.beamToNamed('/messages/${template.id}', data: {"message": template});
  }

  addMessage() {
    context.beamToNamed('/messages/add', beamBackOnPop: true);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageBloc>(context)..add(FetchMessageTemplatesEvent());
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
            var snackBar;
            if (state is AddedMessageTemplateState) {
              snackBar = getSnackbar(context.i18n.addedMessage, size.isMobile, context);
            } else if (state is UpdatedMessageTemplateState) {
              snackBar = getSnackbar(context.i18n.updatedMessage, size.isMobile, context);
            } else if (state is DeletedMessageTemplateState) {
              snackBar = getSnackbar(context.i18n.deletedMessage, size.isMobile, context);
            }
            if (snackBar != null) {
              snackBar.show(context);
              snackBar = null;
            }
          },
          builder: (context, state) {
            return AptLayout(
              key: Key(KEY_MESSAGE_OVERVIEW_SCROLL_VIEW),
              spacing: 15,
              addButton: RoundedIconButton(
                key: Key(KEY_BUTTON_ADD),
                title: context.i18n.addMessage,
                callback: addMessage,
              ),
              breadCrumb: <BreadCrumbItem>[
                BreadCrumbItem(
                  content: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SelectableText(
                      context.i18n.tipsAndInfos,
                      style: getBreadCrumbStyle(context),
                    ),
                  ),
                ),
              ],
              subtitle: Padding(
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
                        context.i18n.messagesHint,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.1, color: infoIconColor),
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                Builder(
                  builder: (context) {
                    if (state is FetchedMessageTemplatesState) {
                      messageTemplates = state.messages;
                      if (messageTemplates.isNotEmpty)
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
                                context.i18n.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending, false);
                              },
                            ),
                            if (!size.isMobile)
                              AptDataColumn(
                                dataColoumnIndex: 1,
                                selectedColumnIndex: selectedColumn,
                                label: Text(
                                  context.i18n.content,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onSort: (columnIndex, ascending) {
                                  sortColumn(columnIndex, ascending, false);
                                },
                              )
                          ],
                          rows: messageTemplates
                              .map(
                                (message) => DataRow(
                                  onSelectChanged: (selected) => goToMessage(message),
                                  cells: [
                                    DataCell(
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              getTranslatedText(message.title, context),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                            ),
                                          ),
                                          if (size.isMobile)
                                            IconButton(
                                              icon: Icon(Icons.arrow_forward_ios),
                                              onPressed: () => goToMessage(message),
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
                                                getTranslatedText(message.text, context),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                      letterSpacing: 1.1,
                                                    ),
                                              ),
                                            ),
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
                      else
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
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  String get traceablePageName => "Message Overview Page";
}
