import 'package:aptapp/apt_scaffold.dart';
import 'package:aptapp/beamer/apt_beam_page.dart';
import 'package:aptapp/drawer/patient_drawer.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/utils/YouTubeFix.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/video/bloc/video_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrainingVideosPage extends StatefulWidget {
  TrainingVideosPage();

  @override
  _TrainingVideosPageState createState() => _TrainingVideosPageState();
}

class VideoEntry {
  final String name;
  final String id;
  final String url;
  VideoEntry(this.name, this.id, this.url);
}

class _TrainingVideosPageState extends State<TrainingVideosPage> with TraceablePageMixin {
  List<VideoEntry> videoList = [];
  List<YoutubePlayerController> playerControllers = [];
  YouTubeFix youTubeFix = YouTubeFix();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft, DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    kiwi.KiwiContainer().resolve<VideoRepository>().getVideoTemplates().then((templates) => {
          setState(() {
            videoList = templates!
                .map((e) => new VideoEntry(getTranslatedText(e.title, context), getYoutubeVideoIdByURL(getTranslatedText(e.youTubeLink, context)),
                    getTranslatedText(e.youTubeLink, context)))
                .toList();
            playerControllers = videoList
                .map((e) => YoutubePlayerController.fromVideoId(
                  videoId: e.id,
                    // initialVideoId: e.id,
                    params: YoutubePlayerParams(
                      // autoPlay: false,
                      // desktopMode: true,
                      showFullscreenButton: true,
                    )))
                .toList();
          })
        });
  }

  @override
  void dispose() {
    playerControllers.forEach((element) {
      element.close();
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Widget videoWidget(width, height, size) {
    List<Widget> list = [];
    for (var i = 0; i < videoList.length; ++i) {
      list.add(
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 4),
            width: size.isMobile
                ? width * 0.8
                : size.isTablet
                    ? width * 0.85
                    : width * 0.5,
            child: SelectableText(videoList[i].name, style: Theme.of(context).textTheme.titleMedium),
          ),
        ]),
      );
      if (!kIsWeb)
        list.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 4),
                width: size.isMobile
                    ? width * 0.8
                    : size.isTablet
                        ? width * 0.85
                        : width * 0.5,
                child: InkWell(
                  onTap: () {
                    launchUrlString(videoList[i].url, mode: LaunchMode.externalApplication);
                  },
                  child: Text(
                    "Fullscreen: YouTube-Link >",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        );
      list.add(
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.only(top: 4),
            width: size.isMobile
                ? width * 0.8
                : size.isTablet
                    ? width * 0.85
                    : width * 0.5,
            child: YoutubePlayer(
              controller: playerControllers[i],
              gestureRecognizers: [
                Factory<OneSequenceGestureRecognizer>(
                  () => VideoDragGestureRecognizer(),
                ),
              ].toSet(),
            ),
          )
        ]),
      );
    }
    return Wrap(children: list);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AptScaffold(
      drawerStateChanged: (value) {
        if (!kIsWeb) {
          return;
        }
        // see https://github.com/sarbagyastha/youtube_player_flutter/issues/338
        if (value) {
          youTubeFix.fixYoutubeOnOverlayShow();
        } else {
          youTubeFix.fixYoutubeOnOverlayHide();
        }
      },
      drawer: PatientDrawer(drawerHeader: AptBeamPage.getDrawerHeader(context)),
      body: ResponsiveBuilder(
        builder: (context, size) {
          return SingleChildScrollView(child: Container(padding: EdgeInsets.symmetric(vertical: 10), child: videoWidget(width, height, size)));
        },
      ),
    );
  }

  String get traceablePageName => "Training Videos Page";
}

class VideoDragGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  bool isPointerAllowed(PointerEvent event) {
    return false;
  }
}
