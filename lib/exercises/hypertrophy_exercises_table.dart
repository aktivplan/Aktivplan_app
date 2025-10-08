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
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HypertrophyExerciseTypesTable extends StatefulWidget {
  final List fetchedExerciseTypes;
  final Function editExerciseType;

  HypertrophyExerciseTypesTable({
    Key? key,
    required this.fetchedExerciseTypes,
    required this.editExerciseType,
  }) : super(key: key);

  @override
  _HypertrophyExerciseTypesTableState createState() => _HypertrophyExerciseTypesTableState();
}

class _HypertrophyExerciseTypesTableState extends State<HypertrophyExerciseTypesTable> {
  bool isAscending = false;
  int selectedColumn = 0;

  sortColumn(int columnIndex, bool ascending, bool numeric) {
    setState(() {
      isAscending = !isAscending;
      selectedColumn = columnIndex;
    });
    if (ascending) {
      widget.fetchedExerciseTypes
          .sort((a, b) => getTranslatedText(a.name, context).toLowerCase().compareTo(getTranslatedText(b.name, context).toLowerCase()));
    } else {
      widget.fetchedExerciseTypes
          .sort((a, b) => getTranslatedText(b.name, context).toLowerCase().compareTo(getTranslatedText(a.name, context).toLowerCase()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(
      builder: (context, size) {
        if (widget.fetchedExerciseTypes.isEmpty)
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
              ),
            ],
          );
        else {
          return DataTable(
            showCheckboxColumn: false,
            showBottomBorder: true,
            sortAscending: isAscending,
            sortColumnIndex: selectedColumn,
            columns: [
              AptDataColumn(
                selectedColumnIndex: selectedColumn,
                dataColoumnIndex: 0,
                label: Text(context.i18n.training, style: TextStyle(fontWeight: FontWeight.w600)),
                numeric: false,
                onSort: (columnIndex, ascending) {
                  sortColumn(columnIndex, ascending, false);
                },
              ),
              if (!size.isMobile)
                AptDataColumn(
                  label: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(context.i18n.intensityLineBreak, style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              if (!size.isMobile)
                AptDataColumn(
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        context.i18n.execution,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Wrap(
                        children: [
                          Text(
                            context.i18n.repeatOrDurationSets,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (size.isDesktop)
                AptDataColumn(
                  label: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18),
                      Text(
                        context.i18n.muscleGroups,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              if (!size.isMobile)
                AptDataColumn(
                  label: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18),
                      Text(context.i18n.weight, style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              if (!size.isMobile)
                AptDataColumn(
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Text(context.i18n.equipment, style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(context.i18n.required, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              AptDataColumn(
                label: Text(""),
              )
            ],
            rows: widget.fetchedExerciseTypes
                .map(
                  (exercise) => DataRow(
                    onSelectChanged: (selected) => widget.editExerciseType(exercise),
                    cells: [
                      DataCell(
                        Container(
                          child: Row(
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
                                  child: IconButton(icon: Icon(Icons.info_outline, color: Colors.black), onPressed: () {}),
                                ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Flexible(
                                child: Container(
                                  child: Wrap(
                                    children: [
                                      Text(getTranslatedText(exercise.name, context)),
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
                            child: Text(
                              exercise.hasRepeatCount
                                  ? "${exercise.exerciseRepeatCount} ${context.i18n.repeatShort} / ${exercise.exerciseRepeatSets}"
                                  : "${exercise.exerciseDurationSeconds} ${context.i18n.durationValueSeconds} / ${exercise.exerciseRepeatSets}",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    letterSpacing: 1.1,
                                  ),
                            ),
                          ),
                        ),
                      if (size.isDesktop)
                        DataCell(
                          Container(
                            width: width * 0.1,
                            child: Wrap(
                              clipBehavior: Clip.hardEdge,
                              children: [
                                Text(exercise.muscleGroups
                                    .map((muscleGroup) =>
                                        (new StrengtheningExerciseMuscleGroupTypeTransformer()).decode(muscleGroup.value)?.getTranslatedText(context))
                                    .join(', '))
                              ],
                            ),
                          ),
                        ),
                      if (!size.isMobile)
                        DataCell(
                          Container(child: Text(exercise.weight == 0 ? "-" : "${exercise.weight}")),
                        ),
                      if (!size.isMobile)
                        DataCell(
                          Container(
                            child: exercise.needsEquipment ? Icon(Icons.check_box) : Icon(Icons.crop_din),
                          ),
                        ),
                      DataCell(
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () => widget.editExerciseType(exercise),
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
        }
      },
    );
  }
}
