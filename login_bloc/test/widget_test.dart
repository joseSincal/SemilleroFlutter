import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Models/theme_preferences.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/Pages/Page_clientes/widgets/cliente_card.dart';
import 'package:login_bloc/Pages/Page_init/page_init.dart';
import 'package:login_bloc/Pages/Page_seguros/widgets/seguro_card.dart';
import 'package:login_bloc/Pages/Page_siniestro/widgets/siniestro_card.dart';
import 'package:login_bloc/Pages/Page_user/widgets/user_info.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Providers/theme_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';
import 'package:provider/provider.dart';

void main() {
  ThemeProvider themeChangeProvider = ThemeProvider();
  themeChangeProvider.setTheme = ThemePreference.DARK;

  LanguajeProvider langProvider = LanguajeProvider();
  Future<void> getCurrentLanguaje() async {
    langProvider.setLanguaje = await langProvider.getDefaultLanguaje();
  }

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
    testWidgets('Toda la pantalla', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(home: Scaffold(body: Background(height: null)))));
      await tester.pump();
      expect(find.byType(Background), findsOneWidget);
    });

    testWidgets('Height definido', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(home: Scaffold(body: Background(height: 356.9)))));
      await tester.pump();
      expect(find.byType(Background), findsOneWidget);
    });
  });

  group('Widget Button Large', () {
    testWidgets('Button Large Test', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(
              home: Scaffold(
                  body: ButtonLarge(
                      buttonText: 'Button Large Test', onPressed: () {})))));
      await tester.pump();
      expect(find.text('Button Large Test'), findsOneWidget);
    });
  });

  group('Text Input Widget', () {
    TextEditingController _testController = TextEditingController();

    testWidgets('Normal sin icono', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(
              home: Scaffold(
                  body: TextInput(
            controller: _testController,
            hintText: 'Prueba',
            inputType: TextInputType.text,
          )))));
      await tester.pump();
      expect(find.text('Prueba'), findsOneWidget);
      expect(find.byIcon(Icons.wine_bar), findsNothing);
    });

    testWidgets('Normal con icono', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(
              home: Scaffold(
                  body: TextInput(
            controller: _testController,
            hintText: 'Prueba2',
            inputType: TextInputType.text,
            icon: Icons.wine_bar_rounded,
          )))));
      await tester.pump();
      expect(find.text('Prueba2'), findsOneWidget);
      expect(find.byIcon(Icons.wine_bar), findsNothing);
      expect(find.byIcon(Icons.wine_bar_rounded), findsOneWidget);
    });

    testWidgets('Password', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(
              home: Scaffold(
                  body: TextInputPassword(
            controller: _testController,
            hintText: 'Prueba Password',
            inputType: TextInputType.visiblePassword,
          )))));
      await tester.pump();
      expect(find.text('Prueba Password'), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('Date', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(
              home: Scaffold(
                  body: TextDateInput(
            controller: _testController,
            hintText: 'Prueba Fecha',
          )))));
      await tester.pump();
      expect(find.text('Prueba Fecha'), findsOneWidget);
      expect(find.byIcon(Icons.date_range_rounded), findsOneWidget);
    });

    testWidgets('CheckBox', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(
              home: Scaffold(
                  body: ChechBoxInput(
            status: true,
            title: 'Paso la prueba',
          )))));
      await tester.pump();
      expect(find.text('Paso la prueba'), findsNothing);
      expect(find.text('Aceptado'), findsOneWidget);
    });
  });

  group('User Info', () {
    testWidgets('User', (WidgetTester tester) async {
      var data = {
        "id": 5,
        "email": "nh8X5vcY9wc=",
        "password": "testing",
        "username": "testing"
      };

      Usuario user = Usuario.fromService(data);

      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: MaterialApp(home: Scaffold(body: UserInfo(usuario: user)))));
      await tester.pump();
      expect(find.text('testing'), findsOneWidget);
      expect(find.byType(Row), findsWidgets);
    });
  });

  group('Splash', () {
    testWidgets('Page init', (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: themeChangeProvider,
          child: const MaterialApp(home: PageInit())));
      await tester.pump();
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Stack), findsWidgets);
    });
  });

  group('Cards', () {
    testWidgets('Cliente card', (WidgetTester tester) async {
      var data = {
        'dniCl': 0,
        'nombreCl': 'test',
        'apellido1': 'test',
        'telefono': 11111111
      };

      Cliente cliente = Cliente.fromService(data);

      await tester.pumpWidget(FutureBuilder(
          future: getCurrentLanguaje(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(
                      value: themeChangeProvider,
                    ),
                    ChangeNotifierProvider(create: (_) => LanguajeProvider())
                  ],
                  child: Consumer2(
                    builder: (context, ThemeProvider themeProvider,
                        LanguajeProvider languajeProvider, widget) {
                      return MaterialApp(
                        locale: languajeProvider.getLang,
                        home:
                            ClienteCard(cliente: cliente, contextList: context),
                      );
                    },
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }));
      await tester.pump();
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('Seguro card', (WidgetTester tester) async {
      var data = {
        'numeroPoliza': 0,
        'ramo': 'test',
        'fechaInicio': '2022-05-17',
        'fechaVencimiento': '2022-05-17',
        'dniCl': 0
      };

      Seguro seguro = Seguro.fromService(data);

      await tester.pumpWidget(FutureBuilder(
          future: getCurrentLanguaje(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(
                      value: themeChangeProvider,
                    ),
                    ChangeNotifierProvider(create: (_) => LanguajeProvider())
                  ],
                  child: Consumer2(
                    builder: (context, ThemeProvider themeProvider,
                        LanguajeProvider languajeProvider, widget) {
                      return MaterialApp(
                        locale: languajeProvider.getLang,
                        home: SeguroCard(seguro: seguro, contextList: context),
                      );
                    },
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }));
      await tester.pump();
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('Siniestro card', (WidgetTester tester) async {
      var data = {
        'idSiniestro': 0,
        'fechaSiniestro': '2022-05-17',
        'aceptado': '1',
        'fechaVencimiento': '2022-05-17',
        'seguro': {
          'numeroPoliza': 0,
          'ramo': 'test',
          'fechaInicio': '2022-05-17',
          'fechaVencimiento': '2022-05-17',
          'dniCl': 0
        }
      };

      Siniestro siniestro = Siniestro.fromService(data);

      await tester.pumpWidget(FutureBuilder(
          future: getCurrentLanguaje(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(
                      value: themeChangeProvider,
                    ),
                    ChangeNotifierProvider(create: (_) => LanguajeProvider())
                  ],
                  child: Consumer2(
                    builder: (context, ThemeProvider themeProvider,
                        LanguajeProvider languajeProvider, widget) {
                      return MaterialApp(
                        locale: languajeProvider.getLang,
                        home: SiniestroCard(siniestro: siniestro, contextList: context),
                      );
                    },
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }));
      await tester.pump();
      expect(find.byType(GestureDetector), findsOneWidget);
    });
  });
}
