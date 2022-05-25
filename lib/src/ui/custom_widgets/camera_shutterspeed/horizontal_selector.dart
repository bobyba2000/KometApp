import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/shutters.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

enum InitialPosition { start, center, end }

class HorizantalPicker extends StatefulWidget {
  final Function(Shutters) onChanged;
  final InitialPosition initialPosition;
  final Color backgroundColor;
  final bool showCursor;
  final Color cursorColor;
  final Color activeItemTextColor;
  final Color passiveItemsTextColor;
  final String currentItem;
  final bool isShutter;

  final List<String> shutterList;
  HorizantalPicker(
      {@required this.onChanged,
      this.initialPosition = InitialPosition.center,
      this.backgroundColor = Colors.white,
      this.showCursor = true,
      this.cursorColor = Colors.red,
      this.activeItemTextColor = Colors.blue,
      this.passiveItemsTextColor = Colors.grey,
      @required this.shutterList,
      @required this.currentItem,
      this.isShutter = false})
      : assert(onChanged != null),
        assert(shutterList != null);
  @override
  _HorizantalPickerState createState() => _HorizantalPickerState();
}

class _HorizantalPickerState extends State<HorizantalPicker> {
  FixedExtentScrollController _scrollController;
  int curItem = 0;
  int beforeItem = 0;

  bool isActive = true;

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
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            widget.onChanged(_shutters[curItem]);
          });
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
        Container(
            height: 38.h,
            width: 76.w,
            margin: EdgeInsets.only(left: 4.sp),
            child: Stack(
              children: [
                SvgPicture.asset(
                  isActive
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
                            ? "${_shutters[curItem].name}s"
                            : "${_shutters[curItem].name}",
                        textAlign: TextAlign.center,
                        style: latoHeavy.copyWith(
                            fontSize: 20.sp, color: HexColor.fromHex("#EDEFF0")),
                      ),
                    ))
              ],
            )),
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
