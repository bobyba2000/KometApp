import 'package:flutter/material.dart';

import 'hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//final String localWesocketurlNEO = 'ws://192.168.1.107:8080';

String formUrl(String url) {
  // return 'ws://$url:11222';
  return 'ws://$url';
}

BoxDecoration decoration = BoxDecoration(
    color: HexColor.fromHex("#030303"),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30), topRight: Radius.circular(30)));

double margin(int curIndex) {
  if (curIndex == 0) {
    //its value is -9
    return 0.3.w;
  }
  if (curIndex == 1) {
    //its value is -8.6
    return 5.7.w;
  }
  if (curIndex == 2) {
    //its value is -8.3
    return 11.w;
  }
  if (curIndex == 3) {
    //its value is -8
    return 16.5.w;
  }
  if (curIndex == 4) {
    //its value is -7.6
    return 22.w;
  }
  if (curIndex == 5) {
    //its value is -7.3
    return 27.5.w;
  }
  if (curIndex == 6) {
    //its value is -7
    return 33.w;
  }
  if (curIndex == 7) {
    //its value is -6.6
    return 38.5.w;
  }
  if (curIndex == 8) {
    //its value is -6.3
    return 44.w;
  }
  if (curIndex == 9) {
    //its value is -6
    return 49.5.w;
  }
  if (curIndex == 10) {
    //its value is -5.6
    return 54.5.w;
  }
  if (curIndex == 11) {
    //its value is -5.3
    return 60.w;
  }
  if (curIndex == 12) {
    //its value is -5
    return 65.5.w;
  }
  if (curIndex == 13) {
    //its value is -4.6
    return 71.w;
  }
  if (curIndex == 14) {
    //its value is -4.3
    return 76.5.w;
  }
  if (curIndex == 15) {
    //its value is -4
    return 82.w;
  }
  if (curIndex == 16) {
    //its value is -3.6
    return 87.5.w;
  }
  if (curIndex == 17) {
    //its value is -3.3
    return 93.w;
  }
  if (curIndex == 18) {
    //its value is -3
    return 98.5.w;
  }
  if (curIndex == 19) {
    //its value is -2.6
    return 104.w;
  }
  if (curIndex == 20) {
    //its value is -2.3
    return 109.w;
  }
  if (curIndex == 21) {
    //its value is -2
    return 114.5.w;
  }
  if (curIndex == 22) {
    //its value is -1.6
    return 120.5.w;
  }
  if (curIndex == 23) {
    //its value is -1.3
    return 125.5.w;
  }
  if (curIndex == 24) {
    //its value is -1
    return 131.w;
  }
  if (curIndex == 25) {
    //its value is -0.6
    return 136.5.w;
  }
  if (curIndex == 26) {
    //its value is -0.3
    return 142.w;
  }
  if (curIndex == 27) {
    //its value is 0
    return 147.5.w;
  }
  if (curIndex == 28) {
    //its value is +0.3
    return 153.w;
  }
  if (curIndex == 29) {
    //its value is +0.6
    return 158.4.w;
  }
  if (curIndex == 30) {
    //its value is +1
    return 164.w;
  }
  if (curIndex == 31) {
    //its value is +1.3
    return 169.w;
  }
  if (curIndex == 32) {
    //its value is +1.6
    return 174.5.w;
  }
  if (curIndex == 33) {
    //its value is +2
    return 180.w;
  }
  if (curIndex == 34) {
    //its value is +2.3
    return 185.5.w;
  }
  if (curIndex == 35) {
    //its value is +2.6
    return 191.w;
  }
  if (curIndex == 36) {
    //its value is +3
    return 196.5.w;
  }
  if (curIndex == 37) {
    //its value is +3.3
    return 202.w;
  }
  if (curIndex == 38) {
    //its value is +3.6
    return 207.5.w;
  }
  if (curIndex == 39) {
    //its value is +4
    return 213.w;
  }
  if (curIndex == 40) {
    //its value is +4.3
    return 218.w;
  }
  if (curIndex == 41) {
    //its value is +4.6
    return 223.3.w;
  }
  if (curIndex == 42) {
    //its value is +5
    return 229.w;
  }
  if (curIndex == 43) {
    //its value is +5.3
    return 234.5.w;
  }
  if (curIndex == 44) {
    //its value is +5.6
    return 240.w;
  }
  if (curIndex == 45) {
    //its value is +6
    return 246.w;
  }
  if (curIndex == 46) {
    //its value is +6.3
    return 251.w;
  }
  if (curIndex == 47) {
    //its value is +6.6
    return 256.4.w;
  }
  if (curIndex == 48) {
    //its value is +7
    return 262.w;
  }
  if (curIndex == 49) {
    //its value is +7.3
    return 267.5.w;
  }
  if (curIndex == 50) {
    //its value is +7.6
    return 273.w;
  }
  if (curIndex == 51) {
    //its value is +8
    return 278.w;
  }
  if (curIndex == 52) {
    //its value is +8.3
    return 284.w;
  }
  if (curIndex == 53) {
    //its value is +8.6
    return 289.w;
  }
  if (curIndex == 54) {
    //its value is +9
    return 294.5.w;
  }
  return 0.w;
}

//Computes and
computeBasic() {}
