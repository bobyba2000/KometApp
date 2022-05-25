import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo/src/constants/hex_color.dart';

class NeoSwitch extends StatelessWidget {
  final bool isActive;
  final Function(bool) onToggle;

  const NeoSwitch({Key key, @required this.isActive, this.onToggle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 61.0.w,
      height: 35.0.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(41.h)),
          border: Border.all(color: HexColor.neoBlue())),
      child: FlutterSwitch(
          width: 61.0.w,
          height: 41.0.h,
          activeColor: HexColor.fromHex("#3498DB"),
          inactiveColor: Colors.transparent,
          inactiveToggleColor: HexColor.fromHex("#959FA5"),
          valueFontSize: 0.0,
          toggleSize: 37.0.h,
          value: isActive,
          borderRadius: 40.0,
          padding: 0,
          showOnOff: false,
          onToggle: onToggle),
    );
  }
}
