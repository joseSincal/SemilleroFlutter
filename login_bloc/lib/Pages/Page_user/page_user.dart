import 'package:flutter/material.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/Pages/Page_clientes/clientes_list.dart';
import 'package:login_bloc/Pages/Page_seguros/seguros_list.dart';
import 'package:login_bloc/Pages/Page_settings/page_settings.dart';
import 'package:login_bloc/Pages/Page_siniestro/siniestros_list.dart';
import 'package:login_bloc/Pages/Page_user/widgets/user_info.dart';
import 'package:login_bloc/Providers/api_manager.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/utils/app_type.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:login_bloc/utils/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageUser extends StatelessWidget {
  final Usuario usuario;
  const PageUser({required this.usuario, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(height: null),
          ListView(
            children: [
              Container(
                margin:
                    const EdgeInsets.only(left: 40.0, right: 20.0, top: 50.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        ),
                        const Expanded(
                          child: Text(""),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            FloatingActionButton(
                                backgroundColor: Colors.white54,
                                mini: true,
                                onPressed: () async {
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.remove('userLogeadFlutter');
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.exit_to_app,
                                  size: 20.0,
                                  color: xiketic,
                                ),
                                heroTag: null),
                            FloatingActionButton(
                                backgroundColor: Colors.white54,
                                mini: true,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (cxt) =>
                                              const PageSettings()));
                                },
                                child: Icon(
                                  Icons.settings,
                                  size: 20.0,
                                  color: xiketic,
                                ),
                                heroTag: null)
                          ],
                        ))
                      ],
                    ),
                    UserInfo(usuario: usuario)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    ButtonLarge(
                      buttonText: "Ver clientes",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) => const ClientesList()));
                      },
                    ),
                    ButtonLarge(
                      buttonText: "Ver seguros",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) => const SegurosList()));
                      },
                    ),
                    ButtonLarge(
                      buttonText: "Ver siniestros",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (cxt) => const SiniestrosList()));
                      },
                    ),
                    ButtonLarge(
                      buttonText: "Ser Admin",
                      onPressed: () {
                        ApiManager.shared
                            .request(
                                baseUrl: ip + ":" + port,
                                pathUrl: "/usuario/error",
                                type: HttpType.GET)
                            .then((value) => {
                                  if (value.statusCode == 403)
                                    {
                                      Navigator.pop(context),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'No está autorizado para realizar esta operación')),
                                      )
                                    }
                                });
                      },
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


/*
ElevatedButton(
              onPressed: () {
                if (crashlytics.isCrashlyticsCollectionEnabled) {
                  crashlytics.recordError(
                      "Cierre inesperado", StackTrace.current,
                      reason: "La aplicación se cerró");
                  crashlytics.crash();
                } else {
                  log("No se pudo enviar el error");
                }
              },
              child: const Text('Generar Error'))
*/