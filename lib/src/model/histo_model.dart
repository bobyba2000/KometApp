import 'package:flutter/material.dart';

class HistoModel {
  int xValue;
  int yValue;
  HistoModel({
    @required this.xValue,
    @required this.yValue,
  });

  String toString() {
    return 'X: $xValue; y: $yValue';
  }
}
