import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_bloc/Repository/cliente_repository.dart';
import 'package:login_bloc/Repository/db_manager.dart';
import 'package:login_bloc/Repository/master_repository.dart';
import 'package:login_bloc/Repository/seguro_repository.dart';
import 'package:login_bloc/Repository/siniestro_repository.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class DialogDelete {
  DialogDelete._privateConstructor();

  static DialogDelete shared = DialogDelete._privateConstructor();

  void show(BuildContext context, String nameTable, String condicion,
          List<String> args) =>
      Dialogs.bottomMaterialDialog(
          msg: '¿Está seguro? no podrás deshacer esta acción',
          title: 'Eliminar',
          context: context,
          actions: [
            IconsOutlineButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Cancelar',
              iconData: Icons.cancel_outlined,
              textStyle: const TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () async {
                switch (nameTable) {
                  case "cliente":
                    await ClienteRepository.shared.delete(
                        tablaName: nameTable,
                        whereClause: condicion,
                        whereArgs: args);
                    break;
                  case "seguro":
                    await SeguroRepository.shared.delete(
                        tablaName: nameTable,
                        whereClause: condicion,
                        whereArgs: args);
                    break;
                  case "siniestro":
                    await SiniestroRepository.shared.delete(
                        tablaName: nameTable,
                        whereClause: condicion,
                        whereArgs: args);
                    break;
                }
                Navigator.pop(context);
                Navigator.pop(context);
                showToast("Dato eliminado");
              },
              text: 'Eliminar',
              iconData: Icons.delete,
              color: Colors.red,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]);

  Future showToast(String msg) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, fontSize: 18.0);
  }
}
