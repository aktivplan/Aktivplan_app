import 'dart:convert';

import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/patient/onboarding_page.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with TraceablePageMixin {
  String version = "";

  @override
  void initState() {
    super.initState();
    rootBundle.loadString("assets/version/version.json").then((value) => setState(() => version = json.decode(value)["currentVersion"]));
  }

  @override
  Widget build(BuildContext context) {
    MatomoTracker.instance.trackPageViewWithName(
      actionName: "Visited Help Page",
      path: getCurrentPath(context),
    );
    final InstitutionDTO currentInstitution = KiwiContainer().resolve<UserRepository>().currentInstitution!;

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
                "Version $version",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 30),
              StyledText(
                  text: context.i18n.helpOnboardingGuide,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  tags: {
                    'a': StyledTextActionTag(
                      (text, attrs) {
                        OnboardingPage.showOnboardingDialog(context);
                      },
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  }),
              SizedBox(height: 30),
              StyledText(
                  text: KiwiContainer().resolve<UserRepository>().userRole == UserRole.PATIENT
                      ? context.i18n.helpUserGuidePatients
                      : context.i18n.helpUserGuideExperts,
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
              SelectableText(
                context.i18n.helpTextProblems,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
              ),
              if ((currentInstitution.emailUserQueries ?? "").isNotEmpty || (currentInstitution.phoneNumberUserQueries ?? "").isNotEmpty)
                SizedBox(height: 30),
              if ((currentInstitution.emailUserQueries ?? "").isNotEmpty)
                StyledText(
                    text: "${context.i18n.email}: <email>${currentInstitution.emailUserQueries}</email>",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                    tags: {
                      'email': StyledTextActionTag(
                        (text, attrs) {
                          launchUrl(
                            Uri(
                              scheme: 'mailto',
                              path: currentInstitution.emailUserQueries,
                            ),
                          );
                        },
                        style: TextStyle(decoration: TextDecoration.underline),
                      )
                    }),
              if ((currentInstitution.phoneNumberUserQueries ?? "").isNotEmpty)
                StyledText(
                    text: "${context.i18n.phone}: <phone>${currentInstitution.phoneNumberUserQueries}</phone>" +
                        (getTranslatedText(currentInstitution.availabilityPhone, context).isNotEmpty
                            ? " (${getTranslatedText(currentInstitution.availabilityPhone, context)})"
                            : ""),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                    tags: {
                      'phone': StyledTextActionTag(
                        (text, attrs) {
                          launchUrl(
                            Uri(
                              scheme: 'tel',
                              path: currentInstitution.phoneNumberUserQueries!.replaceAll(" ", ""),
                            ),
                          );
                        },
                        style: TextStyle(decoration: TextDecoration.underline),
                      )
                    }),
              if (getTranslatedText(currentInstitution.getInTouchNotes, context).isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SelectableText(
                    getTranslatedText(currentInstitution.getInTouchNotes, context),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black, height: 1.2, fontWeight: FontWeight.normal),
                  ),
                ),
            ],
          ),
        ));
      },
    );
  }

  String get traceablePageName => "Help Page";
}
