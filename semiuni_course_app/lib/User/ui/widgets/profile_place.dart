import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:semiuni_course_app/Place/model/place.dart';
import 'package:semiuni_course_app/User/ui/widgets/profile_place_info.dart';

class ProfilePlace extends StatelessWidget {
  Place place;
  ProfilePlace(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final photoCard = Container(
      margin: const EdgeInsets.only(
          top: 10.0,
          bottom: 70.0
      ),
      height: 220.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(place.urlImage)
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: Colors.red,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0)
            )
          ]
      ),
    );

    return Stack(
      alignment: const Alignment(0.0, 0.8),
      children: <Widget>[
        photoCard,
        ProfilePlaceInfo(place)
      ],
    );
  }

}
