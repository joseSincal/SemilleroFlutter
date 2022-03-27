import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:semiuni_course_app/widgets/floating_action_button_green.dart';

class CardImageWithFavIcon extends StatelessWidget {
  final double height;
  final double width;
  double left;
  final String pathImage;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;
  bool internet;

  CardImageWithFavIcon(
      {Key? key,
      required this.pathImage,
      required this.width,
      required this.height,
      required this.onPressedFabIcon,
      required this.iconData,
      this.internet = true,
      this.left = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: left),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: internet
                  ? CachedNetworkImageProvider(pathImage)
                  : FileImage(File(pathImage))
                      as ImageProvider), //FileImage(File(pathImage))),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0))
          ]),
    );

    return Stack(
      alignment: const Alignment(0.9, 1.1),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(
          iconData: iconData,
          onPressed: onPressedFabIcon,
        )
      ],
    );
  }
}
