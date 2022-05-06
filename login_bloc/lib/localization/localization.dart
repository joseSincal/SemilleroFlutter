import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:login_bloc/utils/app_string_en.dart';
import 'package:login_bloc/utils/app_string_es.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String, Map<Strings, String>> _localizedValues = {
    'es': dictionary_es,
    'en': dictionary_en
  };

  String dictionary(Strings label) =>
      _localizedValues[locale.languageCode]![label] ?? "";
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['es', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
