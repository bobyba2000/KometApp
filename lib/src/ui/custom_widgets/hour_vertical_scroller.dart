import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class HourVerticalScroller extends StatefulWidget {
  final Function(int hour) selectedHour;
  final bool isActive;
  final int curIndex;

  const HourVerticalScroller(
      {Key key,
      this.selectedHour,
      @required this.isActive,
      @required this.curIndex})
      : super(key: key);
  @override
  _HourVerticalScrollerState createState() => _HourVerticalScrollerState();
}

class _HourVerticalScrollerState extends State<HourVerticalScroller> {
  FixedExtentScrollController _scrollController;
  List<int> seconds = [];

  int intINdex = 0;

  @override
  void initState() {
    intINdex = widget.curIndex;
    seconds = List.generate(24, (index) {
      return index;
    });

    super.initState();
    setScrollController();
  }

  setScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.selectedHour(widget.curIndex);
    });

    _scrollController =
        FixedExtentScrollController(initialItem: widget.curIndex);
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
                widget.selectedHour(seconds[intINdex]);
              }
              return true;
            },
            child: ListWheelScrollView(
              controller: _scrollController,
              itemExtent: widget.isActive ? 20.h : 50.h,
              perspective: 0.00001,
              diameterRatio: 14.0.w,
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: (value) {
                print("sec $value");
                setState(() {
                  intINdex = value;
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
                              text: e == seconds[widget.curIndex] ? "$e" : "$e",
                              style: latoSemiBold.copyWith(
                                  color: e == seconds[widget.curIndex]
                                      ? HexColor.fromHex("#EDEFF0")
                                      : HexColor.fromHex("#959FA5"),
                                  fontSize: e == seconds[widget.curIndex]
                                      ? 18.sp
                                      : 12.sp),
                            ),
                            if (e == seconds[widget.curIndex])
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(2, -5),
                                  child: Text(
                                    'h',
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
