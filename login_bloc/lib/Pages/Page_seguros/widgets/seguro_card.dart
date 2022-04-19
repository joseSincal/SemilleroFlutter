import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class SeguroCard extends StatelessWidget {
  final Seguro seguro;
  const SeguroCard({Key? key, required this.seguro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return Container(
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
            "${seguro.numeroPoliza} - ${seguro.ramo}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
          Container(height: 10.0),
          Text(
            "DNI Cliente: ${seguro.dniCl}",
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
              Icon(Icons.start_rounded,
                  size: 12.0,
                  color: currentTheme.isDarkTheme()
                      ? const Color(0xffb6b2df)
                      : Colors.white60),
              Container(width: 8.0),
              Text(
                "Fecha Inicio: ${DateFormat("dd-MM-yyyy").format(seguro.fechaInicio)}",
                style: TextStyle(
                    color: currentTheme.isDarkTheme()
                        ? const Color(0xffb6b2df)
                        : Colors.white60,
                    fontSize: 9.0,
                    fontWeight: FontWeight.w400),
              ),
              Container(width: 24.0),
              Icon(Icons.assignment_late_outlined,
                  size: 12.0,
                  color: currentTheme.isDarkTheme()
                      ? const Color(0xffb6b2df)
                      : Colors.white60),
              Container(width: 8.0),
              Text(
                "Fecha Fin: ${DateFormat("dd-MM-yyyy").format(seguro.fechaVencimiento)}",
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
  }
}