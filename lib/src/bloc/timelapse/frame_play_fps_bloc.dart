import 'package:neo/src/bloc/timelapse/duration/hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/minute_bloc.dart';
import 'package:neo/src/model/f_p_F.dart';

import 'duration/fps_bloc.dart';
import 'duration/frame_bloc.dart';
import 'duration/playtime_seconds_bloc.dart';
import 'interval/basic_interval_bloc.dart';

class FramePlayFpsBloc {
  FpsBloc _fpsBloc;
  FrameBloc _frameBloc;
  PlaytimeSecondsBloc _playtimeBloc;
  HourBloc _hourBloc;
  MinuteBloc _minuteBloc;
  BasicIntervalBloc _basicIntervalBloc;

  FramePlayFpsBloc() {
    _fpsBloc = FpsBloc();
    _frameBloc = FrameBloc();
    _playtimeBloc = PlaytimeSecondsBloc();
    _hourBloc = HourBloc();
    _minuteBloc = MinuteBloc();
    _basicIntervalBloc = BasicIntervalBloc();

    _basicIntervalBloc.stream$.listen((event) {
      if (event.isSet) {
        // Interval x Frame =Duration
        // 5s x 360 = 1800 sec = 30 min
        int duration = event.value * _frameBloc.current.value;
        Duration time = Duration(seconds: duration);
        List<String> parts = time.toString().split(':');
        _hourBloc.setHour(FPF(value: int.parse(parts[0]), isSet: false));
        _minuteBloc.setMin(FPF(value: int.parse(parts[1]), isSet: false));
      }
    });

    _minuteBloc.stream$.listen((event) {
      if (event.isSet) {
        int secs = _hourBloc.current * 3600;
        secs = secs + (event.value * 60);
        int interval = (secs / _frameBloc.current.value).round();
        _basicIntervalBloc.setSec(FPF(value: interval, isSet: false));
      }
    });

    _hourBloc.stream$.listen((event) {
      if (event.isSet) {
        int secs = event.value * 3600;
        secs = secs + (_minuteBloc.current * 60);
        int interval = (secs / _frameBloc.current.value).round();
        _basicIntervalBloc.setSec(FPF(value: interval, isSet: false));
      }
    });

    _fpsBloc.fps$.listen((event) {
      print(
          "medy fps: ${event.toString()} - playtime : ${_playtimeBloc.toString()}");
      if (event.isSet) {
        _frameBloc.setFrame(FPF(
            value: (event.value * _playtimeBloc.current.value).round(),
            isSet: false));
      }
    });

    _playtimeBloc.playtime$.listen((FPF event) {
      if (event.isSet) {
        _frameBloc.setFrame(FPF(
            value: (event.value * _fpsBloc.current.value).round(),
            isSet: false));
      }
    });
    _frameBloc.frame$.listen((FPF event) {
      if (event.isSet) {
        _playtimeBloc.setPlaytime(FPF(
            value: (event.value / _fpsBloc.current.value).round(),
            isSet: false));

        int secs = _hourBloc.current * 3600;
        secs = secs + (_minuteBloc.current * 60);
        int interval = (secs / event.value).round();
        _basicIntervalBloc.setSec(FPF(value: interval, isSet: false));
      }
    });
  }

  FpsBloc get fpsBloc => _fpsBloc;
  FrameBloc get frameBloc => _frameBloc;
  PlaytimeSecondsBloc get playtimeBloc => _playtimeBloc;
  HourBloc get hourBloc => _hourBloc;
  MinuteBloc get minBloc => _minuteBloc;
  BasicIntervalBloc get intervalBloc => _basicIntervalBloc;
}
