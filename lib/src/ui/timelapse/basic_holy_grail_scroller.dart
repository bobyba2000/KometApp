import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/timelapse/basic_holy_grail_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

import 'package:provider/provider.dart';

class BasicHolyGrailScroller extends StatefulWidget {
  @override
  _BasicHolyGrailScrollerState createState() => _BasicHolyGrailScrollerState();
}

class _BasicHolyGrailScrollerState extends State<BasicHolyGrailScroller> {
  FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    setScrollController();
  }

  @override
  dispose() {
    context.read<KeyFrameBloc>().add(false);
    super.dispose();
  }

  setScrollController() {
    _scrollController = FixedExtentScrollController(
        initialItem: context.read<BasicHolyGrailBloc>().state);
  }

  final List<String> list = ["BASIC", "HOLY-GRAIL"];
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

                context.read<BasicHolyGrailBloc>().add(item);

                // widget.onChanged(_shutters[item]);

                setState(() {});
              },
              children: list.map((String curValue) {
                //print("q");
                //print(widget.backgroundColor.toString());

                return BlocBuilder<BasicHolyGrailBloc, int>(
                  builder: (context, state) => ItemWidget(
                      curValue,
                      list[state] == curValue ? 18 : 18,
                      list[state] == curValue ? "#EDEFF0" : "#959FA5"),
                );
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
