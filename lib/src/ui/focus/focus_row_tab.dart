import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:web_socket_channel/io.dart';

import 'button_focus_far_large.dart';
import 'button_focus_far_small.dart';
import 'button_focus_near_large.dart';
import 'button_focus_near_small.dart';

class FocusRowTab extends StatefulWidget {
  final String url;

  const FocusRowTab({Key key, @required this.url}) : super(key: key);
  @override
  _FocusRowTabState createState() => _FocusRowTabState();
}

class _FocusRowTabState extends State<FocusRowTab> {
  bool isPressed = false;
  IOWebSocketChannel channel;
  @override
  void initState() {
    channel = IOWebSocketChannel.connect(widget.url);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),
        Text(
          "MANUAL FOCUS CONTROL",
          style: latoSemiBold.copyWith(
              fontSize: 12, color: HexColor.fromHex("#3E505B")),
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 17.5.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#030303"),
              border: Border.all(color: HexColor.fromHex("#1D1D1F"), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonFocusNearLarge(
                channel: channel,
              ),
              ButtonFocusNearSmall(
                channel: channel,
              ),
              ButtonFocusFarSmall(
                channel: channel,
              ),
              ButtonFocusFarLarge(
                channel: channel,
              )
            ],
          ),
        )
      ],
    );
  }
}
