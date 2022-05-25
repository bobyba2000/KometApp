import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/high_speed/slider.dart';

import 'custom_slider_tick_mark_shape.dart';

class HighSpeedMainContent extends StatefulWidget {
  // final String url;

  const HighSpeedMainContent({Key key}) : super(key: key);
  @override
  _HighSpeedMainContentState createState() => _HighSpeedMainContentState();
}

class _HighSpeedMainContentState extends State<HighSpeedMainContent>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool isActive = true;
  Animation<double> animation;
  double _value = 0.1;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.value = 0;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.sp),
            height: 450.w,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#030303"),
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              children: [
                Text('SET SOUND THRESHOLD TO ACTIVATE TRIGGER',
                    style: latoSemiBold.copyWith(
                        color: HexColor.lightGray(), fontSize: 13.sp)),
                Container(
                    // height: 100.w,
                    child:
                        RoundSlider(title: "Volume", radius: 90, maxvalue: 99)),
                SizedBox(height: 20.h),
                Row(children: [
                  SizedBox(width: 18.w),
                  Expanded(
                      child: Text('Sensitivity'.toUpperCase(),
                          style: latoSemiBold.copyWith(
                              color: HexColor.lightGray(), fontSize: 13.sp))),
                  Text('5'.toUpperCase(),
                      style: latoSemiBold.copyWith(
                          color: HexColor.lightGray(), fontSize: 13.sp)),
                  SizedBox(width: 18.w),
                ]),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      activeTrackColor: HexColor.neoBlue(),
                      inactiveTrackColor: HexColor.white(),
                      activeTickMarkColor: HexColor.white(),
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbColor: HexColor.neoBlue(),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      overlayColor: HexColor.neoBlueDisable(),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 20.0),
                      tickMarkShape:
                          CustomSliderTickMarkShape(tickMarkRadius: 3)),
                  child: Slider(
                    value: this._value,
                    divisions: 10,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
                // SliderWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sdCardIcon() {
    return SvgPicture.asset(
      "assets/icons/Icon_StorageSDCard.svg",
      height: 56.h,
      width: 56.w,
    );
  }
}
