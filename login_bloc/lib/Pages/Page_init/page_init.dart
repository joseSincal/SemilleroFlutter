import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_bloc/Pages/Page_login/page_login.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

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
          //context, MaterialPageRoute(builder: (context) => const PageData()));
          context,
          MaterialPageRoute(builder: (context) => const PageLogin()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: currentTheme.isDarkTheme()
                  ? [xiketic, darkSienna]
                  : [persimmon, tangerine],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Center(
          child: Image.asset("assets/img/logo.png"),
        ),
      ),
    );
  }
}
