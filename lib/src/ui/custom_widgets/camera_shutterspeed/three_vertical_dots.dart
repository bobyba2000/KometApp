import 'package:flutter/material.dart';

class ThreeVerticalDots extends StatelessWidget {
  Widget dots() {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [dots(), dots(), dots()],
    );
  }
}
