import 'dart:async';
import 'dart:convert';

import 'package:neo/src/bloc/camera_controls/camera_controls_event.dart';
import 'package:neo/src/bloc/camera_controls/camera_controls_state.dart';
import 'package:neo/src/model/f_s_t_o_p.dart';
import 'package:neo/src/model/i_s_o.dart';
import 'package:neo/src/model/parent_model.dart';
import 'package:neo/src/model/shutter_speed.dart';
import 'package:web_socket_channel/io.dart';

final String localWebsocketurlNEO = 'ws://192.168.1.107:8080';

class ServerRequests {
  StreamController<CameraControlState> _streamController =
      StreamController<CameraControlState>.broadcast();

  //String url = 'ws://192.168.43.14:8080';
  //

  IOWebSocketChannel channel = IOWebSocketChannel.connect(localWebsocketurlNEO,
      pingInterval: Duration(seconds: 1));

  void connectToServer() {
    channel = IOWebSocketChannel.connect(localWebsocketurlNEO,
        pingInterval: Duration(seconds: 1));
  }

  Future<CameraControlState> getScrollerList(CameraControllsEvent event) async {
    print("getScrollerList $event");
    try {
      if (event is CameraControllsEventFetchShutterSpeed) {
        channel.sink.add(jsonEncode({"CONTROL_SHUTTERSPEED": "?"}));
      }
      if (event is CameraControllsEventFetchISO) {
        channel.sink.add(jsonEncode({
          "CMD": {"CONTROL_ISO": "?"}
        }));
      }
      if (event is CameraControllsEventFetchFstop) {
        channel.sink.add(jsonEncode({
          "CMD": {"CONTROL_FSTOP": "?"}
        }));
      }
      //Stream<dynamic> stream = channel.stream.asBroadcastStream();
      channel.stream.listen((onData) {
        print("onData $onData");

        try {
          ParentModel shutterSpeed;
          if (event is CameraControllsEventFetchShutterSpeed) {
            shutterSpeed = ShutterSpeed.fromJson(jsonDecode(onData));
          }
          if (event is CameraControllsEventFetchISO) {
            channel.sink.add(jsonEncode({
              "CMD": {"CONTROL_ISO": "?"}
            }));

            shutterSpeed = ISORESPONSE.fromJson(jsonDecode(onData));
          }

          if (event is CameraControllsEventFetchFstop) {
            channel.sink.add(jsonEncode({
              "CMD": {"CONTROL_FSTOP": "?"}
            }));

            shutterSpeed = FSTOPRESPONSE.fromJson(jsonDecode(onData));
          }

          _streamController.sink.add(CameraControlStateSuccess(
              shutterSpeed.list, shutterSpeed.current));
        } catch (e) {
          print("erro $e");
          String error = "$e";
          if (error.contains("'Uint8List' is not a subtype of type 'String'")) {
            error = "No response data";
          }

          _streamController.sink.add(CameraControlStateError("$error"));
        }
      }, onError: (e) {
        String error = "$e";

        if (error.contains("Connection timed out")) {
          error = "Connection timed out";
        }
        if (error.contains("Connection refused")) {
          error = "Connection refused";
        }

        print("onError $e");

        _streamController.sink.add(CameraControlStateError("$error"));
      }, onDone: () {
        print("onDone ${channel.closeCode} ");
        print("onDone ${channel.closeReason} ");
        _streamController.sink
            .add(CameraControlStateError("Connection closed"));
      });
    } catch (e) {
      _streamController.sink.add(CameraControlStateError("$e"));
    }

    await for (CameraControlState item in _streamController.stream) {
      return item;
    }
  }

  Future closeStreams() async {
    await _streamController.close();
    await channel.sink.close();
  }
}
