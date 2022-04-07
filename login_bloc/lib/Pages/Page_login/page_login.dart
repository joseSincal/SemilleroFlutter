import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login_bloc/Bloc/Login_bloc/login_bloc.dart';
import 'package:login_bloc/Pages/Page_user/page_user.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String email = '';
    String password = '';

    return Scaffold(
        body: BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(listener: ((context, state) {
        switch (state.runtimeType) {
          case AppStarted:
            break;
          case LoginFailure:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Datos incorrectos')),
            );
            break;
          case LoginLoading:
            final estado = state as LoginLoading;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (cxt) => PageUser(username: estado.username)));
            break;
        }
      }), child: BlocBuilder<LoginBloc, LoginState>(
        builder: ((context, state) {
          if (state is AppStarted) {
            log('Aplicacion iniciada');
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bienvenido',
                  style: TextStyle(fontSize: 24.0),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                hintText:
                                    'Ingrese un correo válido (example@company.com)'),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "* Campo obligatorio"),
                              EmailValidator(
                                  errorText: "Ingrese un correo válido"),
                            ]),
                            onChanged: (text) {
                              email = text;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText:
                                      'Ingrese su contraseña de seguridad'),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "* Campo obligatorio"),
                              ]),
                              onChanged: (text) {
                                password = text;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginButtonPressed(
                                          email: email, password: password));
                                }
                              },
                              child: const Text('Log In')),
                        )
                      ],
                    )),
              ],
            ),
          );
        }),
      )),
    ));
  }
}
