import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc/Models/cliente.model.dart';
import 'package:login_bloc/Pages/Page_clientes/widgets/detalle_cliente.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class ClienteCard extends StatelessWidget {
  final Cliente cliente;
  const ClienteCard({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    final infoCard = Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, left: 24, right: 24),
      decoration: BoxDecoration(
        color: currentTheme.isDarkTheme() ? Colors.black45 : Colors.white30,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 4.0),
          Text(
            "${cliente.nombreCl}, ${cliente.apellido1} ${cliente.apellido2}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
          Container(height: 10.0),
          Text(
            "Tel: ${cliente.telefono}",
            style: TextStyle(
                color: currentTheme.isDarkTheme()
                    ? const Color(0xffb6b2df)
                    : Colors.white60,
                fontSize: 12.0,
                fontWeight: FontWeight.w400),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: currentTheme.isDarkTheme()
                  ? const Color(0xff00c6ff)
                  : darkSienna),
          Row(
            children: <Widget>[
              Icon(Icons.location_city_rounded,
                  size: 12.0,
                  color: currentTheme.isDarkTheme()
                      ? const Color(0xffb6b2df)
                      : Colors.white60),
              Container(width: 8.0),
              Text(
                "Ciudad: ${cliente.ciudad}",
                style: TextStyle(
                    color: currentTheme.isDarkTheme()
                        ? const Color(0xffb6b2df)
                        : Colors.white60,
                    fontSize: 9.0,
                    fontWeight: FontWeight.w400),
              ),
              Container(width: 24.0),
              Icon(Icons.location_pin,
                  size: 12.0,
                  color: currentTheme.isDarkTheme()
                      ? const Color(0xffb6b2df)
                      : Colors.white60),
              Container(width: 8.0),
              Text(
                "Cod. Postal: ${cliente.codPostal}",
                style: TextStyle(
                    color: currentTheme.isDarkTheme()
                        ? const Color(0xffb6b2df)
                        : Colors.white60,
                    fontSize: 9.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ]),
      ),
    );

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => DetalleCliente(cliente: cliente));
      },
      child: infoCard,
    );
  }
}
