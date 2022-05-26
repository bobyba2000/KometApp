import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/pages/page_event.dart';
import 'package:neo/src/bloc/pages/pages_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/url_holder.dart';
import 'package:neo/src/ui/custom_widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

import 'custom_widgets/buttons/neo_switch.dart';
import 'custom_widgets/hdr/expanded_items/button_radio.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  static String urlDemo = "localhost:8000";
  // static String urlProd = "192.168.1.1:8080";
  static String urlProd = "103.232.103.205:8080";
  static String red = "RED";
  static String green = "GREEN";
  static String blue = "BLUE";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var formState = GlobalKey<FormState>();
  var controller = TextEditingController(text: SettingsPage.urlProd);
  String currentColor = SettingsPage.red;
  bool enabled = false;
  bool blink = false;

  IOWebSocketChannel _channel;

  @override
  Widget build(BuildContext context) {
    return Consumer<UrlHolder>(builder: (context, value, child) {
      _channel = IOWebSocketChannel.connect(formUrl(value.url));

      return Scaffold(
        backgroundColor: HexColor.fromHex("#0E1011"),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: BackCustomUI(
            textValue: "Settings",
            actionWidget: Container(),
            onTap: () => context.read<PagesBloc>().add(PageEventHome()),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formState,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter IP';
                        }

                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: "Input server details",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.text = SettingsPage.urlDemo;
                          },
                          child: Text("Demo url".toUpperCase())),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          // color: HexColor.fromHex("#030303"),
                          // border: Border.all(color: HexColor.neoGray()),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      width: 150,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formState.currentState.validate()) {
                              Provider.of<UrlHolder>(context, listen: false)
                                  .setUrl(controller.text);
                            }
                          },
                          child: Text("Submit".toUpperCase())),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonRadio(
                              onTap: () {
                                setState(() {
                                  currentColor = SettingsPage.red;
                                });
                              },
                              isActive: currentColor == SettingsPage.red,
                              bracketColor: "#00FF00",
                              name: "Red".toUpperCase()),
                          ButtonRadio(
                              onTap: () {
                                setState(() {
                                  currentColor = SettingsPage.green;
                                });
                              },
                              isActive: currentColor == SettingsPage.green,
                              bracketColor: "#00FF00",
                              name: "Green".toUpperCase()),
                          ButtonRadio(
                              onTap: () {
                                setState(() {
                                  currentColor = SettingsPage.blue;
                                });
                              },
                              isActive: currentColor == SettingsPage.blue,
                              bracketColor: "#00FF00",
                              name: "Blue".toUpperCase()),
                        ]),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 64.h,
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor.neoGray()),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ON/OFF",
                                style: latoSemiBold.copyWith(
                                    color: HexColor.fromHex("#EDEFF0"),
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: NeoSwitch(
                                    isActive: enabled,
                                    onToggle: (isActive) {
                                      setState(() {
                                        enabled = !enabled;
                                      });

                                      _channel.sink.add(jsonEncode({
                                        "CMD": {
                                          "LED": {
                                            "COLOR": currentColor,
                                            "STATE": enabled ? "ON" : "OFF"
                                          }
                                        }
                                      }));
                                      print('togle');
                                    },
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 64.h,
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor.neoGray()),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "BLINK",
                                style: latoSemiBold.copyWith(
                                    color: HexColor.fromHex("#EDEFF0"),
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: NeoSwitch(
                                    isActive: blink,
                                    onToggle: (isActive) {
                                      setState(() {
                                        blink = !blink;
                                      });
                                      if (blink) {
                                        _channel.sink.add(jsonEncode({
                                          "CMD": {
                                            "LED": {
                                              "COLOR": currentColor,
                                              "STATE": "BLINK"
                                            }
                                          }
                                        }));
                                      } else {
                                        _channel.sink.add(jsonEncode({
                                          "CMD": {
                                            "LED": {
                                              "COLOR": currentColor,
                                              "STATE": "OFF"
                                            }
                                          }
                                        }));
                                      }
                                      print('togle');
                                    },
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
