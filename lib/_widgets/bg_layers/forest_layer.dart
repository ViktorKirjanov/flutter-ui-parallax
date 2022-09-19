import 'package:flutter/material.dart';

class ForestLayer extends StatelessWidget {
  const ForestLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/forest_1200.png",
          height: 400,
          fit: BoxFit.fitHeight,
        ),
        Container(
          height: 500,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.black.withOpacity(1),
                Colors.black.withOpacity(.25),
                Colors.black.withOpacity(.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
