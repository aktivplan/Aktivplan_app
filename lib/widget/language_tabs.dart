// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:flutter/material.dart';

class LanguageTabs extends StatefulWidget {
  final List<Widget> germanFields;
  final List<Widget> englishFields;
  LanguageTabs({Key? key, required this.germanFields, required this.englishFields}) : super(key: key);

  @override
  _LanguageTabsState createState() => _LanguageTabsState();
}

class _LanguageTabsState extends State<LanguageTabs> {
  bool isGerman = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                setState(() {
                  isGerman = true;
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1, color: primaryColor),
                backgroundColor: isGerman ? primaryColor.withOpacity(.2) : null,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(context.i18n.german, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  isGerman = false;
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1, color: primaryColor),
                backgroundColor: !isGerman ? primaryColor.withOpacity(.2) : null,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(context.i18n.englishTranslationOptional, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        ...(isGerman ? widget.germanFields : widget.englishFields)
      ],
    );
  }
}
