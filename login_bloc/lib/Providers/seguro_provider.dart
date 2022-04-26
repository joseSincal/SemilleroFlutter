import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Repository/seguro_repository.dart';

class SeguroProvider {
  SeguroProvider._privateConstructor();

  static final SeguroProvider shared = SeguroProvider._privateConstructor();

  Future<List<dynamic>> getAllDb() async {
    return await SeguroRepository.shared.selectAll(tablaName: 'seguro');
  }

  Future<dynamic> saveSeguro(Seguro seguro) async {
    return await SeguroRepository.shared.save(data: [seguro], tableName: 'seguro');
  }

  Future<dynamic> updateSeguro(Map<String, dynamic> seguro, int id) async {
    return await SeguroRepository.shared.update(
        tablaName: 'seguro',
        data: seguro,
        whereClause: "id = ?",
        whereArgs: ["$id"]);
  }

  Future<void> deleteSeguro(String condicion, List<String> args) async {
    await SeguroRepository.shared
        .delete(tablaName: "seguro", whereClause: condicion, whereArgs: args);
  }
}
