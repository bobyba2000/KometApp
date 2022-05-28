import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neo/src/bloc/params_button/params_fstop_bloc.dart';
import 'package:neo/src/bloc/params_button/params_iso_bloc.dart';
import 'package:neo/src/bloc/params_button/params_shutter_bloc.dart';
import 'package:neo/src/bloc/params_button/params_wb_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/final_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/initial_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/final_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/initial_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/final_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/initial_shutter_sp_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/model/f_s_t_o_p.dart';
import 'package:neo/src/model/i_s_o.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/model/shutter_speed.dart';
import 'package:neo/src/model/url_holder.dart';
import 'package:neo/src/model/white_balance.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
import 'package:neo/src/utils/wb_choice_string.dart';

class NeoWebsocket {
  IOWebSocketChannel channel;

  fetchFstop(BuildContext context) {
    String url = context.read<UrlHolder>().url;
    channel = IOWebSocketChannel.connect(formUrl(url));
    StreamSubscription streamController;
    final Map<dynamic, dynamic> map = {
      "CMD": {"CONTROL_FSTOP": "?"}
    };

    channel.sink.add(jsonEncode(map));
    streamController = channel.stream.listen((event) {
      try {
        Map json = jsonDecode(event);
        if (json["RSP"] != null) {
          if (json["RSP"]["CONTROL_FSTOP"] != null) {
            if (json["RSP"]["CONTROL_FSTOP"] == "OK") {
              //  context.read<ParamsFstopBloc>().add(curentvalue);
            } else {
              if (json["RSP"]["CONTROL_FSTOP"]["CHOICE"] != null) {
                FSTOPRESPONSE fstop = FSTOPRESPONSE.fromJson(jsonDecode(event));

                context.read<ParamsFstopBloc>().add(fstop.current);
                streamController.cancel();
                int curItem = fstop.list.indexOf(fstop.current);
                String valueI = fstop.list[curItem];
                context
                    .read<FinalFstopBloc>()
                    .add(HSelectedItem(index: curItem, value: valueI));
                context
                    .read<InitialFstopBloc>()
                    .add(HSelectedItem(index: curItem, value: valueI));
              }
            }
          }
        }
      } catch (e) {
        print("error on fetch Fstop $e");
      }
    }, onDone: () {
      print("done Fstop ");
      streamController.cancel();
    }, onError: (e) {
      print("error Fstop $e ");
      streamController.cancel();
    });
  }

  fetchShutter(BuildContext context) {
    String url = context.read<UrlHolder>().url;
    channel = IOWebSocketChannel.connect(formUrl(url));
    StreamSubscription streamController;
    final Map<dynamic, dynamic> map = {
      "CMD": {"CONTROL_SHUTTERSPEED": "?"}
    };

    channel.sink.add(jsonEncode(map));
    streamController = channel.stream.listen((event) {
      try {
        Map result = jsonDecode(event);
        if (result["RSP"] != null &&
            result["RSP"]["CONTROL_SHUTTERSPEED"] != null) {
          if (result["RSP"]["CONTROL_SHUTTERSPEED"]["CHOICE"] != null) {
            ShutterSpeed shutterSpeed =
                ShutterSpeed.fromJson(jsonDecode(event));

            context.read<ParamsShutterBloc>().add("${shutterSpeed.current}");
            int curItem = shutterSpeed.list.indexOf(shutterSpeed.current);
            try {
              String valueI = shutterSpeed.list[curItem];
              context
                  .read<InitialShutterSpBloc>()
                  .add(HSelectedItem(index: curItem, value: valueI));
              context
                  .read<FinalShutterSpBloc>()
                  .add(HSelectedItem(index: curItem, value: valueI));
            } catch (e) {
              String valueI = shutterSpeed.list[curItem];
              context
                  .read<InitialShutterSpBloc>()
                  .add(HSelectedItem(index: curItem, value: valueI));
              context
                  .read<FinalShutterSpBloc>()
                  .add(HSelectedItem(index: curItem, value: valueI));
            }
          } else if (result["RSP"]["CONTROL_SHUTTERSPEED"] == "OK") {
            //  context.read<ParamsShutterBloc>().add("${curentvalue}s");
          }
        }
      } catch (e) {
        print("error on fetch Shutter $e");
      }
    }, onDone: () {
      print("done Shutter ");
      streamController.cancel();
    }, onError: (e) {
      print("error Shutter $e ");
      streamController.cancel();
    });
  }

  fetchIso(BuildContext context) {
    String url = context.read<UrlHolder>().url;
    channel = IOWebSocketChannel.connect(formUrl(url));
    StreamSubscription streamController;
    final Map<dynamic, dynamic> map = {
      "CMD": {"CONTROL_ISO": "?"}
    };

    channel.sink.add(jsonEncode(map));
    streamController = channel.stream.listen((event) {
      try {
        Map json = jsonDecode(event);
        if (json["RSP"] != null) {
          if (json["RSP"]["CONTROL_ISO"] != null) {
            if (json["RSP"]["CONTROL_ISO"] == "OK") {
              // context.read<ParamsIsoBloc>().add(curentvalue);
            } else if (json["RSP"]["CONTROL_ISO"]["CHOICE"] != null) {
              ISORESPONSE fstop = ISORESPONSE.fromJson(jsonDecode(event));
              context.read<ParamsIsoBloc>().add(fstop.current);
              int curItem = fstop.list.indexOf(fstop.current);
              String valueI = fstop.list[curItem];
              context
                  .read<FinalIsoBloc>()
                  .add(HSelectedItem(index: curItem, value: valueI));
              context
                  .read<InitialIsoBloc>()
                  .add(HSelectedItem(index: curItem, value: valueI));
            }
          }
        }
      } catch (e) {
        print("error on fetch ISO $e");
      }
    }, onDone: () {
      print("done ISO ");
      streamController.cancel();
    }, onError: (e) {
      print("error ISO $e ");
      streamController.cancel();
    });
  }

  fetchWb(BuildContext context) {
    String url = context.read<UrlHolder>().url;
    channel = IOWebSocketChannel.connect(formUrl(url));
    StreamSubscription streamController;
    final Map<dynamic, dynamic> map = {
      "CMD": {"CONTROL_WHITEBALANCE": "?"}
    };

    channel.sink.add(jsonEncode(map));
    streamController = channel.stream.listen((event) {
      try {
        Map json = jsonDecode(event);
        if (json["RSP"] != null) {
          if (json["RSP"]["CONTROL_WHITEBALANCE"] != null) {
            if (json["RSP"]["CONTROL_WHITEBALANCE"] == "OK") {
              //  context.read<ParamsWbBloc>().add(curentvalue.abreviation());
            } else {
              if (json["RSP"]["CONTROL_WHITEBALANCE"]["CHOICE"] != null) {
                WhiteBalance whiteBalance =
                    WhiteBalance.fromJson(jsonDecode(event));
                context
                    .read<ParamsWbBloc>()
                    .add(whiteBalance.current.abreviation());
                //  curentvalue = whiteBalance.current;
              }
            }
          }
        }
      } catch (e) {
        print("error on fetch WHITEBALANCE $e");
      }
    }, onDone: () {
      print("done WHITEBALANCE ");
      streamController.cancel();
    }, onError: (e) {
      print("error WHITEBALANCE $e ");
      streamController.cancel();
    });
  }
}
