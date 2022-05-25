import 'package:flutter/material.dart';

class KeyFrameItem {
  DateTime dateTime;
  int keyFrameINdex;
  String keyFrameValue;
  String type;

  KeyFrameItem(
      {@required this.dateTime,
      @required this.keyFrameINdex,
      @required this.keyFrameValue,
      @required this.type});
}
