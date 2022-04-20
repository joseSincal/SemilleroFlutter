import 'package:flutter/material.dart';
import 'package:login_bloc/Models/cliente.model.dart';
import 'package:login_bloc/utils/color.dart';

class DetalleCliente extends StatelessWidget {
  final Cliente cliente;
  const DetalleCliente({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              cliente.nombreCl,
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            Container(
              margin: const EdgeInsets.only(top: 3.0),
              child: Text(
                "${cliente.apellido1} ${cliente.apellido2}",
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 25.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: DetailIcon(
                        "Tel", cliente.telefono, Icons.phone_enabled_rounded)),
                Expanded(
                    child: DetailIcon(
                        "Ciudad", cliente.ciudad, Icons.location_city_rounded)),
                Expanded(
                    child: DetailIcon(
                        "Cod.P", cliente.codPostal, Icons.location_pin))
              ],
            ),
            const SizedBox(height: 40.0),
            const Text(
              "Detalle de Vía",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: DetailIcon(
                        "Clase", cliente.claseVia, Icons.widgets_rounded)),
                Expanded(
                    child: DetailIcon(
                        "Nombre", cliente.nombreVia, Icons.abc_rounded)),
                Expanded(
                    child: DetailIcon(
                        "Número", cliente.numeroVia, Icons.numbers_rounded))
              ],
            ),
            const SizedBox(height: 40.0),
            const Text(
              "Observación",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15.0),
            Text(
              cliente.observaciones,
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
