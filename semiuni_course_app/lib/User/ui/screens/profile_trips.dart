import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:semiuni_course_app/User/bloc/bloc_user.dart';
import 'package:semiuni_course_app/User/model/user.dart';
import 'package:semiuni_course_app/User/ui/screens/profile_header.dart';
import 'package:semiuni_course_app/User/ui/widgets/profile_places_list.dart';
import 'package:semiuni_course_app/User/ui/widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {
  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              return showProfileData(snapshot);
          }
        });
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No Logeado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: const [Text("Usuario no logeado. Haz login")],
          ),
        ],
      );
    } else {
      print("Logeado");
      var user = User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);

      return Stack(
        children: [
          ProfileBackground(),
          ListView(
            children: [
              ProfileHeader(user: user),
              ProfilePlacesList(user: user)
            ],
          ),
        ],
      );
    }
  }
}
