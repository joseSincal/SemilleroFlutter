import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_bloc/Models/cliente_model.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:provider/provider.dart';

class FormularioCliente extends StatelessWidget {
  Cliente? cliente;
  double height = 20.0;
  FormularioCliente({Key? key, this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _dniController = TextEditingController();
    TextEditingController _nombreController = TextEditingController();
    TextEditingController _apellido1Controller = TextEditingController();
    TextEditingController _apellido2Controller = TextEditingController();
    TextEditingController _postalController = TextEditingController();
    TextEditingController _ciudadController = TextEditingController();
    TextEditingController _telController = TextEditingController();
    TextEditingController _claseVController = TextEditingController();
    TextEditingController _nombreVController = TextEditingController();
    TextEditingController _numVController = TextEditingController();
    TextEditingController _observacionesController = TextEditingController();

    if (cliente != null) {
      _dniController.text = "${cliente?.dniCl}";
      _nombreController.text = cliente?.nombreCl as String;
      _apellido1Controller.text = cliente?.apellido1 as String;
      _apellido2Controller.text = cliente?.apellido2 as String;
      _postalController.text = "${cliente?.codPostal}";
      _ciudadController.text = cliente?.ciudad as String;
      _telController.text = "${cliente?.telefono}";
      _claseVController.text = cliente?.claseVia as String;
      _nombreVController.text = cliente?.nombreVia as String;
      _numVController.text = "${cliente?.numeroVia}";
      _observacionesController.text = cliente?.observaciones as String;
    }

    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
      body: Stack(children: [
        Background(height: null),
        AppBarTitle(
            title: cliente != null
                ? localization.dictionary(Strings.titlePageClientFormEdit)
                : localization.dictionary(Strings.titlePageClientFormAdd)),
        Container(
          margin: const EdgeInsets.only(top: 105),
          child: ListView(
            padding: const EdgeInsets.only(
                top: 25, bottom: 25, right: 30.0, left: 30.0),
            children: [
              TextInput(
                  hintText: "DNI *",
                  inputType: TextInputType.number,
                  controller: _dniController,
                  icon: Icons.numbers_rounded,
                  readOnly: cliente != null ? true : false),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: "${localization.dictionary(Strings.textName)} *",
                  inputType: TextInputType.text,
                  controller: _nombreController,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText:
                      "${localization.dictionary(Strings.lastName1HintInput)} *",
                  inputType: TextInputType.text,
                  controller: _apellido1Controller,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.lastName2HintInput),
                  inputType: TextInputType.text,
                  controller: _apellido2Controller,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.textCity),
                  inputType: TextInputType.text,
                  controller: _ciudadController,
                  icon: Icons.location_city_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.textPostalCard),
                  inputType: TextInputType.number,
                  controller: _postalController,
                  icon: Icons.location_on),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: "${localization.dictionary(Strings.textPhoneComplete)} *",
                  inputType: TextInputType.number,
                  controller: _telController,
                  icon: Icons.phone),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.classViaHintInput),
                  inputType: TextInputType.text,
                  controller: _claseVController,
                  icon: Icons.widgets_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.nameViaHintInput),
                  inputType: TextInputType.text,
                  controller: _nombreVController,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.numberViaHintInput),
                  inputType: TextInputType.number,
                  controller: _numVController,
                  icon: Icons.numbers),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.textObservation),
                  maxLines: 5,
                  inputType: TextInputType.text,
                  controller: _observacionesController),
              SizedBox(
                height: height + 5,
              ),
              ButtonLarge(
                  buttonText: cliente != null ? localization.dictionary(Strings.buttonUpdate) : localization.dictionary(Strings.buttonRegister),
                  onPressed: () {
                    if (_dniController.text.isEmpty ||
                        _nombreController.text.isEmpty ||
                        _apellido1Controller.text.isEmpty ||
                        _telController.text.isEmpty) {
                      showToast(localization.dictionary(Strings.msgErrorFormValidation));
                    } else {
                      var datos = {
                        'dniCl': int.parse(_dniController.text),
                        'nombreCl': _nombreController.text,
                        'apellido1': _apellido1Controller.text,
                        'apellido2': _apellido2Controller.text,
                        'telefono': int.parse(_telController.text),
                        'ciudad': _ciudadController.text,
                        'codPostal': _postalController.text.isEmpty
                            ? 0
                            : int.parse(_postalController.text),
                        'claseVia': _claseVController.text,
                        'nombreVia': _nombreVController.text,
                        'numeroVia': _numVController.text.isEmpty
                            ? 0
                            : int.parse(_numVController.text),
                        'observaciones': _observacionesController.text,
                      };

                      if (cliente != null) {
                        Navigator.pop(context, [datos, cliente!.id]);
                      } else {
                        var nuevosDatos = Cliente.fromService(datos);
                        Navigator.pop(context, nuevosDatos);
                      }
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
