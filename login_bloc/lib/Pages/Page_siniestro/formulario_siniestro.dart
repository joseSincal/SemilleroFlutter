import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:login_bloc/Models/siniestro_model.dart';
import 'package:login_bloc/Providers/languaje_provider.dart';
import 'package:login_bloc/Repository/seguro_repository.dart';
import 'package:login_bloc/Widgets/app_bar_title.dart';
import 'package:login_bloc/Widgets/background.dart';
import 'package:login_bloc/Widgets/button_large.dart';
import 'package:login_bloc/Widgets/text_input.dart';
import 'package:login_bloc/localization/localization.dart';
import 'package:login_bloc/utils/app_string.dart';
import 'package:provider/provider.dart';

class FormularioSiniestro extends StatelessWidget {
  Siniestro? siniestro;
  double height = 20.0;
  FormularioSiniestro({Key? key, this.siniestro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _idSiniestroController = TextEditingController();
    TextEditingController _fechaController = TextEditingController();
    TextEditingController _causaController = TextEditingController();
    bool _aceptadoController = false;
    TextEditingController _indemnizacionController = TextEditingController();
    TextEditingController _polizaController = TextEditingController();

    if (siniestro != null) {
      _idSiniestroController.text = "${siniestro?.idSiniestro}";
      _fechaController.text =
          DateFormat("dd-MM-yyyy").format(siniestro!.fechaSiniestro);
      _causaController.text = siniestro?.causas as String;
      _aceptadoController = siniestro!.aceptado;
      _indemnizacionController.text = "${siniestro?.indenmizacion}";
      _polizaController.text = "${siniestro?.seguro.numeroPoliza}";
    }

    final lang = Provider.of<LanguajeProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);

    final check = ChechBoxInput(
        title: localization.dictionary(Strings.textAceptado),
        status: _aceptadoController);

    return Scaffold(
      body: Stack(children: [
        Background(height: null),
        AppBarTitle(
            title: siniestro != null
                ? localization.dictionary(Strings.titlePageClaimFormEdit)
                : localization.dictionary(Strings.titlePageClaimFormAdd)),
        Container(
          margin: const EdgeInsets.only(top: 105),
          child: ListView(
            padding: const EdgeInsets.only(
                top: 25, bottom: 25, right: 30.0, left: 30.0),
            children: [
              TextInput(
                  hintText:
                      "${localization.dictionary(Strings.textIdSiniestro)} *",
                  inputType: TextInputType.number,
                  controller: _idSiniestroController,
                  icon: Icons.numbers_rounded,
                  readOnly: siniestro != null ? true : false),
              SizedBox(
                height: height,
              ),
              TextDateInput(
                  hintText: "${localization.dictionary(Strings.textFecha)} *",
                  controller: _fechaController),
              SizedBox(
                height: height,
              ),
              TextInput(
                hintText: "${localization.dictionary(Strings.textCausas)} *",
                inputType: TextInputType.text,
                controller: _causaController,
                maxLines: 6,
              ),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText: localization.dictionary(Strings.textIndemnizacion),
                  inputType: TextInputType.number,
                  controller: _indemnizacionController,
                  icon: Icons.attach_money),
              SizedBox(
                height: height,
              ),
              TextInput(
                  hintText:
                      "# ${localization.dictionary(Strings.textPoliza)} *",
                  inputType: TextInputType.number,
                  controller: _polizaController,
                  icon: Icons.numbers),
              SizedBox(
                height: height,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 15.0), child: check),
              SizedBox(
                height: height + 5,
              ),
              ButtonLarge(
                  buttonText: siniestro != null
                      ? localization.dictionary(Strings.buttonUpdate)
                      : localization.dictionary(Strings.buttonRegister),
                  onPressed: () async {
                    if (_idSiniestroController.text.isEmpty ||
                        _fechaController.text.isEmpty ||
                        _causaController.text.isEmpty ||
                        _polizaController.text.isEmpty) {
                      showToast(localization
                          .dictionary(Strings.msgErrorFormValidation));
                    } else {
                      List<dynamic> seguro = await SeguroRepository.shared
                          .selectWhere(
                              tablaName: 'seguro',
                              whereClause: "numeroPoliza = ?",
                              whereArgs: [_polizaController.text]);

                      var datos = {
                        'idSiniestro': int.parse(_idSiniestroController.text),
                        'fechaSiniestro': _fechaController.text,
                        'causas': _causaController.text,
                        'aceptado': check.status ? "1" : "0",
                        'indenmizacion': _indemnizacionController.text,
                        'seguro': seguro.first,
                      };

                      if (siniestro != null) {
                        datos['seguro'] = jsonEncode(seguro.first);
                        Navigator.pop(context, [datos, siniestro!.id]);
                      } else {
                        var nuevosDatos = Siniestro.fromService(datos);
                        Navigator.pop(context, [nuevosDatos]);
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
