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
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TrainingPlansTable extends StatefulWidget {
  final List<TrainingPlanOverviewDTO> fetchedTrainingPlans;
  final Function(TrainingPlanOverviewDTO, bool) editTrainingPlan;
  final bool autosizeColumns;
  final bool canCopy;

  TrainingPlansTable({
    Key? key,
    required this.fetchedTrainingPlans,
    required this.editTrainingPlan,
    this.autosizeColumns = false,
    this.canCopy = false,
  }) : super(key: key);

  @override
  _TrainingPlansTableState createState() => _TrainingPlansTableState();
}

class _TrainingPlansTableState extends State<TrainingPlansTable> {
  bool isAscending = false;
  int selectedColumn = 0;

  sortColumn(int columnIndex, bool ascending, bool numeric) {
    setState(() {
      isAscending = !isAscending;
      selectedColumn = columnIndex;
    });
    if (ascending) {
      widget.fetchedTrainingPlans.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
    } else {
      widget.fetchedTrainingPlans.sort((a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: ResponsiveBuilder(
        builder: (context, size) {
          if (widget.fetchedTrainingPlans.isEmpty)
            return Container(
              height: height * 0.55,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SelectableText(
                    context.i18n.noTrainingPlans,
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
                    label: Text(context.i18n.trainingPlan),
                    numeric: false,
                    onSort: (columnIndex, ascending) {
                      sortColumn(columnIndex, ascending, false);
                    }),
                if (!size.isMobile)
                  AptDataColumn(
                    label: Text(context.i18n.description),
                  ),
                if (!size.isMobile)
                  AptDataColumn(
                    label: Text(context.i18n.recordedDuration),
                  ),
                AptDataColumn(
                  label: Text(""),
                )
              ],
              rows: widget.fetchedTrainingPlans
                  .map(
                    (trainingPlan) => DataRow(
                      onSelectChanged: (selected) => widget.editTrainingPlan(trainingPlan, false),
                      cells: [
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if ((trainingPlan.hint ?? "").isEmpty)
                                IconButton(
                                  icon: Icon(Icons.info_outline, color: Colors.black12),
                                  onPressed: null,
                                ),
                              if ((trainingPlan.hint ?? "").isNotEmpty)
                                Tooltip(
                                  padding: EdgeInsets.all(8.0),
                                  preferBelow: true,
                                  message: trainingPlan.hint,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  textStyle: Theme.of(context).textTheme.bodyMedium,
                                  child: IconButton(
                                    icon: Icon(Icons.info_outline, color: Colors.black),
                                    onPressed: () => print(
                                      trainingPlan.hint,
                                    ),
                                  ),
                                ),
                              Flexible(
                                child: Text(
                                  trainingPlan.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!size.isMobile)
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  trainingPlan.description ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        letterSpacing: 1.1,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        if (!size.isMobile)
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Text(
                                    trainingPlan.numberOfWeeks.toString() +
                                        " " +
                                        (trainingPlan.numberOfWeeks != 1 ? context.i18n.weeks : context.i18n.week),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          letterSpacing: 1.1,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (widget.canCopy)
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () => widget.editTrainingPlan(trainingPlan, true),
                                ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () => widget.editTrainingPlan(trainingPlan, false),
                              ),
                            ],
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
