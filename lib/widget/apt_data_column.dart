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
