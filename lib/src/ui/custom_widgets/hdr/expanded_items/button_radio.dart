import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class ButtonRadio extends StatelessWidget {
  final bool isActive;
  final String bracketColor;
  final String name;
  final Function() onTap;

  const ButtonRadio(
      {Key key,
      @required this.isActive,
      @required this.bracketColor,
      @required this.name,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: SvgPicture.asset(
                  isActive
                      ? "assets/icons/Button_Radio_Enable.svg"
                      : "assets/icons/Button_Radio_Disable.svg",
                  width: 18.w,
                  height: 18.h,
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Flexible(
                flex: 4,
                child: RichText(
                  softWrap: false,
                  text: TextSpan(
                    text: "[",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex(bracketColor), fontSize: 12.sp),
                    children: <TextSpan>[
                      TextSpan(
                        text: "$name",
                        style: latoSemiBold.copyWith(
                            color: isActive
                                ? HexColor.fromHex("#EDEFF0")
                                : HexColor.fromHex("#959FA5"),
                            fontSize: 12.sp),
                      ),
                      TextSpan(
                        text: "]",
                        style: latoSemiBold.copyWith(
                            color: HexColor.fromHex(bracketColor),
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
