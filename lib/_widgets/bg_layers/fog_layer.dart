import 'package:flutter/material.dart';

class FogLayer extends StatelessWidget {
  const FogLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            "assets/images/fog_1200.png",
            fit: BoxFit.fitHeight,
            height: 400,
          ),
        ),
      ],
    );
  }
}
