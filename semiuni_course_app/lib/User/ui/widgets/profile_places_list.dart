import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:semiuni_course_app/User/bloc/bloc_user.dart';
import 'package:semiuni_course_app/User/model/user.dart';

class ProfilePlacesList extends StatelessWidget {
  late UserBloc userBloc;
  final User user;

  ProfilePlacesList({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
        margin: const EdgeInsets.only(
            top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
        child: StreamBuilder(
          stream: userBloc.myPlacesListStream(user.uid),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                return Column(
                  children: userBloc.buildMyPlaces(snapshot.data.docs),
                );
            }
          },
        ));
  }
}
