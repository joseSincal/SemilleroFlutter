import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_bloc/utils/app_preferences.dart';

class LanguajeProvider with ChangeNotifier {
  static Locale? _locale;

  Future<Locale> getDefaultLanguaje() async {
    final String? savedLang =
        await AppPreferences.shared.getString(AppPreferences.LANGUAJE_APP);
    if (savedLang != null) {
      return Locale(savedLang, '');
    } else {
      _locale = Locale(Platform.localeName.substring(0, 2), '');
      return _locale!;
    }
  }

  Locale get getLang => _locale!;

  set setLanguaje(Locale lang) {
    _locale = lang;
    AppPreferences.shared
        .setString(AppPreferences.LANGUAJE_APP, lang.languageCode);
    notifyListeners();
  }
}
