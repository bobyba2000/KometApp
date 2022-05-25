import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/params_button/params_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/final_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/initial_iso_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/i_s_o.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:web_socket_channel/io.dart';

import '../holy_horizontal_elector.dart';

class HolyGrailIsoTab extends StatefulWidget {
  final String url;

  const HolyGrailIsoTab({Key key, @required this.url}) : super(key: key);

  @override
  _HolyGrailIsoTabState createState() => _HolyGrailIsoTabState();
}

class _HolyGrailIsoTabState extends State<HolyGrailIsoTab> {
  IOWebSocketChannel channel;
  ISORESPONSE fstop;
  ActivePosition activePosition = PositionInitial();

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
            if (json["RSP"]["CONTROL_ISO"] != null) {
              if (json["RSP"]["CONTROL_ISO"] == "OK") {
                context.read<ParamsIsoBloc>().add(curentvalue);
              } else if (json["RSP"]["CONTROL_ISO"]["CHOICE"] != null) {
                fstop = ISORESPONSE.fromJson(jsonDecode(snapshot.data));
                context.read<ParamsIsoBloc>().add(fstop.current);
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
                                  activePosition is PositionInitial
                                      ? "INITIAL ISO"
                                      : "FINAL ISO",
                                  style: latoSemiBold.copyWith(
                                      color: HexColor.fromHex("#3E505B"),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            snapshot.hasData
                                ? BlocBuilder<InitialIsoBloc, HSelectedItem>(
                                    builder: (context, isoInitial) =>
                                        BlocBuilder<FinalIsoBloc,
                                            HSelectedItem>(
                                      builder: (context, isoFinal) =>
                                          HolyHorizantalPicker(
                                        finalIndex: isoFinal.value,
                                        initialIndex: isoInitial.value,
                                        finalChanged: (finalV) => context
                                            .read<FinalIsoBloc>()
                                            .add(finalV),
                                        activePosition: activePosition,
                                        initialChanged: (initialV) {
                                          context
                                              .read<InitialIsoBloc>()
                                              .add(initialV);
                                        },
                                        backgroundColor: Colors.grey.shade900,
                                        activeItemTextColor: Colors.white,
                                        passiveItemsTextColor: Colors.amber,
                                        currentItem:
                                            fstop != null ? fstop.current : "",
                                        onChanged: (value) {
                                          setState(() {
                                            curentvalue = value.name;
                                          });
                                        },
                                        shutterList: fstop.list,
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
