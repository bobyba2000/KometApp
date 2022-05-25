import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnderlineWidget extends StatefulWidget {
  final bool isActive;

  const UnderlineWidget({Key key, this.isActive = true}) : super(key: key);
  @override
  _UnderlineWidgetState createState() => _UnderlineWidgetState();
}

class _UnderlineWidgetState extends State<UnderlineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        widget.isActive
            ? "assets/icons/Line_plusMinusValuePicker_Enable.svg"
            : "assets/icons/Line_plusMinusValuePicker_Disable.svg",
        width: 96.w,
        height: 4,
      ),
    );
  }
}
