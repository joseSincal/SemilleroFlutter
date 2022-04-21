import 'package:login_bloc/Repository/db_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class MasterRepository {
  Future<dynamic> save(
      {required List<dynamic> data, required String tableName}) async {
    Database dbManager = await DbManager().db;
    Batch batch = dbManager.batch();
    for (final item in data) {
      batch.insert(tableName, item.toDatabase());
    }
    return batch.commit();
  }

  Future<void> delete(
      {required String tablaName,
      required String whereClause,
      required List<String> whereArgs}) async {
    Database dbManager = await DbManager().db;
    dbManager.delete(tablaName, where: whereClause, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> selectAll(
      {required String tablaName}) async {
    Database dbManager = await DbManager().db;
    return await dbManager.query(tablaName);
  }

  Future<List<Map<String, dynamic>>> selectWhere(
      {required String tablaName,
      required String whereClause,
      required List<String> whereArgs}) async {
    Database dbManager = await DbManager().db;
    return await dbManager.query(tablaName,
        where: whereClause, whereArgs: whereArgs);
  }

  Future<void> update(
      {required String tablaName,
      required Map<String, dynamic> data,
      required String whereClause,
      required List<String> whereArgs}) async {
    Database dbManager = await DbManager().db;
    dbManager.update(tablaName, data, where: whereClause, whereArgs: whereArgs);
  }

  Future<void> addColumn(
      {required String tablaName,
      required String columnName,
      required String typeColumn}) async {
    Database dbManager = await DbManager().db;
    return await dbManager
        .execute("ALTER TABLE $tablaName ADD COLUMN $columnName $typeColumn");
  }
}
