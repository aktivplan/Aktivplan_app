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
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/video/bloc/video_bloc.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:reorderables/reorderables.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VideoTemplatesOverviewPage extends StatefulWidget {
  VideoTemplatesOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _VideoTemplatesOverviewPageState createState() => _VideoTemplatesOverviewPageState();
}

class _VideoTemplatesOverviewPageState extends State<VideoTemplatesOverviewPage> with TraceablePageMixin {
  bool isAscending = true;
  int selectedColumn = 0;
  bool isHome = true;
  List<VideoTemplateDTO> videoTemplates = [];
  VideoBloc? videoBloc;

  goToTemplate(VideoTemplateDTO template) {
    context.beamToNamed('/video-templates/${template.id}', data: {"template": template});
  }

  addMessage() {
    context.beamToNamed('/video-templates/add', beamBackOnPop: true);
  }

  @override
  void initState() {
    super.initState();
    videoBloc = BlocProvider.of<VideoBloc>(context);
    videoBloc!.add(FetchVideoTemplatesEvent());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(
      builder: (context, size) {
        double paddingHorizontal = size.isDesktop
            ? width * 0.05
            : size.isTablet
                ? width * 0.01
                : width * 0.02;
        double innerWidth = width - paddingHorizontal * 2;
        return BlocConsumer<VideoBloc, VideoState>(
          listenWhen: (previous, state) {
            return true;
          },
          listener: (context, state) {
            var snackBar;
            if (state is AddedVideoTemplateState) {
              snackBar = getSnackbar(context.i18n.addedVideo, size.isMobile, context);
            } else if (state is UpdatedVideoTemplateState) {
              snackBar = getSnackbar(context.i18n.updatedVideo, size.isMobile, context);
            } else if (state is DeletedVideoTemplateState) {
              snackBar = getSnackbar(context.i18n.deletedVideo, size.isMobile, context);
            }
            if (snackBar != null) {
              snackBar.show(context);
              snackBar = null;
            }
          },
          builder: (context, state) {
            return AptLayout(
              key: Key(KEY_VIDEO_TEMPLATE_OVERVIEW_SCROLL_VIEW),
              spacing: 15,
              addButton: RoundedIconButton(
                key: Key(KEY_BUTTON_ADD),
                title: context.i18n.addVideo,
                callback: addMessage,
              ),
              breadCrumb: <BreadCrumbItem>[
                BreadCrumbItem(
                  content: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SelectableText(
                      context.i18n.themeVideos,
                      style: getBreadCrumbStyle(context),
                    ),
                  ),
                ),
              ],
              children: [
                Builder(
                  builder: (context) {
                    if (state is FetchedVideoTemplatesState || state is OrderedVideoTemplatesState) {
                      if (state is FetchedVideoTemplatesState) {
                        videoTemplates = state.templates;
                      }
                      if (videoTemplates.isNotEmpty)
                        return ReorderableTable(
                          needsLongPressDraggable: size.isMobile,
                          ignorePrimaryScrollController: true,
                          border: TableBorder(
                              bottom: BorderSide(color: datatableBorderColor), left: BorderSide.none, right: BorderSide.none, top: BorderSide.none),
                          borderColor: datatableBorderColor,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              var temp = videoTemplates[oldIndex];
                              videoTemplates[oldIndex] = videoTemplates[newIndex];
                              videoTemplates[newIndex] = temp;
                            });
                            videoBloc!.add(UpdateVideoTemplatesOrderingEvent(orderedIds: videoTemplates.map((e) => e.id!).toList()));
                          },
                          header: ReorderableTableRow(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            tableRowPadding(
                              child: Text(
                                context.i18n.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (!size.isMobile)
                              tableRowPadding(
                                child: Text(
                                  context.i18n.youTubeUrl,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ]),
                          children: videoTemplates
                              .map(
                                (template) => ReorderableTableRow(
                                  key: Key(template.id.toString()),
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: innerWidth * (size.isMobile ? 0.95 : 0.6),
                                      child: tableRowPadding(
                                        child: Row(
                                          children: [
                                            Icon(Icons.menu),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                getTranslatedText(template.title, context),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                              ),
                                            ),
                                            if (size.isMobile)
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () => goToTemplate(template),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (!size.isMobile)
                                      Container(
                                        width: innerWidth * 0.35,
                                        child: tableRowPadding(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  getTranslatedText(template.youTubeLink, context),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                        letterSpacing: 1.1,
                                                      ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () => goToTemplate(template),
                                              ),
                                            ],
                                          ),
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
                                    context.i18n.noVideos,
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

  String get traceablePageName => "Video Overview Page";
}
