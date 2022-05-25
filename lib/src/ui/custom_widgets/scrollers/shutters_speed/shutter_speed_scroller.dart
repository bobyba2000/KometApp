import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/params_button/params_shutter_bloc.dart';

import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/shutter_speed.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../camera_shutterspeed/horizontal_selector.dart';

class ShutterSpeedScroller extends StatefulWidget {
  final String url;

  ShutterSpeedScroller({Key key, @required this.url}) : super(key: key);

  @override
  _ShutterSpeedScrollerState createState() => _ShutterSpeedScrollerState();
}

class _ShutterSpeedScrollerState extends State<ShutterSpeedScroller>
    with TickerProviderStateMixin {
  IOWebSocketChannel channel;
  String curentvalue;

  ShutterSpeed shutterSpeed;

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(widget.url);
    channel.sink.add(jsonEncode({
      "CMD": {"CONTROL_SHUTTERSPEED": "?"}
    }));

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
                    .add("${shutterSpeed.current}s");
              } else if (result["RSP"]["CONTROL_SHUTTERSPEED"] == "OK") {
                context.read<ParamsShutterBloc>().add("${curentvalue}s");
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
                                      channel.sink.add(jsonEncode(
                                          {"CONTROL_SHUTTERSPEED": "?"}));
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
                                  "SHUTTER SPEED",
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
                                    currentItem: shutterSpeed.current,
                                    isShutter: true,
                                    onChanged: (value) {
                                      print("stopped send $value");
                                      channel.sink.add(jsonEncode({
                                        "CMD": {
                                          "CONTROL_SHUTTERSPEED": value.name
                                        }
                                      }));
                                      setState(() {
                                        curentvalue = value.name;
                                      });
                                    },
                                    shutterList: shutterSpeed.list,
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
