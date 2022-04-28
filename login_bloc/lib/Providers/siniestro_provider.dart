import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Repository/siniestro_repository.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:login_bloc/utils/ip_dab.dart';

class SiniestroProvider {
  SiniestroProvider._privateConstructor();

  static final SiniestroProvider shared = SiniestroProvider._privateConstructor();

  Future<List<dynamic>> getAllDb() async {
    return await SiniestroRepository.shared.selectAll(tablaName: 'siniestro');
  }

  Future<dynamic> saveSiniestro(Siniestro siniestro) async {
    return await SiniestroRepository.shared.save(data: [siniestro], tableName: 'siniestro');
  }

  Future<dynamic> updateSiniestro(Map<String, dynamic> siniestro, int id) async {
    return await SiniestroRepository.shared.update(
        tablaName: 'siniestro',
        data: siniestro,
        whereClause: "id = ?",
        whereArgs: ["$id"]);
  }

  Future<void> deleteSiniestro(String condicion, List<String> args) async {
    await SiniestroRepository.shared
        .delete(tablaName: "siniestro", whereClause: condicion, whereArgs: args);
  }

  Future<void> cargarSiniestros() async {
    dynamic bodyRequest = await ApiManager.shared.request(
        baseUrl: ip + ":" + port,
        pathUrl: "/siniestro/buscar",
        type: HttpType.GET);
    if (bodyRequest != null) {
      List<Siniestro> lista = List<Siniestro>.empty(growable: true);
      for (var item in bodyRequest as List<dynamic>) {
        final Siniestro siniestro = Siniestro.fromService(item);
        lista.add(siniestro);
      }
      SiniestroRepository.shared.save(data: lista, tableName: 'siniestro');
    }
  }
}
