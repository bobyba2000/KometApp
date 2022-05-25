import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';

import 'package:neo/src/bloc/params_button/params_fstop_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/f_s_t_o_p.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/horizontal_selector.dart';
import 'package:web_socket_channel/io.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FStopScroller extends StatefulWidget {
  final String ulr;

  FStopScroller({Key key, @required this.ulr}) : super(key: key);

  @override
  _ShutterSpeedScrollerState createState() => _ShutterSpeedScrollerState();
}

class _ShutterSpeedScrollerState extends State<FStopScroller>
    with TickerProviderStateMixin {
  IOWebSocketChannel channel;

  FSTOPRESPONSE fstop;
  String curentvalue;

  final Map<dynamic, dynamic> map = {
    "CMD": {"CONTROL_FSTOP": "?"}
  };

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(widget.ulr);
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
        if (snapshot.hasData) {
          print("data ${snapshot.data}");
          Map json = jsonDecode(snapshot.data);
          if (json["RSP"] != null) {
            if (json["RSP"]["CONTROL_FSTOP"] != null) {
              if (json["RSP"]["CONTROL_FSTOP"] == "OK") {
                context.read<ParamsFstopBloc>().add(curentvalue);
              } else {
                if (json["RSP"]["CONTROL_FSTOP"]["CHOICE"] != null) {
                  fstop = FSTOPRESPONSE.fromJson(jsonDecode(snapshot.data));
                  context.read<ParamsFstopBloc>().add(fstop.current);
                }
              }
            }
          }
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
                                  "F-STOP",
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
                                    currentItem:
                                        fstop != null ? fstop.current : "",
                                    onChanged: (value) {
                                      channel.sink.add(jsonEncode({
                                        "CMD": {"CONTROL_FSTOP": value.name}
                                      }));
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
