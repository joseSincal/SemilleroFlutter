import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semiuni_course_app/Place/model/place.dart';
import 'package:semiuni_course_app/Place/ui/widgets/card_image.dart';
import 'package:semiuni_course_app/Place/ui/widgets/title_input_location.dart';
import 'package:semiuni_course_app/User/bloc/bloc_user.dart';
import 'package:semiuni_course_app/widgets/button_purple.dart';
import 'package:semiuni_course_app/widgets/gradient_back.dart';
import 'package:semiuni_course_app/widgets/text_input.dart';
import 'package:semiuni_course_app/widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  File image;

  AddPlaceScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();
    final _controllerLocationPlace = TextEditingController();

    return Scaffold(
        body: Stack(
      children: [
        GradientBack(height: 300.0),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 25.0, left: 5.0),
              child: SizedBox(
                height: 45.0,
                width: 45.0,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left,
                      color: Colors.white, size: 45.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Flexible(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                  child: const TitleHeader(
                    title: "Add a new Place",
                  )),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 120.0, bottom: 20.0),
          child: ListView(children: [
            Container(
              // Foto
              alignment: Alignment.center,
              child: CardImageWithFavIcon(
                  pathImage: widget.image.path, //"assets/img/sunset.jpeg",
                  width: 350.0,
                  height: 250.0,
                  onPressedFabIcon: () {},
                  iconData: Icons.camera_alt,
                  internet: false,),
            ),
            Container(
              margin: const EdgeInsets.only(top: 35.0, bottom: 20.0),
              child: TextInput(
                hintText: "Title",
                inputType: null,
                controller: _controllerTitlePlace,
              ),
            ),
            TextInput(
                hintText: "Description",
                inputType: TextInputType.multiline,
                maxLines: 4,
                controller: _controllerDescriptionPlace),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: TextInputLocation(
                hintText: "Add Location",
                iconData: Icons.location_on,
                controller: _controllerLocationPlace,
              ),
            ),
            Container(
              width: 70.0,
              child: ButtonPurple(
                  buttonText: "Add Place",
                  onPressed: () {
                    //ID del usuario logeado actualmente
                    userBloc.currentUser().then((User? user) {
                      if (user != null) {
                        String uid = user.uid;
                        String path = "$uid/${DateTime.now().toString()}.jpg";
                        //1. Firebase Storage
                        //url -
                        userBloc
                            .uploadFile(path, widget.image)
                            .then((UploadTask uploadTask) {
                          uploadTask.then((TaskSnapshot taskSnapshot) {
                            taskSnapshot.ref.getDownloadURL().then((urlImage) {
                              print("URLIMAGE: $urlImage");

                              //2. Cloud Firestore
                              //Place - title, description, url, userOwner, likes
                              userBloc
                                  .updatePlaceDate(Place(
                                      name: _controllerTitlePlace.text,
                                      description:
                                          _controllerDescriptionPlace.text,
                                      likes: 0,
                                      urlImage: urlImage))
                                  .whenComplete(() {
                                print("TERMINO");
                                Navigator.pop(context);
                              });
                            });
                          });
                        });
                      }
                    });
                  }),
            )
          ]),
        )
      ],
    ));
  }
}
