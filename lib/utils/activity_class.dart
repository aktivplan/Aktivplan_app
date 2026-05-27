import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/cupertino.dart';

class ActivityClass {
  final num id;
  final String description;
  final String frequency;
  final String duration;

  ActivityClass({
    required this.id,
    required this.description,
    required this.frequency,
    required this.duration,
  });
}

List<ActivityClass> getActivityDescription(BuildContext context) => [
      ActivityClass(
          id: 0,
          description: context.i18n.activityClass_0_description,
          frequency: context.i18n.activityClass_0_frequency,
          duration: context.i18n.activityClass_0_duration),
      ActivityClass(
          id: 1,
          description: context.i18n.activityClass_1_description,
          frequency: context.i18n.activityClass_1_frequency,
          duration: context.i18n.activityClass_1_duration),
      ActivityClass(
          id: 2,
          description: context.i18n.activityClass_2_description,
          frequency: context.i18n.activityClass_2_frequency,
          duration: context.i18n.activityClass_2_duration),
      ActivityClass(
          id: 3,
          description: context.i18n.activityClass_3_description,
          frequency: context.i18n.activityClass_3_frequency,
          duration: context.i18n.activityClass_3_duration),
      ActivityClass(
          id: 4,
          description: context.i18n.activityClass_4_description,
          frequency: context.i18n.activityClass_4_frequency,
          duration: context.i18n.activityClass_4_duration),
      ActivityClass(
          id: 5,
          description: context.i18n.activityClass_5_description,
          frequency: context.i18n.activityClass_5_frequency,
          duration: context.i18n.activityClass_5_duration),
      ActivityClass(
          id: 6,
          description: context.i18n.activityClass_6_description,
          frequency: context.i18n.activityClass_6_frequency,
          duration: context.i18n.activityClass_6_duration),
      ActivityClass(
          id: 7,
          description: context.i18n.activityClass_7_description,
          frequency: context.i18n.activityClass_7_frequency,
          duration: context.i18n.activityClass_7_duration),
      ActivityClass(
          id: 8,
          description: context.i18n.activityClass_8_description,
          frequency: context.i18n.activityClass_8_frequency,
          duration: context.i18n.activityClass_8_duration),
      ActivityClass(
          id: 9,
          description: context.i18n.activityClass_9_description,
          frequency: context.i18n.activityClass_9_frequency,
          duration: context.i18n.activityClass_9_duration),
      ActivityClass(
          id: 10,
          description: context.i18n.activityClass_10_description,
          frequency: context.i18n.activityClass_10_frequency,
          duration: context.i18n.activityClass_10_duration),
    ];
