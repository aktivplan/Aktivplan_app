import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

const int MINUTES_TO_SECONDS = 60;
const double TO_PERCENT = 100;

final DateFormat germanDateFormat = DateFormat("dd.MM.yyyy");
final DateFormat englishDateFormat = DateFormat("yyyy-MM-dd");

Widget tableRowPadding({required Widget child}) {
  return Padding(
    child: child,
    padding: const EdgeInsets.all(8),
  );
}

bool doShowDrawer(SizingInformation size) {
  return size.screenSize.width < 1400 || userRepository.userRole == UserRole.PATIENT;
}

String getYoutubeVideoIdByURL(String url, {Map<String, String>? map}) {
  if (url.startsWith("https://youtu.be/")) {
    String id = url.replaceFirst("https://youtu.be/", "").replaceAll("/", "");
    if (map != null) {
      map[id] = url;
    }
    return id;
  }
  final regex = RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false);
  try {
    if (regex.hasMatch(url)) {
      String id = regex.firstMatch(url)?.group(1)?.trim() ?? "";
      if (map != null) {
        map[id] = url;
      }
      return id;
    }
  } catch (e) {
    return "";
  }
  return "";
}
