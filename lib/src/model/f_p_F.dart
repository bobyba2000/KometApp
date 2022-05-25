import 'package:flutter/material.dart';

///This class is model which helps to hold data changed from respective bloc ie FPS, Frame
class FPF {
  int value;
  bool isSet;

  FPF({@required this.value, @required this.isSet});

  @override
  String toString() => 'FPF(value: $value, isSet: $isSet)';
}
