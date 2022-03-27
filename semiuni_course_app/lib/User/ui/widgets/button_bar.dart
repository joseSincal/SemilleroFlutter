import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semiuni_course_app/Place/ui/screens/add_place_screen.dart';
import 'package:semiuni_course_app/User/bloc/bloc_user.dart';
import 'package:semiuni_course_app/User/ui/widgets/circle_button.dart';

class ButtonsBar extends StatelessWidget {
  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            //Cambiar la contraseña
            CircleButton(true, Icons.vpn_key, 20.0,
                const Color.fromRGBO(255, 255, 255, 0.6),
                onPressed: () => {}),
            //Añadir lugar
            CircleButton(
                false, Icons.add, 40.0, const Color.fromRGBO(255, 255, 255, 1),
                onPressed: () {
                  ImagePicker().pickImage(source: ImageSource.camera)
                    .then((image) {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddPlaceScreen(image: File(image!.path))));
                    })
                    .catchError((onError) => print(onError));
            }),
            //Cerrar Sesión
            CircleButton(true, Icons.exit_to_app, 20.0,
                const Color.fromRGBO(255, 255, 255, 0.6),
                onPressed: () => {userBloc.signOut()})
          ],
        ));
  }
}
