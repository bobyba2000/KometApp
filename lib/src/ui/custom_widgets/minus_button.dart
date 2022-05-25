import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinusButton extends StatefulWidget {
  final Function() onTap;

  const MinusButton({Key key, @required this.onTap}) : super(key: key);
  @override
  _MinusButtonState createState() => _MinusButtonState();
}

class _MinusButtonState extends State<MinusButton> {
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
            ? "assets/icons/Button_Minus_Pressed.svg"
            : "assets/icons/Button_Minus_Idle.svg",
        width: 128.w,
        height: 28.h,
      ),
    );
  }
}
