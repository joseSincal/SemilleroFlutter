import 'dart:convert';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/Providers/agregar_peticion.dart';
import 'package:login_bloc/Providers/location.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:http/http.dart' as http;

class ApiUsuario {
  ApiUsuario._privateConstructor();

  static final ApiUsuario shared = ApiUsuario._privateConstructor();

  Future<Usuario?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
  }) async {
    final uri = Uri.http(baseUrl, pathUrl);

    http.Response response;

    switch (type) {
      case HttpType.GET:
        response = await http.get(uri);
        break;
      case HttpType.POST:
        response = await http.post(uri,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(bodyParams));
        break;
      case HttpType.PUT:
        response = await http.put(uri);
        break;
      case HttpType.DELETE:
        response = await http.delete(uri);
        break;
    }

    Position pos = await LocationProvider().determinePosition();
    await AgregarPeticion.shared.AddPeticion(pos, response.statusCode, uri.toString(), type);

    if (response.statusCode == 200) {
      if (response.body != "") {
        final body = jsonDecode(response.body);
        return Usuario.fromService(body);
      }
    } else {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.recordError(
            "Error en API usuario", StackTrace.empty,
            reason:
                "StatusCode: ${response.statusCode}. Error al llamar a la URL: $uri");
      } else {
        log("No se pudo enviar el error");
      }
    }

    return null;
  }
}
