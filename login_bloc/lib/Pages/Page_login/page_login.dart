import 'dart:developer';

import 'package:encryptor/encryptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/Bloc/Login_bloc/login_bloc.dart';
import 'package:login_bloc/Models/usuario_model.dart';
import 'package:login_bloc/Pages/Page_user/page_user.dart';
import 'package:login_bloc/Providers/auth_biometric.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Providers/theme_provider.dart';
import 'package:login_bloc/Providers/user_provider.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:login_bloc/utils/auth_codes.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:login_bloc/utils/variables.dart' as variables;

class PageLogin extends StatelessWidget {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
        body: BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
          listener: ((context, state) async {
        switch (state.runtimeType) {
          case AppStarted:
            break;
          case UserNotFound:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(localization.dictionary(Strings.msgErrorUser))),
            );
            break;
          case PasswordFailure:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(localization.dictionary(Strings.msgErrorPassword))),
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
                          padding:
                              const EdgeInsets.only(right: 45.0, left: 45.0),
                          margin:
                              const EdgeInsets.only(top: 35.0, bottom: 20.0),
                          child: emailAutoComplete(localization,
                              context), /*TextInput(
                                hintText: "Email",
                                icon: Icons.email_outlined,
                                inputType: TextInputType.emailAddress,
                                controller: _controllerEmail,
                                inputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.email],
                              ),*/
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: TextInputPassword(
                              hintText: localization
                                  .dictionary(Strings.passwordInputHint),
                              inputType: TextInputType.visiblePassword,
                              controller: _controllerPassword,
                              autofillHints: const [AutofillHints.password]),
                        ),
                        ButtonLarge(
                          buttonText:
                              localization.dictionary(Strings.buttonTextLogin),
                          onPressed: () {
                            if (_controllerEmail.text != '' &&
                                _controllerPassword.text != '') {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginButtonPressed(
                                      email: _controllerEmail.text,
                                      password: _controllerPassword.text));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(localization.dictionary(
                                        Strings.msgErrorDataEmpty))),
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

  Widget emailAutoComplete(
      AppLocalizations localization, BuildContext contextLog) {
    return Autocomplete<Usuario>(
        displayStringForOption: (Usuario option) => option.email,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          _controllerEmail.text = textEditingValue.text;
          if (textEditingValue.text == '') {
            return const Iterable<Usuario>.empty();
          }
          List<Usuario> _userOptions =
              await UserProvider.shared.getUserEmailsPrefs();
          if (_userOptions.isEmpty) {
            return const Iterable<Usuario>.empty();
          }
          return _userOptions.where((Usuario option) {
            return option.email
                .toLowerCase()
                .startsWith(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextInput(
            hintText: localization.dictionary(Strings.emailInputHint),
            icon: Icons.email_outlined,
            inputType: TextInputType.emailAddress,
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
          );
        },
        onSelected: (Usuario selection) async {
          AuthCodes code = await AuthBiometric.shared
              .authenticate(localization.dictionary(Strings.msgBiometric));

          if (code == AuthCodes.authSuccess) {
            _controllerPassword.text =
                Encryptor.decrypt(variables.key, selection.password);
          } else {
            log('No está autorizado');
            msgBiometric(code, contextLog, localization);
          }
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<Usuario> onSelected,
            Iterable<Usuario> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 300,
                height: 350,
                margin: const EdgeInsets.only(left: 30.0),
                color: xiketic,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Usuario option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option.email,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> msgBiometric(
      AuthCodes code, BuildContext context, AppLocalizations localization) {
    late String msg;

    switch (code.name) {
      case 'notAvailable':
      case 'cantBiometric':
        msg = localization.dictionary(Strings.msgBiometricNotAvailable);
        break;
      case 'passcodeNotSet':
        msg = localization.dictionary(Strings.msgBiometricPasscodeNotSet);
        break;
      case 'notEnrolled':
        msg = localization.dictionary(Strings.msgBiometricNotEnrolled);
        break;
      case 'lockedOut':
        msg = localization.dictionary(Strings.msgBiometricLockedOut);
        break;
      case 'otherOperatingSystem':
        msg = localization.dictionary(Strings.msgBiometricOtherOperatingSystem);
        break;
      case 'permanentlyLockedOut':
        msg = localization.dictionary(Strings.msgBiometricPermanentlyLockedOut);
        break;
      case 'noAutorized':
        msg = localization.dictionary(Strings.msgBiometricNoAutorized);
        break;
    }

    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
