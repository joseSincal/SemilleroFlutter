import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:login_bloc/Bloc/Crud_cliente_bloc/crud_cliente_bloc.dart';
import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Pages/Page_clientes/formulario_cliente.dart';
import 'package:login_bloc/Pages/Page_clientes/new_column_cliente.dart';
import 'package:login_bloc/Pages/Page_clientes/widgets/cliente_card.dart';
import 'package:login_bloc/Providers/cliente_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/color.dart';

class ClientesList extends StatelessWidget {
  const ClientesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> clientesDb = List<dynamic>.empty(growable: true);
    List<ClienteCard> clientes = List<ClienteCard>.empty(growable: true);

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => CrudClienteBloc(),
        child: BlocListener<CrudClienteBloc, CrudClienteState>(
          listener: ((context, state) async {
            switch (state.runtimeType) {
              case Searching:
                clientesDb.clear();
                clientesDb = await ClienteProvider.shared.getAllDb();
                break;
              case Found:
                clientes.clear();
                for (var item in clientesDb) {
                  clientes.add(ClienteCard(
                    cliente: Cliente.fromDb(item),
                  ));
                }
                break;
              case SaveError:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('No se guardó el cliente, debido a un error')),
                );
                break;
              case UpdateError:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error, no se pudo actualizar el cliente')),
                );
                break;
              case RemoveError:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error al intentar eliminar')),
                );
                break;
            }
          }),
          child: BlocBuilder<CrudClienteBloc, CrudClienteState>(
              builder: ((context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  Background(height: null),
                  const AppBarTitle(title: 'Clientes'),
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 25),
                      children: clientes,
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
                      child: const Icon(Icons.person_add_alt_rounded),
                      label: "Agregar cliente",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) => FormularioCliente()));
                      }),
                  SpeedDialChild(
                      child: const Icon(Icons.add_card_rounded),
                      label: "Agregar columna",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) => NewColumnCliente()));
                      })
                ],
              ),
            );
          })),
        ),
      ),
    );


    /*Future<List<ClienteCard>> _obtenerData() async {
      List<ClienteCard> clientes = List<ClienteCard>.empty(growable: true);
      List<dynamic> listaClientes =
          await ClienteRepository.shared.selectAll(tablaName: 'cliente');
      for (var item in listaClientes) {
        clientes.add(ClienteCard(
          cliente: Cliente.fromDb(item),
        ));
      }
      return clientes;
    }

    return Scaffold(
        body: FutureBuilder(
      future: _obtenerData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<ClienteCard> listaCardClientes =
              snapshot.requireData as List<ClienteCard>;
          return Scaffold(
            body: Stack(
              children: [
                Background(height: null),
                const AppBarTitle(title: 'Clientes'),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 25),
                    children: listaCardClientes,
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
                    child: const Icon(Icons.person_add_alt_rounded),
                    label: "Agregar cliente",
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (cxt) => FormularioCliente()))
                          .then((value) => {
                                if (value != null)
                                  {
                                    listaCardClientes.add(ClienteCard(
                                      cliente: value,
                                    ))
                                  }
                              });
                    }),
                SpeedDialChild(
                    child: const Icon(Icons.add_card_rounded),
                    label: "Agregar columna",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (cxt) => NewColumnCliente()));
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
