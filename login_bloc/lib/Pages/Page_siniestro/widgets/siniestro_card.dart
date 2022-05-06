import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Pages/Page_siniestro/widgets/detalle_siniestro.dart';
import 'package:login_bloc/Providers/theme_provider.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class SiniestroCard extends StatelessWidget {
  final Siniestro siniestro;
  final BuildContext contextList;
  const SiniestroCard({Key? key, required this.siniestro, required this.contextList}) : super(key: key);

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
            "ID: ${siniestro.idSiniestro} - Ramo: ${siniestro.seguro.ramo}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
          Container(height: 10.0),
          Text(
            siniestro.aceptado ? "Aceptado" : "Rechazado",
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
              Icon(Icons.date_range_rounded,
                  size: 12.0,
                  color: currentTheme.isDarkTheme()
                      ? const Color(0xffb6b2df)
                      : Colors.white60),
              Container(width: 8.0),
              Text(
                "Fecha: ${DateFormat("dd-MM-yyyy").format(siniestro.fechaSiniestro)}",
                style: TextStyle(
                    color: currentTheme.isDarkTheme()
                        ? const Color(0xffb6b2df)
                        : Colors.white60,
                    fontSize: 9.0,
                    fontWeight: FontWeight.w400),
              ),
              Container(width: 24.0),
              Icon(Icons.attach_money,
                  size: 12.0,
                  color: currentTheme.isDarkTheme()
                      ? const Color(0xffb6b2df)
                      : Colors.white60),
              Container(width: 8.0),
              Text(
                "Indemnización: ${siniestro.indenmizacion}",
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
            builder: (context) => DetalleSiniestro(siniestro: siniestro,
                  contextList: contextList,));
      },
      child: infoCard,
    );
  }
}
