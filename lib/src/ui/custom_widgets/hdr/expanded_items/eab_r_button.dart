import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo/src/ui/custom_widgets/usable_widgets/increase_tap_area.dart';

class EABRButton extends StatefulWidget {
  final Function() onTap;

  const EABRButton({Key key, @required this.onTap}) : super(key: key);
  @override
  _EABRButtonState createState() => _EABRButtonState();
}

class _EABRButtonState extends State<EABRButton> {
  bool isPressed = false;
  static double scale = 0.8;
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
              padding: EdgeInsets.all(2),
              child: SvgPicture.asset(
                isPressed
                    ? "assets/icons/Button_AEB-R_Pressed.svg"
                    : "assets/icons/Button_AEB-R_Idle.svg",
                width: 128.w * scale,
                height: 28.h * scale,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
