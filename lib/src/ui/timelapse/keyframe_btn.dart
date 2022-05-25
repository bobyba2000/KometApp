import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KeyFrameBtn extends StatefulWidget {
  final bool hide;
  final Function(bool isFocus) focusListener;

  const KeyFrameBtn(
      {Key key, @required this.hide, @required this.focusListener})
      : super(key: key);

  @override
  _KeyFrameBtnState createState() => _KeyFrameBtnState();
}

class _KeyFrameBtnState extends State<KeyFrameBtn> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    if (!widget.hide) return Container();
    return AnimatedOpacity(
      opacity: widget.hide ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        height: 48.h,
        width: 48.h,
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            widget.focusListener(!isPressed);
            setState(() {
              isPressed = !isPressed;
            });
          },
          icon: SvgPicture.asset(
            isPressed
                ? "assets/icons/Button_Keyframe_Enable.svg"
                : "assets/icons/Button_Keyframe_Disable.svg",
            height: 48.h,
            width: 48.h,
          ),
        ),
      ),
    );
  }
}
