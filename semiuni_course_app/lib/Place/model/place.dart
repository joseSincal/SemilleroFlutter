import 'package:flutter/material.dart';
import 'package:semiuni_course_app/User/model/user.dart';

class Place {
  String? id;
  final String name;
  final String description;
  final String urlImage;
  late final int likes;
  bool liked;

  //User? userOwnre;

  Place({
    Key? key,
    required this.name,
    required this.description,
    required this.urlImage,
    this.likes = 0,
    this.liked = false,
    this.id
    //this.userOwnre
  });
}
