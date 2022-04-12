import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc/Models/theme_preferences.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:provider/provider.dart';

class PageUser extends StatelessWidget {
  final String username;
  const PageUser({required this.username, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: currentTheme.isDarkTheme()
          ? const Color(0xff2a293d)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: currentTheme.isDarkTheme()
            ? Colors.black12
            : Colors.blue,
        title: Text(username),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Toca para cambiar de tema',
            style: TextStyle(
                color: currentTheme.isDarkTheme()
                    ? Colors.white
                    : Colors.black),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.wb_sunny,
                  color: currentTheme.isDarkTheme()
                      ? Colors.white
                      : Colors.black),
              Switch(
                  value: currentTheme.isDarkTheme(),
                  onChanged: (value) {
                    String newTheme =
                        value ? ThemePreference.DARK : ThemePreference.LIGHT;
                    currentTheme.setTheme = newTheme;
                  }),
              Icon(Icons.brightness_2,
                  color: currentTheme.isDarkTheme()
                      ? Colors.white
                      : Colors.black)
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              child: const Text('Generar Error')),
        ]),
      ),
    );
  }
}
