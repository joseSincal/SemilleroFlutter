import 'package:flutter/material.dart';

class PageUser extends StatelessWidget {
  final String username;
  const PageUser({required this.username, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(username),
      ),
    );
  }
}
