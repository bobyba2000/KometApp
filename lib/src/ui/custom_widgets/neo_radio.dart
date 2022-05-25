import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeoRadio extends StatelessWidget {
  final Function(bool) onTap;
  final bool isActive;
  final Size size;

  const NeoRadio(
      {Key key,
      this.onTap,
      @required this.isActive,
      this.size = const Size(30, 30)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height.sp,
        width: size.width.sp,
        child: Center(
          child: GestureDetector(
            onTap: () {
              onTap(isActive);
            },
            child: Padding(
              padding: EdgeInsets.all(0),
              child: SvgPicture.asset(
                isActive
                    ? "assets/icons/Button_Radio_Enable.svg"
                    : "assets/icons/Button_Radio_Disable.svg",
                height: size.height.sp,
                width: size.width.sp,
              ),
            ),
          ),
        ));
  }
}
