import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class HighSpeedScroller extends StatefulWidget {
  @override
  _HighSpeedScrollerState createState() => _HighSpeedScrollerState();
}

class _HighSpeedScrollerState extends State<HighSpeedScroller> {
  FixedExtentScrollController _scrollController;
  int curItem = 1;

  @override
  void initState() {
    super.initState();
    setScrollController();
  }

  setScrollController() {
    _scrollController = FixedExtentScrollController(initialItem: curItem);
  }

  final List<String> list = ["LIGHT", "SOUND", "MOTION"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: HexColor.fromHex("#030303"),
        height: 36.h,
        child: RotatedBox(
          quarterTurns: 3,
          child: ListWheelScrollView(
              controller: _scrollController,
              itemExtent: size.width * 0.5,
              diameterRatio: 2,
              squeeze: 1.5,
              perspective: 0.0000009,
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: (item) {
                print("item changes");

                // curItem = item;
                // if (list[item] == "VIDEO") {
                //   context.read<VideoActiveBloc>().add(true);
                // } else if (list[item] == "PHOTO") {
                //   context.read<VideoActiveBloc>().add(false);
                // }
                // widget.onChanged(_shutters[item]);

                setState(() {});
              },
              children: list.map((String curValue) {
                //print("q");
                //print(widget.backgroundColor.toString());

                return ItemWidget(curValue, list[curItem] == curValue ? 18 : 18,
                    list[curItem] == curValue ? "#EDEFF0" : "#959FA5");
              }).toList()),
        ));
  }
}

class ItemWidget extends StatefulWidget {
  final String curItem;
  final double fontSize;
  final String color;
  ItemWidget(this.curItem, this.fontSize, this.color);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  String get _currentItem => widget.curItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            "$_currentItem",
            style: latoSemiBold.copyWith(
                fontSize: widget.fontSize,
                color: HexColor.fromHex(widget.color)),
          ),
        ),
      ),
    );
  }
}
