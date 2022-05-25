import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';
import 'package:neo/src/ui/custom_widgets/buttons/rounded_check_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'holy_graph_list_model.dart';

class GraphValueRow extends StatefulWidget {
  final Function(bool selected) onTap;
  // final String iconEnabled;
  // final String iconDisabled;
  // final DateTime dateTime;
  // final String curveType;
  // final String yValue;
  final bool isSelected;
  final Color iconColor;
  final HolyGraphListModel model;

  const GraphValueRow({
    Key key,
    @required this.model,
    this.onTap,
    @required this.isSelected,
    @required this.iconColor,
  }) : super(key: key);

  @override
  _GraphValueRowState createState() => _GraphValueRowState();
}

class _GraphValueRowState extends State<GraphValueRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(!widget.isSelected);
      },
      child: Container(
        height: 48.h,
        margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 3.h),
        decoration: BoxDecoration(
            color: HexColor.fromHex("#030303"),
            border: Border.all(width: 2.sp, color: HexColor.fromHex("#1D1D1F")),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              widget.model.iconDisabled,
              height: 24.h,
              width: 24.h,
              color: widget.iconColor,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "${widget.model.dateTime.hour}",
                  style: latoSemiBold.copyWith(
                      color: HexColor.fromHex("#EDEFF0"), fontSize: 20.sp),
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(2, -5),
                    child: Text(
                      'h',
                      //superscript is usually smaller in size
                      textScaleFactor: 0.9,
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#EDEFF0"), fontSize: 20.sp),
                    ),
                  ),
                ),
                TextSpan(
                  text: "  : ${widget.model.dateTime.minute}",
                  style: latoSemiBold.copyWith(
                      color: HexColor.fromHex("#EDEFF0"), fontSize: 20.sp),
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(2, -5),
                    child: Text(
                      'm',
                      //superscript is usually smaller in size
                      textScaleFactor: 0.9,
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#EDEFF0"), fontSize: 20.sp),
                    ),
                  ),
                )
              ]),
            ),
            RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(2, -5),
                    child: Text(
                      '${widget.model.curveType}',
                      //superscript is usually smaller in size
                      textScaleFactor: 0.8,
                      style: TextStyle(color: HexColor.fromHex("#3E505B")),
                    ),
                  ),
                ),
                TextSpan(
                  text: " ${widget.model.keyFrameItem.keyFrameValue}",
                  style: latoSemiBold.copyWith(
                      color: HexColor.fromHex("#EDEFF0"), fontSize: 18.sp),
                ),
              ]),
            ),
            RoundedCheckBox(
              checked: widget.isSelected,
            )
          ],
        ),
      ),
    );
  }
}
