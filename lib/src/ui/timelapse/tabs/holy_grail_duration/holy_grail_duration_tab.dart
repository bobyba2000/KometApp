import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/dur_frame_play_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/fps_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/frame_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/playtime_seconds_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/bloc/timelapse/switch_distance_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/f_p_F.dart';
import 'package:neo/src/ui/custom_widgets/buttons/left_value_btn.dart';
import 'package:neo/src/ui/custom_widgets/buttons/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/right_value_btn.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_duration/radio_btn.dart';

import 'duration_state.dart';
import 'hour_min_state.dart';

class HolyGrailDurationTab extends StatefulWidget {
  final String url;

  const HolyGrailDurationTab({Key key, this.url}) : super(key: key);
  @override
  _HolyGrailDurationTabState createState() => _HolyGrailDurationTabState();
}

class _HolyGrailDurationTabState extends State<HolyGrailDurationTab> {
  HourMinState hourMinState = MinState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchDistanceBloc, bool>(
      builder: (context, isDistance) {
        return BlocBuilder<DurFramePlayBloc, DurationFramePlayState>(
          builder: (context, currentselection) {
            return Container(
              width: double.infinity,
              decoration: decoration,
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentselection.displayName,
                        style: latoSemiBold.copyWith(
                            color: HexColor.fromHex("#3E505B"), fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  if (currentselection is StateDuration) durationWidget(),
                  if (currentselection is StateFrame) frameWidget(),
                  if (currentselection is StatePlay) playTimeWidget(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MinusButton(
                        onTap: () {
                          if (currentselection is StateDuration) {
                            if (hourMinState is HourState) {
                              NeoBlocProvider.of(context).hourBloc.decrement();
                            } else {
                              NeoBlocProvider.of(context).minBloc.decrement();
                            }
                          }

                          if (currentselection is StateFrame) {
                            NeoBlocProvider.of(context).frameBloc.decrement();
                          }
                          if (currentselection is StatePlay) {
                            if (hourMinState is HourState) {
                              NeoBlocProvider.of(context)
                                  .playtimeBloc
                                  .decrement();
                            } else {
                              NeoBlocProvider.of(context).fpsBloc.decrement();
                            }
                          }
                        },
                      ),
                      PlusButton(
                        onTap: () {
                          if (currentselection is StateDuration) {
                            if (hourMinState is MinState) {
                              NeoBlocProvider.of(context).minBloc.increment();
                            } else {
                              NeoBlocProvider.of(context).hourBloc.increment();
                            }
                          }

                          if (currentselection is StateFrame) {
                            NeoBlocProvider.of(context).frameBloc.increment();
                          }
                          if (currentselection is StatePlay) {
                            if (hourMinState is MinState) {
                              NeoBlocProvider.of(context).fpsBloc.increment();
                            } else {
                              NeoBlocProvider.of(context)
                                  .playtimeBloc
                                  .increment();
                            }
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioBtn(
                        isActive: currentselection is StateDuration,
                        name: "DURATION",
                        onTap: () {
                          context.read<DurFramePlayBloc>().add(1);
                        },
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      RadioBtn(
                        isActive: currentselection is StateFrame,
                        name: "FRAME",
                        onTap: () {
                          context.read<DurFramePlayBloc>().add(2);
                        },
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      RadioBtn(
                        isActive: currentselection is StatePlay,
                        name: "PLAY TIME",
                        onTap: () {
                          context.read<DurFramePlayBloc>().add(3);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<FPF>(
                          stream: NeoBlocProvider.of(context).hourBloc.stream$,
                          builder: (context, snapHour) => StreamBuilder<FPF>(
                              stream:
                                  NeoBlocProvider.of(context).minBloc.stream$,
                              builder: (context, snapMin) => StreamBuilder<FPF>(
                                  stream: NeoBlocProvider.of(context)
                                      .frameBloc
                                      .frame$,
                                  builder:
                                      (context, snapframes) =>
                                          StreamBuilder<FPF>(
                                              stream:
                                                  NeoBlocProvider.of(context)
                                                      .playtimeBloc
                                                      .playtime$,
                                              builder: (context, snapPlayT) =>
                                                  StreamBuilder<FPF>(
                                                    stream: NeoBlocProvider.of(
                                                            context)
                                                        .fpsBloc
                                                        .fps$,
                                                    builder:
                                                        (context, snapFps) =>
                                                            RichText(
                                                                softWrap: false,
                                                                text: TextSpan(
                                                                  text:
                                                                      "${snapHour.hasData && snapHour.data.value != null ? snapHour.data.value > 9 ? "${snapHour.data.value}h" : "0${snapHour.data.value}h" : "--"}: ${snapMin.hasData && snapMin.data.value != null ? "${snapMin.data.value > 9 ? "${snapMin.data.value}m" : "0${snapMin.data.value}m"}" : "--"}",
                                                                  style: latoSemiBold.copyWith(
                                                                      color: currentselection
                                                                              is StateDuration
                                                                          ? HexColor.fromHex(
                                                                              "#EDEFF0")
                                                                          : HexColor.fromHex(
                                                                              "#959FA5"),
                                                                      fontSize:
                                                                          12.sp),
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                      text: snapframes
                                                                              .hasData
                                                                          ? "| ${snapframes.data.value}F |"
                                                                          : "--",
                                                                      style: latoSemiBold.copyWith(
                                                                          color: currentselection is StateFrame
                                                                              ? HexColor.fromHex("#EDEFF0")
                                                                              : HexColor.fromHex("#959FA5"),
                                                                          fontSize: 12.sp),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          " ${snapPlayT.hasData ? snapPlayT.data.value : "--"}s@${snapFps.hasData ? snapFps.data.value : "--"}FPS",
                                                                      style: latoSemiBold.copyWith(
                                                                          color: currentselection is StatePlay
                                                                              ? HexColor.fromHex("#EDEFF0")
                                                                              : HexColor.fromHex("#959FA5"),
                                                                          fontSize: 12.sp),
                                                                    ),
                                                                  ],
                                                                )),
                                                  )))))
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget durationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder<FPF>(
          stream: NeoBlocProvider.of(context).hourBloc.stream$,
          builder: (context, snapHour) {
            return LeftValueBtn(
              value: snapHour.hasData && snapHour.data.value != null
                  ? "${snapHour.data.value > 9 ? "${snapHour.data.value}h" : "0${snapHour.data.value}h"}"
                  : "--",
              isActive: hourMinState is HourState,
              onPressed: () {
                setState(() {
                  hourMinState = HourState();
                });
              },
            );
          },
        ),
        StreamBuilder<FPF>(
          stream: NeoBlocProvider.of(context).minBloc.stream$,
          builder: (context, snapMin) => RightValueBtn(
            isActive: hourMinState is MinState,
            onPressed: () {
              setState(() {
                hourMinState = MinState();
              });
            },
            value: snapMin.hasData && snapMin.data.value != null
                ? snapMin.data.value > 9
                    ? "${snapMin.data.value}m"
                    : "0${snapMin.data.value}m"
                : "--",
          ),
        )
      ],
    );
  }

  Widget frameWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<FPF>(
          stream: NeoBlocProvider.of(context).frameBloc.frame$,
          builder: (context, snapFrame) {
            print(
                "increment received ${snapFrame.hasData ? snapFrame.data.value : "none"}");
            return LeftValueBtn(
              value: snapFrame.hasData ? "${snapFrame.data.value}" : "--",
              isActive: true,
              onPressed: () {},
            );
          },
        )
      ],
    );
  }

  Widget playTimeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //PlaytimeSecondsBloc
        StreamBuilder<FPF>(
          stream: NeoBlocProvider.of(context).playtimeBloc.playtime$,
          builder: (context, snap) => LeftValueBtn(
            value: snap.hasData ? "${snap.data.value}" : "--",
            isActive: hourMinState is HourState,
            onPressed: () {
              setState(() {
                hourMinState = HourState();
              });
            },
          ),
        ),
        //FpsBloc
        StreamBuilder(
          stream: NeoBlocProvider.of(context).fpsBloc.fps$,
          builder: (context, snap) => RightValueBtn(
            isActive: hourMinState is MinState,
            onPressed: () {
              setState(() {
                hourMinState = MinState();
              });
            },
            value: snap.hasData ? "${snap.data.value}FPS" : "--",
          ),
        )
      ],
    );
  }
}
