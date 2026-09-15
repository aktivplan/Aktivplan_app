// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/apt_route_preview.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PatientRecommendationListTile extends StatelessWidget {
  final DatahubResponseRecommendationsInner recommendation;
  final List<ActivityOverviewDTO> activities;
  final Color routeColor = const Color(0xFF0066FF);
//  static const String _debugSampleRouteGeoJson = '{"type":"LineString","coordinates":[[13.4050,52.5200],[13.4065,52.5202],[13.4090,52.5206]]}';
  final Function(DatahubResponseRecommendationsInner) onApplyRecommendation;
  final Function(DatahubResponseRecommendationsInner) onAddRecommendation;
  const PatientRecommendationListTile({
    Key? key,
    required this.recommendation,
    required this.activities,
    required this.onApplyRecommendation,
    required this.onAddRecommendation,
  }) : super(key: key);

  String _formatDescription(BuildContext context, String? description) {
    String toReturn = description ?? "";
    PredefinedActivityType.values.forEach((type) {
      toReturn = toReturn.replaceAll('\'${type.value}\'', '\'${type.getTranslatedText(context)}\'');
    });
    return toReturn;
  }

  void _showActionDialog(BuildContext context, DatahubResponseRecommendationsInner recommendation, Color colorToUse) {
    String actionText = "";
    String titleText = recommendation.reason != null ? recommendation.reason!.getTranslatedText(context) : context.i18n.apply;
    if (recommendation.type == RecommendationType.SPACE_TIME) {
      String activityName = "";
      final fittingActivities = activities.where((activity) => activity.activityId == recommendation.activityID);
      if (fittingActivities.isNotEmpty) {
        final activity = fittingActivities.first;
        if (activity.type == ActivityType.PREDEFINED_ACTIVITY || activity.type == ActivityType.PREDEFINED_ACTIVE_MOBILITY) {
          activityName = activity.activity?.predefinedActivity?.predefinedActivityType?.getTranslatedText(context) ?? "";
        } else {
          activityName = getTranslatedText(activity.name, context);
        }
      }

      if (recommendation.changeType == SpaceTimeRecommendationChangeType.TIME) {
        titleText = context.i18n.recommendationMoveActivity;
        String formattedTime = "";
        if (recommendation.timeStart != null) {
          final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
          formattedTime = dateFormat.format(recommendation.timeStart!);
        }
        actionText = context.i18n.recommendationMoveActivityToTime(activityName, formattedTime);
      } else if (recommendation.changeType == SpaceTimeRecommendationChangeType.SPACE) {
        final route = recommendation.route ?? recommendation.proposedRoute;
        titleText = context.i18n.recommendationMoveActivityToRoute(activityName, route?.locOriginAddr ?? "", route?.locDestinationAddr ?? "");
      } else {
        actionText = recommendation.description ?? "";
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(titleText),
          content: Text(actionText),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: getElevatedButtonStyle(context, backgroundColor: colorToUse),
                    onPressed: () {
                      this.onApplyRecommendation(recommendation);
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(context.i18n.apply.toUpperCase()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorToUse, width: 1),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      context.i18n.cancel.toUpperCase(),
                      style: TextStyle(color: colorToUse),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color colorToUse = primaryColor;
    IconData iconToUse = Icons.info;
    final showWarningBadge = recommendation.level == RecommendationLevel.WARNING;
    switch (recommendation.type) {
      case RecommendationType.ACTIVITY:
        colorToUse = predefinedActivityColor;
        iconToUse = ActivityType.PREDEFINED_ACTIVITY.iconData;
        break;
      case RecommendationType.GENERIC_CONTEXT:
        colorToUse = plannedTaskColor;
        iconToUse = Icons.info;
        break;
      case RecommendationType.SPACE_TIME:
        colorToUse = primaryColor;
        iconToUse = ActivityType.APPOINTMENT.iconData;
        break;
      case RecommendationType.MOBILITY:
        colorToUse = predefinedActiveMobilityColor;
        iconToUse = ActivityType.PREDEFINED_ACTIVE_MOBILITY.iconData;
        break;
    }

    if (recommendation.level == RecommendationLevel.WARNING) {
      colorToUse = errorColor;
    }

    RouteProposal? route = recommendation.route ?? recommendation.proposedRoute;
    final mapPreview = route != null ? AptRoutePreview(route: route) : null;

    Widget? trailingWidget;
    if (recommendation.type == RecommendationType.SPACE_TIME && recommendation.changeType != SpaceTimeRecommendationChangeType.NO_CHANGE) {
      trailingWidget = Padding(
        padding: EdgeInsets.only(right: 8),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorToUse.withValues(alpha: 0.1),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: colorToUse, size: 18),
            onPressed: () => _showActionDialog(context, recommendation, colorToUse),
          ),
        ),
      );
    } else if (recommendation.type == RecommendationType.MOBILITY || recommendation.type == RecommendationType.ACTIVITY) {
      trailingWidget = Padding(
        padding: EdgeInsets.only(right: 8),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorToUse.withValues(alpha: 0.1),
          ),
          child: IconButton(
            icon: Icon(Icons.add, color: colorToUse, size: 18),
            onPressed: () => this.onAddRecommendation(recommendation),
          ),
        ),
      );
    }

    String title = _formatDescription(context, recommendation.reasonDetail);

    if (recommendation.level == RecommendationLevel.WARNING && recommendation.timeFrom != null && recommendation.timeUntil != null) {
      final dateFormat = DateFormat('dd.MM.yyyy');
      final timeFormat = DateFormat('HH:mm');
      final startDate = dateFormat.format(recommendation.timeFrom!);
      final endDate = dateFormat.format(recommendation.timeUntil!);
      final startTime = timeFormat.format(recommendation.timeFrom!);
      final endTime = timeFormat.format(recommendation.timeUntil!);
      if (startDate == endDate) {
        title = context.i18n.recommendationWarningDay(recommendation.reasonDetail ?? '', startDate);
      } else {
        bool hideTime = startTime.startsWith('00:') && endTime.startsWith('23:');
        title = context.i18n.recommendationWarningDays(
            recommendation.reasonDetail ?? '', startDate + (hideTime ? '' : ' $startTime'), endDate + (hideTime ? '' : ' $endTime'));
      }
    }

    return Card(
      margin: EdgeInsets.zero,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: colorToUse, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 5),
            dense: true,
            title: SelectableText(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: recommendation.description != null
                ? SelectableLinkify(
                    text: _formatDescription(context, recommendation.description),
                    style: Theme.of(context).textTheme.titleSmall,
                    onOpen: (link) async {
                      if (await canLaunchUrlString(link.url)) {
                        String cleanedUrl = link.url;
                        if (cleanedUrl.endsWith("!")) {
                          cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                        }
                        launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                      }
                    },
                  )
                : null,
            leading: SizedBox(
              width: 38,
              height: 38,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: colorToUse,
                      radius: 18.0,
                      child: iconToUse == Icons.info
                          ? Text(
                              'i',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            )
                          : Icon(
                              iconToUse,
                              color: Colors.white,
                              size: 18.0,
                            ),
                    ),
                  ),
                  if (showWarningBadge)
                    Positioned(
                      left: -2,
                      top: -2,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            trailing: trailingWidget,
          ),
          if (mapPreview != null) ...[
            const SizedBox(height: 4),
            mapPreview,
          ],
        ],
      ),
    );
  }
}
