import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Bloc/Crud_siniestro_bloc/crud_siniestro_bloc.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Pages/Page_siniestro/formulario_siniestro.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Widgets/dialog_delete.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class DetalleSiniestro extends StatelessWidget {
  final Siniestro siniestro;
  final BuildContext contextList;
  const DetalleSiniestro(
      {Key? key, required this.siniestro, required this.contextList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return AlertDialog(
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "ID - ${siniestro.idSiniestro}",
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: detailIcon(
                        localization.dictionary(Strings.textFecha),
                        DateFormat("dd-MM-yyyy")
                            .format(siniestro.fechaSiniestro),
                        Icons.date_range_rounded)),
                Expanded(
                    child: detailIcon(
                        localization.dictionary(Strings.textEstado),
                        siniestro.aceptado
                            ? localization.dictionary(Strings.textAceptado)
                            : localization.dictionary(Strings.textRechazado),
                        siniestro.aceptado
                            ? Icons.shield
                            : Icons.remove_moderator)),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                    child: detailIcon(
                        localization.dictionary(Strings.textIndemnizacion),
                        siniestro.indenmizacion,
                        Icons.attach_money)),
              ],
            ),
            const SizedBox(height: 40.0),
            Text(
              localization.dictionary(Strings.titlePageSure),
              style:
                  const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: detailIcon(
                        localization.dictionary(Strings.textPoliza),
                        siniestro.seguro.numeroPoliza,
                        Icons.numbers)),
                Expanded(
                    child: detailIcon(localization.dictionary(Strings.textRamo),
                        siniestro.seguro.ramo, Icons.interests))
              ],
            ),
            const SizedBox(height: 40.0),
            Text(
              localization.dictionary(Strings.textCausas),
              style:
                  const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15.0),
            Text(
              siniestro.causas,
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
            return iconAction(Icons.delete_forever_rounded, darkRed, () {
              if (connected) {
                return DialogDelete.shared.show(
                    contextList,
                    "siniestro",
                    "id = ?",
                    [siniestro.id.toString(), siniestro.idSiniestro.toString()],
                    localization);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text(localization.dictionary(Strings.msgNoInternet))),
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
            return iconAction(Icons.edit, Colors.blue[600], () {
              if (connected) {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (cxt) => FormularioSiniestro(
                              siniestro: siniestro,
                            ))).then((value) => {
                      if (value != null)
                        {
                          BlocProvider.of<CrudSiniestroBloc>(contextList).add(
                              ButtonUpdate(siniestro: value[0], id: value[1]))
                        }
                    });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text(localization.dictionary(Strings.msgNoInternet))),
                );
              }
            });
          },
          child: const Text("Hola"),
        ),
        iconAction(Icons.check_rounded, Colors.blueGrey, () {
          Navigator.pop(context);
        }),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Widget detailIcon(String title, dynamic value, IconData icon) {
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

  Widget iconAction(IconData icon, Color? color, Function() func) {
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
