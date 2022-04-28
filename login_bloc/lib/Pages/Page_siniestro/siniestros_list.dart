import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:login_bloc/Bloc/Crud_siniestro_bloc/crud_siniestro_bloc.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Pages/Page_siniestro/formulario_siniestro.dart';
import 'package:login_bloc/Pages/Page_siniestro/new_column_siniestro.dart';
import 'package:login_bloc/Pages/Page_siniestro/widgets/siniestro_card.dart';
import 'package:login_bloc/Providers/siniestro_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/color.dart';

class SiniestrosList extends StatelessWidget {
  const SiniestrosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<SiniestroCard>> _obtenerData(BuildContext context) async {
      List<SiniestroCard> siniestros =
          List<SiniestroCard>.empty(growable: true);
      List<dynamic> listaSiniestros = await SiniestroProvider.shared.getAllDb();
      for (var item in listaSiniestros) {
        siniestros.add(SiniestroCard(
          siniestro: Siniestro.fromDb(item),
          contextList: context,
        ));
      }
      return siniestros;
    }

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => CrudSiniestroBloc(),
        child: BlocListener<CrudSiniestroBloc, CrudSiniestroState>(
            listener: ((context, state) async {
          switch (state.runtimeType) {
            case SaveError:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('No se guardó el siniestro, debido a un error')),
              );
              break;
            case UpdateError:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Error, no se pudo actualizar el siniestro')),
              );
              break;
            case RemoveError:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error al intentar eliminar')),
              );
              break;
          }
        }), child: BlocBuilder<CrudSiniestroBloc, CrudSiniestroState>(
                builder: ((context, state) {
          return FutureBuilder(
            future: _obtenerData(context),
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
                                  child: const Icon(Icons.add_alert_rounded),
                                  label: "Agregar siniestro",
                                  onTap: () {
                                    if (connected) {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (cxt) =>
                                                      FormularioSiniestro()))
                                          .then((value) => {
                                                if (value != null)
                                                  {
                                                    BlocProvider.of<
                                                                CrudSiniestroBloc>(
                                                            context)
                                                        .add(ButtonAdd(
                                                            siniestro: value))
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
                                                NewColumnSiniestro()));
                                  })
                            ],
                          );
                        },
                        child: const Text("Hola")));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        }))),
      ),
    );

    /*Future<List<SiniestroCard>> _obtenerData() async {
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (cxt) => NewColumnSiniestro()));
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
