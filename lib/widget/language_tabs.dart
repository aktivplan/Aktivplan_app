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
