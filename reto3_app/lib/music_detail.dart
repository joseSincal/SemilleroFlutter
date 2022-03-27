import 'package:flutter/material.dart';

class MusicDetail extends StatelessWidget {
  String musicName;
  String artistName;
  String albumName;
  String albumImage;

  MusicDetail(this.musicName, this.artistName, this.albumName, this.albumImage,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = Container(
      margin: const EdgeInsets.only(left: 20.0),
      child: Text(
        musicName,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 18.0,
            fontFamily: "WorkSans",
            fontWeight: FontWeight.w900),
      ),
    );

    final artist = Container(
      margin: const EdgeInsets.only(left: 20.0),
      child: Text(
        artistName,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 14.0,
            fontFamily: "WorkSans",
            fontWeight: FontWeight.w500),
      ),
    );

    final album = Container(
      margin: const EdgeInsets.only(left: 20.0),
      child: Text(albumName,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 12.0,
            fontFamily: "WorkSans",
          )),
    );

    final description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[name, artist, album],
    );

    final albumPic = Container(
        margin: const EdgeInsets.only(top: 10.0, left: 20.0),
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(albumImage))));

    final iconMore = Container(
      margin: const EdgeInsets.only(right: 40.0),
      child: const Icon(
        Icons.more_vert,
        color: Colors.black,
        size: 25.0,
      ),
    );

    final iconHeart = Container(
      margin: const EdgeInsets.only(right: 20.0),
      child: const Icon(
        Icons.favorite,
        color: Color(0xFF9d0208),
        size: 25.0,
      ),
    );

    final icons = Row(
      children: [iconHeart, iconMore],
    );

    final detail = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        albumPic,
        description,
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[detail, icons],
    );
  }
}
