import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Pages/Page_seguros/widgets/seguro_card.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/utils/app_type.dart';

class SegurosList extends StatelessWidget {
  const SegurosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ApiManager.shared.request(
          baseUrl: "192.168.1.4:9595",
          pathUrl: "/seguro/buscar",
          type: HttpType.GET),
      builder: (BuildContext context, snapshot) {
        List<SeguroCard> seguros = List<SeguroCard>.empty(growable: true);
        if (snapshot.hasData) {
          var utf8Runes = snapshot.data.toString().runes.toList();
          var decoded = utf8.decode(utf8Runes);
          var lista = json.decode(decoded.toString());
          for (var item in lista) {
            Seguro seguro = Seguro.fromService(item);
            seguros.add(SeguroCard(
              seguro: seguro,
            ));
          }
        }
        return Scaffold(
          body: Stack(
            children: [
              Background(height: null),
              const AppBarTitle(title: 'Seguros'),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 25),
                  children: seguros,
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
