import 'package:login_bloc/Models/seguro_model.dart';

class Siniestro {
  late int idSiniestro;
  late DateTime fechaSiniestro;
  late String causas;
  late bool aceptado;
  late String indenmizacion;
  late Seguro seguro;

  Siniestro.fromService(Map<String, dynamic> data) {
    this.idSiniestro = data['idSiniestro'];
    this.fechaSiniestro = DateTime.parse(data['fechaSiniestro']);
    this.causas = data['causas'];
    this.aceptado = data['aceptado'] == "1";
    this.indenmizacion = data['indenmizacion'];
    this.seguro = Seguro.fromService(data['seguro']);
  }
}
