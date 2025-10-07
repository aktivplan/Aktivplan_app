import 'dart:js' as js;

import 'package:aptapp/utils/YouTubeFix.dart';

class YouTubeFixWeb implements YouTubeFix {
  void fixYoutubeOnOverlayShow() {
    try {
      String jsCode = '''
              var iframes = document.getElementsByTagName("iframe"); 
              for(var i = 0; i < iframes.length; i++) { 
                 iframes[i].style.pointerEvents = "none";
              } 
          ''';
      js.context.callMethod("eval", [jsCode]);
    } catch (e) {
      print('Error _fixYoutubeOnWeb: $e');
    }
  }

  void fixYoutubeOnOverlayHide() {
    try {
      String jsCode = '''
              var iframes = document.getElementsByTagName("iframe"); 
              for(var i = 0; i < iframes.length; i++) { 
                 iframes[i].style.pointerEvents = "auto";
              } 
          ''';
      js.context.callMethod("eval", [jsCode]);
    } catch (e) {
      print('Error _fixYoutubeOnWeb: $e');
    }
  }
}

YouTubeFix getYouTubeFix() => YouTubeFixWeb();
