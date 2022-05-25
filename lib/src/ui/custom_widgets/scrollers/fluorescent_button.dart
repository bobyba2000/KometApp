import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FluorescentButton extends StatefulWidget {
  final bool isPressed;

  final Function() onTap;

  const FluorescentButton(
      {Key key, @required this.isPressed, @required this.onTap})
      : super(key: key);
  @override
  _FluorescentButtonState createState() => _FluorescentButtonState();
}

class _FluorescentButtonState extends State<FluorescentButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
        child: SvgPicture.asset(
          widget.isPressed
              ? "assets/icons/Button_WBFluorescent_Enable.svg"
              : "assets/icons/Button_WBFluorescent_Disable.svg",
          height: 32.h,
          width: 21.33.h,
        ),
      ),
    );
  }
}
