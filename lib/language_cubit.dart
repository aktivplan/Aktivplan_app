// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/authentication/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit(Locale locale) : super(locale);

  void changeLanguage(BuildContext context) async {
    final String newLanguageCode = Localizations.localeOf(context).languageCode == 'de' ? 'en' : 'de';
    setLanguageCode(newLanguageCode);
  }

  void setLanguageCode(String languageCode) async {
    emit(Locale(languageCode));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language_code', languageCode);
    final userRepository = KiwiContainer().resolve<UserRepository>();
    if (userRepository.currentUser != null) {
      userRepository.persistLanguage(languageCode);
    }
  }
}
