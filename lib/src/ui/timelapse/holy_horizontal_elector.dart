import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/model/shutters.dart';

class HolyHorizantalPicker extends StatefulWidget {
  final Function(Shutters) onChanged;
  // final Function(bool) initialChanged;
  final Function(HSelectedItem) initialChanged;
  final Function(HSelectedItem) finalChanged;
  final Function(ActivePosition activePosition) activePostionChnaged;
  final ActivePosition activePosition;
  final Color backgroundColor;

  final Color activeItemTextColor;
  final Color passiveItemsTextColor;
  final String currentItem;
  final bool isShutter;
  final String initialIndex;
  final String finalIndex;

  final List<String> shutterList;
  HolyHorizantalPicker(
      {@required this.onChanged,
      @required this.activePostionChnaged,
      this.backgroundColor = Colors.white,
      this.activeItemTextColor = Colors.blue,
      this.passiveItemsTextColor = Colors.grey,
      @required this.shutterList,
      @required this.currentItem,
      this.initialChanged,
      this.isShutter = false,
      @required this.initialIndex,
      @required this.finalIndex,
      @required this.finalChanged,
      @required this.activePosition})
      : assert(onChanged != null),
        assert(shutterList != null);
  @override
  _HorizantalPickerState createState() => _HorizantalPickerState();
}

class _HorizantalPickerState extends State<HolyHorizantalPicker> {
  FixedExtentScrollController _scrollController;
  int curItem = 0;

  int beforeItem = 0;

  int selectedFontSize = 14;

  List<Shutters> _shutters = [];

  double offset = 0;

  bool isAdded = false;

  @override
  void initState() {
    int count = 0;
    if (widget.shutterList.isNotEmpty) {
      for (var i = 0; i < widget.shutterList.length; i++) {
        print("i : $count");
        Shutters shat = Shutters(
            name: widget.shutterList[i],
            index: i,
            heigh: count == 0 ? 30.0 : 18.0,
            showName: count == 0 ? true : false);

        if (count < 2) {
          count++;
        } else {
          count = 0;
        }

        _shutters.add(shat);
        if (shat.name.trim() == widget.currentItem.trim()) {
          print("curItem : ${shat.name}");
          curItem = _shutters.indexOf(shat);

          try {
            int finalIndex = curItem + 3;
            int initialIndex = curItem - 3;
            String valueI = _shutters[initialIndex].name;
            String valueF = _shutters[finalIndex].name;

            widget.initialChanged(
                HSelectedItem(index: initialIndex, value: valueI));

            widget
                .finalChanged(HSelectedItem(index: finalIndex, value: valueF));
          } catch (e) {
            print("e");
            String valueI = _shutters[curItem].name;
            widget.initialChanged(HSelectedItem(index: curItem, value: valueI));
            widget.finalChanged(HSelectedItem(index: curItem, value: valueI));
          }
        }
      }
    }

    super.initState();

    setScrollController();
  }

  setScrollController() {
    _scrollController = FixedExtentScrollController(initialItem: curItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.activePostionChnaged(PositionInitial());
              },
              child: Container(
                  height: 38.h,
                  width: 76.w,
                  margin: EdgeInsets.only(left: 4.sp),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        widget.activePosition is PositionInitial
                            ? "assets/icons/Button_ScrollValuePicker_Enable.svg"
                            : "assets/icons/Button_ScrollValuePicker_Disable.svg",
                        height: 38.h,
                        width: 76.w,
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.isShutter
                                  ? "${widget.initialIndex}s"
                                  : "${widget.initialIndex}",
                              textAlign: TextAlign.center,
                              style: latoHeavy.copyWith(
                                  fontSize: 20.sp,
                                  color: HexColor.fromHex("#EDEFF0")),
                            ),
                          ))
                    ],
                  )),
            ),
            SizedBox(
              width: 132.w,
            ),
            GestureDetector(
              onTap: () {
                widget.activePostionChnaged(PositionFinal());
              },
              child: Container(
                  height: 38.h,
                  width: 76.w,
                  margin: EdgeInsets.only(left: 4.sp),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        widget.activePosition is PositionFinal
                            ? "assets/icons/Button_ScrollValuePicker_Enable.svg"
                            : "assets/icons/Button_ScrollValuePicker_Disable.svg",
                        height: 38.h,
                        width: 76.w,
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.isShutter
                                  ? "${widget.finalIndex}s"
                                  : "${widget.finalIndex}",
                              textAlign: TextAlign.center,
                              style: latoHeavy.copyWith(
                                  fontSize: 20.sp,
                                  color: HexColor.fromHex("#EDEFF0")),
                            ),
                          ))
                    ],
                  )),
            )
          ],
        ),
        Container(
          height: 48.h,
          child: Container(
            color: HexColor.fromHex("#0E1011"),
            child: RotatedBox(
              quarterTurns: 3,
              child: NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification) {
                      widget.onChanged(_shutters[curItem]);

                      /// your code
                    }
                    return true;
                  },
                  child: ListWheelScrollView(
                    controller: _scrollController,
                    diameterRatio: 14.0.w,
                    itemExtent: 35.w,
                    perspective: 0.00001,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (item) {
                      print("item changes");

                      curItem = item;

                      if (widget.activePosition == PositionInitial()) {
                        if (curItem > 3) {
                          int initialIndex = curItem - 3;

                          String value = _shutters[initialIndex].name;

                          widget.initialChanged(
                              HSelectedItem(index: initialIndex, value: value));
                        }
                      } else {
                        if (_shutters.length > curItem + 3) {
                          int finalIndex = curItem + 3;
                          String value = _shutters[finalIndex].name;

                          widget.finalChanged(
                              HSelectedItem(index: finalIndex, value: value));
                        }
                      }

                      setState(() {});
                    },
                    children: _shutters.map((Shutters curValue) {
                      //print("q");
                      //print(widget.backgroundColor.toString());

                      return ItemWidget(
                        curValue,
                      );
                    }).toList(),
                  )),
            ),
          ),
        )
      ],
    );
  }
}

class ItemWidget extends StatefulWidget {
  final Shutters curItem;
  ItemWidget(this.curItem);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  Shutters get _currentItem => widget.curItem;

  SizedBox shortSize() {
    return SizedBox(
      height: 0.02.sh,
      child: Container(
        color: _currentItem.showName ? Colors.white70 : Colors.white24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _currentItem.heigh.h,
              width: 3,
              child: Container(
                color: _currentItem.showName ? Colors.white70 : Colors.white24,
              ),
            ),
            Expanded(
                child: Text(
              _currentItem.showName ? "${_currentItem.name}" : "",
              style: latoSemiBold.copyWith(
                  fontSize: 9.5.w, color: HexColor.fromHex("#3E505B")),
            ))
          ],
        ),
      ),
    );
  }
}

class ActivePosition extends Equatable {
  @override
  List<Object> get props => [];
}

class PositionInitial extends ActivePosition {}

class PositionFinal extends ActivePosition {}
