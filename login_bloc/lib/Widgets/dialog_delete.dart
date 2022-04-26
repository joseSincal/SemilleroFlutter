import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_bloc/Bloc/Crud_bloc/crud_bloc.dart' as crud_seg;
import 'package:login_bloc/Bloc/Crud_bloc/crud_bloc.dart';
import 'package:login_bloc/Bloc/Crud_cliente_bloc/crud_cliente_bloc.dart'
    as crud_cli;
import 'package:login_bloc/Bloc/Crud_cliente_bloc/crud_cliente_bloc.dart';
import 'package:login_bloc/Bloc/Crud_siniestro_bloc/crud_siniestro_bloc.dart'
    as crud_sin;
import 'package:login_bloc/Bloc/Crud_siniestro_bloc/crud_siniestro_bloc.dart';
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
              onPressed: () {
                switch (nameTable) {
                  case "cliente":
                    BlocProvider.of<CrudClienteBloc>(context).add(
                        crud_cli.ButtonRemove(
                            condition: condicion, args: args));
                    /*await ClienteRepository.shared.delete(
                        tablaName: nameTable,
                        whereClause: condicion,
                        whereArgs: args);*/
                    break;
                  case "seguro":
                    BlocProvider.of<CrudBloc>(context).add(
                        crud_seg.ButtonRemove(
                            condition: condicion, args: args));
                    /*await SeguroRepository.shared.delete(
                        tablaName: nameTable,
                        whereClause: condicion,
                        whereArgs: args);*/
                    break;
                  case "siniestro":
                    BlocProvider.of<CrudSiniestroBloc>(context).add(
                        crud_sin.ButtonRemove(
                            condition: condicion, args: args));
                    /*await SiniestroRepository.shared.delete(
                        tablaName: nameTable,
                        whereClause: condicion,
                        whereArgs: args);*/
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
