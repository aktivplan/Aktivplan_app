import 'package:aptapp/utils/YouTubeFix.dart';

class YouTubeFixMobile implements YouTubeFix {
  void fixYoutubeOnOverlayShow() {}
  void fixYoutubeOnOverlayHide() {}
}

YouTubeFix getYouTubeFix() => YouTubeFixMobile();
