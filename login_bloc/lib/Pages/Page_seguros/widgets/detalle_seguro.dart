import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Bloc/Crud_bloc/crud_bloc.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Pages/Page_seguros/formulario_seguro.dart';
import 'package:login_bloc/Widgets/dialog_delete.dart';
import 'package:login_bloc/utils/color.dart';

class DetalleSeguro extends StatelessWidget {
  final Seguro seguro;
  final BuildContext contextList;
  const DetalleSeguro(
      {Key? key, required this.seguro, required this.contextList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Poliza #-${seguro.numeroPoliza}",
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: DetailIcon(
                        "DNI Cliente", seguro.dniCl, Icons.person_rounded)),
                Expanded(
                    child:
                        DetailIcon("Ramo", seguro.ramo, Icons.widgets_rounded))
              ],
            ),
            const SizedBox(height: 40.0),
            const Text(
              "Vigencía",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: DetailIcon(
                        "Inicio",
                        DateFormat("dd-MM-yyyy").format(seguro.fechaInicio),
                        Icons.start_rounded)),
                Expanded(
                    child: DetailIcon(
                        "Fin",
                        DateFormat("dd-MM-yyyy")
                            .format(seguro.fechaVencimiento),
                        Icons.assignment_late_outlined))
              ],
            ),
            const SizedBox(height: 40.0),
            const Text(
              "Observación",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15.0),
            Text(
              seguro.observaciones,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400),
            ),
          ]),
      actions: [
        OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return IconAction(Icons.delete_forever_rounded, darkRed, () {
              if (connected) {
                return DialogDelete.shared.show(contextList, "seguro", "id = ?",
                    [seguro.id.toString(), seguro.numeroPoliza.toString()]);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('No puede realizar la operación sin internet')),
                );
              }
            });
          },
          child: const Text("Hola"),
        ),
        OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return IconAction(Icons.edit, Colors.blue[600], () {
              if (connected) {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (cxt) => FormularioSeguro(
                              seguro: seguro,
                            ))).then((value) => {
                      //aqui se debe hacer el update
                      BlocProvider.of<CrudBloc>(contextList)
                          .add(ButtonUpdate(seguro: value[0], id: value[1]))
                    });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('No puede realizar la operación sin internet')),
                );
              }
            });
          },
          child: const Text("Hola"),
        ),
        IconAction(Icons.check_rounded, Colors.blueGrey, () {
          Navigator.pop(context);
        }),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Widget DetailIcon(String title, dynamic value, IconData icon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(icon, size: 14, color: Colors.black54),
      const SizedBox(height: 6.0),
      Text(
        title,
        style: const TextStyle(
            fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w400),
      ),
      const SizedBox(height: 1.5),
      Text(
        value.toString(),
        style: const TextStyle(
            fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w400),
      )
    ]);
  }

  Widget IconAction(IconData icon, Color? color, Function() func) {
    return FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0,
        mini: true,
        onPressed: func,
        child: Icon(
          icon,
          color: color,
          size: 22.0,
        ));
  }
}
