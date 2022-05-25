import 'package:flutter/material.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HolyGrailMotionControlTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: decoration,
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "INTERVAL | ",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                  ),
                  TextSpan(
                    text: 'Motion Control',
                    style: TextStyle(
                        color: HexColor.fromHex("#EDEFF0"), fontSize: 12.sp),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            "AUX - IN",
            style:
                TextStyle(color: HexColor.fromHex("#EDEFF0"), fontSize: 20.sp),
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
