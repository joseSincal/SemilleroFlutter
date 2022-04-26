import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:login_bloc/Bloc/Crud_bloc/crud_bloc.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Pages/Page_seguros/formulario_seguro.dart';
import 'package:login_bloc/Pages/Page_seguros/new_columns_seguro.dart';
import 'package:login_bloc/Pages/Page_seguros/widgets/seguro_card.dart';
import 'package:login_bloc/Providers/seguro_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/color.dart';

class SegurosList extends StatelessWidget {
  const SegurosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> segurosDb = List<SeguroCard>.empty(growable: true);
    List<SeguroCard> seguros = List<SeguroCard>.empty(growable: true);

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => CrudBloc(),
        child: BlocListener<CrudBloc, CrudState>(
          listener: ((context, state) async {
            switch (state.runtimeType) {
              case Searching:
                segurosDb.clear();
                segurosDb = await SeguroProvider.shared.getAllDb();
                break;
              case Found:
                seguros.clear();
                for (var item in segurosDb) {
                  seguros.add(SeguroCard(
                    seguro: Seguro.fromDb(item),
                  ));
                }
                break;
              case SaveError:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('No se guardó el seguro, debido a un error')),
                );
                break;
              case UpdateError:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error, no se pudo actualizar el seguro')),
                );
                break;
              case RemoveError:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error al intentar eliminar')),
                );
                break;
            }
          }),
          child: BlocBuilder<CrudBloc, CrudState>(
            builder: ((context, state) {
              return Scaffold(
                body: Stack(
                  children: [
                    Background(height: null),
                    const AppBarTitle(title: 'Seguro'),
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 25),
                        children: seguros,
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
                        child: const Icon(Icons.add_moderator_rounded),
                        label: "Agregar seguro",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (cxt) => FormularioSeguro()));
                        }),
                    SpeedDialChild(
                        child: const Icon(Icons.add_card_rounded),
                        label: "Agregar columna",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (cxt) => NewColumnSeguro()));
                        })
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
    /*Future<List<SeguroCard>> _obtenerData() async {
      List<SeguroCard> seguros = List<SeguroCard>.empty(growable: true);
      List<dynamic> listaSeguros =
          await SeguroRepository.shared.selectAll(tablaName: 'seguro');
      for (var item in listaSeguros) {
        seguros.add(SeguroCard(
          seguro: Seguro.fromDb(item),
        ));
      }
      return seguros;
    }*/

    /*return Scaffold(
        body: FutureBuilder(
      future: _obtenerData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<SeguroCard> listaCardSeguros =
              snapshot.requireData as List<SeguroCard>;
          return Scaffold(
            body: Stack(
              children: [
                Background(height: null),
                const AppBarTitle(title: 'Seguro'),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 25),
                    children: listaCardSeguros,
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
                    child: const Icon(Icons.add_moderator_rounded),
                    label: "Agregar seguro",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (cxt) => FormularioSeguro()));
                    }),
                SpeedDialChild(
                    child: const Icon(Icons.add_card_rounded),
                    label: "Agregar columna",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (cxt) => NewColumnSeguro()));
                    })
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));*/
  }
}
