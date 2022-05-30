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
import 'package:neo/src/bloc/params_button/params_fstop_bloc.dart';
import 'package:neo/src/bloc/params_button/params_iso_bloc.dart';
import 'package:neo/src/bloc/params_button/params_shutter_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_state.dart';
import 'package:neo/src/model/capture_button_model.dart';
import 'package:neo/src/ui/custom_widgets/hdr/collapse_button.dart';
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

  double count = 0;

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
            // percentage = 0;
          });
        } else {
          setState(() {});
        }
      });
    controller.animateTo(1, duration: Duration(milliseconds: 1));

    channel = IOWebSocketChannel.connect(widget.url);
    channel.stream.listen((event) {
      print("repsonse me $event");
      if (currentTabState is TabStateHDR) {
        try {
          Map<String, dynamic> map = jsonDecode(event);

          String rsp = map['RSP']['CAPTURE'];
          if (rsp == "OK") {
            // controller.animateTo(1);
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
              // controller.animateTo(1);
            }
          }
        } catch (e) {
          print("error $e");
        }
      }

      try {
        Map json = jsonDecode(event);
        if (json["NTF"] != null) {
          if (json["NTF"]["CAPTURE"] != null &&
              json["NTF"]["CAPTURE"]["DURATION"] != null) {
            setState(() {
              count++;
            });
            int hour = json["NTF"]["CAPTURE"]["DURATION"]["H"] as int;
            hour = hour.abs();
            int min = json["NTF"]["CAPTURE"]["DURATION"]["M"] as int;
            min = min.abs();
            int sec = json["NTF"]["CAPTURE"]["DURATION"]["S"] as int;
            sec = sec.abs();

            if (hour == 0 && min == 0 && sec == 1) {
              context.read<CaptureButtonPressedBloc>().add(false);
              context.read<BulbTimeCounterBloc>().add("00 : 00 : 00");
              context.read<SecondsRecieverBloc>().add(0);
            } else {
              hour = (count ~/ 3600).round();
              min = ((count % 3600) ~/ 60).round();
              sec = ((count % 3600) % 60).round();
              String sString = sec < 10 ? '0$sec' : '$sec';
              String mString = min < 10 ? '0$min' : '$min';
              String hString = hour < 10 ? '0$hour' : '$hour';
              String time = "$hString : $mString : $sString";
              context.read<BulbTimeCounterBloc>().add(time);
              context.read<SecondsRecieverBloc>().add(sec);
            }
          }
        }
        if (json["RSP"] != null &&
            json["RSP"]["BULB"] != null &&
            json["RSP"]["BULB"] == "OK") {
          context.read<CaptureButtonPressedBloc>().add(false);
          context.read<BulbTimeCounterBloc>().add("00 : 00 : 00");
          context.read<SecondsRecieverBloc>().add(0);
        }
        if (currentTabState is TabStateHDR) {
          print(event);
          if (json['NTF'] != null) {
            if (json['NTF']['CAPTURE'] != null) {
              if (json['NTF']['CAPTURE']['HDR'] != null) {
                controller.animateTo(percentage + incValue);
                setState(() {
                  percentage = percentage + incValue;
                  print(percentage);
                });
              }
            }
            if (json['NTF']['CONTROL_SHUTTERSPEED'] != null) {
              print('shutterspeed');
              String shutterspeed = json['NTF']['CONTROL_SHUTTERSPEED'];
              context.read<ParamsShutterBloc>().add('$shutterspeed');
            }
            if (json['NTF']['CONTROL_FSTOP'] != null) {
              print('fstop');
              String fstop = json['NTF']['CONTROL_FSTOP'];
              context.read<ParamsFstopBloc>().add('$fstop');
            }
            if (json['NTF']['CONTROL_ISO'] != null) {
              print('iso');
              String iso = json['NTF']['CONTROL_ISO'];
              context.read<ParamsIsoBloc>().add('$iso');
            }
          }
        } else {
          if (json['NTF'] != null) {
            if (json['NTF']['CAPTURE'] != null &&
                json['NTF']['CAPTURE']['DELAY'] != null) {
              if (json['NTF']['CAPTURE']['DELAY']['H'] == 0 &&
                  json['NTF']['CAPTURE']['DELAY']['M'] == 0 &&
                  json['NTF']['CAPTURE']['DELAY']['S'] == 0) {
                controller.reset();
                controller.animateTo(1);
              }
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
          setState(() {
            percentage = 0;
            count = 0;
          });
          bool moreOptionOpen = context.read<MoreOptionVisibilityBloc>().state;
          print("currentTabState $currentTabState");

          if (currentTabState is TabStateHDR) {
            CaptureButtonModel model =
                Provider.of<CaptureButtonModel>(context, listen: false);
            controller.reset();

            double v = double.parse(model.shift);
            String shift = returnSHift(v);

            List<String> sequence = List.from(model.sequence);
            setState(() {
              incValue = 1 / int.tryParse(model.bracket);
              percentage = 0;
            });
            sequence.insert((sequence.length / 2).ceil(), 'BASE');

            print("BRACKET ${model.bracket}");
            print("STEP ${model.step}");
            print("shift $v");
            print("sequences ${model.sequence.toString()}");
            bool isExpanded = !context.read<ExpandedBloc>().state;
            if (isExpanded) {
              channel.sink.add(
                jsonEncode(
                  {
                    "CMD": {
                      "CAPTURE": {
                        // "DELAY": model.delay.toMap(),
                        // "MULTISHOTS": model.multishots,
                        "HDR": {
                          "BRACKET": int.tryParse(model.bracket) ?? 0,
                          "STEP": double.tryParse(model.step.substring(1)) ?? 0,
                          "ORDER": "-0+"
                        },
                      }
                    }
                  },
                ),
              );
            } else {
              channel.sink.add(
                jsonEncode(
                  {
                    "CMD": {
                      "CAPTURE": {
                        // "DELAY": model.delay.toMap(),
                        // "MULTISHOTS": model.multishots,
                        "HDR": {
                          "BRACKET": int.tryParse(model.bracket) ?? 0,
                          "STEP": double.tryParse(model.step.substring(1)) ?? 0,
                          "SEQUENCE": List<String>.from(sequence.map((x) => x)),
                          "SHIFT": double.parse(model.shift),
                          "ORDER": "-0+",
                        },
                      }
                    }
                  },
                ),
              );
            }

            channel.sink.add(
              jsonEncode(
                {
                  "CMD": {"CAPTURE": "HDR"}
                },
              ),
            );
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

                  channel.sink.add(
                    jsonEncode(
                      {
                        "CMD": {
                          "CAPTURE": {
                            "DURATION": {"H": 0, "M": min, "S": sec}
                          }
                        }
                      },
                    ),
                  );
                  channel.sink.add(
                    jsonEncode(
                      {
                        "CMD": {"CAPTURE": "BULB"}
                      },
                    ),
                  );
                }
              } else if (bulbType is BulbTypeStateTap) {
                bool isTap = context.read<BulbTapBloc>().state;
                if (isTap) {
                  context.read<CaptureButtonPressedBloc>().add(false);
                  channel.sink.add(jsonEncode({
                    "CMD": {"CAPTURE": "BREAK"}
                  }));
                } else {
                  context.read<CaptureButtonPressedBloc>().add(true);
                  channel.sink.add(jsonEncode({
                    "CMD": {"CAPTURE": "BULB"}
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
                "CMD": {"CAPTURE": "BULB"}
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
                "CMD": {"CAPTURE": "BREAK"}
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
                      ? EdgeInsets.all(8)
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
