import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:login_bloc/Models/theme_preferences.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Providers/theme_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
        body: Stack(children: [
      Background(height: 350),
      AppBarTitle(title: localization.dictionary(Strings.settingsPageTitle)),
      Container(
        margin: const EdgeInsets.only(top: 110.0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 35.0),
              child: Text(
                localization.dictionary(Strings.settingsThemeOptionTitle),
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 7.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.wb_sunny,
                      color:
                          currentTheme.isDarkTheme() ? Colors.white : xiketic),
                  Switch(
                      value: currentTheme.isDarkTheme(),
                      onChanged: (value) {
                        String newTheme = value
                            ? ThemePreference.DARK
                            : ThemePreference.LIGHT;
                        currentTheme.updateTheme = newTheme;
                      }),
                  Icon(Icons.brightness_2,
                      color:
                          currentTheme.isDarkTheme() ? Colors.white : xiketic)
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            Container(
              margin: const EdgeInsets.only(left: 35.0),
              child: Text(
                localization.dictionary(Strings.settingsLanguajeOptionTitle),
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 42.0, vertical: 10.0),
              child: DropdownButtonHideUnderline(
                  child: GFDropdown(
                      hint: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Text(lang.getLang.languageCode)),
                      items: [
                        localization.dictionary(Strings.languajeOptionSpanish),
                        localization.dictionary(Strings.languajeOptionEnglish)
                      ]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        changeLang(value, context);
                      })),
            )
          ],
        ),
      )
    ]));
  }

  void changeLang(value, BuildContext context) async {
    Locale locale = await LanguajeProvider().getDefaultLanguaje();
    switch (value) {
      case 'Ingles':
      case 'English':
        locale = const Locale("en");
        break;
      case 'Español':
      case 'Spanish':
        locale = const Locale("es");
        break;
    }

    final langChange = Provider.of<LanguajeProvider>(context, listen: false);
    langChange.setLanguaje = locale;
  }
}
