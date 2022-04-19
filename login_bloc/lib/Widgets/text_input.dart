import 'package:flutter/material.dart';
import 'package:login_bloc/Providers/theme.dart';
import 'package:login_bloc/utils/color.dart';
import 'package:provider/provider.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextInputType? inputType;
  final TextEditingController controller;
  final IconData icon;
  int maxLines;

  TextInput(
      {Key? key,
      required this.hintText,
      required this.inputType,
      required this.controller,
      required this.icon,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return Container(
      padding: const EdgeInsets.only(right: 45.0, left: 45.0),
      child: TextField(
          autofocus: false,
          controller: controller,
          keyboardType: inputType,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 15.0,
              color:
                  currentTheme.isDarkTheme() ? Colors.white70 : Colors.black87,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              suffixIcon: Icon(
                icon,
                color: currentTheme.isDarkTheme() ? Colors.white : xiketic,
              ),
              filled: true,
              fillColor:
                  currentTheme.isDarkTheme() ? Colors.white12 : Colors.black12,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Colors.white38
                      : Colors.black45),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: currentTheme.isDarkTheme()
                          ? Colors.white12
                          : Colors.black12),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          currentTheme.isDarkTheme() ? Colors.white : xiketic),
                  borderRadius: const BorderRadius.all(Radius.circular(30))))),
    );
  }
}

class TextInputPassword extends StatefulWidget {
  final String hintText;
  final TextInputType? inputType;
  final TextEditingController controller;
  int maxLines;

  TextInputPassword(
      {Key? key,
      required this.hintText,
      required this.inputType,
      required this.controller,
      this.maxLines = 1})
      : super(key: key);

  @override
  State<TextInputPassword> createState() => _TextInputPasswordState();
}

class _TextInputPasswordState extends State<TextInputPassword> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return Container(
      padding: const EdgeInsets.only(right: 45.0, left: 45.0),
      child: TextFormField(
          autofocus: false,
          controller: widget.controller,
          keyboardType: widget.inputType,
          obscureText: _passwordVisible,
          style: TextStyle(
              fontSize: 15.0,
              color:
                  currentTheme.isDarkTheme() ? Colors.white70 : Colors.black87,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 13.0, color: darkRed),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: currentTheme.isDarkTheme() ? Colors.white : xiketic,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              filled: true,
              fillColor:
                  currentTheme.isDarkTheme() ? Colors.white12 : Colors.black12,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Colors.white38
                      : Colors.black45),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: currentTheme.isDarkTheme()
                          ? Colors.white12
                          : Colors.black12),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          currentTheme.isDarkTheme() ? Colors.white : xiketic),
                  borderRadius: const BorderRadius.all(Radius.circular(30))))),
    );
  }
}
