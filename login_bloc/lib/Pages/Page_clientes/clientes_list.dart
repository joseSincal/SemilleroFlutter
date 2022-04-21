import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Pages/Page_clientes/formulario_cliente.dart';
import 'package:login_bloc/Pages/Page_clientes/widgets/cliente_card.dart';
import 'package:login_bloc/Repository/cliente_repository.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/color.dart';

class ClientesList extends StatelessWidget {
  const ClientesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<ClienteCard>> _obtenerData() async {
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
                              builder: (cxt) => FormularioCliente()));
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
