import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WbAutoButton extends StatefulWidget {
  final bool isPressed;

  final Function() onTap;

  const WbAutoButton({Key key, @required this.isPressed, @required this.onTap})
      : super(key: key);
  @override
  _WbAutoButtonState createState() => _WbAutoButtonState();
}

class _WbAutoButtonState extends State<WbAutoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
        child: SvgPicture.asset(
          widget.isPressed
              ? "assets/icons/Button_WBAuto_Enable.svg"
              : "assets/icons/Button_WBAuto_Disable.svg",
          height: 32.h,
          width: 21.33.h,
        ),
      ),
    );
  }
}
