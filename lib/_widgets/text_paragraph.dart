import 'package:flutter/material.dart';

class TextParagraph extends StatelessWidget {
  final String text;

  const TextParagraph({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 30,
      style: TextStyle(
        color: Colors.grey.shade400,
      ),
      textAlign: TextAlign.left,
    );
  }
}
