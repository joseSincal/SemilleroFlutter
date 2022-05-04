import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Repository/seguro_repository.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:login_bloc/utils/variables.dart';

class SeguroProvider {
  SeguroProvider._privateConstructor();

  static final SeguroProvider shared = SeguroProvider._privateConstructor();

  Future<List<dynamic>> getAllDb() async {
    return await SeguroRepository.shared.selectAll(tablaName: 'seguro');
  }

  Future<dynamic> saveSeguro(Seguro seguro) async {
    dynamic response = await SeguroRepository.shared.save(data: [seguro], tableName: 'seguro');
    await ApiManager.shared.request(
        baseUrl: ip + ":" + port,
        pathUrl: "/seguro/guardar",
        type: HttpType.POST,
        bodyParams: seguro.toDatabase());
    // await cargarClientes();
    return response;
  }

  Future<dynamic> updateSeguro(Map<String, dynamic> seguro, int id) async {
    await SeguroRepository.shared.update(
        tablaName: 'seguro',
        data: seguro,
        whereClause: "id = ?",
        whereArgs: ["$id"]);
    dynamic response = await ApiManager.shared.request(
        baseUrl: ip + ":" + port,
        pathUrl: "/seguro/guardar",
        type: HttpType.POST,
        bodyParams: seguro);
    // await cargarClientes();
    return response;
  }

  Future<void> deleteSeguro(String condicion, List<String> args) async {
    await SeguroRepository.shared
        .delete(tablaName: "seguro", whereClause: condicion, whereArgs: [args[0]]);
    await ApiManager.shared.request(
        baseUrl: ip + ":" + port,
        pathUrl: "/seguro/eliminar/${args[1]}",
        type: HttpType.DELETE);
    // await cargarClientes();
  }

  Future<void> cargarSeguros() async {
    dynamic bodyRequest = await ApiManager.shared.request(
        baseUrl: ip + ":" + port,
        pathUrl: "/seguro/buscar",
        type: HttpType.GET);
    if (bodyRequest != null) {
      List<Seguro> lista = List<Seguro>.empty(growable: true);
      for (var item in bodyRequest as List<dynamic>) {
        final Seguro seguro = Seguro.fromService(item);
        lista.add(seguro);
      }
      SeguroRepository.shared.save(data: lista, tableName: 'seguro');
    }
  }
}
