import 'package:flutter/material.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/usable_widgets/underliner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulbMinSecButton extends StatelessWidget {
  final bool state;
  final String value;
  final Function() onPressed;

  const BulbMinSecButton(
      {Key key,
      @required this.onPressed,
      @required this.state,
      @required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Column(
          children: [
            Text(
              "$value",
              textAlign: TextAlign.center,
              style: latoSemiBold.copyWith(
                color: state
                    ? HexColor.fromHex("#EDEFF0")
                    : HexColor.fromHex("#959FA5"),
                fontSize: 20.sp,
              ),
            ),
            UnderlineWidget(
              isActive: state,
            )
          ],
        ),
        onPressed: onPressed);
  }
}
