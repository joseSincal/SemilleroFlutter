import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 25.0, left: 5.0),
          child: SizedBox(
            height: 45.0,
            width: 45.0,
            child: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left,
                  color: Colors.white, size: 45.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Flexible(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }
}
