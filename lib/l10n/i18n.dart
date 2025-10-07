import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension I18n on BuildContext {
  AppLocalizations get i18n {
    return AppLocalizations.of(this)!;
  }
}

extension I18nState<T extends StatefulWidget> on State<T> {
  AppLocalizations get i18n {
    return AppLocalizations.of(context)!;
  }
}
