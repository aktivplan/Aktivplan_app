// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AptSubtitle extends StatelessWidget {
  final Widget left;
  final Widget right;
  final String tableHeadline;
  const AptSubtitle({Key? key, required this.left, required this.right, this.tableHeadline = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(builder: (context, size) {
      if (size.isMobile) {
        return Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Flexible(
                    child: left,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: right,
                  ),
                ],
              ),
            ],
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 16),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: width * .4, child: left),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    right,
                  ],
                )
              ],
            ),
            if (tableHeadline.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(tableHeadline, style: getBreadCrumbStyle(context)),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
