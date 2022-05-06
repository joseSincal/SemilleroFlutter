import 'package:flutter/material.dart';
import 'package:login_bloc/Providers/theme_provider.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class Background extends StatelessWidget {
  late double? height;

  Background({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: height ?? screenHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: currentTheme.isDarkTheme()
                  ? [xiketic, darkSienna]
                  : [persimmon, tangerine],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        )
    );
  }
}
