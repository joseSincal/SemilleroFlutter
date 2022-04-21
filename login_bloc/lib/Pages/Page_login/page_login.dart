import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/Bloc/Login_bloc/login_bloc.dart';
import 'package:login_bloc/Pages/Page_user/page_user.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatelessWidget {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return Scaffold(
        body: BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(listener: ((context, state) {
        switch (state.runtimeType) {
          case AppStarted:
            break;
          case UserNotFound:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Este usuario no existe')),
            );
            break;
          case PasswordFailure:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contraseña incorrecta')),
            );
            break;
          case LoginSuccess:
            final estado = state as LoginSuccess;
            _controllerEmail = TextEditingController();
            _controllerPassword = TextEditingController();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (cxt) => PageUser(usuario: estado.usuario)));
            break;
        }
      }), child: BlocBuilder<LoginBloc, LoginState>(
        builder: ((context, state) {
          if (state is AppStarted) {
            log('Aplicacion iniciada');
          }
          return Scaffold(
              body: Stack(children: [
            Background(height: null),
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SemiFlutter",
                      style: TextStyle(
                          fontSize: 37.0,
                          color: currentTheme.isDarkTheme()
                              ? Colors.white
                              : darkSienna,
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 45.0, left: 45.0),
                          margin:
                              const EdgeInsets.only(top: 35.0, bottom: 20.0),
                          child: TextInput(
                            hintText: "Email",
                            icon: Icons.email_outlined,
                            inputType: null,
                            controller: _controllerEmail,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: TextInputPassword(
                            hintText: "Password",
                            inputType: TextInputType.visiblePassword,
                            controller: _controllerPassword,
                          ),
                        ),
                        ButtonLarge(
                          buttonText: "Ingresar",
                          onPressed: () {
                            if (_controllerEmail.text != '' &&
                                _controllerPassword.text != '') {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginButtonPressed(
                                      email: _controllerEmail.text,
                                      password: _controllerPassword.text));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Por favor introduzca todos los datos')),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ]),
            )
          ]));
        }),
      )),
    ));
  }
}


/**
 * Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bienvenido',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: currentTheme.isDarkTheme()
                                ? Colors.white
                                : Colors.black),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 50.0, top: 15.0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: currentTheme.isDarkTheme()
                                          ? Colors.white70
                                          : Colors.black87),
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                          color: currentTheme.isDarkTheme()
                                              ? Colors.white70
                                              : Colors.black87),
                                      labelText: 'Email',
                                      hintStyle: TextStyle(
                                          color: currentTheme.isDarkTheme()
                                              ? Colors.white54
                                              : Colors.black45),
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
                                    keyboardType: TextInputType.text,
                                    obscureText: _passwordVisible,
                                    style: TextStyle(
                                        color: currentTheme.isDarkTheme()
                                            ? Colors.white70
                                            : Colors.black87),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            _passwordVisible = !_passwordVisible;
                                          },
                                        ),
                                        border: const OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                            color: currentTheme.isDarkTheme()
                                                ? Colors.white70
                                                : Colors.black87),
                                        labelText: 'Password',
                                        hintStyle: TextStyle(
                                            color: currentTheme.isDarkTheme()
                                                ? Colors.white54
                                                : Colors.black45),
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
                                                email: email,
                                                password: password));
                                      }
                                    },
                                    child: const Text('Log In')),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
 */