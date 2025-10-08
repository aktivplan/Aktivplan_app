// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return TraceableWidget(
      actionName: "Visited Not Found Page",
      path: getCurrentPath(context),
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: ResponsiveBuilder(
          builder: (context, size) {
            double horizontalPadding = size.isDesktop
                ? width * 0.2
                : size.isTablet
                    ? width * 0.03
                    : width * 0.01;
            return Center(
              child: Container(
                padding: EdgeInsets.only(
                  top: size.isMobile ? height * 0.01 : height * 0.05,
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 150,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(context.i18n.errorPageNotFound, style: Theme.of(context).textTheme.headlineSmall)],
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      child: Text(context.i18n.back.toUpperCase()),
                      onPressed: () {
                        if (context.canBeamBack) {
                          context.beamBack();
                        } else {
                          // context.beamTo(HomeLocation(pathBlueprint: '/'), beamToReplacement: true);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
