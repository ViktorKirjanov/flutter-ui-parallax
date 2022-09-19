import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget {
  const TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "NatureCamp",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          CupertinoButton(
            child: Icon(
              Icons.menu_rounded,
              color: Colors.grey.shade500,
              size: 24.0,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
