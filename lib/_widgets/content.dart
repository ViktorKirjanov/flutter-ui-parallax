import 'package:flutter/material.dart';

import 'text_paragraph.dart';

class Content extends StatelessWidget {
  final double opacity;

  const Content({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Opacity(
        opacity: opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Strategic",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4.0),
            Text(
              "ALLIANCE",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25.0),
            const TextParagraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Duis pulvinar. Praesent in mauris eu tortor porttitor accumsan. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. ",
            ),
            const SizedBox(height: 25.0),
            const TextParagraph(
              text:
                  "Maecenas aliquet accumsan leo. Fusce tellus. Cras elementum. Nullam justo enim, consectetuer nec, ullamcorper ac, vestibulum in, elit. Aliquam erat volutpat.",
            ),
          ],
        ),
      ),
    );
  }
}
