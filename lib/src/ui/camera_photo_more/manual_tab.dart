import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:web_socket_channel/io.dart';

import 'seconds_picker.dart';

class ManualTab extends StatefulWidget {
  final String url;

  const ManualTab({Key key, @required this.url}) : super(key: key);
  @override
  _ManualTabState createState() => _ManualTabState();
}

class _ManualTabState extends State<ManualTab> {
  int curItem = 0;
  int curNdFilter = 0;
  int curSec = 0;
  final List<int> items = [
    1,
    2,
    3,
    4,
    5,
  ];
  IOWebSocketChannel _channel;

  @override
  void initState() {
    _channel = IOWebSocketChannel.connect(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Container(
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                clockIcon(curSec != 0),
                SizedBox(
                  width: 12.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delay",
                      style: latoSemiBold.copyWith(
                          color: curSec != 0
                              ? HexColor.fromHex("#EDEFF0")
                              : HexColor.fromHex("#959FA5"),
                          fontSize: 15.sp),
                    ),
                    Text(
                      "Time Delay Before Shot",
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                    )
                  ],
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: SecondsPicker(
                    selectedSec: (int sec) {
                      print("sec $sec");

                      setState(() {
                        this.curSec = sec;
                      });
                      _channel.sink.add(
                        jsonEncode(
                          {
                            "CMD": {
                              "CAPTURE": {
                                "DELAY": {
                                  "H": 0,
                                  "M": 0,
                                  "S": curSec,
                                },
                                "MULTISHOTS": items[curItem],
                              }
                            }
                          },
                        ),
                      );
                    },
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            decoration: BoxDecoration(
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                stackIcon(curItem != 0),
                SizedBox(
                  width: 12.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Multi-Shots",
                      style: latoSemiBold.copyWith(
                          color: curItem != 0
                              ? HexColor.fromHex("#EDEFF0")
                              : HexColor.fromHex("#959FA5"),
                          fontSize: 15.sp),
                    ),
                    Text(
                      "Number of Shots",
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                    )
                  ],
                ),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                    child: Row(
                        children: items.map((e) {
                  return Expanded(
                      child: IconButton(
                    icon: Text(
                      "$e",
                      style: latoSemiBold.copyWith(
                          fontSize: e == items[curItem] ? 15.sp : 12.sp,
                          color: e == items[curItem]
                              ? HexColor.fromHex("#EDEFF0")
                              : HexColor.fromHex("#959FA5")),
                    ),
                    onPressed: () {
                      setState(() {
                        curItem = items.indexOf(e);
                      });
                      _channel.sink.add(
                        jsonEncode(
                          {
                            "CMD": {
                              "CAPTURE": {
                                "DELAY": {
                                  "H": 0,
                                  "M": 0,
                                  "S": curSec,
                                },
                                "MULTISHOTS": e
                              }
                            }
                          },
                        ),
                      );
                    },
                  ));
                }).toList()))
              ],
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                ndFilterIcon(curNdFilter != 0),
                SizedBox(
                  width: 12.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ND Filter",
                      style: latoSemiBold.copyWith(
                          color: curNdFilter != 0
                              ? HexColor.fromHex("#EDEFF0")
                              : HexColor.fromHex("#959FA5"),
                          fontSize: 15.sp),
                    ),
                    Text(
                      "ND64, OD1.8",
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            curNdFilter = 1;
                          });
                        },
                        child: Container(
                          height: 36.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              color: curNdFilter == 1
                                  ? HexColor.neoBlue()
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              border: Border.all(color: HexColor.neoBlue())),
                          child: Center(
                            child: Text(
                              "6 STOP",
                              style: latoSemiBold.copyWith(
                                  color: curNdFilter == 1
                                      ? HexColor.fromHex("#EDEFF0")
                                      : HexColor.fromHex("#959FA5"),
                                  fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            curNdFilter = 2;
                          });
                        },
                        child: Container(
                          height: 36.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: curNdFilter == 2
                                ? HexColor.neoBlue()
                                : Colors.transparent,
                            border: Border.all(color: HexColor.neoBlue()),
                          ),
                          child: Center(
                            child: Text(
                              "10 STOP",
                              style: latoSemiBold.copyWith(
                                  color: curNdFilter == 2
                                      ? HexColor.fromHex("#EDEFF0")
                                      : HexColor.fromHex("#959FA5"),
                                  fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            curNdFilter = 3;
                          });
                        },
                        child: Container(
                          height: 36.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              color: curNdFilter == 3
                                  ? HexColor.neoBlue()
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border.all(color: HexColor.neoBlue())),
                          child: Center(
                            child: Text(
                              "15 STOP",
                              style: latoSemiBold.copyWith(
                                  color: curNdFilter == 3
                                      ? HexColor.fromHex("#EDEFF0")
                                      : HexColor.fromHex("#959FA5"),
                                  fontSize: 12.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget clockIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_TimeDelay_Enable.svg"
          : "assets/icons/Button_TimeDelay_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }

  Widget stackIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_MultipleShots_Enable.svg"
          : "assets/icons/Button_MultipleShots_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }

  Widget ndFilterIcon(bool active) {
    return SvgPicture.asset(
      active
          ? "assets/icons/Button_NDFilter_Enable.svg"
          : "assets/icons/Button_NDFilter_Disable.svg",
      height: 36.h,
      width: 36.w,
    );
  }
}
