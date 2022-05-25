import 'dart:async';

import 'package:neo/src/model/f_p_F.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PlaytimeSecondsBloc {
  final _playtime$ = BehaviorSubject<FPF>();
  final _incrementController = StreamController<FPF>();

  PlaytimeSecondsBloc() {
    setPlaytime(FPF(value: 15, isSet: false));
    _incrementController.stream.listen((data) {
      _playtime$.add(data);
    });
  }

  void increment() {
    if (_playtime$.value.value < 59) {
      int f = _playtime$.value.value + 1;
      _incrementController.sink.add(FPF(value: f, isSet: true));
    }
  }

  void decrement() {
    if (_playtime$.value.value > 5) {
      int f = _playtime$.value.value - 1;
      _incrementController.sink.add(FPF(value: f, isSet: true));
    }
  }

  void setPlaytime(FPF playtime) {
    _incrementController.sink.add(playtime);
  }

  Stream<FPF> get playtime$ => _playtime$.stream;

  FPF get current => _playtime$.value;

  void dispose() {
    _incrementController.close();
    _playtime$.close();
  }
}
