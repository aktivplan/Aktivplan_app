// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:math';

import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QrScanInfoPage extends StatefulWidget {
  QrScanInfoPage({Key? key}) : super(key: key);

  @override
  _QrScanInfoPageState createState() => _QrScanInfoPageState();
}

class _QrScanInfoPageState extends State<QrScanInfoPage> with TraceablePageMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = min(500, width * 0.9);
    final String languageCode = Localizations.localeOf(context).languageCode.toLowerCase();

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: containerWidth,
          child: Column(
            children: [
              SizedBox(height: 30),
              Image.asset(
                "assets/images/logo.png",
                height: 150,
              ),
              StyledText(
                  text: context.i18n.qrCodeUnsupported,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                  tags: {
                    'b': StyledTextTag(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  }),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: ResponsiveGridRow(
                  children: [
                    ResponsiveGridCol(
                      md: 6,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0, bottom: 20),
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          onTap: () => launchUrlString(iosStoreUrl, mode: LaunchMode.externalApplication),
                          child: Image.asset(
                            "assets/images/app_store_$languageCode.png",
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      md: 6,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          onTap: () => launchUrlString(googlePlayStoreUrl, mode: LaunchMode.externalApplication),
                          child: Image.asset(
                            "assets/images/google_play_$languageCode.png",
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get traceablePageName => "QR Scan Info Page";
}
