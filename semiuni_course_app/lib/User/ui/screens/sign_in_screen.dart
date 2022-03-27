import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semiuni_course_app/User/bloc/bloc_user.dart';
import 'package:semiuni_course_app/User/model/user.dart' as us;
import 'package:semiuni_course_app/platzi_trips_cupertino.dart';
import 'package:semiuni_course_app/widgets/gradient_back.dart';
import 'package:semiuni_course_app/widgets/button_green.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class SignIngScreen extends StatefulWidget {
  const SignIngScreen({Key? key}) : super(key: key);

  @override
  State<SignIngScreen> createState() {
    return _SignIngScreenState();
  }
}

class _SignIngScreenState extends State<SignIngScreen> {
  late UserBloc userBloc;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot - data - Object User
        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        } else {
          return PlatziTripsCupertino();
        }
      },
    );
  }

  Widget signInGoogleUI() {
    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      GradientBack(height: null),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Container(
                width: screenWidth,
                child: const Text(
                  "Welcome. \n This is your Travel App",
                  style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
          )),
          ButtonGreen(
            text: "Login with Gmail",
            onPressed: () async {
              userBloc.signOut();
              final UserCredential valueResponsed = await userBloc.signIn();
              userBloc.updateUserData(us.User(
                  uid: valueResponsed.user?.uid ?? '',
                  name: valueResponsed.user?.displayName ?? '',
                  email: valueResponsed.user?.email ?? '',
                  photoURL: valueResponsed.user?.photoURL ?? ''));
            },
            width: 300.0,
            height: 60.0,
          )
        ],
      )
    ]));
  }
}
