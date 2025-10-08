// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
