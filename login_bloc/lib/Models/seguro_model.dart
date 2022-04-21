import 'package:intl/intl.dart';

class Seguro {
  late int id;
  late int numeroPoliza;
  late String ramo;
  late DateTime fechaInicio;
  late DateTime fechaVencimiento;
  late String condicionesParticulares;
  late String observaciones;
  late int dniCl;

  Seguro.fromService(Map<String, dynamic> data) {
    numeroPoliza = data['numeroPoliza'];
    ramo = data['ramo'];
    fechaInicio = DateFormat("dd-MM-yyyy").parse(data['fechaInicio']);
    fechaVencimiento = DateFormat("dd-MM-yyyy").parse(data['fechaVencimiento']);
    condicionesParticulares = data['condicionesParticulares'];
    observaciones = data['observaciones'];
    dniCl = data['dniCl'];
  }

  Seguro.fromDb(Map<String, dynamic> data) {
    id = data["id"];
    numeroPoliza = data['numeroPoliza'];
    ramo = data['ramo'];
    fechaInicio = DateFormat("dd-MM-yyyy").parse(data['fechaInicio']);
    fechaVencimiento = DateFormat("dd-MM-yyyy").parse(data['fechaVencimiento']);
    condicionesParticulares = data['condicionesParticulares'];
    observaciones = data['observaciones'];
    dniCl = data['dniCl'];
  }

  Map<String, dynamic> toDatabase() => {
        'numeroPoliza': numeroPoliza,
        'ramo': ramo,
        'fechaInicio': DateFormat("dd-MM-yyyy").format(fechaInicio),
        'fechaVencimiento': DateFormat("dd-MM-yyyy").format(fechaVencimiento),
        'condicionesParticulares': condicionesParticulares,
        'observaciones': observaciones,
        'dniCl': dniCl
      };

  String toStringJson() => "{ "
      "'numeroPoliza': $numeroPoliza, "
      "'ramo': '$ramo', "
      "'fechaInicio': '${DateFormat("dd-MM-yyyy").format(fechaInicio)}', "
      "'fechaVencimiento': '${DateFormat("dd-MM-yyyy").format(fechaVencimiento)}', "
      "'condicionesParticulares': '$condicionesParticulares', "
      "'observaciones': '$observaciones', "
      "'dniCl': $dniCl "
      "}";
}
