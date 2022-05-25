import 'package:flutter/material.dart';
import 'package:neo/src/constants/hex_color.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/usable_widgets/underliner.dart';

class LeftValueBtn extends StatefulWidget {
  final Function() onPressed;
  final String value;
  final isActive;
  const LeftValueBtn({
    Key key,
    @required this.onPressed,
    @required this.value,
    @required this.isActive,
  }) : super(key: key);

  @override
  _LeftValueBtnState createState() => _LeftValueBtnState();
}

class _LeftValueBtnState extends State<LeftValueBtn> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Column(
        children: [
          Text(
            "${widget.value}",
            textAlign: TextAlign.center,
            style: latoSemiBold.copyWith(
              color: widget.isActive
                  ? HexColor.fromHex("#EDEFF0")
                  : HexColor.fromHex("#959FA5"),
              fontSize: 20.sp,
            ),
          ),
          UnderlineWidget(
            isActive: widget.isActive,
          )
        ],
      ),
    );
  }
}
