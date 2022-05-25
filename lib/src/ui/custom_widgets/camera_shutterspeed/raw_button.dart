import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RawButton extends StatefulWidget {
  @override
  _RawButtonState createState() => _RawButtonState();
}

class _RawButtonState extends State<RawButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Container(
        child: SvgPicture.asset(
          isPressed
              ? "assets/icons/Button_ImageFormatRAW_Pressed.svg"
              : "assets/icons/Button_ImageFormatRAW_Idle.svg",
          height: 36,
          width: 30,
        ),
      ),
    );
  }
}
