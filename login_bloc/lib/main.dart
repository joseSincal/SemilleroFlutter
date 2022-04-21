import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Pages/Page_init/page_init.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:login_bloc/Repository/cliente_repository.dart';
import 'package:login_bloc/Repository/seguro_repository.dart';
import 'package:login_bloc/Repository/siniestro_repository.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runZonedGuarded(() => runApp(const MyApp()),
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();
  late Future<void> _firebase;

  Future<void> _initializeFB() async {
    await Firebase.initializeApp();
    await _initializeC();
    await _initializeRC();
    await _initializeCM();
    getCurrentAppTheme();
    await _deleteDb();

    await _cargarSeguros();
    await _cargarClientes();
    await _cargarSiniestros();
  }

  Future<void> _deleteDb() async {
    Directory directoryDb = await getApplicationDocumentsDirectory();
    String path = "${directoryDb.path}test.db";
    databaseFactory.deleteDatabase(path);
  }

  Future<void> _initializeC() async {
    //await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    Function onOriginalError = FlutterError.onError as Function;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      onOriginalError(errorDetails);
    };
  }

  Future<void> _initializeRC() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    remoteConfig.setDefaults({
      'parametro': 1,
      'userEmail': 'ottozincal@gmail.com',
      'password': 'heiy'
    });
  }

  Future<void> _initializeCM() async {
    FirebaseMessaging cloudMessagin = FirebaseMessaging.instance;

    String token = await cloudMessagin.getToken() ?? "";
    log(token);

    FirebaseMessaging.onMessage.listen((event) {
      log(event.notification!.title!);
    });
  }

  void getCurrentAppTheme() {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('preferencias/tema');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      themeChangeProvider.setTheme = data as String;
    });
  }

  Future<void> _cargarClientes() async {
    dynamic bodyRequest = await ApiManager.shared.request(
        baseUrl: "192.168.1.4:9595",
        pathUrl: "/cliente/buscar",
        type: HttpType.GET);
    if (bodyRequest != null) {
      List<Cliente> lista = List<Cliente>.empty(growable: true);
      for (var item in bodyRequest as List<dynamic>) {
        final Cliente cliente = Cliente.fromService(item);
        lista.add(cliente);
      }
      ClienteRepository.shared.save(data: lista, tableName: 'cliente');
    }
  }

  Future<void> _cargarSeguros() async {
    dynamic bodyRequest = await ApiManager.shared.request(
        baseUrl: "192.168.1.4:9595",
        pathUrl: "/seguro/buscar",
        type: HttpType.GET);
    if (bodyRequest != null) {
      List<Seguro> lista = List<Seguro>.empty(growable: true);
      for (var item in bodyRequest as List<dynamic>) {
        final Seguro seguro = Seguro.fromService(item);
        lista.add(seguro);
      }
      SeguroRepository.shared.save(data: lista, tableName: 'seguro');
    }
  }

  Future<void> _cargarSiniestros() async {
    dynamic bodyRequest = await ApiManager.shared.request(
        baseUrl: "192.168.1.4:9595",
        pathUrl: "/siniestro/buscar",
        type: HttpType.GET);
    if (bodyRequest != null) {
      List<Siniestro> lista = List<Siniestro>.empty(growable: true);
      for (var item in bodyRequest as List<dynamic>) {
        final Siniestro siniestro = Siniestro.fromService(item);
        lista.add(siniestro);
      }
      SiniestroRepository.shared.save(data: lista, tableName: 'siniestro');
    }
  }

  @override
  void initState() {
    super.initState();
    _firebase = _initializeFB();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider.value(
                value: themeChangeProvider,
                child: MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: const PageInit(),
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
