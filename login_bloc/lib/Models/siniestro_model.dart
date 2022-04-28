import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:login_bloc/Models/seguro_model.dart';

class Siniestro {
  late int id;
  late int idSiniestro;
  late DateTime fechaSiniestro;
  late String causas;
  late bool aceptado;
  late String indenmizacion;
  late Seguro seguro;

  Siniestro.fromService(Map<String, dynamic> data) {
    idSiniestro = data['idSiniestro'];
    fechaSiniestro = DateFormat("dd-MM-yyyy").parse(data['fechaSiniestro']);
    causas = data['causas']??"";
    aceptado = data['aceptado'] == "1";
    indenmizacion = data['indenmizacion']??0;
    seguro = Seguro.fromService(data['seguro']);
  }

  Siniestro.fromDb(Map<String, dynamic> data) {
    id = data["id"];
    idSiniestro = data['idSiniestro'];
    fechaSiniestro = DateFormat("dd-MM-yyyy").parse(data['fechaSiniestro']);
    causas = data['causas'];
    aceptado = data['aceptado'] == 1;
    indenmizacion = data['indenmizacion'];
    seguro =
        Seguro.fromService(json.decode(data['seguro'].replaceAll("'", "\"")));
  }

  Map<String, dynamic> toDatabase() => {
        'idSiniestro': idSiniestro,
        'fechaSiniestro': DateFormat("dd-MM-yyyy").format(fechaSiniestro),
        'causas': causas,
        'aceptado': aceptado ? 1 : 0,
        'indenmizacion': indenmizacion,
        'seguro': seguro.toStringJson()
      };
}
