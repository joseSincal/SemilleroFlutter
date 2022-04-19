import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Pages/Page_siniestro/widgets/siniestro_card.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/app_type.dart';

class SiniestrosList extends StatelessWidget {
  const SiniestrosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ApiManager.shared.request(
          baseUrl: "192.168.1.4:9595",
          pathUrl: "/siniestro/buscar",
          type: HttpType.GET),
      builder: (BuildContext context, snapshot) {
        List<SiniestroCard> siniestros =
            List<SiniestroCard>.empty(growable: true);
        if (snapshot.hasData) {
          var utf8Runes = snapshot.data.toString().runes.toList();
          var decoded = utf8.decode(utf8Runes);
          var lista = json.decode(decoded.toString());
          for (var item in lista) {
            Siniestro siniestro = Siniestro.fromService(item);
            siniestros.add(SiniestroCard(
              siniestro: siniestro,
            ));
          }
        }
        return Scaffold(
          body: Stack(
            children: [
              Background(height: null),
              const AppBarTitle(title: 'Siniestros'),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 25),
                  children: siniestros,
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
