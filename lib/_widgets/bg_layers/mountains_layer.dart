import 'package:flutter/material.dart';

class MountainsLayer extends StatelessWidget {
  const MountainsLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/mountain_1200.png",
          height: 400,
          fit: BoxFit.fitHeight,
        ),
        Container(
          height: 400,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
                Colors.black,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
