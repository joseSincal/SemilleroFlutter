import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/utils/color.dart';

class DetalleSeguro extends StatelessWidget {
  final Seguro seguro;
  const DetalleSeguro({Key? key, required this.seguro}) : super(key: key);

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
        IconAction(Icons.delete_forever_rounded, darkRed, () {}),
        IconAction(Icons.edit, Colors.blue[600], () {}),
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
