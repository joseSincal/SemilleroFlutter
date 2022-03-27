import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:semiuni_course_app/Place/model/place.dart';
import 'package:semiuni_course_app/Place/ui/widgets/card_image.dart';
import 'package:semiuni_course_app/User/bloc/bloc_user.dart';
import 'package:semiuni_course_app/User/model/user.dart';

class CardImageList extends StatefulWidget {
  final User user;
  const CardImageList({Key? key, required this.user}) : super(key: key);

  @override
  State<CardImageList> createState() => _CardImageListState();
}

late UserBloc userBloc;

class _CardImageListState extends State<CardImageList> {
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
        height: 350.0,
        child: StreamBuilder(
            stream: userBloc.placeStream,
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  return listViewPlaces(
                      userBloc.buildPlaces(snapshot.data.docs, widget.user));
              }
            }));
  }

  Widget listViewPlaces(List<Place> places) {
    void setLiked(Place place){
      setState(() {
        place.liked = !place.liked;
        userBloc.likePlace(place, widget.user.uid);
        place.likes = place.liked ? place.likes + 1 : place.likes - 1;
        userBloc.placeSelectedSink.add(place);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;
    return ListView(
      padding: const EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place) {
        return GestureDetector(
          onTap: (){
            userBloc.placeSelectedSink.add(place);
          },
          child: CardImageWithFavIcon(
          pathImage: place.urlImage,
          width: 300.0,
          height: 275.0,
          left: 20.0,
          iconData: place.liked ? iconDataLiked : iconDataLike,
          onPressedFabIcon: () {
            setLiked(place);
          },
          internet: true,
          )
        );
      }).toList(),
    );
  }
}
