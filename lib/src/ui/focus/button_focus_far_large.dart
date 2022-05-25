import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';

class ButtonFocusFarLarge extends StatefulWidget {
  final IOWebSocketChannel channel;

  const ButtonFocusFarLarge({Key key, @required this.channel})
      : super(key: key);
  @override
  _ButtonFocusFarLargeState createState() => _ButtonFocusFarLargeState();
}

class _ButtonFocusFarLargeState extends State<ButtonFocusFarLarge> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.channel.sink.add(jsonEncode({
          "CMD": {"FOCUS": "Far L"}
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
      child: Container(
        child: SvgPicture.asset(
          !isPressed
              ? "assets/icons/Button_FocusFarLarge_Idle.svg"
              : "assets/icons/Button_FocusFarLarge_Pressed.svg",
          height: 28.w,
          width: 64.h,
        ),
      ),
    );
  }
}
