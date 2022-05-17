import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login_bloc/utils/app_type.dart';

class AgregarPeticion {
  AgregarPeticion._privateConstructor();

  static final AgregarPeticion shared = AgregarPeticion._privateConstructor();

  Future<void> AddPeticion(Position pos, int statusCode, String url, HttpType type) async {
    CollectionReference peticiones =
        FirebaseFirestore.instance.collection('peticiones');

    var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;

    return peticiones
        .add({
          'url': url,
          'statusCode': statusCode,
          'type': type.toString(),
          'position': {
            'longitude': pos.longitude,
            'latitude': pos.latitude,
            'accuracy': pos.accuracy,
            'altitude': pos.altitude
          },
          'devide_id': androidDeviceInfo.androidId,
          'time': DateTime.now()
        })
        .then((value) => log("Petición Guardada"))
        .catchError((error) {
          if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
            FirebaseCrashlytics.instance.recordError(
                "Error al guardar la peticion", StackTrace.empty,
                reason: "ERROR $error");
          } else {
            log("No se pudo enviar el error");
          }
        });
  }
}
