import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Repository/cliente_repository.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:login_bloc/utils/ip_dab.dart';

class ClienteProvider {
  ClienteProvider._privateConstructor();

  static final ClienteProvider shared = ClienteProvider._privateConstructor();

  Future<List<dynamic>> getAllDb() async {
    return await ClienteRepository.shared.selectAll(tablaName: 'cliente');
  }

  Future<dynamic> saveCliente(Cliente cliente) async {
    return await ClienteRepository.shared.save(data: [cliente], tableName: 'cliente');
  }

  Future<dynamic> updateCliente(Map<String, dynamic> cliente, int id) async {
    return await ClienteRepository.shared.update(
        tablaName: 'cliente',
        data: cliente,
        whereClause: "id = ?",
        whereArgs: ["$id"]);
  }

  Future<void> deleteCliente(String condicion, List<String> args) async {
    await ClienteRepository.shared
        .delete(tablaName: "cliente", whereClause: condicion, whereArgs: args);
  }

  Future<void> cargarClientes() async {
    dynamic bodyRequest = await ApiManager.shared.request(
        baseUrl: ip + ":" + port,
        pathUrl: "/cliente/buscar",
        type: HttpType.GET);
    if (bodyRequest != null) {
      List<Cliente> lista = List<Cliente>.empty(growable: true);
      for (var item in bodyRequest as List<dynamic>) {
        final Cliente cliente = Cliente.fromService(item);
        lista.add(cliente);
      }
      ClienteRepository.shared.save(data: lista, tableName: 'cliente');
    }
  }
}