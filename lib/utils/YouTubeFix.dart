import 'YouTubeFixMobile.dart' if (dart.library.html) 'YouTubeFixWeb.dart';

abstract class YouTubeFix {
  void fixYoutubeOnOverlayShow();

  void fixYoutubeOnOverlayHide();

  factory YouTubeFix() => getYouTubeFix();
}
