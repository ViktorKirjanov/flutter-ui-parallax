import 'package:flutter/material.dart';

class Slogan extends StatelessWidget {
  final double opacity;

  const Slogan({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Opacity(
        opacity: opacity,
        child: Text(
          "Preserve \nNature",
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: 36.0,
            height: 1.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
