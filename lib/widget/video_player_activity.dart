// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:math' as math;

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/video_player_preview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayerActivity extends StatefulWidget {
  final ActivityOverviewDTO activity;
  final Function(Map<int, int>) updateExerciseToVideoIndex;
  final int initialVideoIndex;

  const VideoPlayerActivity({
    Key? key,
    required this.activity,
    required this.updateExerciseToVideoIndex,
    this.initialVideoIndex = 0,
  }) : super(key: key);

  @override
  State<VideoPlayerActivity> createState() => _VideoPlayerActivityState();
}

class _VideoPlayerActivityState extends State<VideoPlayerActivity> {
  Map<int, int> workoutExerciseIndexToVideoSourceIndex = {};
  List<String> videoSources = [];
  List<int> pauseIndizes = [];
  final FileControllerApi fileControllerApi = FileControllerApi(apiClient);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      loadVideoSources();
    });
  }

  loadVideoSources() {
    final List<String> fileKeys = [];
    workoutExerciseIndexToVideoSourceIndex = {};
    final Set<int> allPauseIndizes = {0};
    if (widget.activity.activity?.videoFileKey?.isNotEmpty ?? false) {
      if (widget.activity.type != ActivityType.STRENGTHENING && widget.activity.type != ActivityType.HYPERTROPHY) {
        fileKeys.add(widget.activity.activity!.videoFileKey!);
      } else {
        fileKeys.addAll(getFileKeysForStrengtheningAndHypertrophy(widget.activity.activity!.strengtheningExercise!));
      }
      allPauseIndizes.add(fileKeys.length);
    }
    if (widget.activity.type == ActivityType.WORKOUT) {
      final videoWaitBetweenExercisesSeconds = widget.activity.activity!.workout!.videoWaitBetweenExercisesSeconds ?? 0;
      final waitTimeText = widget.activity.activity!.workout!.waitTimeText ?? "";
      final workoutExercises = widget.activity.activity!.workout!.exercises;
      for (int i = 0; i < workoutExercises.length; i++) {
        final exercise = workoutExercises[i];
        if (videoWaitBetweenExercisesSeconds > 0 && (i == 0 || (workoutExercises[i - 1].waitTimeAfterExerciseSeconds ?? 0) <= 0)) {
          String nextExerciseText = waitTimeText.isNotEmpty ? "$waitTimeText\n" : "";
          nextExerciseText += context.i18n.nextExercise(getTranslatedText(exercise.name, context));
          allPauseIndizes.add(fileKeys.length);
          fileKeys.add("pause:$videoWaitBetweenExercisesSeconds:$nextExerciseText");
          allPauseIndizes.add(fileKeys.length);
        }
        workoutExerciseIndexToVideoSourceIndex[i] = fileKeys.length;
        fileKeys.addAll(getFileKeysForStrengtheningAndHypertrophy(exercise));
        allPauseIndizes.add(fileKeys.length);
        final individualWaitTimeSeconds = exercise.waitTimeAfterExerciseSeconds ?? 0;
        if (individualWaitTimeSeconds > 0) {
          List<String> exerciseLines = [];
          if ((exercise.waitTimeText ?? "").isNotEmpty) {
            exerciseLines.add(exercise.waitTimeText!);
          }
          if (i + 1 < workoutExercises.length) {
            exerciseLines.add(context.i18n.nextExercise(getTranslatedText(workoutExercises[i + 1].name, context)));
          }
          final nextExerciseText = exerciseLines.join("\n");
          allPauseIndizes.add(fileKeys.length);
          fileKeys.add("pause:$individualWaitTimeSeconds:$nextExerciseText");
          allPauseIndizes.add(fileKeys.length);
        }
      }
    }

    widget.updateExerciseToVideoIndex(workoutExerciseIndexToVideoSourceIndex);

    // Separate pause entries from actual file keys
    final Set<String> uniqueFileKeys = {};
    for (int i = 0; i < fileKeys.length; i++) {
      final key = fileKeys[i];
      if (!key.toLowerCase().startsWith('pause:')) {
        uniqueFileKeys.add(key);
      }
    }

    // Fetch only unique actual file keys (pause entries don't need fetching)
    Future.wait(uniqueFileKeys
            .map((fileKey) => fileControllerApi.getFile(fileKey).catchError((err) {
                  print("Error loading file $fileKey: $err");
                  return null; // Return null for failed requests
                }))
            .toList())
        .then((files) {
      // Create a mapping from file key to URL
      final Map<String, String?> keyToUrlMap = {};
      final List<String> fetchedKeys = uniqueFileKeys.toList();

      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final fileKey = fetchedKeys[i];
        if (file != null && (file.exists ?? false)) {
          keyToUrlMap[fileKey] = file.url;
        } else {
          // Mark as unable to resolve
          keyToUrlMap[fileKey] = null;
        }
      }

      // Reconstruct the video sources list in original order, including pause entries
      final List<String> resolvedSources = [];
      for (final key in fileKeys) {
        if (key.toLowerCase().startsWith('pause:')) {
          // Keep pause entries as-is
          resolvedSources.add(key);
        } else if (keyToUrlMap.containsKey(key)) {
          final url = keyToUrlMap[key];
          if (url != null) {
            // Add the resolved URL
            resolvedSources.add(url);
          } else {
            // File failed to load or doesn't exist - skip with warning
            print("Warning: Video file key '$key' could not be resolved (failed to load or doesn't exist)");
          }
        } else {
          // This shouldn't happen, but add the key as fallback
          print("Warning: Video file key '$key' not in fetch results");
          resolvedSources.add(key);
        }
      }

      setState(() {
        videoSources = resolvedSources;
        pauseIndizes = allPauseIndizes.toList()..sort();
      });
    }).catchError((err) {
      print("Error loading video sources: $err");
    });
  }

  List<String> getFileKeysForStrengtheningAndHypertrophy(StrengtheningExercisePostDTO exercise) {
    final String videoFileKey = exercise.videoFileKey ?? "";
    if (videoFileKey.isEmpty) {
      return [];
    }
    List<String> fileKeys = [];
    final repeats = math.max(exercise.exerciseRepeatCount ?? 0, 1);
    final sets = math.max(exercise.exerciseRepeatSets ?? 0, 1);
    final breakBetweenSets = exercise.exerciseBreakBetweenSetsDurationSeconds ?? 0;
    for (int currentSet = 0; currentSet < sets; currentSet++) {
      for (int currentRepeat = 0; currentRepeat < repeats; currentRepeat++) {
        fileKeys.add(videoFileKey);
      }
      if (breakBetweenSets > 0 && currentSet < sets - 1) {
        fileKeys.add("pause:$breakBetweenSets");
      }
    }
    return fileKeys;
  }

  @override
  Widget build(BuildContext context) {
    if (videoSources.isEmpty) {
      return Container();
    }
    return Column(
      children: [
        VideoPlayerPreview(sources: videoSources, pauseIndizes: pauseIndizes, initialIndex: widget.initialVideoIndex),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: OutlinedButton(
            onPressed: () {
              final activityId = widget.activity.activityId;
              if (activityId != null) {
                final url = Uri.parse('$basePath/views/video-player/activity/$activityId');
                launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            style: OutlinedButton.styleFrom(side: BorderSide(width: 1, color: primaryColor)),
            child: Text(context.i18n.openInBrowser),
          ),
        ),
      ],
    );
  }
}
