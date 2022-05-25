import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/res/neo_websocket.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_state.dart';
import 'package:neo/src/bloc/params_button/params_fstop_bloc.dart';
import 'package:neo/src/bloc/params_button/params_iso_bloc.dart';
import 'package:neo/src/bloc/params_button/params_shutter_bloc.dart';
import 'package:neo/src/bloc/params_button/params_wb_bloc.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/aperture_ramp_bloc.dart';
import 'package:neo/src/bloc/timelapse/basic_holy_grail_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/dur_frame_play_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/fps_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/frame_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/playtime_seconds_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/final_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/initial_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/basic_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/distance_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/final_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/initial_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/final_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/initial_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/bloc/timelapse/shut_lag_mot_co_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_lag_sec_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/final_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/initial_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/switch_distance_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/f_p_F.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/model/keyframe/keyframe_shutter_model.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/parameter_button.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_duration/duration_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

typedef ParamTabSelected(int index);

class TimeLapseParamsTabs extends StatefulWidget {
  final ParamTabSelected paramTabSelected;

  const TimeLapseParamsTabs({Key key, this.paramTabSelected}) : super(key: key);
  @override
  _TimeLapseParamsTabsState createState() => _TimeLapseParamsTabsState();
}

class _TimeLapseParamsTabsState extends State<TimeLapseParamsTabs> {
  NeoWebsocket neoWebsocket;
  @override
  void initState() {
    neoWebsocket = NeoWebsocket();
    neoWebsocket.fetchFstop(context);
    neoWebsocket.fetchShutter(context);
    neoWebsocket.fetchIso(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SelectedParamsTabBloc, int>(
      builder: (context, index) => BlocListener<KeyFrameBloc, bool>(
          listener: (context, state) {
            // if (state) {
            //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //     setState(() {
            //       activeIndex = null;
            //     });
            //   });
            // }
          },
          child: BlocBuilder<BasicHolyGrailBloc, int>(
              builder: (context, isHoly) => BlocBuilder<KeyFrameBloc, bool>(
                    builder: (context, isKeyFrame) => Column(
                      children: [
                        if (index == null && !isKeyFrame)
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "TAP PARAMETER BELOW TO ADJUST TIMELAPSE SETTINGS",
                                textAlign: TextAlign.center,
                                style: latoSemiBold.copyWith(
                                    color: HexColor.fromHex("#3E505B"),
                                    fontSize: 12.sp),
                              ))
                            ],
                          ),
                        SizedBox(
                          height: index == null && !isKeyFrame ? 150.h : 0.h,
                        ),
                        Consumer<KeyFrameModel>(
                          builder: (context, frameList, child) => Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor.fromHex("#3498DB")
                                      .withOpacity(0.1),
                                  spreadRadius: 30,
                                  blurRadius: 15,
                                  offset: Offset(
                                      0, 15), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Container(
                              color: HexColor.fromHex("#0E1011"),
                              child: BlocBuilder<ApertureRampBloc, bool>(
                                builder: (context, isApertureRamp) =>
                                    BlocConsumer<KeyFrameBloc, bool>(
                                  listener: (context, keyFr) {
                                    if (!keyFr) {
                                      // context.read<ApertureRampBloc>().add(true);
                                    }
                                  },
                                  builder: (context, isKeyFRame) {
                                    return Container(
                                      height: 65.h,
                                      color: HexColor.fromHex("#3498DB")
                                          .withOpacity(0.05),
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        itemExtent: isHoly == 1 && isKeyFRame
                                            ? !isApertureRamp
                                                ? size.width / 2
                                                : size.width / 3
                                            : isHoly == 1
                                                ? 90.w
                                                : 75.w,
                                        children: [
                                          BlocBuilder<InitialShutterSpBloc,
                                              HSelectedItem>(
                                            builder: (context, shutterInitial) {
                                              return isHoly == 1
                                                  ? BlocBuilder<
                                                          FinalShutterSpBloc,
                                                          HSelectedItem>(
                                                      builder: (context,
                                                              shutterFinal) =>
                                                          BlocBuilder<
                                                              KeyFrameBloc,
                                                              bool>(
                                                            builder: (context,
                                                                    isKeyFRame) =>
                                                                ParamButton(
                                                              name: "SHUTTER",
                                                              unit:
                                                                  shutterInitial
                                                                      .value,
                                                              unitFinal: isHoly ==
                                                                      1
                                                                  ? shutterFinal
                                                                      .value
                                                                  : null,
                                                              isTimeLapse:
                                                                  isHoly == 1,
                                                              dashColor: frameList
                                                                              .shutterItemList
                                                                              .length >
                                                                          0 &&
                                                                      isKeyFRame
                                                                  ? HexColor
                                                                      .shutterColor()
                                                                  : Colors.blue,
                                                              paramButtonCallback:
                                                                  () {
                                                                if (index ==
                                                                    0) {
                                                                  context
                                                                      .read<
                                                                          SelectedParamsTabBloc>()
                                                                      .add(
                                                                          null);
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          SelectedParamsTabBloc>()
                                                                      .add(0);
                                                                }

                                                                widget
                                                                    .paramTabSelected(
                                                                        index);
                                                              },
                                                              isActive:
                                                                  index == 0
                                                                      ? true
                                                                      : false,
                                                            ),
                                                          ))
                                                  : BlocBuilder<
                                                      ParamsShutterBloc,
                                                      String>(
                                                      builder:
                                                          (context, state) {
                                                        return BlocBuilder<
                                                            ButtonModeBloc,
                                                            ButtonModeState>(
                                                          builder: (context,
                                                                  buttonMode) =>
                                                              ParamButton(
                                                            name: "SHUTTER",
                                                            unit: buttonMode
                                                                    is ButtonModeStateBulb
                                                                ? "BULB"
                                                                : state,
                                                            paramButtonCallback:
                                                                () {
                                                              if (index == 0) {
                                                                context
                                                                    .read<
                                                                        SelectedParamsTabBloc>()
                                                                    .add(null);
                                                              } else {
                                                                context
                                                                    .read<
                                                                        SelectedParamsTabBloc>()
                                                                    .add(0);
                                                              }

                                                              widget
                                                                  .paramTabSelected(
                                                                      index);
                                                            },
                                                            isActive: index == 0
                                                                ? true
                                                                : false,
                                                          ),
                                                        );
                                                      },
                                                    );
                                            },
                                          ),
                                          if (isHoly == 1 && isApertureRamp)
                                            BlocBuilder<InitialFstopBloc,
                                                HSelectedItem>(
                                              builder: (context, initialFstop) {
                                                return BlocBuilder<
                                                    FinalFstopBloc,
                                                    HSelectedItem>(
                                                  builder:
                                                      (context, finalFstop) {
                                                    return BlocBuilder<
                                                        KeyFrameBloc, bool>(
                                                      builder: (context,
                                                              isKeyFRame) =>
                                                          ParamButton(
                                                        name: "F-STOP",
                                                        unit:
                                                            initialFstop.value,
                                                        unitFinal: isHoly == 1
                                                            ? finalFstop.value
                                                            : null,
                                                        isTimeLapse:
                                                            isHoly == 1,
                                                        dashColor: frameList
                                                                        .fstoptemList
                                                                        .length >
                                                                    0 &&
                                                                isKeyFRame
                                                            ? HexColor
                                                                .fstopColor()
                                                            : Colors.blue,
                                                        paramButtonCallback:
                                                            () {
                                                          if (index == 1) {
                                                            context
                                                                .read<
                                                                    SelectedParamsTabBloc>()
                                                                .add(null);
                                                          } else {
                                                            context
                                                                .read<
                                                                    SelectedParamsTabBloc>()
                                                                .add(1);
                                                          }

                                                          widget
                                                              .paramTabSelected(
                                                                  index);
                                                        },
                                                        isActive: index == 1
                                                            ? true
                                                            : false,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          if (isHoly == 0)
                                            BlocBuilder<ParamsFstopBloc,
                                                String>(
                                              builder: (context, state) {
                                                return ParamButton(
                                                  name: "F-STOP",
                                                  unit: state,
                                                  paramButtonCallback: () {
                                                    if (index == 1) {
                                                      context
                                                          .read<
                                                              SelectedParamsTabBloc>()
                                                          .add(null);
                                                    } else {
                                                      context
                                                          .read<
                                                              SelectedParamsTabBloc>()
                                                          .add(1);
                                                    }

                                                    widget.paramTabSelected(
                                                        index);
                                                  },
                                                  isActive:
                                                      index == 1 ? true : false,
                                                );
                                              },
                                            ),
                                          BlocBuilder<InitialIsoBloc,
                                              HSelectedItem>(
                                            builder: (context, initialV) {
                                              int i = 2;
                                              return BlocBuilder<FinalIsoBloc,
                                                  HSelectedItem>(
                                                builder: (context, finalValue) {
                                                  return BlocBuilder<
                                                      KeyFrameBloc, bool>(
                                                    builder:
                                                        (context, isKeyFRame) =>
                                                            BlocBuilder<
                                                                ParamsIsoBloc,
                                                                String>(
                                                      builder:
                                                          (context, isostate) =>
                                                              ParamButton(
                                                        name: "ISO",
                                                        unit: isHoly == 1
                                                            ? initialV.value
                                                            : isostate,
                                                        unitFinal: isHoly == 1
                                                            ? finalValue.value
                                                            : null,
                                                        isTimeLapse:
                                                            isHoly == 1,
                                                        dashColor: frameList
                                                                        .isoItemList
                                                                        .length >
                                                                    0 &&
                                                                isKeyFRame
                                                            ? HexColor
                                                                .isoColor()
                                                            : Colors.blue,
                                                        paramButtonCallback:
                                                            () {
                                                          if (index == i) {
                                                            context
                                                                .read<
                                                                    SelectedParamsTabBloc>()
                                                                .add(null);
                                                          } else {
                                                            context
                                                                .read<
                                                                    SelectedParamsTabBloc>()
                                                                .add(i);
                                                          }

                                                          widget
                                                              .paramTabSelected(
                                                                  index);
                                                        },
                                                        isActive: index == i
                                                            ? true
                                                            : false,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          if (!isKeyFRame)
                                            BlocBuilder<ShutLagMotCotBloc,
                                                ShutLagMotCotState>(
                                              builder: (context,
                                                  shutLagMotCotState) {
                                                int i = 4;
                                                if (shutLagMotCotState
                                                    is ShutLagState)
                                                  return BlocBuilder<
                                                          ShutterLagSecBloc,
                                                          int>(
                                                      builder: (context,
                                                              shuterSec) =>
                                                          StreamBuilder(
                                                            stream: NeoBlocProvider
                                                                    .of(context)
                                                                .intervalBloc
                                                                .stream$,
                                                            builder: (context,
                                                                    snapBasicInt) =>
                                                                ParamButton(
                                                              unit: isHoly == 1
                                                                  ? "${shuterSec}s"
                                                                  : snapBasicInt
                                                                          .hasData
                                                                      ? "${snapBasicInt.data.value}s"
                                                                      : "--",
                                                              unitFinal: null,
                                                              isTimeLapse:
                                                                  isHoly == 1,
                                                              isActive:
                                                                  index == i
                                                                      ? true
                                                                      : false,
                                                              dashColor: isKeyFRame
                                                                  ? HexColor
                                                                      .intervalColor()
                                                                  : Colors.blue,
                                                              paramButtonCallback:
                                                                  () {
                                                                if (index ==
                                                                    i) {
                                                                  context
                                                                      .read<
                                                                          SelectedParamsTabBloc>()
                                                                      .add(
                                                                          null);
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          SelectedParamsTabBloc>()
                                                                      .add(i);
                                                                }

                                                                widget
                                                                    .paramTabSelected(
                                                                        index);
                                                              },
                                                              name: "INTERVAL",
                                                            ),
                                                          ));

                                                if (shutLagMotCotState
                                                    is MotCotState)
                                                  return BlocBuilder<
                                                      ShutterLagSecBloc, int>(
                                                    builder:
                                                        (context, shutterSec) =>
                                                            ParamButton(
                                                      unit: "AUX - IN",
                                                      unitFinal: null,
                                                      isTimeLapse: isHoly == 1,
                                                      isActive: index == i
                                                          ? true
                                                          : false,
                                                      dashColor: isKeyFRame
                                                          ? HexColor
                                                              .intervalColor()
                                                          : Colors.blue,
                                                      paramButtonCallback: () {
                                                        if (index == i) {
                                                          context
                                                              .read<
                                                                  SelectedParamsTabBloc>()
                                                              .add(null);
                                                        } else {
                                                          context
                                                              .read<
                                                                  SelectedParamsTabBloc>()
                                                              .add(i);
                                                        }

                                                        widget.paramTabSelected(
                                                            index);
                                                      },
                                                      name: "INTERVAL",
                                                    ),
                                                  );

                                                return BlocBuilder<
                                                    InitialIntervalBloc,
                                                    String>(
                                                  builder: (context,
                                                      initialInterval) {
                                                    return BlocBuilder<
                                                        KeyFrameBloc, bool>(
                                                      builder: (context,
                                                              isKeyFRame) =>
                                                          BlocBuilder<
                                                              FinalIntervalBloc,
                                                              String>(
                                                        builder: (context,
                                                                finalInterval) =>
                                                            StreamBuilder<FPF>(
                                                          stream:
                                                              NeoBlocProvider.of(
                                                                      context)
                                                                  .intervalBloc
                                                                  .stream$,
                                                          builder: (context,
                                                                  snapInter) =>
                                                              BlocBuilder<
                                                                  SwitchDistanceBloc,
                                                                  bool>(
                                                            builder: (context,
                                                                    isDist) =>
                                                                BlocBuilder<
                                                                    DistanceIntervalBloc,
                                                                    int>(
                                                              builder: (context,
                                                                      distInt) =>
                                                                  ParamButton(
                                                                name: isHoly ==
                                                                        1
                                                                    ? "INTERVAL"
                                                                    : isDist
                                                                        ? "DISTANCE"
                                                                        : "INTERVAL",
                                                                unit: isHoly ==
                                                                        1
                                                                    ? initialInterval
                                                                    : isDist
                                                                        ? "${distInt}m"
                                                                        : "${snapInter.hasData ? snapInter.data.value : ""}s",
                                                                unitFinal:
                                                                    isHoly == 1
                                                                        ? finalInterval
                                                                        : null,
                                                                isTimeLapse:
                                                                    isHoly == 1,
                                                                dashColor: isKeyFRame
                                                                    ? HexColor
                                                                        .intervalColor()
                                                                    : Colors
                                                                        .blue,
                                                                paramButtonCallback:
                                                                    () {
                                                                  if (index ==
                                                                      i) {
                                                                    context
                                                                        .read<
                                                                            SelectedParamsTabBloc>()
                                                                        .add(
                                                                            null);
                                                                  } else {
                                                                    context
                                                                        .read<
                                                                            SelectedParamsTabBloc>()
                                                                        .add(i);
                                                                  }

                                                                  widget
                                                                      .paramTabSelected(
                                                                          index);
                                                                },
                                                                isActive:
                                                                    index == i
                                                                        ? true
                                                                        : false,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          if (!isKeyFRame)
                                            BlocBuilder<DurFramePlayBloc,
                                                DurationFramePlayState>(
                                              builder: (context, state) {
                                                int i = 5;
                                                return StreamBuilder<FPF>(
                                                    stream: NeoBlocProvider.of(context)
                                                        .hourBloc
                                                        .stream$,
                                                    builder: (context, snapHour) =>
                                                        StreamBuilder<FPF>(
                                                            stream:
                                                                NeoBlocProvider.of(context)
                                                                    .minBloc
                                                                    .stream$,
                                                            builder: (context, snapMin) => StreamBuilder<
                                                                    FPF>(
                                                                stream:
                                                                    NeoBlocProvider.of(context)
                                                                        .frameBloc
                                                                        .frame$,
                                                                builder: (context,
                                                                        snapFrames) =>
                                                                    StreamBuilder<
                                                                            FPF>(
                                                                        stream: NeoBlocProvider.of(context)
                                                                            .playtimeBloc
                                                                            .playtime$,
                                                                        builder: (context, snapPlayT) => StreamBuilder<FPF>(
                                                                              stream: NeoBlocProvider.of(context).fpsBloc.fps$,
                                                                              builder: (context, snapFps) {
                                                                                String disValue = "--";
                                                                                if (state is StateDuration) {
                                                                                  disValue = "${snapHour.hasData && snapHour.data.value != null ? snapHour.data.value > 9 ? "${snapHour.data.value}h" : "0${snapHour.data.value}h" : "--"}:${snapMin.hasData && snapMin.data.value != null ? snapMin.data.value > 9 ? "${snapMin.data.value}m" : "0${snapMin.data.value}m" : "--"} ";
                                                                                }
                                                                                if (state is StateFrame) {
                                                                                  disValue = snapFrames.hasData ? " ${snapFrames.data.value}F" : "--";
                                                                                }
                                                                                if (state is StatePlay) {
                                                                                  disValue = " ${snapPlayT.hasData ? snapPlayT.data.value : "--"}s@${snapFps.hasData ? snapFps.data.value : "--"}FPS";
                                                                                }

                                                                                return ParamButton(
                                                                                  name: state.displayName,
                                                                                  unit: disValue,
                                                                                  unitFinal: null,
                                                                                  isTimeLapse: isHoly == 1,
                                                                                  paramButtonCallback: () {
                                                                                    if (index == i) {
                                                                                      context.read<SelectedParamsTabBloc>().add(null);
                                                                                    } else {
                                                                                      context.read<SelectedParamsTabBloc>().add(i);
                                                                                    }

                                                                                    widget.paramTabSelected(index);
                                                                                  },
                                                                                  isActive: index == i ? true : false,
                                                                                );
                                                                              },
                                                                            )))));
                                              },
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
