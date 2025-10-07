import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/social/edit_story_buttons.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_presenter/flutter_story_presenter.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserStoryPage extends StatefulWidget {
  final String userId;
  final String? profilePicture;
  final String fullName;

  UserStoryPage({Key? key, required this.userId, required this.fullName, required this.profilePicture}) : super(key: key);

  @override
  _UserStoryPageState createState() => _UserStoryPageState();
}

class _UserStoryPageState extends State<UserStoryPage> with TraceablePageMixin, WidgetsBindingObserver {
  SocialBloc? socialBloc;
  int currentMinutes = 0;
  bool isMyStory = false;

  final UserRepository userRepository = KiwiContainer().resolve<UserRepository>();

  @override
  void initState() {
    super.initState();
    socialBloc = BlocProvider.of<SocialBloc>(context);
    socialBloc!.add(FetchStoryEvent(userId: widget.userId));
  }

  final ValueNotifier<int> currentMinutesNotifier = ValueNotifier<int>(0);
  final ValueNotifier<String> filesIdNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [];
    isMyStory = userRepository.currentUser?.id == widget.userId;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: ResponsiveBuilder(
        builder: (context, size) {
          return Container(
            padding: EdgeInsets.all(0),
            alignment: Alignment.topCenter,
            width: width,
            height: double.infinity,
            child: BlocConsumer<SocialBloc, SocialState>(listener: (context, state) {
              var snackBar;
              // INFO refetch story items after removing one
              // INFO shows snackbar here when it comes from dialog
              if (state is RemovedStoryItemState) {
                snackBar = getSnackbar(state.success ? context.i18n.postedItemRemoved : context.i18n.postedItemRemovedError, size.isMobile, context,
                    error: !state.success);
              } else if (state is PostedStoryMessageState || state is PostedStoryImagesState) {
                var success = (state as PostedStoryMessageState).success || (state as PostedStoryImagesState).success;
                snackBar = getSnackbar(success ? context.i18n.postedStatusMessage : context.i18n.postedStatusMessageError, size.isMobile, context,
                    error: !success);
              }

              if (state is FetchedStoryState && state.statusFiles.isEmpty) {
                context.beamToNamed('/contacts', replaceRouteInformation: true);
              }

              if (snackBar != null) {
                snackBar.show(context);
                snackBar = null;
                socialBloc!.add(FetchStoryEvent(userId: widget.userId));
              }
            }, builder: (context, state) {
              if (state is FetchedStoryState && state.statusFiles.isNotEmpty) {
                var items = (state).statusFiles;
                var result = _getStoryItems(items);
                storyItems = result[0];

                if (storyItems.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                FlutterStoryController controller = FlutterStoryController();
                var lastSeenIndex = result[1];
                // INFO is lastSeenIndex is the last story item jump to start
                if (lastSeenIndex + 1 == storyItems.length) {
                  lastSeenIndex = -1;
                }
                return FlutterStoryPresenter(
                  items: storyItems,
                  initialIndex: lastSeenIndex + 1,
                  flutterStoryController: controller,
                  onStoryChanged: (idx) {
                    currentMinutesNotifier.value = items[idx].ageInMinutes!;
                    var item = items[idx];
                    filesIdNotifier.value = item.id!;
                    if (item.seenByUser == null || item.seenByUser == false) {
                      socialBloc!.add(MarkStoryItemAsSeenEvent(fileId: items[idx].id!));
                    }
                  },
                  onCompleted: () async {
                    context.beamBack();
                  },
                  onRightTap: () {
                    controller.next();
                  },
                  onLeftTap: () {
                    controller.previous();
                  },
                  onSlideDown: (p0) {
                    controller.pause();
                  },
                  headerWidget: _buildProfileView(context),
                  footerWidget: isMyStory
                      ? ValueListenableBuilder<String>(
                          valueListenable: filesIdNotifier,
                          builder: (context, statusFileId, child) {
                            return EditStoryButtons(
                              storyController: controller,
                              statusFileId: statusFileId,
                            );
                          },
                        )
                      : null,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          );
        },
      ),
    );
  }

  _getPostingTime(
    int ageInMinutes,
    BuildContext context,
  ) {
    if (ageInMinutes > 60) {
      return "${(ageInMinutes / 60).round()} ${context.i18n.postedHoursAgo}";
    } else {
      return "${ageInMinutes} ${context.i18n.postedMinutesAgo}";
    }
  }

  Widget _buildProfileView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.profilePicture != null && widget.profilePicture != ''
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.profilePicture!),
                )
              : Icon(Icons.account_circle, color: Colors.grey, size: 56),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.fullName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                ValueListenableBuilder<int>(
                    valueListenable: currentMinutesNotifier,
                    builder: (context, currentMinutes, child) {
                      return Text(
                        _getPostingTime(currentMinutes, context),
                        style: TextStyle(
                          color: Colors.white38,
                        ),
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  _getStoryItems(List<StatusFileDTO> files) {
    List<StoryItem> storyItems = [];
    int lastSeenIndex = -1;
    for (int idx = 0; idx < files.length; idx++) {
      final file = files[idx];
      if (file.seenByUser != null && file.seenByUser == true) {
        lastSeenIndex = idx;
      }
      if (file.fileType == StatusFileType.PICTURE && file.file?.exists == true) {
        storyItems.add(
          StoryItem(
              url: file.file?.url ?? '',
              duration: const Duration(seconds: 5),
              storyItemType: StoryItemType.image,
              textConfig: StoryViewTextConfig(
                backgroundColor: primaryColor,
              ),
              imageConfig: StoryViewImageConfig(
                fit: BoxFit.fitWidth,
                progressIndicatorBuilder: (p0, p1, p2) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
        );
      } else if (file.fileType == StatusFileType.TEXT) {
        storyItems.add(
          StoryItem(
            url: file.statusText ?? '',
            storyItemType: StoryItemType.text,
            duration: const Duration(seconds: 5),
            textConfig: StoryViewTextConfig(
              backgroundColor: primaryColor,
              textWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  file.statusText ?? '',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    ;
    return [storyItems, lastSeenIndex];
  }

  String get traceablePageName => "Story View Page";
}
