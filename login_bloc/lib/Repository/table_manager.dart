import 'package:sqflite/sqflite.dart';

class TableManager {
  TableManager._privateConstructor();

  static final TableManager shared = TableManager._privateConstructor();

  Future<void> cliente(Database db) async {
    const String table = "CREATE TABLE cliente( "
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "dniCl INTEGER, "
        "nombreCl TEXT, "
        "apellido1 TEXT, "
        "apellido2 TEXT, "
        "claseVia TEXT, "
        "numeroVia INTEGER, "
        "codPostal INTEGER, "
        "ciudad TEXT, "
        "telefono INTEGER, "
        "observaciones TEXT, "
        "nombreVia TEXT "
        ");";

    await db.execute(table);
  }

  Future<void> seguro(Database db) async {
    const String table = "CREATE TABLE seguro( "
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "numeroPoliza INTEGER, "
        "ramo TEXT, "
        "fechaInicio TEXT, "
        "fechaVencimiento TEXT, "
        "condicionesParticulares TEXT, "
        "observaciones TEXT, "
        "dniCl INTEGER "
        ");";

    await db.execute(table);
  }

  Future<void> siniestro(Database db) async {
    const String table = "CREATE TABLE siniestro( "
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "idSiniestro INTEGER, "
        "fechaSiniestro TEXT, "
        "causas TEXT, "
        "aceptado INTEGER, "
        "indenmizacion TEXT, "
        "seguro TEXT "
        ");";

    await db.execute(table);
  }
}
