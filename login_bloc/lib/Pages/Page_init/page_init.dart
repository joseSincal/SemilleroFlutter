import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_bloc/Pages/Page_login/page_login.dart';
import 'package:login_bloc/Widgets/background.dart';

class PageInit extends StatefulWidget {
  const PageInit({Key? key}) : super(key: key);

  @override
  State<PageInit> createState() => _PageInitState();
}

class _PageInitState extends State<PageInit> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.push(
          //context, MaterialPageRoute(builder: (context) => const PageSettings()));
          context,
          MaterialPageRoute(builder: (context) => PageLogin()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [Background(height: null), Image.asset("assets/img/logo.png")],
    ));
  }
}
