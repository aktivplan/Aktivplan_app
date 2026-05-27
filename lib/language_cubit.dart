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
