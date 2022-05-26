import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';

class SecondsPicker extends StatefulWidget {
  final Function(int sec) selectedSec;

  const SecondsPicker({
    Key key,
    @required this.selectedSec,
  }) : super(key: key);
  @override
  _SecondsPickerState createState() => _SecondsPickerState();
}

class _SecondsPickerState extends State<SecondsPicker> {
  FixedExtentScrollController _scrollController;

  int curIndex = 0;

  List<int> seconds = [];

  @override
  void initState() {
    // seconds = List.generate(60, (index) {
    //   return index;
    // }).reversed.toList();
    seconds = List.generate(60, (index) {
      return index;
    });

    super.initState();
    setScrollController();
  }

  setScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.selectedSec(curIndex);
    });

    _scrollController = FixedExtentScrollController(initialItem: curIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 30.w,
      child: RotatedBox(
          quarterTurns: 2,
          child: NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                widget.selectedSec(seconds[curIndex]);
              }
              return true;
            },
            child: ListWheelScrollView(
              controller: _scrollController,
              itemExtent: 20.h,
              perspective: 0.00001,
              diameterRatio: 14.0.w,
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: (value) {
                print("sec $value");
                setState(() {
                  curIndex = value;
                });
              },
              children: seconds.map((e) {
                return RotatedBox(
                  quarterTurns: 2,
                  child: Container(
                      width: 30.w,
                      child: Center(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: e == seconds[curIndex] ? "$e" : "$e",
                              style: latoSemiBold.copyWith(
                                  color: e == seconds[curIndex]
                                      ? HexColor.fromHex("#EDEFF0")
                                      : HexColor.fromHex("#959FA5"),
                                  fontSize:
                                      e == seconds[curIndex] ? 18.sp : 12.sp),
                            ),
                            if (e == seconds[curIndex])
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(2, -5),
                                  child: Text(
                                    's',
                                    //superscript is usually smaller in size
                                    textScaleFactor: 0.9,
                                    style: TextStyle(
                                        color: HexColor.fromHex("#EDEFF0")),
                                  ),
                                ),
                              )
                          ]),
                        ),
                      )),
                );
              }).toList(),
            ),
          )),
    );
  }
}
