import 'dart:convert';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login_bloc/Providers/agregar_peticion.dart';
import 'package:login_bloc/Providers/location.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  ApiManager._privateConstructor();

  static final ApiManager shared = ApiManager._privateConstructor();

  Future<dynamic> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
  }) async {
    final uri = Uri.http(baseUrl, pathUrl);

    dynamic response;
    dynamic headers = {
      'Content-Type': 'application/json',
    };

    switch (type) {
      case HttpType.GET:
        response = await http.get(uri);
        break;
      case HttpType.POST:
        response = await http.post(uri,
            headers: headers, body: json.encode(bodyParams));
        break;
      case HttpType.PUT:
        response = await http.put(uri,
            headers: headers, body: json.encode(bodyParams));
        break;
      case HttpType.DELETE:
        response = await http.delete(uri);
        break;
    }

    Position pos = await LocationProvider().determinePosition();
    await AgregarPeticion.shared
        .AddPeticion(pos, response.statusCode, uri.toString(), type);

    if (response.statusCode == 200) {
      if (response.body != "") {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
    } else if (response.statusCode == 403) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.recordError(
            "Error en API usuario", StackTrace.empty,
            reason:
                "StatusCode: ${response.statusCode}. Usuario no autorizado: $uri");
      } else {
        log("No se pudo enviar el error");
      }
      return response;
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
