import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Models/seguro_model.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:provider/provider.dart';

class FormularioSeguro extends StatelessWidget {
  Seguro? seguro;
  double height = 20.0;
  FormularioSeguro({Key? key, this.seguro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _polizaController = TextEditingController();
    TextEditingController _ramoController = TextEditingController();
    TextEditingController _fechaIniController = TextEditingController();
    TextEditingController _fechaFinController = TextEditingController();
    TextEditingController _condicionController = TextEditingController();
    TextEditingController _observacionController = TextEditingController();
    TextEditingController _dniController = TextEditingController();

    if (seguro != null) {
      _polizaController.text = "${seguro?.numeroPoliza}";
      _ramoController.text = seguro?.ramo as String;
      _fechaIniController.text =
          DateFormat("dd-MM-yyyy").format(seguro!.fechaInicio);
      _fechaFinController.text =
          DateFormat("dd-MM-yyyy").format(seguro!.fechaVencimiento);
      _condicionController.text = seguro?.condicionesParticulares as String;
      _observacionController.text = seguro?.observaciones as String;
      _dniController.text = "${seguro?.dniCl}";
    }

    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    return Scaffold(
      body: Stack(children: [
        Background(height: null),
        AppBarTitle(title: seguro != null ? localization.dictionary(Strings.titlePageSureFormEdit) : localization.dictionary(Strings.titlePageSureFormAdd)),
        Container(
          margin: const EdgeInsets.only(top: 105),
          child: ListView(
            padding: const EdgeInsets.only(
                top: 25, bottom: 25, right: 30.0, left: 30.0),
            children: [
              TextInput(
                  hintText: "${localization.dictionary(Strings.polizaHintText)} *",
                  inputType: TextInputType.number,
                  controller: _polizaController,
                  icon: Icons.numbers_rounded,
                  readOnly: seguro != null ? true : false),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: "${localization.dictionary(Strings.textRamo)} *",
                  inputType: TextInputType.text,
                  controller: _ramoController,
                  icon: Icons.abc_rounded),
              SizedBox(
                height: height,
              ),
              TextDateInput(
                  hintText: "${localization.dictionary(Strings.textFechaInicio)} *", controller: _fechaIniController),
              SizedBox(
                height: height,
              ),
              TextDateInput(
                  hintText: "${localization.dictionary(Strings.textFechaFin)} *",
                  controller: _fechaFinController),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: "${localization.dictionary(Strings.textDniClient)} *",
                  inputType: TextInputType.number,
                  controller: _dniController,
                  icon: Icons.numbers_rounded),
              SizedBox(
                height: height,
              ),
              TextInput(
                hintText: localization.dictionary(Strings.condiconesHintText),
                inputType: TextInputType.text,
                controller: _condicionController,
                maxLines: 5,
              ),
              SizedBox(
                height: height,
              ),
              TextInput(
                hintText: localization.dictionary(Strings.textObservation),
                inputType: TextInputType.text,
                controller: _observacionController,
                maxLines: 5,
              ),
              SizedBox(
                height: height,
              ),
              SizedBox(
                height: height + 5,
              ),
              ButtonLarge(
                  buttonText: seguro != null ? localization.dictionary(Strings.buttonUpdate) : localization.dictionary(Strings.buttonRegister),
                  onPressed: () {
                    if (_polizaController.text.isEmpty ||
                        _ramoController.text.isEmpty ||
                        _fechaIniController.text.isEmpty ||
                        _fechaIniController.text.isEmpty ||
                        _dniController.text.isEmpty) {
                      showToast(localization.dictionary(Strings.msgErrorFormValidation));
                    } else {
                      var datos = {
                        'numeroPoliza': int.parse(_polizaController.text),
                        'ramo': _ramoController.text,
                        'fechaInicio': _fechaIniController.text,
                        'fechaVencimiento': _fechaFinController.text,
                        'condicionesParticulares': _condicionController.text,
                        'observaciones': _observacionController.text,
                        'dniCl': int.parse(_dniController.text),
                      };

                      if (seguro != null) {
                        Navigator.pop(context, [datos, seguro!.id]);
                      } else {
                        var nuevosDatos = Seguro.fromService(datos);
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
