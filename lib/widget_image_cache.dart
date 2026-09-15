// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class WidgetImageCache {
  /// Attempts to download [url] and store it as [filename] in the temporary
  /// directory. Returns the local file path on success or if a cached file
  /// already exists. Returns null if neither is available.
  static Future<String?> fetchAndCache(String url, String filename) async {
    try {
      final uri = Uri.parse(url);
      final resp = await http.get(uri);
      if (resp.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/$filename');
        await file.writeAsBytes(resp.bodyBytes, flush: true);
        return file.path;
      }
    } catch (_) {
      // ignore network / parse errors and fallthrough to cache check
    }

    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$filename');
      if (await file.exists()) return file.path;
    } catch (_) {}

    return null;
  }
}
