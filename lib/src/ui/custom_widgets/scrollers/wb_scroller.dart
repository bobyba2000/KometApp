import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';

import 'package:neo/src/bloc/params_button/params_wb_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/white_balance.dart';
import 'package:neo/src/ui/custom_widgets/buttons/cloudy_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/shadow_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/wb_auto_button.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'daylight_button.dart';
import 'flash_button.dart';
import 'fluorescent_button.dart';
import 'tungsten_button.dart';
import 'package:provider/provider.dart';
import 'package:neo/src/utils/wb_choice_string.dart';

class WbScroller extends StatefulWidget {
  final String url;

  const WbScroller({Key key, @required this.url}) : super(key: key);

  @override
  _WbScrollerState createState() => _WbScrollerState();
}

class _WbScrollerState extends State<WbScroller> with TickerProviderStateMixin {
  IOWebSocketChannel channel;
  WhiteBalance whiteBalance;
  String curentvalue;

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(widget.url);
    channel.sink.add(jsonEncode({
      "CMD": {"CONTROL_WHITEBALANCE": "?"}
    }));

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("data ${snapshot.data}");
          Map json = jsonDecode(snapshot.data);
          if (json["RSP"] != null) {
            if (json["RSP"]["CONTROL_WHITEBALANCE"] != null) {
              if (json["RSP"]["CONTROL_WHITEBALANCE"] == "OK") {
                context.read<ParamsWbBloc>().add(curentvalue.abreviation());
              } else {
                if (json["RSP"]["CONTROL_WHITEBALANCE"]["CHOICE"] != null) {
                  whiteBalance =
                      WhiteBalance.fromJson(jsonDecode(snapshot.data));
                  context
                      .read<ParamsWbBloc>()
                      .add(whiteBalance.current.abreviation());
                  curentvalue = whiteBalance.current;
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
                                padding: EdgeInsets.only(
                                  top: 12.h,
                                ),
                                child: Text(
                                  "WHITE BALANCE",
                                  style: latoSemiBold.copyWith(
                                      color: HexColor.fromHex("#3E505B"),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 12.h, bottom: 12.h),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${curentvalue.fullName()}",
                                        textAlign: TextAlign.center,
                                        style: latoSemiBold.copyWith(
                                          color: HexColor.fromHex("#EDEFF0"),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      Container(
                                        width: 96.w,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: HexColor.neoBlue(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            snapshot.hasData
                                ? Container(
                                    height: 40,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: whiteBalance
                                          .rsp.whitebalance.choice.length,
                                      itemBuilder: (context, index) {
                                        switch (whiteBalance.list[index]
                                            .fullName()) {
                                          case "AUTO":
                                            bool isActive =
                                                curentvalue.fullName() ==
                                                    "AUTO";
                                            return WbAutoButton(
                                              isPressed: isActive,
                                              onTap: () {
                                                channel.sink.add(jsonEncode({
                                                  "CMD": {
                                                    "CONTROL_WHITEBALANCE":
                                                        whiteBalance.list[index]
                                                  }
                                                }));
                                                setState(() {
                                                  curentvalue =
                                                      whiteBalance.list[index];
                                                });
                                              },
                                            );
                                            break;
                                          case "DAYLIGHT":
                                            bool isActive =
                                                curentvalue.fullName() ==
                                                    "DAYLIGHT";
                                            return DaylightButton(
                                              isPressed: isActive,
                                              onTap: () {
                                                channel.sink.add(jsonEncode({
                                                  "CMD": {
                                                    "CONTROL_WHITEBALANCE":
                                                        whiteBalance.list[index]
                                                  }
                                                }));
                                                setState(() {
                                                  curentvalue =
                                                      whiteBalance.list[index];
                                                });
                                              },
                                            );
                                            break;
                                          case "SHADOW":
                                            bool isActive =
                                                curentvalue.fullName() ==
                                                    "SHADOW";
                                            return ShadowButton(
                                              isPressed: isActive,
                                              onTap: () {
                                                channel.sink.add(jsonEncode({
                                                  "CMD": {
                                                    "CONTROL_WHITEBALANCE":
                                                        whiteBalance.list[index]
                                                  }
                                                }));
                                                setState(() {
                                                  curentvalue =
                                                      whiteBalance.list[index];
                                                });
                                              },
                                            );
                                            break;
                                          case "CLOUDY":
                                            bool isActive =
                                                curentvalue.fullName() ==
                                                    "CLOUDY";
                                            return CloudyButton(
                                              isPressed: isActive,
                                              onTap: () {
                                                channel.sink.add(jsonEncode({
                                                  "CMD": {
                                                    "CONTROL_WHITEBALANCE":
                                                        whiteBalance.list[index]
                                                  }
                                                }));
                                                setState(() {
                                                  curentvalue =
                                                      whiteBalance.list[index];
                                                });
                                              },
                                            );
                                            break;
                                          case "TUNGSTEN":
                                            bool isActive =
                                                curentvalue.fullName() ==
                                                    "TUNGSTEN";
                                            return TungstenButton(
                                              isPressed: isActive,
                                              onTap: () {
                                                channel.sink.add(jsonEncode({
                                                  "CMD": {
                                                    "CONTROL_WHITEBALANCE":
                                                        whiteBalance.list[index]
                                                  }
                                                }));
                                                setState(() {
                                                  curentvalue =
                                                      whiteBalance.list[index];
                                                });
                                              },
                                            );
                                            break;
                                          case "FLUORESCENT":
                                            bool isActive =
                                                curentvalue.fullName() ==
                                                    "FLUORESCENT";
                                            return FluorescentButton(
                                              isPressed: isActive,
                                              onTap: () {
                                                channel.sink.add(jsonEncode({
                                                  "CMD": {
                                                    "CONTROL_WHITEBALANCE":
                                                        whiteBalance.list[index]
                                                  }
                                                }));
                                                setState(() {
                                                  curentvalue =
                                                      whiteBalance.list[index];
                                                });
                                              },
                                            );
                                            break;
                                          case "FLASH":
                                            bool isActive =
                                                curentvalue.fullName() ==
                                                    "FLASH";
                                            return FlashButton(
                                              isPressed: isActive,
                                              onTap: () {
                                                channel.sink.add(jsonEncode({
                                                  "CMD": {
                                                    "CONTROL_WHITEBALANCE":
                                                        whiteBalance.list[index]
                                                  }
                                                }));
                                                setState(() {
                                                  curentvalue =
                                                      whiteBalance.list[index];
                                                });
                                              },
                                            );
                                            break;
                                          default:
                                            return Container();
                                        }
                                      },
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
    ));
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
