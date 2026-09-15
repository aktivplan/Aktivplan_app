// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:convert';
import 'dart:js_interop';
import 'package:intl/intl.dart';
import 'package:web/web.dart' as web;

Future<void> downloadGpxFile(String gpxData) async {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd_HH-mm');
  final timestamp = formatter.format(now);
  final fileName = 'route_$timestamp.gpx';

  final bytes = utf8.encode(gpxData);
  final blob = web.Blob([bytes.toJS].toJS, web.BlobPropertyBag(type: 'application/gpx+xml'));
  final url = web.URL.createObjectURL(blob);
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = url;
  anchor.download = fileName;
  anchor.click();
  web.URL.revokeObjectURL(url);
}
