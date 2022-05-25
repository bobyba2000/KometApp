import 'package:flutter/material.dart';

class SizeConfig {
  static double pixelRatio;

  void init(BuildContext context) {
    pixelRatio = MediaQuery.of(context).devicePixelRatio;
  }
}
