import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class KnobButton extends StatefulWidget {
  final double margin;
  final double value;
  final Function(bool isShift) shiftChanged;

  const KnobButton(
      {Key key,
      @required this.margin,
      @required this.shiftChanged,
      @required this.value})
      : super(key: key);

  @override
  _KnobButtonState createState() => _KnobButtonState();
}

class _KnobButtonState extends State<KnobButton> {
  bool isShift = false;

  shiftChanged(bool isShift) {
    setState(() {
      this.isShift = isShift;
    });
    widget.shiftChanged(isShift);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        shiftChanged(!isShift);
      },
      child: Container(
          margin: EdgeInsets.only(
              left: widget.margin, top: 12.h, bottom: 4.h), //bottom is 4.h
          child: Stack(
            children: [
              SvgPicture.asset(
                isShift
                    ? "assets/icons/Knob_AEB_Select.svg"
                    : "assets/icons/Knob_AEB_Idle.svg",
                height: 24.w,
                width: 24.w,
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  isShift ? "< - >" : getDisplayValue(widget.value),
                  textAlign: TextAlign.center,
                  style: latoHeavy.copyWith(
                      fontSize: 10, color: HexColor.fromHex("#EDEFF0")),
                ),
              ))
            ],
          )),
    );
  }

  String getDisplayValue(double name) {
    return name % 1 == 0
        ? name.toInt().isNegative
            ? "${name.toInt()}"
            : name.toInt() != 0
                ? "+${name.toInt()}"
                : "${name.toInt()}"
        : "$name";
  }
}
