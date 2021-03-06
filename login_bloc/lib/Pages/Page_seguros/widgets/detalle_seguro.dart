import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Bloc/Crud_bloc/crud_bloc.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Pages/Page_seguros/formulario_seguro.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Widgets/dialog_delete.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class DetalleSeguro extends StatelessWidget {
  final Seguro seguro;
  final BuildContext contextList;
  const DetalleSeguro(
      {Key? key, required this.seguro, required this.contextList})
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
              "${localization.dictionary(Strings.textPoliza)} #-${seguro.numeroPoliza}",
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: detailIcon(
                        localization.dictionary(Strings.textDniClient),
                        seguro.dniCl,
                        Icons.person_rounded)),
                Expanded(
                    child: detailIcon(localization.dictionary(Strings.textRamo),
                        seguro.ramo, Icons.widgets_rounded))
              ],
            ),
            const SizedBox(height: 40.0),
            Text(
              localization.dictionary(Strings.textVigencia),
              style:
                  const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: detailIcon(
                        localization.dictionary(Strings.textInicio),
                        DateFormat("dd-MM-yyyy").format(seguro.fechaInicio),
                        Icons.start_rounded)),
                Expanded(
                    child: detailIcon(
                        localization.dictionary(Strings.textFin),
                        DateFormat("dd-MM-yyyy")
                            .format(seguro.fechaVencimiento),
                        Icons.assignment_late_outlined))
              ],
            ),
            const SizedBox(height: 40.0),
            Text(
              localization.dictionary(Strings.textObservation),
              style:
                  const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w300),
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
            return iconAction(Icons.delete_forever_rounded, darkRed, () {
              if (connected) {
                return DialogDelete.shared.show(
                    contextList,
                    "seguro",
                    "id = ?",
                    [seguro.id.toString(), seguro.numeroPoliza.toString()],
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
                        builder: (cxt) => FormularioSeguro(
                              seguro: seguro,
                            ))).then((value) => {
                      if (value != null)
                        {
                          BlocProvider.of<CrudBloc>(contextList)
                              .add(ButtonUpdate(seguro: value[0], id: value[1]))
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
