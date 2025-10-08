// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:flutter/material.dart';

class AptDataColumn extends DataColumn {
  AptDataColumn({
    required Widget label,
    int? selectedColumnIndex,
    int? dataColoumnIndex,
    DataColumnSortCallback? onSort,
    bool numeric = false,
  }) : super(
          label: onSort != null
              ? Row(
                  children: [
                    if (numeric && selectedColumnIndex != dataColoumnIndex)
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                      ),
                    label,
                    if (!numeric && selectedColumnIndex != dataColoumnIndex)
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                      )
                  ],
                )
              : label,
          onSort: onSort,
          numeric: numeric,
        );
}
