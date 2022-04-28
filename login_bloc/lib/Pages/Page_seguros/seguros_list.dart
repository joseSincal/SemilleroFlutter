import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
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
    Future<List<SeguroCard>> _obtenerData(BuildContext context) async {
      List<SeguroCard> seguros = List<SeguroCard>.empty(growable: true);
      List<dynamic> listaSeguros = await SeguroProvider.shared.getAllDb();
      for (var item in listaSeguros) {
        seguros
            .add(SeguroCard(seguro: Seguro.fromDb(item), contextList: context));
      }
      return seguros;
    }

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => CrudBloc(),
        child: BlocListener<CrudBloc, CrudState>(
          listener: ((context, state) async {
            switch (state.runtimeType) {
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
              return FutureBuilder(
                future: _obtenerData(context),
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
                      floatingActionButton: OfflineBuilder(
                          connectivityBuilder: (
                            BuildContext context,
                            ConnectivityResult connectivity,
                            Widget child,
                          ) {
                            final bool connected =
                                connectivity != ConnectivityResult.none;
                            return SpeedDial(
                              backgroundColor: Colors.white,
                              foregroundColor: darkSienna,
                              overlayColor: Colors.black,
                              overlayOpacity: 0.1,
                              spacing: 12.0,
                              spaceBetweenChildren: 12.0,
                              animatedIcon: AnimatedIcons.menu_close,
                              children: [
                                SpeedDialChild(
                                    child:
                                        const Icon(Icons.add_moderator_rounded),
                                    label: "Agregar seguro",
                                    onTap: () {
                                      if (connected) {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (cxt) =>
                                                        FormularioSeguro()))
                                            .then((value) => {
                                                  if (value != null)
                                                    {
                                                      BlocProvider.of<CrudBloc>(
                                                              context)
                                                          .add(ButtonAdd(
                                                              seguro: value))
                                                    }
                                                });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'No puede realizar la operación sin internet')),
                                        );
                                      }
                                    }),
                                SpeedDialChild(
                                    child: const Icon(Icons.add_card_rounded),
                                    label: "Agregar columna",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (cxt) =>
                                                  NewColumnSeguro()));
                                    })
                              ],
                            );
                          },
                          child: const Text("Hola")),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
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
