import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/Models/theme_preferences.dart';
import 'package:login_bloc/Providers/theme_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:provider/provider.dart';

void main() {
  group('test', () {
    testWidgets('test widget Text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Text('Hola mundo')),
        ),
      );
      await tester.pump();
      expect(find.byType(Text), findsOneWidget);
      expect(find.text("Hola mundo"), findsOneWidget);
    });

    testWidgets('test widget App Bar Title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(body: AppBarTitle(title: 'Testing'))));
      await tester.pump();
      expect(find.byType(AppBarTitle), findsOneWidget);
      expect(find.text("Testing"), findsOneWidget);
    });
  });

  group('Background', () {
    ThemeProvider themeChangeProvider = ThemeProvider();
    themeChangeProvider.setTheme = ThemePreference.DARK;

    testWidgets('Toda la pantalla', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(home: Scaffold(body: Background(height: null)))));
      await tester.pump();
      expect(find.byType(Background), findsOneWidget);
    });
  });
}
