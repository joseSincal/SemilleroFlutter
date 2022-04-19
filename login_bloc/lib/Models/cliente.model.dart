class Cliente {
  late int dniCl;
  late String nombreCl;
  late String apellido1;
  late String apellido2;
  late String claseVia;
  late String nombreVia;
  late int numeroVia;
  late int codPostal;
  late String ciudad;
  late int telefono;
  late String observaciones;

  Cliente.fromService(Map<String, dynamic> data) {
    this.dniCl = data['dniCl'];
    this.nombreCl = data['nombreCl'];
    this.apellido1 = data['apellido1'];
    this.apellido2 = data['apellido2'];
    this.claseVia = data['claseVia'];
    this.nombreVia = data['nombreVia'];
    this.numeroVia = data['numeroVia'];
    this.codPostal = data['codPostal'];
    this.ciudad = data['ciudad'];
    this.telefono = data['telefono'];
    this.observaciones = data['observaciones'];
  }
}
