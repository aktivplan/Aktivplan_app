import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

const int MINUTES_TO_SECONDS = 60;
const double TO_PERCENT = 100;
const String SYSTEM_CREATED = "system";

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

String getActivityName(ActivityOverviewDTO activity, BuildContext context) {
  final String translatedName = getTranslatedText(activity.name, context);
  if (activity.type != ActivityType.PREDEFINED_ACTIVITY && activity.type != ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
    return translatedName;
  }
  if (translatedName.isNotEmpty) {
    return translatedName;
  }
  return activity.activity?.predefinedActivity?.predefinedActivityType?.getTranslatedText(context) ?? "";
}

String getFormattedDurationLine(int minutes, bool isKlimafit, BuildContext context) {
  if (isKlimafit) {
    return "$minutes ${context.i18n.activeMinutesKlimafit}";
  }

  final String durationLabel = "${context.i18n.duration}:";
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  if (hours == 0) {
    return '$durationLabel ${mins}min';
  } else if (mins == 0) {
    return '$durationLabel ${hours}h';
  } else {
    return '$durationLabel ${hours}h ${mins}min';
  }
}
