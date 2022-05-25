import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';

class ButtonFocusFarSmall extends StatefulWidget {
  final IOWebSocketChannel channel;

  const ButtonFocusFarSmall({Key key, @required this.channel})
      : super(key: key);
  @override
  _ButtonFocusFarSmallState createState() => _ButtonFocusFarSmallState();
}

class _ButtonFocusFarSmallState extends State<ButtonFocusFarSmall> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.channel.sink.add(jsonEncode({
          "CMD": {"FOCUS": "Far S"}
        }));
      },
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
        !isPressed
            ? "assets/icons/Button_FocusFarSmall_Idle.svg"
            : "assets/icons/Button_FocusFarSmall_Pressed.svg",
        height: 28.w,
        width: 64.h,
      ),
    );
  }
}
