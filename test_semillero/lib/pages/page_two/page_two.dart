import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String title;
  const PageTwo({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(title),
      ),
    );
  }
}
