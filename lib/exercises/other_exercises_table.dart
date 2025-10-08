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
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OtherExercisesTable extends StatefulWidget {
  final List<OtherExercise> fetchedExercises;
  final Function editExercise;

  OtherExercisesTable({
    Key? key,
    required this.fetchedExercises,
    required this.editExercise,
  }) : super(key: key);

  @override
  _OtherExercisesTableState createState() => _OtherExercisesTableState();
}

class _OtherExercisesTableState extends State<OtherExercisesTable> {
  bool isAscending = false;
  int selectedColumn = 0;

  sortColumn(int columnIndex, bool ascending, bool numeric) {
    setState(() {
      isAscending = !isAscending;
      selectedColumn = columnIndex;
    });
    if (ascending) {
      widget.fetchedExercises
          .sort((a, b) => getTranslatedText(a.name, context).toLowerCase().compareTo(getTranslatedText(b.name, context).toLowerCase()));
    } else {
      widget.fetchedExercises
          .sort((a, b) => getTranslatedText(b.name, context).toLowerCase().compareTo(getTranslatedText(a.name, context).toLowerCase()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: ResponsiveBuilder(
        builder: (context, size) {
          double mobileWidth = width * 0.95;
          double tabletWidth = width * 0.9;

          double containerWidth = size.isMobile
              ? mobileWidth
              : size.isTablet
                  ? tabletWidth
                  : width * 0.6;

          if (widget.fetchedExercises.isEmpty)
            return Container(
              height: height * 0.55,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SelectableText(
                    context.i18n.noExercises,
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
                    dataColoumnIndex: selectedColumn,
                    selectedColumnIndex: 0,
                    label: Text(context.i18n.training),
                    numeric: false,
                    onSort: (columnIndex, ascending) {
                      sortColumn(columnIndex, ascending, false);
                    }),
                if (!size.isMobile)
                  AptDataColumn(
                    label: Text(context.i18n.intensity),
                  ),
                if (!size.isMobile)
                  AptDataColumn(
                    label: Text(context.i18n.duration),
                  ),
                AptDataColumn(
                  label: Text(""),
                )
              ],
              rows: widget.fetchedExercises
                  .map(
                    (exercise) => DataRow(
                      onSelectChanged: (selected) => widget.editExercise(exercise),
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
                                if (getTranslatedText(exercise.hint, context).isEmpty)
                                  IconButton(
                                    icon: Icon(Icons.info_outline, color: Colors.black12),
                                    onPressed: null,
                                  ),
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
                                      onPressed: () => print(
                                        exercise.hint,
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Wrap(
                                      children: [
                                        SelectableText(getTranslatedText(exercise.name, context)),
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
                                exercise.exerciseIntensityPercentageStart != null && exercise.exerciseIntensityPercentageEnd != null
                                    ? "${exercise.exerciseIntensityPercentageStart}-${exercise.exerciseIntensityPercentageEnd} %"
                                    : "",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      letterSpacing: 1.1,
                                    ),
                              ),
                            ),
                          ),
                        if (!size.isMobile)
                          DataCell(
                            Container(
                              width: size.isDesktop ? containerWidth * 0.14 : containerWidth * 0.14,
                              child: Text(
                                "${Duration(seconds: exercise.exerciseDurationSeconds!).inMinutes} ${context.i18n.durationValueMinutes}",
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
                                  onPressed: () => widget.editExercise(exercise),
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
      ),
    );
  }
}
