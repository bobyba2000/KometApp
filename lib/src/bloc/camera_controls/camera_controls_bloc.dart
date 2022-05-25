import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/res/server_helpers/server_requests.dart';
import 'package:neo/src/bloc/camera_controls/camera_controls_state.dart';

import 'camera_controls_event.dart';

class CameraControllsBloc
    extends Bloc<CameraControllsEvent, CameraControlState> {
  ServerRequests _requests = ServerRequests();

  CameraControllsBloc() : super(CameraControlStateInitial());

  @override
  Future<void> close() {
    //  _requests.closeStreams();
    return super.close();
  }

  @override
  Stream<CameraControlState> mapEventToState(
      CameraControllsEvent event) async* {
    print("mapEventToState $event ");
    try {
      if (event is CameraControllsEventFetch) {
        yield CameraControlStateLoading();
        CameraControlState list = await _requests.getScrollerList(event);
        yield list;
      }

      // if (event is CameraControllsEventFetchISO) {
      //   yield CameraControlStateLoading();

      //   Stream<CameraControlState> list = _requests.getScrollerList(event);
      //   await for (CameraControlState item in list) {
      //     yield item;
      //   }
      // }

      // if (event is CameraControllsEventFetchFstop) {
      //   yield CameraControlStateLoading();

      //   Stream<CameraControlState> list = _requests.getScrollerList(event);
      //   await for (CameraControlState item in list) {
      //     yield item;
      //   }
      // }

      // if (event is CameraControllsEventISOValueChanged) {
      //   _requests.channel.sink.add(jsonEncode({
      //     "CMD": {"ISO": event.value}
      //   }));
      // }
      // if (event is CameraControllsEventFSTOPValueChanged) {
      //   _requests.channel.sink.add(jsonEncode({
      //     "CMD": {"FSTOP": event.value}
      //   }));
      // }
      // if (event is CameraControllsEventSHUTTERSPEEDValueChanged) {
      //   print("called sutters");
      //   _requests.channel.sink.add(jsonEncode({
      //     "CMD": {"SHUTTERSPEED": event.value}
      //   }));
      // }
      //   if (event is CameraControllsEventReconnectServer) {
      //     yield CameraControlStateLoading();
      //     _requests.connectToServer();
      //   }
    } catch (e) {
      yield CameraControlStateError("$e");
    }
  }
}
