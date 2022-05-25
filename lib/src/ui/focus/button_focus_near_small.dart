import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';

class ButtonFocusNearSmall extends StatefulWidget {
  final IOWebSocketChannel channel;

  const ButtonFocusNearSmall({Key key, @required this.channel})
      : super(key: key);
  @override
  _ButtonFocusNearSmallState createState() => _ButtonFocusNearSmallState();
}

class _ButtonFocusNearSmallState extends State<ButtonFocusNearSmall> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.channel.sink.add(jsonEncode({
          "CMD": {"FOCUS": "Near S"}
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
            ? "assets/icons/Button_FocusNearSmall_Idle.svg"
            : "assets/icons/Button_FocusNearSmall_Pressed.svg",
        height: 28.w,
        width: 64.h,
      ),
    );
  }
}
