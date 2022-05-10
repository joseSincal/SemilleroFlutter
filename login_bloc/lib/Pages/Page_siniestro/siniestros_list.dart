import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:login_bloc/Bloc/Crud_siniestro_bloc/crud_siniestro_bloc.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Pages/Page_siniestro/formulario_siniestro.dart';
import 'package:login_bloc/Pages/Page_siniestro/new_column_siniestro.dart';
import 'package:login_bloc/Pages/Page_siniestro/widgets/siniestro_card.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Providers/siniestro_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

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

    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => CrudSiniestroBloc(),
        child: BlocListener<CrudSiniestroBloc, CrudSiniestroState>(
            listener: ((context, state) async {
          switch (state.runtimeType) {
            case SaveError:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(localization.dictionary(Strings.msgErrorSave))),
              );
              break;
            case UpdateError:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(localization.dictionary(Strings.msgErrorupdate))),
              );
              break;
            case RemoveError:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(localization.dictionary(Strings.msgErrorDelete))),
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
                        AppBarTitle(
                            title: localization
                                .dictionary(Strings.titlePageClaim)),
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
                                  label: localization
                                      .dictionary(Strings.textAddClaim),
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
                                        SnackBar(
                                            content: Text(
                                                localization.dictionary(
                                                    Strings.msgNoInternet))),
                                      );
                                    }
                                  }),
                              SpeedDialChild(
                                  child: const Icon(Icons.add_card_rounded),
                                  label: localization
                                      .dictionary(Strings.textAddColumn),
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
  }
}
