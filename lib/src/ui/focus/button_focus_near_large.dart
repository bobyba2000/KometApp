import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';

class ButtonFocusNearLarge extends StatefulWidget {
  final IOWebSocketChannel channel;

  const ButtonFocusNearLarge({Key key, @required this.channel})
      : super(key: key);
  @override
  _ButtonFocusNearLargeState createState() => _ButtonFocusNearLargeState();
}

class _ButtonFocusNearLargeState extends State<ButtonFocusNearLarge> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.channel.sink.add(jsonEncode({
          "CMD": {"FOCUS": "Near L"}
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
              ? "assets/icons/Button_FocusNearLarge_Idle.svg"
              : "assets/icons/Button_FocusNearLarge_Pressed.svg",
          height: 28.w,
          width: 64.h,
        ),
      ),
    );
  }
}
