import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_min/bulb_min_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_tap_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_time_counter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_state.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_state.dart';
import 'package:neo/src/bloc/more_option/capture_button_pressed_bloc.dart';
import 'package:neo/src/bloc/more_option/more_option_visibility_bloc.dart';
import 'package:neo/src/bloc/more_option/seconds_reciever_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_state.dart';
import 'package:neo/src/model/capture_button_model.dart';
import 'package:neo/src/ui/custom_widgets/row_more_flickr_capture_raw_image/dotted_circular_progress.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class CaptureButton extends StatefulWidget {
  final String url;

  const CaptureButton({Key key, @required this.url}) : super(key: key);
  @override
  _CaptureButtonState createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton>
    with TickerProviderStateMixin {
  AnimationController controller;
  IOWebSocketChannel channel;
  bool isPressed = false;
  bool loading = false;
  TabState currentTabState;

  double percentage = 0;
  double incValue = 0;

  int multishots = 0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 750,
      ),
    )..addListener(() {
        if (controller.isCompleted) {
          setState(() {
            percentage = 0;
          });
        } else {
          setState(() {});
        }
      });
    controller.animateTo(1, duration: Duration(milliseconds: 1));

    channel = IOWebSocketChannel.connect(widget.url);
    channel.stream.listen((event) {
      // print("repsonse me $event");
      if (currentTabState is TabStateHDR) {
        try {
          Map<String, dynamic> map = jsonDecode(event);

          String rsp = map['RSP']['CAPTURE'];
          if (rsp == "OK") {
            setState(() {
              percentage = percentage + incValue;
            });
            print("percentage $percentage");

            controller.animateTo(percentage);
          }
        } catch (e) {
          print("error $e");
        }
      } else {
        try {
          Map<String, dynamic> map = jsonDecode(event);

          String rsp = map['RSP']['CAPTURE'];
          if (rsp == "OK") {
            if (rsp == "OK") {
              setState(() {
                percentage = percentage + incValue;
              });
              print("percentage $percentage");
              controller.animateTo(1);
            }
          }
        } catch (e) {
          print("error $e");
        }
      }

      try {
        print(event);
        Map json = jsonDecode(event);
        if (json["NTF"] != null) {
          if (json["NTF"]["BULB"] != null &&
              json["NTF"]["BULB"]["TIME"] != null) {
            dynamic hour = json["NTF"]["BULB"]["TIME"]["H"];
            hour = "$hour";
            dynamic min = json["NTF"]["BULB"]["TIME"]["M"];
            min = "$min";
            dynamic sec = json["NTF"]["BULB"]["TIME"]["S"];
            sec = "$sec";
            String time = "$hour : $min : $sec";
            context.read<BulbTimeCounterBloc>().add(time);

            context.read<SecondsRecieverBloc>().add(int.parse(sec));
          }
        }
        if (json["RSP"] != null &&
            json["RSP"]["BULB"] != null &&
            json["RSP"]["BULB"] == "OK") {
          context.read<CaptureButtonPressedBloc>().add(false);
          context.read<BulbTimeCounterBloc>().add("00 : 00 : 00");
          context.read<SecondsRecieverBloc>().add(60);
        }

        if (json['NTF'] != null) {
          if (json['NTF']['CAPTURE'] != null) {
            dynamic multishots = json['NTF']['CAPTURE']['MULTISHOTS'];
            int cur = int.parse(multishots);
            if (cur != this.multishots) {
              controller.reset();
              controller.animateTo(1);
              this.multishots = cur;
            }
          }
        }
      } catch (e) {
        print("error on websocket resp $e");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabBloc, TabState>(
      listener: (context, state) {
        if (!loading) {
          setState(() {
            currentTabState = state;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          if (currentTabState == null) return;
          if (loading) return;
          bool moreOptionOpen = context.read<MoreOptionVisibilityBloc>().state;
          print("currentTabState $currentTabState");

          if (currentTabState is TabStateHDR) {
            CaptureButtonModel model =
                Provider.of<CaptureButtonModel>(context, listen: false);
            controller.reset();

            double v = double.parse(model.shift);
            String shift = returnSHift(v);

            setState(() {
              incValue = 1 / model.sequence.length;
            });

            print("BRACKET ${model.bracket}");
            print("STEP ${model.step}");
            print("shift $shift");
            print("sequences ${model.sequence.toString()}");
            channel.sink.add(jsonEncode({
              "CMD": {
                "HDR": {
                  "BRACKET": model.bracket,
                  "STOP": "+-${model.step}",
                  "ADVANCED": {
                    "SEQUENCE": List<String>.from(model.sequence.map((x) => x)),
                    "SHIFT": "$shift"
                  }
                }
              }
            }));
          } else if (currentTabState is TabStateShutterSpeed) {
            print("more option and is hutter tab");

            ButtonModeState buttonModeState =
                context.read<ButtonModeBloc>().state;
            if (buttonModeState is ButtonModeStateBulb) {
              BulbTypeState bulbType = context.read<BulbTypeBloc>().state;
              if (bulbType is BulbTypeStateShot) {
                bool inSession = context.read<CaptureButtonPressedBloc>().state;
                if (inSession) {
                  channel.sink.add(jsonEncode({
                    "CMD": {"BULB": "CLOSE"}
                  }));
                  context.read<CaptureButtonPressedBloc>().add(false);
                } else {
                  context.read<CaptureButtonPressedBloc>().add(true);
                  int min = context.read<BulbMinBloc>().state;
                  int sec = context.read<BulbSecBloc>().state;
                  channel.sink.add(jsonEncode({
                    "CMD": {
                      "BULB": {
                        "TIME": {"H": 00, "M": min, "S": sec}
                      }
                    }
                  }));
                }
              } else if (bulbType is BulbTypeStateTap) {
                bool isTap = context.read<BulbTapBloc>().state;
                if (isTap) {
                  context.read<CaptureButtonPressedBloc>().add(false);
                  channel.sink.add(jsonEncode({
                    "CMD": {"BULB": "CLOSE"}
                  }));
                } else {
                  context.read<CaptureButtonPressedBloc>().add(true);
                  channel.sink.add(jsonEncode({
                    "CMD": {"BULB": "OPEN"}
                  }));
                }
                context.read<BulbTapBloc>().add(!isTap);
              }
            } else {
              controller.reset();
              setState(() {
                incValue = 1;
              });
              channel.sink.add(jsonEncode({
                "CMD": {"CAPTURE": "IMAGE"}
              }));
            }
          } else {
            controller.reset();
            setState(() {
              incValue = 1;
            });
            channel.sink.add(jsonEncode({
              "CMD": {"CAPTURE": "IMAGE"}
            }));
          }
        },
        onTapDown: (details) {
          setState(() {
            isPressed = true;
          });
          ButtonModeState buttonModeState =
              context.read<ButtonModeBloc>().state;
          if (buttonModeState is ButtonModeStateBulb) {
            BulbTypeState bulbType = context.read<BulbTypeBloc>().state;
            if (bulbType is BulbTypeStateHold) {
              context.read<CaptureButtonPressedBloc>().add(true);
              channel.sink.add(jsonEncode({
                "CMD": {"BULB": "OPEN"}
              }));
            }
          }
        },
        onTapUp: (details) {
          setState(() {
            isPressed = false;
          });
          ButtonModeState buttonModeState =
              context.read<ButtonModeBloc>().state;
          if (buttonModeState is ButtonModeStateBulb) {
            BulbTypeState bulbType = context.read<BulbTypeBloc>().state;
            if (bulbType is BulbTypeStateHold) {
              context.read<CaptureButtonPressedBloc>().add(false);
              channel.sink.add(jsonEncode({
                "CMD": {"BULB": "CLOSE"}
              }));
            }
          }
        },
        child: BlocBuilder<CaptureButtonPressedBloc, bool>(
          builder: (context, isCounter) {
            return Stack(
              children: [
                isCounter
                    ? Positioned.fill(child: DotedCirc())
                    : Positioned.fill(
                        child: CircularProgressIndicator(
                        value: controller.value,
                        semanticsLabel: 'Linear progress indicator',
                      )),
                Container(
                  margin: isCounter
                      ? EdgeInsets.all(4)
                      : EdgeInsets.all(isPressed ? 6 : 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(48))),
                  height: isPressed ? 64 : 64,
                  width: isPressed ? 64 : 64,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String returnSHift(double value) {
    String shift = '';
    if (value.isNegative) {
      shift = "$value";
    } else {
      if (value == 0.0) {
        shift = "0";
      } else {
        shift = "+$value";
      }
    }
    return shift;
  }
}
