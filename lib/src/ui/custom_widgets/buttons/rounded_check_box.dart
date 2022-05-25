import 'package:flutter/material.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedCheckBox extends StatelessWidget {
  final bool checked;
  final Function(bool) onValueChanged;

  const RoundedCheckBox({Key key, @required this.checked, this.onValueChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onValueChanged(!checked);
      },
      child: Container(
        height: 18.h,
        width: 18.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: HexColor.neoBlue()),
            color: checked ? Colors.blue : Colors.transparent),
        child: checked
            ? Center(
                child: Icon(
                  Icons.check,
                  size: 15.0.sp,
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
    );
  }
}
