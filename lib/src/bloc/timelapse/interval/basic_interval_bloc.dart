import 'dart:async';

import 'package:neo/src/model/f_p_F.dart';
import 'package:rxdart/rxdart.dart';

class BasicIntervalBloc {
  final _sec$ = BehaviorSubject<FPF>();
  final _controller = StreamController<FPF>();

  BasicIntervalBloc() {
    setSec(FPF(value: 5, isSet: false));
    _controller.stream.listen((data) {
      _sec$.add(data);
    });
  }

  void setSec(FPF min) {
    _controller.sink.add(min);
  }

  void increment() {
    if (_sec$.value.value < 59)
      _controller.sink.add(FPF(value: _sec$.value.value + 1, isSet: true));
  }

  void decrement() {
    if (_sec$.value.value > 0)
      _controller.sink.add(FPF(value: _sec$.value.value - 1, isSet: true));
  }

  Stream<FPF> get stream$ => _sec$.stream;

  int get current => _sec$.value.value;

  void dispose() {
    _controller.close();
    _sec$.close();
  }
}
