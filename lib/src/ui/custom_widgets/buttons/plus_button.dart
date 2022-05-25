import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlusButton extends StatefulWidget {
  final Function() onTap;

  const PlusButton({Key key, @required this.onTap}) : super(key: key);
  @override
  _PlusButtonState createState() => _PlusButtonState();
}

class _PlusButtonState extends State<PlusButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: SvgPicture.asset(
        isPressed
            ? "assets/icons/Button_Plus_Pressed.svg"
            : "assets/icons/Button_Plus_Idle.svg",
        width: 128.w,
        height: 28.h,
      ),
    );
  }
}
