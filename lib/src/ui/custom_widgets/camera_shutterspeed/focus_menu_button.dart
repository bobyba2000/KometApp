import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FocusMenuButton extends StatefulWidget {
  final bool hide;
  final Function(bool isFocus) focusListener;

  const FocusMenuButton({Key key, @required this.hide, this.focusListener})
      : super(key: key);
  @override
  _FocusMenuButtonState createState() => _FocusMenuButtonState();
}

class _FocusMenuButtonState extends State<FocusMenuButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
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
                ? "assets/icons/Button_Focus_Enable.svg"
                : "assets/icons/Button_Focus_Disable.svg",
            height: 48.h,
            width: 48.h,
          ),
        ),
      ),
    );
  }
}
