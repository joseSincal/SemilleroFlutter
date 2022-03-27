import 'package:flutter/material.dart';
import 'music_detail.dart';

class MusicDetailList extends StatelessWidget {
  const MusicDetailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 110.0, left: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MusicDetail(
              "Yellow", "Coldplay", "Parachutes", "assets/img/Parachutes.jpg"),
          MusicDetail("Magic", "Coldplay", "Ghost Stories",
              "assets/img/Ghost-Stories.jpg"),
          MusicDetail("Blinding Lights", "The Weeknd", "After Hours",
              "assets/img/after-hours.jpg"),
          MusicDetail("In Your Eyes", "The Weeknd", "After Hours",
              "assets/img/after-hours.jpg"),
          MusicDetail("Save Your Tears", "The Weeknd", "After Hours",
              "assets/img/after-hours.jpg"),
          MusicDetail("Smile (with The Weeknd)", "Juice WRLD, The Weeknd",
              "Legends Never Die", "assets/img/legends_never_die.jpg"),
          MusicDetail(
              "24K Magic", "Bruno Mars", "24K Magic", "assets/img/24k.jpg"),
          MusicDetail("Versace on the Floor", "Bruno Mars", "24K Magic",
              "assets/img/24k.jpg"),
        ],
      ),
    );
  }
}
