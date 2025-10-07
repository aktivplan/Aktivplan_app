import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/activity_class.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ActivityClassesPage extends StatelessWidget {
  ActivityClassesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List descriptions = getActivityDescription(context);
    String headline = context.i18n.activityClasses;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          key: Key(KEY_BUTTON_CLOSE),
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ResponsiveBuilder(builder: (context, size) {
            final double containerWidth = size.isMobile ? width * 0.9 : width * 0.5;
            return Container(
              width: containerWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFieldPadding(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        headline,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: datatableBorderColor,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DataTable(
                            showBottomBorder: true,
                            columns: [
                              AptDataColumn(
                                label: Text(context.i18n.id),
                                numeric: true,
                              ),
                              AptDataColumn(
                                label: Text(context.i18n.trainingDescription),
                              ),
                              AptDataColumn(
                                label: Text(context.i18n.trainingFrequency),
                              ),
                              AptDataColumn(
                                label: Text(context.i18n.trainingDuration),
                              )
                            ],
                            rows: descriptions
                                .map(
                                  (activity) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(activity.id.toString()),
                                      ),
                                      DataCell(
                                        Text(activity.description),
                                      ),
                                      DataCell(
                                        Text(activity.frequency),
                                      ),
                                      DataCell(
                                        Text(activity.duration),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
