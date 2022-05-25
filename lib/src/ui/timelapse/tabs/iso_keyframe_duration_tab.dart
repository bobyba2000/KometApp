import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/params_button/params_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/framekey_index_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/edit_key_frame_model.dart';
import 'package:neo/src/model/i_s_o.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/ui/custom_widgets/buttons/left_value_btn.dart';
import 'package:neo/src/ui/custom_widgets/buttons/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/right_value_btn.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/horizontal_selector.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'holy_grail_duration/hour_min_state.dart';

class IsoKeyframeDurationTab extends StatefulWidget {
  final String url;

  const IsoKeyframeDurationTab({Key key, @required this.url}) : super(key: key);
  @override
  _IsoKeyframeDurationTabState createState() => _IsoKeyframeDurationTabState();
}

class _IsoKeyframeDurationTabState extends State<IsoKeyframeDurationTab> {
  IOWebSocketChannel channel;
  HourMinState hourMinState = MinState();

  ISORESPONSE fstop;

  String curentvalue;

  final Map<dynamic, dynamic> map = {
    "CMD": {"CONTROL_ISO": "?"}
  };

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(widget.url);
    channel.sink.add(jsonEncode(map));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: decoration,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
              child: Text(
                "ISO KEYFRAME DURATION",
                style: latoSemiBold.copyWith(
                    color: HexColor.fromHex("#3E505B"), fontSize: 12),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<GrapHourBloc, String>(
                builder: (context, initialInterval) => LeftValueBtn(
                  value: initialInterval,
                  isActive: hourMinState is HourState,
                  onPressed: () {
                    setState(() {
                      hourMinState = HourState();
                    });
                  },
                ),
              ),
              BlocBuilder<GraphMinuteBloc, String>(
                builder: (context, finalInterval) => RightValueBtn(
                  isActive: hourMinState is MinState,
                  onPressed: () {
                    setState(() {
                      hourMinState = MinState();
                    });
                  },
                  value: finalInterval,
                ),
              )
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MinusButton(
                onTap: () {
                  if (hourMinState is HourState) {
                    context.read<GrapHourBloc>().decrement();
                  } else {
                    context.read<GraphMinuteBloc>().decrement();
                  }
                },
              ),
              PlusButton(
                onTap: () {
                  int hour = NeoBlocProvider.of(context).hourBloc.current;
                  int min = NeoBlocProvider.of(context).minBloc.current;
                  if (hour == 0 && min == 0) {
                    min = 30;
                  }
                  if (hourMinState is MinState) {
                    context.read<GraphMinuteBloc>().increment(maxMin: min);
                  } else {
                    context.read<GrapHourBloc>().increment(maxHour: hour);
                  }
                },
              )
            ],
          ),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("data ${snapshot.data}");
                Map json = jsonDecode(snapshot.data);
                if (json["RSP"] != null) {
                  if (json["RSP"]["CONTROL_ISO"] != null) {
                    if (json["RSP"]["CONTROL_ISO"] == "OK") {
                      context.read<ParamsIsoBloc>().add(curentvalue);
                    } else if (json["RSP"]["CONTROL_ISO"]["CHOICE"] != null) {
                      print("ISO response ");
                      fstop = ISORESPONSE.fromJson(jsonDecode(snapshot.data));
                      context.read<ParamsIsoBloc>().add(fstop.current);
                    }
                  }
                }
              }
              int editIndex = context.read<EditKeyFrameModel>().editIndex;

              return Container(
                child: !snapshot.hasData
                    ? Container(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Text(
                            "Loading...",
                            style: latoSemiBold.copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    : snapshot.hasError
                        ? Container(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    returnError("${snapshot.error}"),
                                    style: latoSemiBold.copyWith(
                                        color: Colors.red),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        channel.sink.add(jsonEncode(map));
                                      },
                                      child: Text("Retry"))
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 12.h, bottom: 12.h),
                                  child: Text(
                                    "ISO KEYFRAME VALUE",
                                    style: latoSemiBold.copyWith(
                                        color: HexColor.fromHex("#3E505B"),
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              snapshot.hasData
                                  ? HorizantalPicker(
                                      showCursor: false,
                                      backgroundColor: Colors.grey.shade900,
                                      activeItemTextColor: Colors.white,
                                      passiveItemsTextColor: Colors.amber,
                                      currentItem: fstop != null
                                          ? editIndex != null
                                              ? fstop.list[editIndex]
                                              : fstop.current
                                          : "",
                                      onChanged: (value) {
                                        context.read<FrameKeyIndex>().add(
                                            HSelectedItem(
                                                value: value.name,
                                                index: value.index));
                                        setState(() {
                                          curentvalue = value.name;
                                        });
                                      },
                                      shutterList: fstop.list,
                                    )
                                  : Container(),
                              SizedBox(
                                height: 24.h,
                              )
                            ],
                          ),
              );
            },
          )
        ],
      ),
    );
  }

  String returnError(String e) {
    String error = "$e";

    if (error.contains("Connection timed out")) {
      error = "Connection timed out";
    }
    if (error.contains("Connection refused")) {
      error = "Connection refused";
    }

    return error;
  }
}
