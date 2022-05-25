import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo/src/ui/custom_widgets/usable_widgets/increase_tap_area.dart';

class EABlButton extends StatefulWidget {
  final Function() onTap;

  const EABlButton({Key key, @required this.onTap}) : super(key: key);
  @override
  _EABlButtonState createState() => _EABlButtonState();
}

class _EABlButtonState extends State<EABlButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 28.h,
      // width: 128.w,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (details) {
          setState(() {
            isPressed = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            isPressed = false;
          });
        },
        child: Center(
          child: ExpandedHitTestArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
              child: SvgPicture.asset(
                isPressed
                    ? "assets/icons/Button_AEB-L_Pressed.svg"
                    : "assets/icons/Button_AEB-L_Idle.svg",
                width: 128.w * 0.8,
                height: 28.h * 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
