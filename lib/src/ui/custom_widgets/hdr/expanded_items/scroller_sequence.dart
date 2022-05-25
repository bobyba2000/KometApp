import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo/src/bloc/hdr/hdr_sequence_state.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/shutters.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'eab_l_button.dart';
import 'eab_r_button.dart';

class ScrollerWidget extends StatelessWidget {
  final List<double> values = [
    -9.0,
    -8.6,
    -8.3,
    -8.0,
    -7.6,
    -7.3,
    -7.0,
    -6.6,
    -6.3,
    -6.0,
    -5.6,
    -5.3,
    -5.0,
    -4.6,
    -4.3,
    -4.0,
    -3.6,
    -3.3,
    -3.0,
    -2.6,
    -2.3,
    -2.0,
    -1.6,
    -1.3,
    -1.0,
    -0.6,
    -0.3,
    0.0,
    0.3,
    0.6,
    1.0,
    1.3,
    1.6,
    2.0,
    2.3,
    2.6,
    3.0,
    3.3,
    3.6,
    4.0,
    4.3,
    4.6,
    5.0,
    5.3,
    5.6,
    6.0,
    6.3,
    6.6,
    7.0,
    7.3,
    7.6,
    8.0,
    8.3,
    8.6,
    9.0
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: ScollerSequence(
        currentItem: 0.0,
        shutterList: values,
      ),
    );
  }
}

class ScollerSequence extends StatefulWidget {
  final List<double> shutterList;
  final double currentItem;
  final Function(Sequence) onChanged;

  const ScollerSequence(
      {Key key,
      @required this.shutterList,
      @required this.currentItem,
      this.onChanged})
      : super(key: key);
  @override
  _ScollerSequenceState createState() => _ScollerSequenceState();
}

class _ScollerSequenceState extends State<ScollerSequence> {
  FixedExtentScrollController _scrollController;

  List<Sequence> _shutters = [];
  int curItem = 0;

  bool isInRange(int i) {
    int first = curItem;
    int last = curItem;
    if (curItem > 0) {
      first = curItem - 3;
    }

    if (curItem <= widget.shutterList.length) {
      last = curItem + 3;
    }
    return i >= first && i <= last;
  }

  loopMagic() {
    int count = 0;
    print("curItem u $curItem");
    print("shutterList.length u ${widget.shutterList.length}");
    _shutters = [];
    if (widget.shutterList.isNotEmpty) {
      for (var i = 0; i < widget.shutterList.length; i++) {
        Sequence shat = Sequence(
            isMax: false,
            isMin: false,
            name: widget.shutterList[i],
            state: isInRange(i)
                ? i == curItem
                    ? HdrSequenceStateInitial()
                    : "#DC143C"
                : "#3E505B",
            heigh: count == 0 ? 30.0 : 18.0,
            width: isInRange(i) ? 4 : 2,
            showName: count == 0 ? true : false);

        if (count < 2) {
          count++;
        } else {
          count = 0;
        }

        _shutters.add(shat);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    curItem = widget.shutterList.indexOf(widget.currentItem);

    loopMagic();
    setScrollController();
  }

  setScrollController() {
    print("curItme alomst $curItem");
    _scrollController = FixedExtentScrollController(initialItem: curItem);
  }

  final bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Stack(
          children: [
            SvgPicture.asset(
              isActive
                  ? "assets/icons/Knob_AEB_Select.svg"
                  : "assets/icons/Knob_AEB_Idle.svg",
              height: 24.h,
              width: 24.w,
            ),
            Positioned.fill(
                child: Center(
              child: Text(
                "${_shutters[curItem].name}",
                textAlign: TextAlign.center,
                style: latoHeavy.copyWith(
                    fontSize: 10, color: HexColor.fromHex("#EDEFF0")),
              ),
            ))
          ],
        )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: EABlButton(
                onTap: () {},
              ),
            ),
            Flexible(
                child: Container(
              height: 60.h,
              child: RotatedBox(
                quarterTurns: 3,
                child: ListWheelScrollView(
                    controller: _scrollController,
                    diameterRatio: 5.0.w,
                    itemExtent: 10.w,
                    perspective: 0.00001,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (item) {
                      print("item changes $item");
                      setState(() {
                        curItem = item;
                      });
                      loopMagic();

                      //  widget.onChanged(_shutters[item]);
                    },
                    children: _shutters.map((Sequence curValue) {
                      //print("q");
                      //print(widget.backgroundColor.toString());

                      return ItemWidget(
                        curItem: curValue,
                      );
                    }).toList()),
              ),
            )),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: EABRButton(
                onTap: () {},
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ItemWidget extends StatefulWidget {
  final Sequence curItem;

  ItemWidget({
    @required this.curItem,
  });

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  Sequence get _currentItem => widget.curItem;

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
              width: _currentItem.width,
              child: Container(
                color: HexColor.fromHex("${_currentItem.getColor}"),
              ),
            ),
            AutoSizeText(
              _currentItem.showName ? "${_currentItem.name}" : "",
              maxLines: 2,
              minFontSize: 5,
              style: latoSemiBold.copyWith(
                  fontSize: 9.5.w, color: HexColor.fromHex("#3E505B")),
            )
          ],
        ),
      ),
    );
  }
}
