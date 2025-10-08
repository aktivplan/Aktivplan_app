// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
