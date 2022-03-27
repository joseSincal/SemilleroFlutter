import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  double height;
  Color color;
  Color borderColor = Colors.transparent;
  double borderWidth = 2;

  Circle(this.height, this.color,
      {this.borderColor = Colors.transparent, this.borderWidth = 2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }
}
