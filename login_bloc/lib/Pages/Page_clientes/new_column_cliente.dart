import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_bloc/Repository/cliente_repository.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';

class NewColumnCliente extends StatelessWidget {
  double height = 20.0;
  NewColumnCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _typeController = TextEditingController();

    return Scaffold(
      body: Stack(children: [
        Background(height: null),
        const AppBarTitle(title: "Add campo cliente"),
        Container(
          margin: const EdgeInsets.only(top: 105),
          child: ListView(
            padding: const EdgeInsets.only(
                top: 25, bottom: 25, right: 30.0, left: 30.0),
            children: [
              TextInput(
                  hintText: "Nombre *",
                  inputType: TextInputType.text,
                  controller: _nameController,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: "Tipo de dato *",
                  inputType: TextInputType.text,
                  controller: _typeController,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height + 5,
              ),
              ButtonLarge(
                  buttonText: "Agregar",
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _typeController.text.isEmpty) {
                      showToast("Error, debe llenar los campos obligatorios");
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
