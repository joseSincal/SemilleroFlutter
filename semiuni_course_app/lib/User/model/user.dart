import 'package:flutter/material.dart';
import 'package:semiuni_course_app/Place/model/place.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Place>? myPlaces;
  final List<Place>? myFavoritePlaces;
  /*late final List<Place> myPlaces;
  late final List<Place> myFavoritePlaces;*/

  User(
      {Key? key,
      required this.uid,
      required this.name,
      required this.email,
      required this.photoURL,
      this.myPlaces,
      this.myFavoritePlaces
    }
  );

  /*User(
      {Key? key,
      required this.uid,
      required this.name,
      required this.email,
      required this.photoURL,
      List<Place>? myPlaces,
      List<Place>? myFavoritePlaces}) {
    this.myPlaces = myPlaces ?? [];
    this.myFavoritePlaces = myFavoritePlaces ?? [];
  }*/
}
