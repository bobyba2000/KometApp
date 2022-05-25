import 'dart:async';

import 'package:neo/src/model/f_p_F.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class FrameBloc {
  final _frame$ = BehaviorSubject<FPF>();
  final _incrementController = StreamController<FPF>();

  FrameBloc() {
    setFrame(FPF(value: 360, isSet: false));
    _incrementController.stream.listen((FPF data) {
      print("added stream ${data.toString()}");
      _frame$.add(data);
    });
  }

  void increment() {
    if (_frame$.value.value < 999) {
      int f = _frame$.value.value + 1;
      print("increment $f");
      _incrementController.sink.add(FPF(value: f, isSet: true));
    }
  }

  void decrement() {
    if (_frame$.value.value > 120) {
      int f = _frame$.value.value - 1;
      _incrementController.sink.add(FPF(value: f, isSet: true));
    }
  }

  void setFrame(FPF frame) {
    _incrementController.sink.add(frame);
  }

  Stream<FPF> get frame$ => _frame$.stream;
  FPF get current => _frame$.value;

  void dispose() {
    _incrementController.close();
    _frame$.close();
  }
}
