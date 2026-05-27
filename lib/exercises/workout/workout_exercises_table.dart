import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WorkoutExercisesTable extends StatefulWidget {
  final List exercises;
  final Function(dynamic) editExercise;
  final Function(dynamic)? deleteExercise;
  final Function(int, int)? reorderExercises;
  final double parentWidth;
  WorkoutExercisesTable(
      {Key? key, required this.parentWidth, required this.exercises, required this.editExercise, this.deleteExercise, this.reorderExercises})
      : super(key: key);

  @override
  State<WorkoutExercisesTable> createState() => _WorkoutExercisesTableState();
}

class _WorkoutExercisesTableState extends State<WorkoutExercisesTable> {
  List exercises = [];

  @override
  Widget build(BuildContext context) {
    this.exercises = widget.exercises;
    return SingleChildScrollView(
      child: ResponsiveBuilder(builder: (context, size) {
        return ReorderableTable(
          needsLongPressDraggable: size.isMobile,
          border: TableBorder.all(),
          ignorePrimaryScrollController: true,
          borderColor: datatableBorderColor,
          onReorder: (oldIndex, newIndex) {
            if (widget.reorderExercises != null) {
              widget.reorderExercises!(oldIndex, newIndex);
            } else {
              setState(() {
                final row = this.exercises.removeAt(oldIndex);
                this.exercises.insert(newIndex, row);
              });
            }
          },
          onNoReorder: (int index) {
            debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
          },
          children: _exerciseRows(size),
          header: _headerRow(size),
        );
      }),
    );
  }

  List<ReorderableTableRow> _exerciseRows(SizingInformation size) {
    return exercises.map((exercise) {
      return ReorderableTableRow(
        decoration: BoxDecoration(border: Border.all()),
        //a key must be specified for each row
        key: ObjectKey(exercise),
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          tableRowPadding(
            child: Container(
              width: widget.parentWidth * (size.isMobile ? 0.7 : 0.4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu),
                  if (getTranslatedText(exercise.hint, context).isNotEmpty)
                    Tooltip(
                      padding: EdgeInsets.all(8.0),
                      preferBelow: true,
                      message: getTranslatedText(exercise.hint, context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      child: IconButton(
                        icon: Icon(Icons.info_outline, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  if (getTranslatedText(exercise.hint, context).isEmpty) Icon(Icons.info_outline, color: Colors.black12),
                  Flexible(
                    child: Text(
                      getTranslatedText(exercise.name, context),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            letterSpacing: 1.1,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!size.isMobile && !size.isTablet)
            tableRowPadding(
              child: Text(
                exercise.exerciseIntensityPercentageStart != null && exercise.exerciseIntensityPercentageEnd != null
                    ? "${exercise.exerciseIntensityPercentageStart}-${exercise.exerciseIntensityPercentageEnd} % "
                    : exercise.exerciseTrainingHeartRateLowerLimit != null && exercise.exerciseTrainingHeartRateUpperLimit != null
                        ? "${exercise.exerciseTrainingHeartRateLowerLimit}-${exercise.exerciseTrainingHeartRateUpperLimit} bpm"
                        : "",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      letterSpacing: 1.1,
                    ),
              ),
            ),
          if (!size.isMobile)
            tableRowPadding(
              child: Text(
                (exercise.hasRepeatCount != null && exercise.hasRepeatCount) || exercise.exerciseRepeatCount != 0
                    ? "${exercise.exerciseRepeatCount} ${context.i18n.repeatShort} / ${exercise.exerciseRepeatSets}"
                    : "${exercise.exerciseDurationSeconds} ${context.i18n.durationValueSeconds} / ${exercise.exerciseRepeatSets}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      letterSpacing: 1.1,
                    ),
              ),
            ),
          if (!size.isMobile && !size.isTablet) tableRowPadding(child: Text(exercise.weight == 0 ? "-" : "${exercise.weight}")),
          tableRowPadding(
            child: Container(
              width: 45,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => widget.editExercise(exercise),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => widget.deleteExercise != null ? widget.deleteExercise!(exercise) : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  ReorderableTableRow _headerRow(SizingInformation size) {
    return ReorderableTableRow(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tableRowPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(context.i18n.exercise, style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (!size.isMobile && !size.isTablet)
          tableRowPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.i18n.intensity, style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        if (!size.isMobile)
          tableRowPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(context.i18n.execution, style: TextStyle(fontWeight: FontWeight.w600)),
                Wrap(
                  children: [
                    Text(context.i18n.repeatOrDurationSets, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        if (!size.isMobile && !size.isTablet)
          tableRowPadding(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.i18n.weight, style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        SizedBox(width: 96, child: Text("")),
      ],
    );
  }
}
