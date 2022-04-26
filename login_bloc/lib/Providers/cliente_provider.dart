import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Repository/cliente_repository.dart';

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
}