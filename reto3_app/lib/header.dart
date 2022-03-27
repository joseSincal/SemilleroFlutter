import 'package:flutter/material.dart';
import 'circle_shape.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0)),
        child: Container(
          height: 110.0,
          decoration: const BoxDecoration(
            color: Color(0xFF6a040f),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10.0, right: -120.0, child: Circle(300, Colors.black26)),
              Positioned(
                  top: -60.0, left: -65.0, child: Circle(235, Colors.white10)),
              Positioned(
                  top: -230,
                  right: -30,
                  child: Circle(280, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 15.0),
                      alignment: Alignment.center,
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Tus me gusta",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontFamily: "WorkSans",
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          )))),
              const Positioned(
                top: 50.0,
                left: 0.0,
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 40.0,
                ),
              )
            ],
          ),
        ));
  }
}
