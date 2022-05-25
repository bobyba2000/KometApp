import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/res/neo_websocket.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_state.dart';
import 'package:neo/src/bloc/params_button/params_fstop_bloc.dart';
import 'package:neo/src/bloc/params_button/params_hdr_bloc.dart';
import 'package:neo/src/bloc/params_button/params_iso_bloc.dart';
import 'package:neo/src/bloc/params_button/params_shutter_bloc.dart';
import 'package:neo/src/bloc/params_button/params_wb_bloc.dart';
import 'package:neo/src/bloc/video/video_active_bloc.dart';
import 'package:neo/src/utils/wb_choice_string.dart';

import 'parameter_button.dart';

typedef ParamTabSelected(int index);

class ParameterTabs extends StatefulWidget {
  final ParamTabSelected paramTabSelected;

  const ParameterTabs({
    Key key,
    @required this.paramTabSelected,
  }) : super(key: key);
  @override
  _ParameterTabsState createState() => _ParameterTabsState();
}

class _ParameterTabsState extends State<ParameterTabs> {
  int activeIndex;
  NeoWebsocket neoWebsocket;

  @override
  void initState() {
    neoWebsocket = NeoWebsocket();
    neoWebsocket.fetchFstop(context);
    neoWebsocket.fetchShutter(context);
    neoWebsocket.fetchIso(context);
    neoWebsocket.fetchWb(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<VideoActiveBloc, bool>(
      builder: (context, isVideo) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<ParamsShutterBloc, String>(
              builder: (context, state) {
                return BlocBuilder<ButtonModeBloc, ButtonModeState>(
                  builder: (context, buttonMode) => ParamButton(
                    name: "SHUTTER",
                    unit: buttonMode is ButtonModeStateBulb ? "BULB" : state,
                    paramButtonCallback: () {
                      setState(() {
                        if (activeIndex == 0) {
                          activeIndex = null;
                        } else {
                          activeIndex = 0;
                        }
                      });
                      widget.paramTabSelected(activeIndex);
                    },
                    isActive: activeIndex == 0 ? true : false,
                  ),
                );
              },
            ),
            BlocBuilder<ParamsFstopBloc, String>(
              builder: (context, state) {
                return ParamButton(
                  name: "F-STOP",
                  unit: state,
                  paramButtonCallback: () {
                    setState(() {
                      if (activeIndex == 1) {
                        activeIndex = null;
                      } else {
                        activeIndex = 1;
                      }
                    });
                    widget.paramTabSelected(activeIndex);
                  },
                  isActive: activeIndex == 1 ? true : false,
                );
              },
            ),
            BlocBuilder<ParamsIsoBloc, String>(
              builder: (context, state) {
                int i = 2;
                return ParamButton(
                  name: "ISO",
                  unit: state,
                  paramButtonCallback: () {
                    setState(() {
                      if (activeIndex == i) {
                        activeIndex = null;
                      } else {
                        activeIndex = i;
                      }
                    });
                    widget.paramTabSelected(activeIndex);
                  },
                  isActive: activeIndex == i ? true : false,
                );
              },
            ),
            BlocBuilder<ParamsWbBloc, String>(
              builder: (context, state) {
                int i = 3;
                return ParamButton(
                  name: "WB",
                  unit: state.abreviation(),
                  paramButtonCallback: () {
                    setState(() {
                      if (activeIndex == i) {
                        activeIndex = null;
                      } else {
                        activeIndex = i;
                      }
                    });
                    widget.paramTabSelected(activeIndex);
                  },
                  isActive: activeIndex == i ? true : false,
                );
              },
            ),
            if (!isVideo)
              BlocBuilder<ParamsHdrBloc, String>(
                builder: (context, state) {
                  int i = 4;
                  return ParamButton(
                    name: "HDR",
                    unit: state,
                    paramButtonCallback: () {
                      setState(() {
                        if (activeIndex == i) {
                          activeIndex = null;
                        } else {
                          activeIndex = i;
                        }
                      });
                      widget.paramTabSelected(activeIndex);
                    },
                    isActive: activeIndex == i ? true : false,
                  );
                },
              ),
          ],
        );
      },
    ));
  }

  String returnAbr(String state) {
    // if (state == "Auto") {
    //   return 'AU';
    // }
    // if (state == "Daylight") {
    //   return 'DL';
    // }
    // if (state == "Shadow") {
    //   return 'SH';
    // }
    // if (state == "Cloudy") {
    //   return 'CL';
    // }
    // if (state == "Tungsten") {
    //   return 'TN';
    // }
    // if (state == "Fluorescent") {
    //   return 'FL';
    // }
    // if (state == "Flash") {
    //   return 'FL';
    // }

    return state.abreviation();
  }
}

class Items {
  String unit;
  String name;
  Items({
    @required this.unit,
    @required this.name,
  });
}
