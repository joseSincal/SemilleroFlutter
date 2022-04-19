class Seguro {
  late int numeroPoliza;
  late String ramo;
  late DateTime fechaInicio;
  late DateTime fechaVencimiento;
  late String condicionesParticulares;
  late String observaciones;
  late int dniCl;

  Seguro.fromService(Map<String, dynamic> data) {
    this.numeroPoliza = data['numeroPoliza'];
    this.ramo = data['ramo'];
    this.fechaInicio = DateTime.parse(data['fechaInicio']);
    this.fechaVencimiento = DateTime.parse(data['fechaVencimiento']);
    this.condicionesParticulares = data['condicionesParticulares'];
    this.observaciones = data['observaciones'];
    this.dniCl = data['dniCl'];
  }
}
