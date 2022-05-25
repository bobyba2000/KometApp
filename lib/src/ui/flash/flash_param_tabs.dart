import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/res/neo_websocket.dart';
import 'package:neo/src/bloc/params_button/params_iso_bloc.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/aperture_ramp_bloc.dart';
import 'package:neo/src/bloc/timelapse/basic_holy_grail_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/final_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/initial_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/final_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/initial_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/final_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/initial_shutter_sp_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/model/keyframe/keyframe_shutter_model.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/parameter_button.dart';
import 'package:provider/provider.dart';

typedef ParamTabSelected(int index);

class FlashParamsTabs extends StatefulWidget {
  final ParamTabSelected paramTabSelected;

  const FlashParamsTabs({Key key, this.paramTabSelected}) : super(key: key);

  @override
  _FlashParamsTabsState createState() => _FlashParamsTabsState();
}

class _FlashParamsTabsState extends State<FlashParamsTabs> {
  NeoWebsocket neoWebsocket;

  @override
  void initState() {
    // neoWebsocket = NeoWebsocket();
    // neoWebsocket.fetchFstop(context);
    // neoWebsocket.fetchShutter(context);
    // neoWebsocket.fetchIso(context);
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
                              // Expanded(
                              //     child: Text(
                              //   "RC-01:11",
                              //   textAlign: TextAlign.center,
                              //   style: latoSemiBold.copyWith(
                              //       color: HexColor.fromHex("#3E505B"),
                              //       fontSize: 12.sp),
                              // ))
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
                                              return BlocBuilder<
                                                      FinalShutterSpBloc,
                                                      HSelectedItem>(
                                                  builder: (context,
                                                          shutterFinal) =>
                                                      BlocBuilder<KeyFrameBloc,
                                                          bool>(
                                                        builder: (context,
                                                                isKeyFRame) =>
                                                            ParamButton(
                                                          name: "GROUP",
                                                          unit: "ALL",
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
                                                            // if (index ==
                                                            //     0) {
                                                            //   context
                                                            //       .read<
                                                            //           SelectedParamsTabBloc>()
                                                            //       .add(
                                                            //           null);
                                                            // } else {
                                                            //   context
                                                            //       .read<
                                                            //           SelectedParamsTabBloc>()
                                                            //       .add(0);
                                                            // }
                                                            //
                                                            // widget
                                                            //     .paramTabSelected(
                                                            //         index);
                                                          },
                                                          isActive: index == 0
                                                              ? true
                                                              : false,
                                                        ),
                                                      ));
                                            },
                                          ),
                                          BlocBuilder<InitialFstopBloc,
                                              HSelectedItem>(
                                            builder: (context, initialFstop) {
                                              return BlocBuilder<FinalFstopBloc,
                                                  HSelectedItem>(
                                                builder: (context, finalFstop) {
                                                  return BlocBuilder<
                                                      KeyFrameBloc, bool>(
                                                    builder:
                                                        (context, isKeyFRame) =>
                                                            ParamButton(
                                                      name: "GROUP",
                                                      unit: "A",
                                                      isTimeLapse: isHoly == 1,
                                                      dashColor: frameList
                                                                      .fstoptemList
                                                                      .length >
                                                                  0 &&
                                                              isKeyFRame
                                                          ? HexColor
                                                              .fstopColor()
                                                          : Colors.blue,
                                                      paramButtonCallback: () {
                                                        if (index == 11) {
                                                          context
                                                              .read<
                                                                  SelectedParamsTabBloc>()
                                                              .add(null);
                                                        } else {
                                                          context
                                                              .read<
                                                                  SelectedParamsTabBloc>()
                                                              .add(11);
                                                        }

                                                        widget.paramTabSelected(
                                                            index);
                                                      },
                                                      isActive: index == 11
                                                          ? true
                                                          : false,
                                                    ),
                                                  );
                                                },
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
                                                        name: "GROUP",
                                                        unit: "B",
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
                                                          // if (index == i) {
                                                          //   context
                                                          //       .read<
                                                          //           SelectedParamsTabBloc>()
                                                          //       .add(null);
                                                          // } else {
                                                          //   context
                                                          //       .read<
                                                          //           SelectedParamsTabBloc>()
                                                          //       .add(i);
                                                          // }
                                                          //
                                                          // widget
                                                          //     .paramTabSelected(
                                                          //         index);
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
                                                        name: "GROUP",
                                                        unit: "C",
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
                                                          // if (index == i) {
                                                          //   context
                                                          //       .read<
                                                          //           SelectedParamsTabBloc>()
                                                          //       .add(null);
                                                          // } else {
                                                          //   context
                                                          //       .read<
                                                          //           SelectedParamsTabBloc>()
                                                          //       .add(i);
                                                          // }
                                                          //
                                                          // widget
                                                          //     .paramTabSelected(
                                                          //         index);
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
                                                        name: "GROUP",
                                                        unit: "D",
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
                                                          // if (index == i) {
                                                          //   context
                                                          //       .read<
                                                          //           SelectedParamsTabBloc>()
                                                          //       .add(null);
                                                          // } else {
                                                          //   context
                                                          //       .read<
                                                          //           SelectedParamsTabBloc>()
                                                          //       .add(i);
                                                          // }
                                                          //
                                                          // widget
                                                          //     .paramTabSelected(
                                                          //         index);
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
