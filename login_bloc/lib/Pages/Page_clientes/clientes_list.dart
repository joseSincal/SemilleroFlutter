import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:login_bloc/Bloc/Crud_cliente_bloc/crud_cliente_bloc.dart';
import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Pages/Page_clientes/formulario_cliente.dart';
import 'package:login_bloc/Pages/Page_clientes/new_column_cliente.dart';
import 'package:login_bloc/Pages/Page_clientes/widgets/cliente_card.dart';
import 'package:login_bloc/Providers/cliente_provider.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class ClientesList extends StatelessWidget {
  const ClientesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    
    Future<List<ClienteCard>> _cargarLista(BuildContext context) async {
      List<ClienteCard> clientes = List<ClienteCard>.empty(growable: true);
      List<dynamic> clientesDb = await ClienteProvider.shared.getAllDb();
      for (var item in clientesDb) {
        clientes.add(ClienteCard(
          cliente: Cliente.fromDb(item),
          contextList: context,
        ));
      }
      return clientes;
      //BlocProvider.of<CrudClienteBloc>(context).add(EndSearching());
    }

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => CrudClienteBloc(),
        child: BlocListener<CrudClienteBloc, CrudClienteState>(
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
                      content: Text(localization.dictionary(Strings.msgErrorupdate))),
                );
                break;
              case RemoveError:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(localization.dictionary(Strings.msgErrorDelete))),
                );
                break;
            }
          }),
          child: BlocBuilder<CrudClienteBloc, CrudClienteState>(
              builder: ((context, state) {
            return FutureBuilder(
              future: _cargarLista(context),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  List<ClienteCard> listaCardClientes =
                      snapshot.requireData as List<ClienteCard>;
                  return Scaffold(
                    body: Stack(
                      children: [
                        Background(height: null),
                        AppBarTitle(title: localization.dictionary(Strings.titlePageClient)),
                        Container(
                          margin: const EdgeInsets.only(top: 100),
                          child: ListView(
                            padding: const EdgeInsets.only(bottom: 25),
                            children: listaCardClientes,
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
                                child: const Icon(Icons.person_add_alt_rounded),
                                label: localization.dictionary(Strings.textAddClient),
                                onTap: () {
                                  if (connected) {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (cxt) =>
                                                    FormularioCliente()))
                                        .then((value) => {
                                              if (value != null)
                                                {
                                                  BlocProvider.of<
                                                              CrudClienteBloc>(
                                                          context)
                                                      .add(ButtonAdd(
                                                          cliente: value))
                                                }
                                            });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(localization.dictionary(Strings.msgNoInternet))),
                                    );
                                  }
                                }),
                            SpeedDialChild(
                                child: const Icon(Icons.add_card_rounded),
                                label: localization.dictionary(Strings.textAddColumn),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (cxt) =>
                                              NewColumnCliente()));
                                })
                          ],
                        );
                      },
                      child: const Text("Hola"),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          })),
        ),
      ),
    );
  }
}
