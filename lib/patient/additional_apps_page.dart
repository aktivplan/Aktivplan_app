// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/external_app/bloc/external_app_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdditionalAppsPage extends StatefulWidget {
  @override
  _AdditionalAppsPageState createState() => _AdditionalAppsPageState();
}

class _AdditionalAppsPageState extends State<AdditionalAppsPage> with TraceablePageMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExternalAppBloc>(context).add(FetchExternalAppsEvent());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    MatomoTracker.instance.trackPageViewWithName(
      actionName: "Visited Additional Apps Page",
      path: getCurrentPath(context),
    );

    return ResponsiveBuilder(
      builder: (context, size) {
        double containerWidth = size.isMobile
            ? width * 0.95
            : size.isTablet
                ? width * 0.85
                : width * 0.6;
        return Center(
          heightFactor: 1.1,
          child: SingleChildScrollView(
            child: Container(
              width: containerWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 5),
                  SelectableText(context.i18n.additionalApps, style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.2)),
                  SizedBox(height: 25),
                  SelectableText(
                    context.i18n.additionalAppsDescription,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 25),
                  BlocBuilder<ExternalAppBloc, ExternalAppState>(builder: (context, state) {
                    if (!(state is FetchedExternalAppsState)) {
                      return CircularProgressIndicator();
                    }
                    return Column(
                      children: state.externalApps.map((app) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: size.isMobile && getSingleLinkForApp(app).isNotEmpty
                                  ? () {
                                      launchUrlString(getSingleLinkForApp(app), mode: LaunchMode.externalApplication);
                                    }
                                  : null,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslatedText(app.title, context),
                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            getTranslatedText(app.description, context),
                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
                                          ),
                                          if (getSingleLinkForApp(app).isEmpty && getLinkListForApp(app).isNotEmpty)
                                            Wrap(children: getLinkListForApp(app)),
                                        ],
                                      ),
                                    ),
                                    if (size.isMobile && getSingleLinkForApp(app).isNotEmpty)
                                      Icon(
                                        Icons.chevron_right,
                                        color: color,
                                        size: 30,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getSingleLinkForApp(ExternalAppDTO externalApp) {
    if (kIsWeb) {
      return ""; // no single link for web
    }
    if (Platform.isIOS) {
      return externalApp.iosurl ?? externalApp.webUrl ?? externalApp.androidUrl ?? "";
    }
    return externalApp.androidUrl ?? externalApp.webUrl ?? externalApp.iosurl ?? "";
  }

  bool hasAnyAppLink(ExternalAppDTO externalApp) {
    return (externalApp.iosurl ?? "").isNotEmpty || (externalApp.androidUrl ?? "").isNotEmpty || (externalApp.webUrl ?? "").isNotEmpty;
  }

  List<Widget> getLinkListForApp(ExternalAppDTO externalApp) {
    List<Widget> toReturn = [];
    TextStyle? linkStyle = Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline);
    if ((externalApp.iosurl ?? "").isNotEmpty) {
      toReturn.add(
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () async {
              launchUrlString(externalApp.iosurl!, mode: LaunchMode.externalApplication);
            },
            child: Text(
              "Apple App Store",
              style: linkStyle,
            ),
          ),
        ),
      );
    }
    if ((externalApp.androidUrl ?? "").isNotEmpty) {
      toReturn.add(
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () async {
              launchUrlString(externalApp.androidUrl!, mode: LaunchMode.externalApplication);
            },
            child: Text(
              "Google Play Store",
              style: linkStyle,
            ),
          ),
        ),
      );
    }
    if ((externalApp.webUrl ?? "").isNotEmpty) {
      toReturn.add(
        InkWell(
          onTap: () async {
            launchUrlString(externalApp.webUrl!, mode: LaunchMode.externalApplication);
          },
          child: Text(
            "Website",
            style: linkStyle,
          ),
        ),
      );
    }
    return toReturn.map((e) => Padding(padding: EdgeInsets.only(top: 10), child: e)).toList();
  }

  String get traceablePageName => "Additional Apps Page";
}
