// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../colors.dart';

class WorkoutTable extends StatefulWidget {
  final List<Workout> fetchedWorkouts;
  final Function editWorkout;

  WorkoutTable({
    Key? key,
    required this.fetchedWorkouts,
    required this.editWorkout,
  }) : super(key: key);

  @override
  _WorkoutTableState createState() => _WorkoutTableState();
}

class _WorkoutTableState extends State<WorkoutTable> {
  bool isAscending = true;
  int selectedColumn = 0;

  sortColumn(int columnIndex, bool ascending) {
    setState(() {
      isAscending = ascending;
      selectedColumn = columnIndex;
    });

    if (ascending) {
      widget.fetchedWorkouts
          .sort((a, b) => getTranslatedText(a.name, context).toLowerCase().compareTo(getTranslatedText(b.name, context).toLowerCase()));
    } else {
      widget.fetchedWorkouts
          .sort((a, b) => getTranslatedText(b.name, context).toLowerCase().compareTo(getTranslatedText(a.name, context).toLowerCase()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(
      builder: (context, size) {
        double mobileWidth = width * 0.95;
        double tabletWidth = width * 0.9;

        double containerWidth = size.isMobile
            ? mobileWidth
            : size.isTablet
                ? tabletWidth
                : width * 0.6;
        if (widget.fetchedWorkouts.isEmpty)
          return Container(
            height: height * 0.55,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SelectableText(
                  context.i18n.noWorkouts,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: lightTextColor,
                      ),
                ),
              ),
            ),
          );
        else
          return DataTable(
            showCheckboxColumn: false,
            showBottomBorder: true,
            sortAscending: isAscending,
            sortColumnIndex: selectedColumn,
            headingTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            columns: [
              AptDataColumn(
                selectedColumnIndex: selectedColumn,
                dataColoumnIndex: 0,
                label: Text(context.i18n.workout),
                onSort: (columnIndex, ascending) {
                  sortColumn(columnIndex, ascending);
                },
              ),
              if (!size.isMobile)
                AptDataColumn(
                  label: Text(context.i18n.exercises),
                ),
              if (!size.isMobile)
                AptDataColumn(
                  label: Text(context.i18n.duration),
                ),
              AptDataColumn(
                label: Text(""),
              )
            ],
            rows: widget.fetchedWorkouts
                .map(
                  (workout) => DataRow(
                    onSelectChanged: (selected) {
                      widget.editWorkout(workout);
                    },
                    cells: [
                      DataCell(
                        Container(
                          width: size.isDesktop
                              ? containerWidth * 0.25
                              : size.isTablet
                                  ? containerWidth * 0.27
                                  : containerWidth * 0.6,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (getTranslatedText(workout.notes, context).isEmpty)
                                IconButton(
                                  icon: Icon(Icons.info_outline, color: Colors.black12),
                                  onPressed: null,
                                ),
                              if (getTranslatedText(workout.notes, context).isNotEmpty)
                                Tooltip(
                                  padding: EdgeInsets.all(8.0),
                                  preferBelow: true,
                                  message: getTranslatedText(workout.notes, context),
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
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Flexible(
                                child: Container(
                                  child: Wrap(
                                    children: [
                                      SelectableText(getTranslatedText(workout.name, context)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!size.isMobile)
                        DataCell(
                          Container(
                            width: size.isDesktop ? containerWidth * 0.19 : containerWidth * 0.23,
                            child: Text(
                              "${workout.exercises.map((e) => getTranslatedText(e.name, context)).join(", ")}",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    letterSpacing: 1.1,
                                  ),
                            ),
                          ),
                        ),
                      if (!size.isMobile)
                        DataCell(
                          Container(
                            width: containerWidth * 0.14,
                            child: Text(
                              "${workout.exerciseDurationSeconds != null ? Duration(seconds: workout.exerciseDurationSeconds!).inMinutes : getWorkoutExercisesDurationInMinutes(workout.exercises)} ${context.i18n.durationValueMinutes}",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    letterSpacing: 1.1,
                                  ),
                            ),
                          ),
                        ),
                      DataCell(
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () => widget.editWorkout(workout),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
      },
    );
  }
}
