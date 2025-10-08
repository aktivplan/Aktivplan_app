// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/utils/trace_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

mixin TraceablePageMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      MatomoTracker.instance.trackPageViewWithName(
        actionName: "Visited $traceablePageName",
        path: getCurrentPath(context),
      );
    });
  }

  @protected
  String get traceablePageName;
}
