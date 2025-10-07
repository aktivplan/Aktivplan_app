import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/patient/patient_calendar/active_minutes/percent_indicator.dart';
import 'package:aptapp/patient/patient_calendar/done_slider.dart';
import 'package:aptapp/patient/share_button.dart';
import 'package:aptapp/patient/training_videos_page.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:jiffy/jiffy.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:screenshot/screenshot.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:math' as math;

import '../activity/bloc/activity_bloc.dart';

class ActivityDialog extends StatefulWidget {
  final PatientGetDTO patient;
  final ActivityOverviewDTO activity;
  final ActiveMinutesOverviewDTO activeMinutes;
  final bool rateActivity;
  final bool allowRescheduleActivities;
  final Function(String, ActivityType) deleteActivity;

  const ActivityDialog(
      {Key? key,
      required this.patient,
      required this.activity,
      required this.activeMinutes,
      required this.rateActivity,
      required this.deleteActivity,
      required this.allowRescheduleActivities})
      : super(key: key);

  static Future<void> showUndoRatingDialog(
    BuildContext context,
    PatientGetDTO patient,
    ActivityOverviewDTO activity,
    ActiveMinutesOverviewDTO activeMinutes,
    bool rateActivity,
    bool allowRescheduleActivities,
    Function(String, ActivityType) deleteActivity,
  ) {
    final AlertDialog alert = AlertDialog(
      content: SelectableText(context.i18n.undoRatingText),
      actions: [
        if (activity.type == ActivityType.EXTRA)
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith(
                    (states) => primaryColor,
                  ),
                ),
                child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.editActivity)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ActivityDialog(
                          patient: patient,
                          activity: activity,
                          activeMinutes: activeMinutes,
                          rateActivity: rateActivity,
                          deleteActivity: deleteActivity,
                          allowRescheduleActivities: allowRescheduleActivities,
                        );
                      });
                }),
          ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => primaryColor,
              ),
            ),
            child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.undoExecution)),
            onPressed: () {
              final activityBloc = BlocProvider.of<ActivityBloc>(context);
              var rating = ActivityPatientRatingPostDTO()..done = false;
              activityBloc.add(UpdateActivityRatingEvent(
                  activityType: activity.type!, rating: rating, id: activity.activityId!, date: activity.date!, patientId: patient.id!));
              Navigator.of(context, rootNavigator: true).pop();
            }),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => errorColor,
            ),
          ),
          child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.cancel)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> showActiveMinutesAchieved(
      BuildContext context, double percentage, int activeMinutes, int durationMinutes, double height) async {
    double containerHeight = height * 0.35;
    final ScreenshotController screenshotController = ScreenshotController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 0, left: 5, right: 5),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    key: Key(KEY_BUTTON_CLOSE),
                    child: Icon(
                      Icons.close,
                      size: 24,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              FittedBox(
                child: SelectableText(
                  context.i18n.achievedActivityShort,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              FittedBox(
                child: SelectableText(
                  context.i18n.activeMinutesPerWeekAmount(activeMinutes),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                ),
              ),
            ],
          ),
          content: Container(
            height: containerHeight,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: containerHeight * (kIsWeb ? 0.9 : 0.8),
                  width: containerHeight * (kIsWeb ? 0.9 : 0.8),
                  child: Screenshot(
                    controller: screenshotController,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: PercentIndicator(
                        percentage: percentage,
                        durationMinutesActive: activeMinutes,
                        durationMinutes: durationMinutes,
                        cardContainerHeight: 360,
                      ),
                    ),
                  ),
                ),
                if (!kIsWeb)
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ShareButton(screenshotController: screenshotController, shareContext: "Active Minutes"),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  _ActivityDialogState createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  final _activityFormKey = GlobalKey<FormState>();
  ActivityBloc? activityBloc;
  bool rateActivity = false;
  final heartrateController = TextEditingController();
  final durationController = TextEditingController();
  final notesController = TextEditingController();
  final extraActivityNameController = TextEditingController();
  List<bool> workoutShowHints = [];
  DateTime? rateTime;
  Map<String, String> youtubeIdMapping = {};
  final moveDateController = MaskedTextController(mask: "00.00.0000");
  DateTime? moveDate;
  DateTime? allowedFirstMoveDate;
  DateTime? allowedLastMoveDate;
  // by default the dialog is for setting activity to done
  bool isDone = true;
  String extraActivityName = "";

  List<YoutubePlayerController> playerControllers = [];

  @override
  void initState() {
    super.initState();

    isDone = true;
    rateTime = DateTime.now();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    rateActivity = widget.rateActivity;
    moveDate = englishDateFormat.parse(widget.activity.date!);
    moveDateController.text = germanDateFormat.format(moveDate!);
    if (widget.activity.type == ActivityType.EXTRA) {
      allowedFirstMoveDate = DateTime(2015, 8);
      allowedLastMoveDate = DateTime(2100);
    } else {
      allowedFirstMoveDate = Jiffy.parseFromDateTime(moveDate!).startOf(Unit.week).dateTime;
      allowedLastMoveDate = Jiffy.parseFromDateTime(moveDate!).endOf(Unit.week).subtract(days: 1).dateTime;
    }
    if (widget.activity.rating != null) {
      if ((widget.activity.rating?.heartrate ?? 0) > 0) {
        heartrateController.text = widget.activity.rating!.heartrate!.toString();
      }
      if (widget.activity.rating?.durationMinutes != null && (widget.activity.rating?.done ?? false)) {
        durationController.text = widget.activity.rating!.durationMinutes!.toString();
      } else {
        durationController.text = widget.activity.durationMinutes.toString();
      }
      notesController.text = widget.activity.rating!.note ?? "";
    }
    if (widget.activity.type == ActivityType.WORKOUT) {
      workoutShowHints = widget.activity.activity!.workout!.exercises.map((e) => false).toList();
    }
    Future.delayed(Duration.zero, () {
      initYouTubePlayerControllers();
      if (widget.activity.type == ActivityType.EXTRA) {
        extraActivityNameController.text = getTranslatedText(widget.activity.name, context);
      }
    });
  }

  @override
  void dispose() {
    playerControllers.forEach((element) {
      element.close();
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Widget getActivityInfoLine(String title, String value) {
    return Row(
      children: [
        Flexible(
            child: StyledText(
          text: '<b>$title:</b> $value',
          tags: {
            'b': StyledTextTag(
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          },
        )),
      ],
    );
  }

  Widget getActivityInfoLineWithWidget(String title, Widget widget) {
    return Row(
      children: [
        Flexible(
            child: StyledText(
          text: '<b>$title:</b> <widget/>',
          tags: {
            'b': StyledTextTag(
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            'widget': StyledTextWidgetTag(widget, alignment: PlaceholderAlignment.baseline)
          },
        ))
      ],
    );
  }

  initYouTubePlayerControllers() {
    if (widget.activity.type == ActivityType.WORKOUT) {
      String youTubeId = getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.workout!.youTubeUrl, context), map: youtubeIdMapping);
      setState(() {
        playerControllers = [];
        if (youTubeId.isNotEmpty) {
          playerControllers.add(YoutubePlayerController.fromVideoId(
            videoId: youTubeId,
              // initialVideoId: youTubeId,
              params: YoutubePlayerParams(
                // autoPlay: false,
                // desktopMode: true,
                showFullscreenButton: true,
                loop: true,
                // playlist: [youTubeId],
              )));
        }
        playerControllers.addAll(widget.activity.activity!.workout!.exercises
            .where((element) => getYoutubeVideoIdByURL(getTranslatedText(element.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty)
            .map((e) {
          String exerciseYouTubeId = getYoutubeVideoIdByURL(getTranslatedText(e.youTubeUrl, context), map: youtubeIdMapping);
          return YoutubePlayerController.fromVideoId(
            videoId: exerciseYouTubeId,
              // initialVideoId: exerciseYouTubeId,
              params: YoutubePlayerParams(
                // autoPlay: false,
                // desktopMode: true,
                showFullscreenButton: true,
                loop: true,
                // playlist: [exerciseYouTubeId],
              ));
        }).toList());
      });
    } else {
      String youTubeId = "";
      switch (widget.activity.type) {
        case ActivityType.ENDURANCE:
          youTubeId =
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.enduranceExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.HYPERTROPHY:
        case ActivityType.STRENGTHENING:
          youTubeId =
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.strengtheningExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.INTERVAL:
          youTubeId =
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.intervalExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.OTHER:
          youTubeId = getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.otherExercise!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        case ActivityType.TASK:
          youTubeId = getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.task!.youTubeUrl, context), map: youtubeIdMapping);
          break;
        default:
          youTubeId = "";
          break;
      }
      if (youTubeId.isNotEmpty) {
        setState(() {
          playerControllers = [
            YoutubePlayerController.fromVideoId(
              videoId: youTubeId,
                // initialVideoId: youTubeId,
                params: YoutubePlayerParams(
                  // autoPlay: false,
                  // desktopMode: true,
                  showFullscreenButton: true,
                  loop: true,
                  // playlist: [youTubeId],
                ))
          ];
        });
      }
    }
  }

  getActivityHint() {
    String hint = "";
    switch (widget.activity.type) {
      case ActivityType.ENDURANCE:
        hint = getTranslatedText(widget.activity.activity!.enduranceExercise!.hint, context);
        break;
      case ActivityType.HYPERTROPHY:
      case ActivityType.STRENGTHENING:
        hint = getTranslatedText(widget.activity.activity!.strengtheningExercise!.hint, context);
        break;
      case ActivityType.INTERVAL:
        hint = getTranslatedText(widget.activity.activity!.intervalExercise!.hint, context);
        break;
      case ActivityType.WORKOUT:
        hint = getTranslatedText(widget.activity.activity!.workout!.notes, context);
        break;
      case ActivityType.OTHER:
        hint = getTranslatedText(widget.activity.activity!.otherExercise!.hint, context);
        break;
      case ActivityType.TASK:
        hint = getTranslatedText(widget.activity.activity!.task!.hint, context);
        break;
      default:
        hint = "";
        break;
    }
    if (hint.isEmpty) {
      return [];
    } else {
      return [
        getActivityInfoLineWithWidget(
          widget.activity.type != ActivityType.TASK ? context.i18n.notes : context.i18n.taskNotes,
          SelectableLinkify(
            text: hint,
            onOpen: (link) async {
              if (await canLaunchUrlString(link.url)) {
                String cleanedUrl = link.url;
                if (cleanedUrl.endsWith("!")) {
                  cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                }
                launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ),
      ];
    }
  }

  setActivityToDone(double? value, bool hasInitialValue) {
    if (!_activityFormKey.currentState!.validate()) {
      return;
    }

    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
          category: EVENT_CATEGORY_ACTIVITY,
          name: EVENT_NAME_RATE_ACTIVITY_TIME,
          action: "Rated Activity",
          value: DateTime.now().difference(rateTime!).inSeconds),
    );

    var rating = ActivityPatientRatingPostDTO()
      ..done = true
      ..rating = value != null ? value.truncate() : null
      ..durationMinutes = int.tryParse(durationController.text)
      ..heartrate = int.tryParse(heartrateController.text)
      ..note = notesController.text
      ..date = englishDateFormat.format(moveDate!);

    widget.activity.rating!.done = rating.done;
    widget.activity.rating!.rating = rating.rating;
    activityBloc!.add(UpdateActivityRatingEvent(
        activityType: widget.activity.type!,
        rating: rating,
        id: widget.activity.activityId!,
        date: widget.activity.date!,
        patientId: widget.patient.id!,
        extraActivityName: extraActivityNameController.text));
    Navigator.pop(context);

    if (!hasInitialValue) {
      checkIfActiveMinutesAchieved(MediaQuery.of(context).size.height);
    }
  }

  updateActivity() {
    if (!_activityFormKey.currentState!.validate()) {
      return;
    }

    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
          category: EVENT_CATEGORY_ACTIVITY,
          name: EVENT_NAME_UPDATE,
          action: "Updated Activity",
          value: DateTime.now().difference(rateTime!).inSeconds),
    );

    var rating = ActivityPatientRatingPostDTO()
      ..done = false
      ..rating = widget.activity.rating?.rating
      ..durationMinutes = int.tryParse(durationController.text)
      ..heartrate = int.tryParse(heartrateController.text)
      ..note = notesController.text
      ..date = englishDateFormat.format(moveDate!);

    widget.activity.rating!.done = rating.done;
    widget.activity.rating!.rating = rating.rating;
    activityBloc!.add(UpdateActivityRatingEvent(
        activityType: widget.activity.type!,
        rating: rating,
        id: widget.activity.activityId!,
        date: widget.activity.date!,
        patientId: widget.patient.id!,
        extraActivityName: extraActivityNameController.text));
    Navigator.pop(context);
  }

  checkIfActiveMinutesAchieved(double height) {
    var date = DateTime.parse(widget.activity.date!).weekOfYear;
    bool isCurrentWeek = date == DateTime.now().toLocal().weekOfYear;
    bool isDone = widget.activity.rating!.done ?? false;

    // already done
    if (widget.activeMinutes.durationMinutesActive! >= widget.activeMinutes.durationMinutes!) {
      return;
    }
    var duration = int.tryParse(durationController.text) ?? 0;
    //only check if activity is in current week
    if (isDone && isCurrentWeek) {
      bool goalAchieved = (widget.activeMinutes.durationMinutesActive! + duration) >= widget.activeMinutes.durationMinutes!;
      double percentage = widget.activeMinutes.durationMinutesActive! + duration / widget.activeMinutes.durationMinutes!;
      if (goalAchieved)
        ActivityDialog.showActiveMinutesAchieved(
          context,
          percentage,
          widget.activeMinutes.durationMinutesActive! + duration,
          widget.activeMinutes.durationMinutes!,
          height,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      return Scaffold(
        appBar: AppBar(
          elevation: 20,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!rateActivity && widget.activity.rating!.done!) getActivityRatingInfo(context),
                  ...getActivityInfos(widget.activity, context),
                  if (rateActivity) getActivityRating(context, size)
                ],
              )),
        ),
      );
    });
  }

  getActivityRatingInfo(BuildContext context) {
    Color backgroundColor = plannedActivityColor;
    if (widget.activity.type == ActivityType.EXTRA) {
      backgroundColor = extraActivityColor;
    } else if (widget.activity.type == ActivityType.TASK) {
      backgroundColor = plannedTaskColor;
    }
    return Padding(
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: datatableBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    heightFactor: 0.7,
                    widthFactor: 0.7,
                    child: Icon(Icons.check, color: Colors.white, size: 24),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  context.i18n.executed,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            if (widget.activity.rating!.rating != null)
              Padding(
                padding: EdgeInsets.only(top: 22),
                child: SelectableText("(${widget.activity.rating!.rating}) ${getRatingText(widget.activity.rating!.rating!)}"),
              ),
            SizedBox(height: 22),
            if ((widget.activity.rating!.heartrate ?? 0) > 0)
              getActivityInfoLine(context.i18n.trainingHeartFrequency, widget.activity.rating!.heartrate!.toString() + " bpm"),
            getActivityInfoLineWithWidget(
              context.i18n.notes,
              SelectableLinkify(
                text: (widget.activity.rating!.note ?? "").isNotEmpty ? widget.activity.rating!.note! : "-",
                onOpen: (link) async {
                  if (await canLaunchUrlString(link.url)) {
                    String cleanedUrl = link.url;
                    if (cleanedUrl.endsWith("!")) {
                      cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                    }
                    launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ),
            SizedBox(height: 22),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rateActivity = true;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(context.i18n.adjust.toUpperCase())],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getRatingText(int value) {
    switch (value) {
      case 6:
      case 7:
      case 8:
        return context.i18n.ratingValue_6_8;
      case 9:
      case 10:
      case 11:
      case 12:
        return context.i18n.ratingValue_9_12;
      case 13:
      case 14:
        return context.i18n.ratingValue_13_14;
      case 15:
      case 16:
        return context.i18n.ratingValue_15_16;
      case 17:
      case 18:
        return context.i18n.ratingValue_17_18;
      case 19:
      case 20:
      default:
        return context.i18n.ratingValue_19_20;
    }
  }

  Future<Null> _selectMoveDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: moveDate, firstDate: allowedFirstMoveDate!, lastDate: allowedLastMoveDate!);
    if (picked != null && picked != moveDate)
      setState(() {
        moveDate = picked;
        moveDateController.text = germanDateFormat.format(moveDate!);
      });
  }

  getActivityRating(BuildContext context, SizingInformation size) {
    return Form(
      key: _activityFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // can change name of extra activity as it is planned by user
          if (widget.activity.type == ActivityType.EXTRA)
            FormFieldPadding(
              child: TextFormField(
                controller: extraActivityNameController,
                decoration: InputDecoration(
                  hintText: context.i18n.name,
                  labelText: context.i18n.name,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.activity.type == ActivityType.EXTRA || widget.allowRescheduleActivities)
            FormFieldPadding(
              child: TextFormField(
                controller: moveDateController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if ((value ?? "").replaceAll(".", "").length < 8) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    DateTime? date = DateTime.tryParse(germanDateFormat.parse(value!).toString());
                    if (date == null) {
                      return context.i18n.validationInvalidValue;
                    } else if (date.isBefore(allowedFirstMoveDate!) || date.isAfter(allowedLastMoveDate!)) {
                      return context.i18n.validationMoveDateWithinAWeek;
                    }
                  }
                  return null;
                },
                onChanged: (val) {
                  String valueWithoutDots = val.replaceAll(".", "");
                  if (valueWithoutDots.length == 8) {
                    moveDate = DateTime.utc(int.parse(valueWithoutDots.substring(4)), int.parse(valueWithoutDots.substring(2, 4)),
                        int.parse(valueWithoutDots.substring(0, 2)));
                  }
                },
                decoration: InputDecoration(
                  hintText: isDone ? context.i18n.performedOn : context.i18n.plannedOn,
                  labelText: isDone ? context.i18n.performedOn : context.i18n.plannedOn,
                  border: OutlineInputBorder(),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.date_range),
                    color: lightTextColor,
                    onPressed: () => _selectMoveDate(context),
                  ),
                ),
              ),
            ),
          if (widget.activity.type != ActivityType.TASK)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: heartrateController,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: context.i18n.trainingHeartFrequencyBpm,
                  labelText: context.i18n.trainingHeartFrequencyBpm,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.activity.type != ActivityType.TASK)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: durationController,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return context.i18n.validationNotEmpty;
                  }
                  if (int.parse(value!) < 1) {
                    return context.i18n.validationInvalidValue;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: context.i18n.actualTotalDurationMin,
                  labelText: context.i18n.actualTotalDurationMin,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: datatableBorderColor,
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: TextFormField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: context.i18n.note,
                labelText: context.i18n.note,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: datatableBorderColor,
                  ),
                ),
              ),
            ),
          ),
          if (widget.activity.type == ActivityType.EXTRA)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: isDone,
                onChanged: (value) {
                  setState(() {
                    isDone = value ?? false;
                  });
                },
                title: Text(
                  context.i18n.executed,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: lightTextColor,
                      ),
                ),
              ),
            ),
          if (widget.activity.type != ActivityType.TASK && isDone)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: DoneSlider(
                  activity: widget.activity,
                  patientId: widget.patient.id!,
                  activeMinutes: widget.activeMinutes,
                  rateActivity: setActivityToDone,
                  size: size),
            ),
          if (widget.activity.type != ActivityType.TASK && !isDone)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  updateActivity();
                },
                style: getElevatedButtonStyle(context),
                child: Row(
                  mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(context.i18n.update.toUpperCase())],
                ),
              ),
            ),
          if (widget.activity.type == ActivityType.TASK)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  setActivityToDone(null, true);
                },
                style: getElevatedButtonStyle(context),
                child: Row(
                  mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(context.i18n.executeTask.toUpperCase())],
                ),
              ),
            ),
          if (widget.activity.type == ActivityType.EXTRA)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                child: Row(
                  mainAxisSize: size.isDesktop ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.i18n.deleteActivity.toUpperCase()),
                  ],
                ),
                onPressed: () => DeleteButton.showDeleteConfirmationDialog(
                  context,
                  context.i18n.deleteActivity,
                  context.i18n.deleteMessageActivity(getTranslatedText(widget.activity.name, context)),
                  () {
                    widget.deleteActivity(widget.activity.activityId!, widget.activity.type!);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  getActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final String timeString = getTranslatedTimeString(activity.time ?? "", context);

    if (activity.type == ActivityType.APPOINTMENT) {
      return [
        SizedBox(height: 10),
        SelectableText(getTranslatedText(activity.name, context),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, height: 1)),
        SizedBox(height: 10),
        SelectableText("${activity.type!.getTranslatedText(context)}, $timeString"),
        if ((activity.activity!.appointment!.location ?? "").isNotEmpty || (activity.activity!.appointment!.details ?? "").isNotEmpty)
          SizedBox(height: 10),
        if ((activity.activity!.appointment!.location ?? "").isNotEmpty)
          getActivityInfoLine(context.i18n.location, activity.activity!.appointment!.location!),
        if ((activity.activity!.appointment!.details ?? "").isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(context.i18n.details + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
              Flexible(
                child: SelectableLinkify(
                  text: activity.activity!.appointment!.details!,
                  onOpen: (link) async {
                    if (await canLaunchUrlString(link.url)) {
                      String cleanedUrl = link.url;
                      if (cleanedUrl.endsWith("!")) {
                        cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                      }
                      launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
              ),
            ],
          ),
      ];
    }

    String typeLine = activity.type!.getTranslatedText(context);
    if (timeString.isNotEmpty) {
      typeLine += ", $timeString";
    }
    if ((activity.durationMinutes ?? 0) > 0) {
      typeLine += ", ${activity.durationMinutes} ${context.i18n.durationValueMinutes}";
    }

    return [
      SizedBox(height: 10),
      SelectableText(getTranslatedText(activity.name, context),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, height: 1)),
      SizedBox(height: 10),
      SelectableText(typeLine),
      SizedBox(height: 10),
      if (activity.type == ActivityType.EXTRA) ...getExtraActivityInfos(activity, context),
      if (activity.type == ActivityType.ENDURANCE) ...getEnduranceActivityInfos(activity, context),
      if (activity.type == ActivityType.INTERVAL) ...getIntervalActivityInfos(activity, context),
      if (activity.type == ActivityType.HYPERTROPHY || activity.type == ActivityType.STRENGTHENING)
        ...getStrengtheningActivityInfos(activity.activity!.strengtheningExercise!, context, false),
      if (activity.type == ActivityType.OTHER) ...getOtherActivityInfos(activity, context),
      ...getActivityHint(),
      if ((activity.type != ActivityType.WORKOUT && playerControllers.length > 0) ||
          (activity.type == ActivityType.WORKOUT &&
              playerControllers.length > 0 &&
              getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.workout!.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty))
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: getYouTubeWidget(0),
        ),
      if (activity.type == ActivityType.WORKOUT) ...getWorkoutActivityInfos(activity, context),
    ];
  }

  getExtraActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    if (!(activity.rating?.done ?? false) && !rateActivity) {
      return [
        ElevatedButton(
          onPressed: () {
            setState(() {
              rateActivity = true;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(context.i18n.adjust.toUpperCase())],
          ),
        ),
      ];
    }
    return [];
  }

  getEnduranceActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final EnduranceExercisePostDTO enduranceExercise = activity.activity!.enduranceExercise!;
    if ((enduranceExercise.exerciseTrainingHeartRateLowerLimit ?? 0) <= 0 || (enduranceExercise.exerciseTrainingHeartRateUpperLimit ?? 0) <= 0) {
      return [];
    }

    return [
      getActivityInfoLine(context.i18n.trainingHeartFrequency,
          "${enduranceExercise.exerciseTrainingHeartRateLowerLimit} - ${enduranceExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
    ];
  }

  getOtherActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final OtherExercisePostDTO otherExercise = activity.activity!.otherExercise!;
    if ((otherExercise.exerciseTrainingHeartRateLowerLimit ?? 0) <= 0 || (otherExercise.exerciseTrainingHeartRateUpperLimit ?? 0) <= 0) {
      return [];
    }

    return [
      getActivityInfoLine(context.i18n.trainingHeartFrequency,
          "${otherExercise.exerciseTrainingHeartRateLowerLimit} - ${otherExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
    ];
  }

  getIntervalActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    final IntervalExercisePostDTO intervalExercise = activity.activity!.intervalExercise!;
    final toReturn = [];
    final double gapHeight = MediaQuery.of(context).size.height * 0.02;
    toReturn.add(SizedBox(height: gapHeight));
    toReturn.add(
      SelectableText(context.i18n.exerciseIntensityPhase + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    if (((intervalExercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0) && ((intervalExercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0)) {
      toReturn.add(
        getActivityInfoLine(context.i18n.trainingHeartFrequency,
            "${intervalExercise.exerciseTrainingHeartRateLowerLimit} - ${intervalExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
      );
    }
    toReturn.add(
      getActivityInfoLine(
        context.i18n.duration,
        " ${intervalExercise.selectedExerciseSeconds ?? false ? intervalExercise.exerciseDurationSeconds.toString() + ' ${context.i18n.durationValueSeconds}' : Duration(seconds: intervalExercise.exerciseDurationSeconds!).inMinutes.toString() + ' ${context.i18n.durationValueMinutes}'}",
      ),
    );
    toReturn.add(SizedBox(height: gapHeight));
    toReturn.add(
      SelectableText(context.i18n.exerciseRecoveryPhase + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    if ((intervalExercise.recoveryTrainingHeartRateLowerLimit ?? 0) > 0 && (intervalExercise.recoveryTrainingHeartRateUpperLimit ?? 0) > 0) {
      toReturn.add(
        getActivityInfoLine(context.i18n.trainingHeartFrequency,
            "${intervalExercise.recoveryTrainingHeartRateLowerLimit} - ${intervalExercise.recoveryTrainingHeartRateUpperLimit} bpm"),
      );
    }
    toReturn.add(
      getActivityInfoLine(
        context.i18n.duration,
        " ${intervalExercise.selectedRecoverySeconds ?? false ? intervalExercise.recoveryDurationSeconds.toString() + ' ${context.i18n.durationValueSeconds}' : Duration(seconds: intervalExercise.recoveryDurationSeconds!).inMinutes.toString() + ' ${context.i18n.durationValueMinutes}'}",
      ),
    );
    toReturn.add(SizedBox(height: gapHeight));
    toReturn.add(
      getActivityInfoLine(context.i18n.intervals, "${intervalExercise.intervalCount}"),
    );
    return toReturn;
  }

  getStrengtheningActivityInfos(StrengtheningExercisePostDTO strengtheningExercise, BuildContext context, bool isWorkout) {
    return [
      if ((strengtheningExercise.exerciseTrainingHeartRateLowerLimit ?? 0) > 0 &&
          (strengtheningExercise.exerciseTrainingHeartRateUpperLimit ?? 0) > 0 &&
          !isWorkout)
        getActivityInfoLine(context.i18n.trainingHeartFrequency,
            "${strengtheningExercise.exerciseTrainingHeartRateLowerLimit} - ${strengtheningExercise.exerciseTrainingHeartRateUpperLimit} bpm"),
      if (!isWorkout) getActivityInfoLine(context.i18n.execution, getStrengtheningExecutionString(strengtheningExercise, context)),
      getActivityInfoLine(
          context.i18n.muscleGroups,
          strengtheningExercise.muscleGroups.isNotEmpty
              ? strengtheningExercise.muscleGroups.map((entry) => entry.getTranslatedText(context)).join(", ")
              : "-"),
      getActivityInfoLine(context.i18n.exerciseNeedsEquipment, (strengtheningExercise.needsEquipment ?? false) ? context.i18n.yes : context.i18n.no),
      if ((strengtheningExercise.weight ?? 0) > 0)
        getActivityInfoLine(context.i18n.weight, "${strengtheningExercise.weight ?? "-"} ${context.i18n.kg}"),
    ];
  }

  List<Widget> getWorkoutActivityInfos(ActivityOverviewDTO activity, BuildContext context) {
    if (activity.activity!.workout!.exercises.isEmpty) {
      return [];
    }
    List<Widget> workoutWidgets = [];
    int youTubeCount =
        getYoutubeVideoIdByURL(getTranslatedText(widget.activity.activity!.workout!.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty ? 1 : 0;
    for (int currentIndex = 0; currentIndex < activity.activity!.workout!.exercises.length; ++currentIndex) {
      for (int pastIndex = 0; pastIndex < currentIndex; ++pastIndex) {
        if (getYoutubeVideoIdByURL(getTranslatedText(activity.activity!.workout!.exercises[pastIndex].youTubeUrl, context), map: youtubeIdMapping)
            .isNotEmpty) {
          ++youTubeCount;
        }
      }
      StrengtheningExercisePostDTO exercise = activity.activity!.workout!.exercises[currentIndex];
      bool showHint = workoutShowHints[currentIndex];
      String hintText = getTranslatedText(exercise.hint, context);
      String activityDescription =
          "<b>${getTranslatedText(exercise.name, context)}</b>\n<b>${context.i18n.execution}:</b> ${getStrengtheningExecutionString(exercise, context)}";
      if (exercise.exerciseTrainingHeartRateLowerLimit != null && exercise.exerciseTrainingHeartRateUpperLimit != null) {
        activityDescription +=
            "\n<b>${context.i18n.trainingHeartFrequency}:</b> ${exercise.exerciseTrainingHeartRateLowerLimit} - ${exercise.exerciseTrainingHeartRateUpperLimit} bpm";
      }
      Widget innerText = Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: datatableBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: StyledText(
                    text: activityDescription,
                    tags: {
                      'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
                    },
                  ),
                ),
                Transform.rotate(
                  angle: math.pi / 2,
                  child: Icon(showHint ? Icons.chevron_left : Icons.chevron_right),
                ),
              ],
            ),
            if (showHint)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...getStrengtheningActivityInfos(exercise, context, true),
                  if (hintText.isNotEmpty)
                    getActivityInfoLineWithWidget(
                      context.i18n.notes,
                      SelectableLinkify(
                        text: hintText,
                        onOpen: (link) async {
                          if (await canLaunchUrlString(link.url)) {
                            String cleanedUrl = link.url;
                            if (cleanedUrl.endsWith("!")) {
                              cleanedUrl = cleanedUrl.substring(0, cleanedUrl.length - 1);
                            }
                            launchUrlString(cleanedUrl, mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                    ),
                  if (getYoutubeVideoIdByURL(getTranslatedText(exercise.youTubeUrl, context), map: youtubeIdMapping).isNotEmpty &&
                      youTubeCount < playerControllers.length)
                    getYouTubeWidget(youTubeCount)
                ],
              ),
          ],
        ),
      );
      workoutWidgets.add(Padding(
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: InkWell(
          child: innerText,
          onTap: () {
            setState(() {
              workoutShowHints[currentIndex] = !workoutShowHints[currentIndex];
            });
          },
        ),
      ));
    }
    return workoutWidgets;
  }

  Widget getYouTubeWidget(int index) {
    // String? youTubeUrl = youtubeIdMapping[playerControllers[index].initialVideoId];
    String? youTubeUrl = youtubeIdMapping[playerControllers[index].videoUrl];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if ((youTubeUrl ?? "").isNotEmpty && !kIsWeb)
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                launchUrlString(youTubeUrl!, mode: LaunchMode.externalApplication);
              },
              child: Text(
                "Fullscreen: YouTube-Link >",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
            ),
          ),
        Container(
          width: math.min(MediaQuery.of(context).size.width, 600),
          padding: EdgeInsets.only(top: 4),
          child: YoutubePlayer(
            controller: playerControllers[index],
            gestureRecognizers: [
              Factory<OneSequenceGestureRecognizer>(
                () => VideoDragGestureRecognizer(),
              ),
            ].toSet(),
          ),
        ),
      ],
    );
  }
}
