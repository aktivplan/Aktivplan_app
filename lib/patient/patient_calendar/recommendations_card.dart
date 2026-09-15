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
import 'package:aptapp/patient/patient_calendar/patient_recommendation_list.dart';
import 'package:flutter/material.dart';

class RecommendationsCard extends StatelessWidget {
  final List<DatahubResponseRecommendationsInner> recommendations;
  final List<ActivityOverviewDTO> activities;
  final String patientId;
  final Function(DatahubResponseRecommendationsInner) onAddActivity;
  final bool loading;

  RecommendationsCard({
    Key? key,
    required this.recommendations,
    required this.activities,
    required this.patientId,
    required this.onAddActivity,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(side: BorderSide(color: datatableBorderColor), borderRadius: BorderRadius.all(Radius.circular(6))),
          semanticContainer: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 6),
                child: Row(
                  children: [
                    SelectableText(
                      context.i18n.recommendations,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: lightTextColor,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: PatientRecommendationList(
                      recommendations: recommendations,
                      activities: activities,
                      patientId: patientId,
                      showHeader: false,
                      loading: loading,
                      onAddActivity: onAddActivity,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
