import 'package:flutter/material.dart';

mixin HexColor implements Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color dedGray() {
    return HexColor.fromHex("#f2f2f2");
  }

  static Color lightGray() {
    return HexColor.fromHex("#3E505B");
  }

  static Color neoBlue() {
    return HexColor.fromHex("#3498DB");
  }

  static Color neoBlueDisable() {
    return HexColor.fromHex("#1d5378");
  }

  static Color neoGray() {
    return HexColor.fromHex("#1D1D1F");
  }

  static Color isoColor() {
    return HexColor.fromHex("#00FFFF");
  }

  static Color shutterColor() {
    return HexColor.fromHex('#DC143C');
  }

  static Color fstopColor() {
    return HexColor.fromHex('#00FF00');
  }

  static Color white() {
    return HexColor.fromHex('#EDEFF0');
  }

  static Color intervalColor() {
    return HexColor.fromHex('#FFBF00');
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
