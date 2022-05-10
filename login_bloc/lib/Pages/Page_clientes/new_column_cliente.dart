import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Repository/cliente_repository.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:provider/provider.dart';

class NewColumnCliente extends StatelessWidget {
  double height = 20.0;
  NewColumnCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _typeController = TextEditingController();

    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
      body: Stack(children: [
        Background(height: null),
        AppBarTitle(title: localization.dictionary(Strings.titlePageAddField)),
        Container(
          margin: const EdgeInsets.only(top: 105),
          child: ListView(
            padding: const EdgeInsets.only(
                top: 25, bottom: 25, right: 30.0, left: 30.0),
            children: [
              TextInput(
                  hintText: "${localization.dictionary(Strings.textName)} *",
                  inputType: TextInputType.text,
                  controller: _nameController,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: "${localization.dictionary(Strings.dataTypeHint)} *",
                  inputType: TextInputType.text,
                  controller: _typeController,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height + 5,
              ),
              ButtonLarge(
                  buttonText: localization.dictionary(Strings.buttonAddField),
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _typeController.text.isEmpty) {
                      showToast(localization.dictionary(Strings.msgErrorFormValidation));
                    } else {
                      ClienteRepository.shared.addColumn(
                          tablaName: "cliente",
                          columnName: _nameController.text,
                          typeColumn: _typeController.text);
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        )
      ]),
    );
  }

  Future showToast(String msg) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, fontSize: 18.0);
  }
}
