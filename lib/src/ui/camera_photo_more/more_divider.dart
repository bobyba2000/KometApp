import 'package:flutter/material.dart';
import 'package:neo/src/constants/hex_color.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Divider(
          height: 3.h,
          thickness: 2.h,
          color: HexColor.fromHex("#1D1D1F"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4.h,
                width: 54.w,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    color: HexColor.neoBlue(),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              )
            ],
          ),
        )
      ],
    );
  }
}
