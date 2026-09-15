// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/patient_calendar/patient_recommendation_list_tile.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/exercise_time_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PatientRecommendationList extends StatefulWidget {
  final List<ActivityOverviewDTO> activities;
  final List<DatahubResponseRecommendationsInner> recommendations;
  final String patientId;
  final bool showHeader;
  final bool loading;
  final Function(DatahubResponseRecommendationsInner) onAddActivity;

  PatientRecommendationList({
    Key? key,
    required this.recommendations,
    required this.activities,
    required this.patientId,
    required this.onAddActivity,
    required this.loading,
    this.showHeader = true,
  }) : super(key: key);

  @override
  _PatientRecommendationListState createState() => _PatientRecommendationListState();
}

class _PatientRecommendationListState extends State<PatientRecommendationList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.showHeader)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SelectableText(
              context.i18n.recommendations,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        if (widget.recommendations.isNotEmpty)
          ...widget.recommendations.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: PatientRecommendationListTile(
                recommendation: item,
                activities: widget.activities,
                onApplyRecommendation: (recommendation) {
                  if (recommendation.type == RecommendationType.SPACE_TIME && recommendation.timeStart != null) {
                    final date = englishDateFormat.format(recommendation.timeStart!);
                    final existingActivity =
                        widget.activities.where((activity) => activity.activityId == recommendation.activityID && activity.date == date).firstOrNull;
                    if (existingActivity != null) {
                      final timeFormat = DateFormat('HH:mm');
                      final activityBloc = BlocProvider.of<ActivityBloc>(context);
                      final rating = existingActivity.rating != null ? existingActivity.rating! : ActivityPatientRatingPostDTO();
                      rating.date = date;
                      rating.time = timeFormat.format(recommendation.timeStart!);
                      rating.endTime = recommendation.timeEnd != null ? timeFormat.format(recommendation.timeEnd!) : null;
                      if ((rating.time ?? "").isNotEmpty && (rating.endTime ?? "").isNotEmpty) {
                        rating.durationMinutes = ExerciseTypeTimeData.calculateMinutesBetween(
                            startTime: rating.time!, endTime: rating.endTime!, rating: rating.rating?.toDouble());
                      }
                      final route = recommendation.route ?? recommendation.proposedRoute;
                      if (recommendation.changeType == SpaceTimeRecommendationChangeType.SPACE && route != null) {
                        rating.startLocation = route.locOrigin;
                        rating.startLocationAddress = route.locOriginAddr;
                        rating.endLocation = route.locDestination;
                        rating.endLocationAddress = route.locDestinationAddr;
                        rating.routeProposal = route;
                      }
                      activityBloc.add(UpdateActivityRatingEvent(
                          activityType: existingActivity.type!,
                          rating: rating,
                          id: existingActivity.activityId!,
                          date: date,
                          patientId: widget.patientId));
                    }
                  }
                },
                onAddRecommendation: (recommendation) => widget.onAddActivity(recommendation),
              ),
            );
          }).toList(),
        if (widget.recommendations.isEmpty && !widget.loading)
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              title: Center(
                child: SelectableText(
                  context.i18n.noRecommendations,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        if (widget.loading)
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
