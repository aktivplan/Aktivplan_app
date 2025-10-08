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
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HealthProfessionalsTable extends StatefulWidget {
  const HealthProfessionalsTable({
    Key? key,
    required this.healthcareProfessionalsOverview,
    required this.size,
    required this.editAction,
  }) : super(key: key);

  final HealthcareProfessionalsOverviewDTO healthcareProfessionalsOverview;
  final Function(HealthcareProfessionalGetDTO, InstitutionDTO) editAction;
  final SizingInformation size;

  @override
  _HealthProfessionalsTableState createState() => _HealthProfessionalsTableState();
}

class _HealthProfessionalsTableState extends State<HealthProfessionalsTable> {
  bool isAscending = true;
  int selectedColumn = 0;
  List<HealthcareProfessionalGetDTO> users = [];

  @override
  void initState() {
    super.initState();
    users = widget.healthcareProfessionalsOverview.users;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return DataTable(
          showBottomBorder: true,
          sortAscending: isAscending,
          sortColumnIndex: selectedColumn,
          showCheckboxColumn: false,
          columns: [
            AptDataColumn(
              dataColoumnIndex: 0,
              selectedColumnIndex: selectedColumn,
              label: Text(context.i18n.name, style: TextStyle(fontWeight: FontWeight.w600)),
              onSort: sortColumn,
            ),
            if (!widget.size.isMobile)
              AptDataColumn(
                dataColoumnIndex: 1,
                selectedColumnIndex: selectedColumn,
                label: Text(context.i18n.jobName, style: TextStyle(fontWeight: FontWeight.w600)),
                onSort: sortColumn,
              ),
          ],
          rows: getDataRows(context),
        );
      },
    );
  }

  List<DataRow> getDataRows(BuildContext context) {
    return users
        .map(
          (user) => DataRow(
            onSelectChanged: (selected) => widget.editAction(user, widget.healthcareProfessionalsOverview.institution!),
            cells: [
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Text(
                        "${user.lastName} ${user.firstName}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                      ),
                    ),
                    if (widget.size.isMobile)
                      IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () => widget.editAction(user, widget.healthcareProfessionalsOverview.institution!))
                  ],
                ),
              ),
              if (!widget.size.isMobile)
                DataCell(
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
                    Text(
                      "${user.jobName} ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () => widget.editAction(user, widget.healthcareProfessionalsOverview.institution!))
                  ]),
                ),
            ],
          ),
        )
        .toList();
  }

  sortColumn(int columnIndex, bool ascending) {
    this.isAscending = ascending;
    this.selectedColumn = columnIndex;
    var sortedEntries = this.users;

    if (columnIndex == 0) {
      if (ascending) {
        sortedEntries.sort((a, b) => (a.lastName ?? "").toLowerCase().compareTo((b.lastName ?? "").toLowerCase()));
      } else {
        sortedEntries.sort((a, b) => (b.lastName ?? "").toLowerCase().compareTo((a.lastName ?? "").toLowerCase()));
      }
    } else {
      if (ascending) {
        sortedEntries.sort((a, b) => (a.jobName ?? "").toLowerCase().compareTo((b.jobName ?? "").toLowerCase()));
      } else {
        sortedEntries.sort((a, b) => (b.jobName ?? "").toLowerCase().compareTo((a.jobName ?? "").toLowerCase()));
      }
    }

    setState(() {
      this.users = sortedEntries;
    });
  }
}
