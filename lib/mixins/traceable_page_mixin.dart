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
