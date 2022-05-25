import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/more_option/more_option_visibility_bloc.dart';
import 'package:neo/src/bloc/timelapse/switch_distance_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/camera_photo_more/preset_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/neo_switch.dart';
import 'package:neo/src/ui/custom_widgets/hour_vertical_scroller.dart';
import 'package:neo/src/ui/custom_widgets/minute_vertical_scroller.dart';
import 'package:neo/src/ui/custom_widgets/seconds_vertical_scroller.dart';

import 'more_divider.dart';

class BasicMoreOptions extends StatefulWidget {
  final ScrollController scrollController;

  const BasicMoreOptions({Key key, @required this.scrollController})
      : super(key: key);
  @override
  _BasicMoreOptionsState createState() => _BasicMoreOptionsState();
}

class _BasicMoreOptionsState extends State<BasicMoreOptions> {
  int hour = 3;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreOptionVisibilityBloc, bool>(
      builder: (context, state) {
        if (!state) {
          return Container();
        }
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        });
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.5.w),
          child: Column(
            children: [
              MoreDivider(),
              SizedBox(
                height: 15.h,
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
                          "Time Delay Before Start",
                          style: latoSemiBold.copyWith(
                              color: HexColor.fromHex("#3E505B"),
                              fontSize: 12.sp),
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
              BlocBuilder<SwitchDistanceBloc, bool>(
                builder: (context, isDistance) => Container(
                  height: 64.h,
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                      border: Border.all(color: HexColor.neoGray()),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    children: [
                      svgIcon(
                          active: isDistance,
                          activeIcon: "assets/icons/Button_Distance_Enable.svg",
                          inactiveIcon:
                              "assets/icons/Button_Distance_Disable.svg"),
                      SizedBox(
                        width: 12.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Distance Interval",
                            style: latoSemiBold.copyWith(
                                color: isDistance
                                    ? HexColor.fromHex("#EDEFF0")
                                    : HexColor.fromHex("#959FA5"),
                                fontSize: 15.sp),
                          ),
                          Text(
                            "Interval by Distance Travel",
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
                                isActive: isDistance,
                                onToggle: (isActive) {
                                  context
                                      .read<SwitchDistanceBloc>()
                                      .switchDistance();
                                },
                              )))
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [PresetButton()],
              ),
            ],
          ),
        );
      },
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

  Widget clockIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_TimeDelay_Enable.svg"
          : "assets/icons/Button_TimeDelay_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }
}
