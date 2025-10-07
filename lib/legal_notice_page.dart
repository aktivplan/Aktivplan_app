import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LegalNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MatomoTracker.instance.trackPageViewWithName(
      actionName: "Visited Legal Notice Page",
      path: getCurrentPath(context),
    );

    return ResponsiveBuilder(
      builder: (context, size) {
        return SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SelectableText(
                context.i18n.legalNoticeCompanyName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              SelectableText(
                context.i18n.legalNoticeCompanyDescription,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 30),
              SelectableText(
                context.i18n.legalNoticeCompanyContactAddress,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
              ),
              StyledText(
                  text: context.i18n.legalNoticeCompanyContactPhone,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  tags: {
                    'phone': StyledTextActionTag(
                      (text, attrs) {
                        String phoneNumber = attrs['number']!;
                        launchUrl(
                          Uri(
                            scheme: 'tel',
                            path: phoneNumber,
                          ),
                        );
                      },
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  }),
              StyledText(
                  text: context.i18n.legalNoticeCompanyContactMail,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  tags: {
                    'mail': StyledTextActionTag(
                      (text, attrs) {
                        String mail = attrs['target']!;
                        launchUrl(
                          Uri(
                            scheme: 'mailto',
                            path: mail,
                          ),
                        );
                      },
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  }),
              SizedBox(height: 30),
              StyledText(
                  text: context.i18n.legalNoticeMoreInformation,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  tags: {
                    'a': StyledTextActionTag(
                      (text, attrs) {
                        launchUrlString(attrs['href']!);
                      },
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  }),
              SizedBox(height: 30),
              SelectableText(
                context.i18n.legalNoticeDataProtection,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              StyledText(
                  text: context.i18n.legalNoticeTermsAndConditions,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  tags: {
                    'a': StyledTextActionTag(
                      (text, attrs) {
                        launchUrl(Uri.parse(attrs['href']!), mode: LaunchMode.externalApplication);
                      },
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  }),
              SizedBox(height: 30),
              StyledText(
                  text: context.i18n.legalNoticePrivacyPolicy,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  tags: {
                    'a': StyledTextActionTag(
                      (text, attrs) {
                        launchUrl(Uri.parse(attrs['href']!), mode: LaunchMode.externalApplication);
                      },
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  }),
            ],
          ),
        ));
      },
    );
  }
}
