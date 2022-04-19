import 'package:flutter/material.dart';
import 'package:login_bloc/Models/theme_preferences.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return Scaffold(
        body: Stack(children: [
      Background(height: 300),
      const AppBarTitle(title: 'Settings'),
      ListView(
        padding: const EdgeInsets.only(top: 120.0),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.wb_sunny,
                    color: currentTheme.isDarkTheme() ? Colors.white : xiketic),
                Switch(
                    value: currentTheme.isDarkTheme(),
                    onChanged: (value) {
                      String newTheme =
                          value ? ThemePreference.DARK : ThemePreference.LIGHT;
                      currentTheme.updateTheme = newTheme;
                    }),
                Icon(Icons.brightness_2,
                    color: currentTheme.isDarkTheme() ? Colors.white : xiketic)
              ],
            ),
          )
        ],
      )
    ]));
  }
}
