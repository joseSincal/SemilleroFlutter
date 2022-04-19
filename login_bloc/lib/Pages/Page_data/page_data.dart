import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login_bloc/Models/comic_model.dart';
import 'package:login_bloc/Providers/api_usuario.dart';
import 'package:login_bloc/utils/app_type.dart';

class PageData extends StatelessWidget {
  const PageData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiUsuario.shared.request(
            baseUrl: "gateway.marvel.com",
            pathUrl: "/v1/public/characters/1010911",
            type: HttpType.GET),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final Comic comic = snapshot.requireData as Comic;
            log('el eTag es: ${comic.name}');
          }

          log('Defecto');
          return Container();
        },
      ),
    );
  }
}
