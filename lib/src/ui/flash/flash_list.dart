import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class FlashList extends StatefulWidget {
  // final String url;

  const FlashList({Key key}) : super(key: key);
  @override
  _FlashListState createState() => _FlashListState();
}

class _FlashListState extends State<FlashList> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w),
      child: Column(
        children: [
          // SizedBox(
          //   height: 12.h,
          // ),
          Container(
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#030303"),
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                Expanded(
                    child: Row(children: [
                  SizedBox(
                    width: 12.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "RC-01:11:22:33:FF:EE",
                        style: latoSemiBold.copyWith(
                            color: HexColor.fromHex("#EDEFF0"),
                            fontSize: 15.sp),
                      ),
                      Text(
                        "RSS-150dBm, BAT 100%, FW A6",
                        style: latoSemiBold.copyWith(
                            color: HexColor.fromHex("#3E505B"),
                            fontSize: 12.sp),
                      )
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "[A]",
                          style: latoSemiBold.copyWith(
                              color:
                                  HexColor.fromHex("#3498DB").withOpacity(0.9),
                              fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                      ]),
                ])),
                Column(children: [
                  RichText(
                    text: TextSpan(children: [
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0, -1),
                          child: Text(
                            '1/',
                            //superscript is usually smaller in size
                            // textScaleFactor: 0.8,
                            style: TextStyle(
                                color: HexColor.fromHex("#3498DB")
                                    .withOpacity(0.9),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "1",
                        style: latoSemiBold.copyWith(
                            color: HexColor.fromHex("#3498DB").withOpacity(0.9),
                            fontSize: 28.sp),
                      ),
                    ]),
                  ),
                  Text(
                    "70mm",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex("#EDEFF0"), fontSize: 12.sp),
                  )
                ]),
                SizedBox(width: 22.w),
                Column(children: [
                  SvgPicture.asset(
                    isActive
                        ? "assets/icons/Checkbox_Enable.svg"
                        : "assets/icons/Checkbox_Disable.svg",
                    width: 18.w,
                    height: 18.h,
                  ),
                ]),
                SizedBox(width: 5.w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget clockIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_TimeDelay_Enable.svg"
          : "assets/icons/Button_TimeDelay_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }

  Widget stackIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_MultipleShots_Enable.svg"
          : "assets/icons/Button_MultipleShots_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }

  Widget ndFilterIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_NDFilter_Enable.svg"
          : "assets/icons/Button_NDFilter_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }
}
