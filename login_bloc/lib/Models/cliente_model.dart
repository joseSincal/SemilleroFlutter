class Cliente {
  late int id;
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
    dniCl = data['dniCl'];
    nombreCl = data['nombreCl'];
    apellido1 = data['apellido1'];
    apellido2 = data['apellido2'];
    claseVia = data['claseVia'];
    nombreVia = data['nombreVia'];
    numeroVia = data['numeroVia'];
    codPostal = data['codPostal'];
    ciudad = data['ciudad'];
    telefono = data['telefono'];
    observaciones = data['observaciones'];
  }

  Cliente.fromDb(Map<String, dynamic> data) {
    id = data['id'];
    dniCl = data['dniCl'];
    nombreCl = data['nombreCl'];
    apellido1 = data['apellido1'];
    apellido2 = data['apellido2'];
    claseVia = data['claseVia'];
    nombreVia = data['nombreVia'];
    numeroVia = data['numeroVia'];
    codPostal = data['codPostal'];
    ciudad = data['ciudad'];
    telefono = data['telefono'];
    observaciones = data['observaciones'];
  }

  Map<String, dynamic> toDatabase() => {
        'dniCl': dniCl,
        'nombreCl': nombreCl,
        'apellido1': apellido1,
        'apellido2': apellido2,
        'claseVia': claseVia,
        'nombreVia': nombreVia,
        'numeroVia': numeroVia,
        'codPostal': codPostal,
        'ciudad': ciudad,
        'telefono': telefono,
        'observaciones': observaciones
      };
}
