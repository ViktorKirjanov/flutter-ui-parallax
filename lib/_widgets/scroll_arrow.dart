import 'package:flutter/material.dart';

class ScrollArrow extends StatelessWidget {
  final double arrowLineHeight;
  final double arrowSize;
  final double arrowLineWidth;
  final double opacity;

  const ScrollArrow({
    super.key,
    required this.arrowLineHeight,
    required this.arrowSize,
    required this.arrowLineWidth,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: arrowLineHeight + arrowSize / 2,
        width: arrowSize,
        child: Stack(
          children: [
            Positioned(
              left: arrowSize / 2 - arrowLineWidth / 2,
              child: Container(
                height: arrowLineHeight,
                width: arrowLineWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(arrowLineWidth / 2),
                      topLeft: Radius.circular(arrowLineWidth / 2)),
                  color: const Color.fromRGBO(214, 222, 224, 1),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: arrowSize,
                height: arrowSize,
                child: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: const Color.fromRGBO(214, 222, 224, 1),
                  size: arrowSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
