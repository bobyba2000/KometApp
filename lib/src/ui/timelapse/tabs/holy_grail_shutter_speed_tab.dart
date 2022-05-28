import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/params_button/params_shutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/final_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/initial_shutter_sp_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/model/keyframe/keyframe_shutter_model.dart';
import 'package:neo/src/model/shutter_speed.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../holy_horizontal_elector.dart';

class HolyGrailShutterSpeed extends StatefulWidget {
  final String url;

  const HolyGrailShutterSpeed({Key key, @required this.url}) : super(key: key);
  @override
  _HolyGrailShutterSpeedState createState() => _HolyGrailShutterSpeedState();
}

class _HolyGrailShutterSpeedState extends State<HolyGrailShutterSpeed> {
  IOWebSocketChannel channel;
  ShutterSpeed shutterSpeed;
  String curentvalue;
  ActivePosition activePosition = PositionInitial();
  Map map = {
    "CMD": {"CONTROL_SHUTTERSPEED": "?"}
  };

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(widget.url);
    channel.sink.add(jsonEncode(map));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        try {
          print(" websocketME ${snapshot.data}");
          if (snapshot.hasData) {
            Map result = jsonDecode(snapshot.data);

            if (result["RSP"] != null &&
                result["RSP"]["CONTROL_SHUTTERSPEED"] != null) {
              if (result["RSP"]["CONTROL_SHUTTERSPEED"]["CHOICE"] != null) {
                shutterSpeed = ShutterSpeed.fromJson(jsonDecode(snapshot.data));

                context
                    .read<ParamsShutterBloc>()
                    .add("${shutterSpeed.current}");
              } else if (result["RSP"]["CONTROL_SHUTTERSPEED"] == "OK") {
                context.read<ParamsShutterBloc>().add("$curentvalue");
              }
            }
          }
        } catch (e) {
          print("eror on websocket $e");
        }
        return BlocBuilder<LiveViewBloc, bool>(
          builder: (context, isLiveView) {
            return Container(
              margin: EdgeInsets.only(top: isLiveView ? 10.h : 0),
              width: double.infinity,
              decoration: decoration,
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
                                  style:
                                      latoSemiBold.copyWith(color: Colors.red),
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
                                  activePosition is PositionInitial
                                      ? "INITIAL SHUTTER SPEED"
                                      : "FINAL SHUTTER SPEED",
                                  style: latoSemiBold.copyWith(
                                      color: HexColor.fromHex("#3E505B"),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            snapshot.hasData
                                ? BlocBuilder<InitialShutterSpBloc,
                                    HSelectedItem>(
                                    builder: (context, isoInitial) =>
                                        BlocBuilder<FinalShutterSpBloc,
                                            HSelectedItem>(
                                      builder: (context, isoFinal) =>
                                          HolyHorizantalPicker(
                                        finalIndex: isoFinal.value,
                                        initialIndex: isoInitial.value,
                                        finalChanged: (finalV) => context
                                            .read<FinalShutterSpBloc>()
                                            .add(finalV),
                                        activePosition: activePosition,
                                        initialChanged: (initialV) {
                                          context
                                              .read<InitialShutterSpBloc>()
                                              .add(initialV);
                                        },
                                        backgroundColor: Colors.grey.shade900,
                                        activeItemTextColor: Colors.white,
                                        passiveItemsTextColor: Colors.amber,
                                        currentItem: shutterSpeed != null
                                            ? shutterSpeed.current
                                            : "",
                                        onChanged: (value) {
                                          setState(() {
                                            curentvalue = value.name;
                                          });
                                        },
                                        shutterList: shutterSpeed.list,
                                        activePostionChnaged:
                                            (ActivePosition activePosition) {
                                          setState(() {
                                            this.activePosition =
                                                activePosition;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 24.h,
                            )
                          ],
                        ),
            );
          },
        );
      },
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
