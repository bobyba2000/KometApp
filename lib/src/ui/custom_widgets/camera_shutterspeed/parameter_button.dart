import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

typedef ParamButtonCallback();

class ParamButton extends StatefulWidget {
  final ParamButtonCallback paramButtonCallback;

  final String unit;
  final String unitFinal;
  final String name;
  final bool isActive;
  final bool isTimeLapse;
  final Color dashColor;

  const ParamButton({
    Key key,
    @required this.unit,
    @required this.name,
    @required this.paramButtonCallback,
    @required this.isActive,
    this.unitFinal,
    this.isTimeLapse = false,
    this.dashColor,
  }) : super(key: key);
  @override
  _ParamButtonState createState() => _ParamButtonState();
}

class _ParamButtonState extends State<ParamButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57.h,
      width: 75.w,
      child: TextButton(
        onPressed: () {
          widget.paramButtonCallback();
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
        ),
        child: Column(
          children: [
            Container(
                width: 73.w,
                decoration: BoxDecoration(
                  border: Border(
                    top: Divider.createBorderSide(context,
                        color: widget.dashColor != null
                            ? widget.dashColor
                            : Colors.blue,
                        width: widget.isActive ? 2.3 : 0 / 3),
                  ),
                )),
            if (widget.unitFinal == null)
              SizedBox(
                height: 0.010.sh,
              ),
            FittedBox(
              child: Text(
                "${widget.unit}",
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: latoSemiBold.copyWith(
                    color: widget.isActive
                        ? HexColor.fromHex("#EDEFF0")
                        : HexColor.fromHex("#959FA5"),
                    fontSize: 15.sp),
              ),
            ),
            widget.unitFinal != null
                ? Text(
                    "${widget.unitFinal}",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: latoSemiBold.copyWith(
                        color: widget.isActive
                            ? HexColor.fromHex("#EDEFF0")
                            : HexColor.fromHex("#959FA5"),
                        fontSize: 15.sp),
                  )
                : widget.isTimeLapse
                    ? Flexible(
                        child: SizedBox(
                        height: 11.h,
                      ))
                    : Container(),
            SizedBox(
              height: 0.01.sh,
            ),
            Text(
              "${widget.name}",
              style: latoSemiBold.copyWith(
                  fontSize: 12.sp,
                  color: widget.isActive
                      ? HexColor.fromHex("#959FA5")
                      : HexColor.fromHex("#3E505B")),
            ),
          ],
        ),
      ),
    );
  }
}
