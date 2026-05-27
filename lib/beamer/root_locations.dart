import 'package:aptapp/beamer/apt_beam_page.dart';
import 'package:aptapp/help_page.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/login/login_page.dart';
import 'package:aptapp/login/reset_password_page.dart';
import 'package:aptapp/notFound/not_found_page.dart';
import 'package:aptapp/legal_notice_page.dart';
import 'package:aptapp/patient/onboarding_page.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class LoginLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/login'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          title: context.i18n.appTitle,
          key: ValueKey('login'),
          child: LoginPage(),
        ),
      ];
}

class ResetPasswordLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/resetPassword', '/resetPassword/:token'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        AptBeamPage(
          context: context,
          key: ValueKey('resetPassword'),
          child: ResetPasswordPage(
            resetKey: state.pathParameters['token'] ?? "",
            languageCode: state.queryParameters['language'] ?? "",
          ),
        ),
      ];
}

class ImprintLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/imprint',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('imprint'),
        child: LegalNoticePage(),
      ),
    ];
  }
}

class HelpLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/help',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('help'),
        child: HelpPage(),
      ),
    ];
  }
}

class OnboardingLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/onboarding',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      AptBeamPage(
        context: context,
        key: ValueKey('onboarding'),
        child: OnboardingPage(
          isKlimafit: state.queryParameters['klimafit'] == 'true',
          isSinglePage: true,
        ),
      ),
    ];
  }
}

class NotFoundLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/not-found'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('not-found'),
          child: NotFoundPage(),
        ),
      ];
}

final rootLocations = [
  LoginLocation(),
  ResetPasswordLocation(),
  ImprintLocation(),
  HelpLocation(),
  OnboardingLocation(),
  NotFoundLocation(),
];
