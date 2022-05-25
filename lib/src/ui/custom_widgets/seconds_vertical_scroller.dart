import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class SecondsVerticalScroller extends StatefulWidget {
  final Function(int sec) selectedSec;

  const SecondsVerticalScroller({Key key, this.selectedSec}) : super(key: key);

  @override
  _SecondsVerticalScrollerState createState() =>
      _SecondsVerticalScrollerState();
}

class _SecondsVerticalScrollerState extends State<SecondsVerticalScroller> {
  FixedExtentScrollController _scrollController;
  List<int> seconds = [];
  int curIndex = 3;

  @override
  void initState() {
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
