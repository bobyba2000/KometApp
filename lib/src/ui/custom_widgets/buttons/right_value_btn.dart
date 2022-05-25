import 'package:flutter/material.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/usable_widgets/underliner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightValueBtn extends StatelessWidget {
  final Function() onPressed;
  final String value;
  final bool isActive;

  const RightValueBtn(
      {Key key,
      @required this.onPressed,
      @required this.value,
      @required this.isActive})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Text(
              "$value",
              textAlign: TextAlign.center,
              style: latoSemiBold.copyWith(
                color: isActive
                    ? HexColor.fromHex("#EDEFF0")
                    : HexColor.fromHex("#959FA5"),
                fontSize: 20.sp,
              ),
            ),
            UnderlineWidget(
              isActive: isActive,
            )
          ],
        ));
  }
}
