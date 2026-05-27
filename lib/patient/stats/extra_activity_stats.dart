import 'package:apt_api/api.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/widget/borg_slider.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ExtraActivityStats extends StatefulWidget {
  final ActivityOverviewDTO activity;
  final String patientId;
  final Function deleteActivity;

  const ExtraActivityStats({
    Key? key,
    required this.activity,
    required this.patientId,
    required this.deleteActivity,
  }) : super(key: key);

  @override
  _ExtraActivityStatsState createState() => _ExtraActivityStatsState();
}

class _ExtraActivityStatsState extends State<ExtraActivityStats> {
  @override
  void initState() {
    super.initState();
  }

  deleteActivity() {
    widget.deleteActivity(widget.activity.activityId, widget.activity.type);
    context.beamBack();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double gapHeight = height * 0.02;
    double _value = widget.activity.rating?.rating == null ? 6.0 : widget.activity.rating!.rating!.toDouble();
    String notes = widget.activity.rating?.note ?? "";
    bool isDone = widget.activity.rating?.done ?? false;
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              SelectableText(
                '${context.i18n.activity}: ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SelectableText(
                '${widget.activity.name}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              SelectableText(
                '${context.i18n.state}: ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SelectableText(
                widget.activity.rating!.done! ? context.i18n.executed : context.i18n.notExecuted,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: gapHeight,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              SelectableText(
                '${context.i18n.duration}: ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SelectableText(
                "${widget.activity.durationMinutes} ${context.i18n.durationValueMinutes}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              SelectableText(
                '${context.i18n.trainingHeartFrequency}: ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SelectableText(
                widget.activity.rating?.heartrate == null ? "-" : "${widget.activity.rating!.heartrate} bpm",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: gapHeight,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              SelectableText(
                '${context.i18n.notes}: ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Wrap(
                children: [
                  SelectableText(
                    notes.isEmpty ? "-" : notes,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: gapHeight,
          ),
          if (isDone)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SelectableText(
                      "${context.i18n.rating}: ${_value.truncate()}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                SelectableText("0 = ${context.i18n.ratingValue_0_1}", style: Theme.of(context).textTheme.bodyLarge),
                SelectableText("10 = ${context.i18n.ratingValue_10}", style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(
                  height: height * 0.1,
                ),
                BorgSlider(
                  value: _value,
                  onChanged: (value) => {},
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      BorgUtils.getLevelString(context, _value),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: BorgUtils.getColor(_value),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.01,
                          ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
