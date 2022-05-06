import 'package:flutter/material.dart';
import 'package:login_bloc/Providers/theme_provider.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class ButtonLarge extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const ButtonLarge(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: 50.0,
        width: 180.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: currentTheme.isDarkTheme()
                    ? [persimmon, tangerine]
                    : [xiketic, darkSienna],
                begin: const FractionalOffset(0.2, 0.0),
                end: const FractionalOffset(1.0, 0.6),
                stops: const [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 18.0,
                color: currentTheme.isDarkTheme() ? darkSienna : Colors.white),
          ),
        ),
      ),
    );
  }
}
