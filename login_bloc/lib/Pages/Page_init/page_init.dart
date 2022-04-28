import 'package:flutter/material.dart';
import 'package:login_bloc/Widgets/background.dart';

class PageInit extends StatelessWidget {
  const PageInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [Background(height: null), Image.asset("assets/img/logo.png")],
    ));
    /**/
  }
}
