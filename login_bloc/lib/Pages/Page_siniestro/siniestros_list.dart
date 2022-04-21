import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Pages/Page_siniestro/formulario_siniestro.dart';
import 'package:login_bloc/Pages/Page_siniestro/widgets/siniestro_card.dart';
import 'package:login_bloc/Repository/siniestro_repository.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/color.dart';

class SiniestrosList extends StatelessWidget {
  const SiniestrosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<SiniestroCard>> _obtenerData() async {
      List<SiniestroCard> siniestros =
          List<SiniestroCard>.empty(growable: true);
      List<dynamic> listaSiniestros =
          await SiniestroRepository.shared.selectAll(tablaName: 'siniestro');
      for (var item in listaSiniestros) {
        siniestros.add(SiniestroCard(
          siniestro: Siniestro.fromDb(item),
        ));
      }
      return siniestros;
    }

    return Scaffold(
        body: FutureBuilder(
      future: _obtenerData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<SiniestroCard> listaCardSiniestros =
              snapshot.requireData as List<SiniestroCard>;
          return Scaffold(
            body: Stack(
              children: [
                Background(height: null),
                const AppBarTitle(title: 'Siniestros'),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 25),
                    children: listaCardSiniestros,
                  ),
                )
              ],
            ),
            floatingActionButton: SpeedDial(
              backgroundColor: Colors.white,
              foregroundColor: darkSienna,
              overlayColor: Colors.black,
              overlayOpacity: 0.1,
              spacing: 12.0,
              spaceBetweenChildren: 12.0,
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                    child: const Icon(Icons.add_alert_rounded),
                    label: "Agregar siniestro",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (cxt) => FormularioSiniestro()));
                    }),
                SpeedDialChild(
                    child: const Icon(Icons.add_card_rounded),
                    label: "Agregar columna",
                    onTap: () {})
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
