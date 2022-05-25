import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo/src/bloc/timelapse/aperture_ramp_bloc.dart';
import 'package:neo/src/bloc/timelapse/shut_lag_mot_co_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/camera_photo_more/seconds_picker.dart';
import 'package:neo/src/ui/custom_widgets/buttons/neo_switch.dart';
import 'package:neo/src/ui/custom_widgets/hdr/expanded_items/button_radio.dart';
import 'package:neo/src/ui/custom_widgets/hour_vertical_scroller.dart';
import 'package:neo/src/ui/custom_widgets/minute_vertical_scroller.dart';
import 'package:neo/src/ui/custom_widgets/neo_radio.dart';
import 'package:neo/src/ui/custom_widgets/seconds_vertical_scroller.dart';

class HolyManual extends StatefulWidget {
  @override
  _HolyManualState createState() => _HolyManualState();
}

class _HolyManualState extends State<HolyManual> {
  int hour = 3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Container(
            height: 64.h,
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                clockIcon(true),
                SizedBox(
                  width: 12.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Delay",
                      style: latoSemiBold.copyWith(
                          color: true
                              ? HexColor.fromHex("#EDEFF0")
                              : HexColor.fromHex("#959FA5"),
                          fontSize: 15.sp),
                    ),
                    Text(
                      "Time Delay Before Shot",
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                    )
                  ],
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HourVerticalScroller(
                        isActive: true,
                        curIndex: hour,
                        selectedHour: (hour) {
                          setState(() {
                            this.hour = hour;
                          });
                        },
                      ),
                      MinuteVerticalScroller(),
                      SecondsVerticalScroller()
                    ],
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
              height: 64.h,
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                  border: Border.all(color: HexColor.neoGray()),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: BlocBuilder<ApertureRampBloc, bool>(
                builder: (context, apertRampActive) => Row(
                  children: [
                    svgIcon(
                        active: apertRampActive,
                        activeIcon:
                            "assets/icons/Button_ApertureRamp_Enable.svg",
                        inactiveIcon:
                            "assets/icons/Button_ApertureRamp_Disable.svg"),
                    SizedBox(
                      width: 12.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Aperture Ramp",
                          style: latoSemiBold.copyWith(
                              color: apertRampActive
                                  ? HexColor.fromHex("#EDEFF0")
                                  : HexColor.fromHex("#959FA5"),
                              fontSize: 15.sp),
                        ),
                        Text(
                          "Ramp F-STOP",
                          style: latoSemiBold.copyWith(
                              color: HexColor.fromHex("#3E505B"),
                              fontSize: 12.sp),
                        )
                      ],
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: NeoSwitch(
                              isActive: apertRampActive,
                              onToggle: (isActive) {
                                context.read<ApertureRampBloc>().add(isActive);
                              },
                            )))
                  ],
                ),
              )),
          SizedBox(
            height: 8.h,
          ),
          BlocBuilder<ShutLagMotCotBloc, ShutLagMotCotState>(
            builder: (context, shutLagMotCotState) => GestureDetector(
              onTap: () {
                context.read<ShutLagMotCotBloc>().add(
                    shutLagMotCotState is MotCotState
                        ? ShutLagEvent()
                        : MotCotEvent());
              },
              child: Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor.neoGray()),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        svgIcon(
                            active: shutLagMotCotState is MotCotState,
                            activeIcon:
                                "assets/icons/Button_MotionControl_Enable.svg",
                            inactiveIcon:
                                "assets/icons/Button_MotionControl_Disable.svg"),
                        SizedBox(
                          width: 12.sp,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Motion Control",
                              style: latoSemiBold.copyWith(
                                  color: shutLagMotCotState is MotCotState
                                      ? HexColor.fromHex("#EDEFF0")
                                      : HexColor.fromHex("#959FA5"),
                                  fontSize: 15.sp),
                            ),
                            Text(
                              "Interval by AUX Pulse Input",
                              style: latoSemiBold.copyWith(
                                  color: HexColor.fromHex("#3E505B"),
                                  fontSize: 12.sp),
                            )
                          ],
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: NeoSwitch(
                                  isActive: shutLagMotCotState is MotCotState,
                                  onToggle: (isActive) {
                                    context.read<ShutLagMotCotBloc>().add(
                                        !isActive
                                            ? ShutLagEvent()
                                            : MotCotEvent());
                                  },
                                ))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget clockIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_TimeDelay_Enable.svg"
          : "assets/icons/Button_TimeDelay_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }

  Widget svgIcon(
      {@required bool active,
      @required String activeIcon,
      @required String inactiveIcon}) {
    return SvgPicture.asset(
      active ? activeIcon : inactiveIcon,
      height: 36.h,
      width: 36.w,
    );
  }
}
