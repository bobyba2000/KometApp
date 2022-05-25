import 'dart:async';

import 'package:neo/src/model/f_p_F.dart';
import 'package:rxdart/rxdart.dart';

class MinuteBloc {
  final _min$ = BehaviorSubject<FPF>();
  final _controller = StreamController<FPF>();

  MinuteBloc() {
    setMin(FPF(value: 30, isSet: false));
    _controller.stream.listen((data) {
      _min$.add(data);
    });
  }

  void setMin(FPF min) {
    _controller.sink.add(min);
  }

  void increment() {
    if (_min$.value.value == null) _min$.value.value = 0;
    if (_min$.value.value < 59)
      _controller.sink.add(FPF(value: _min$.value.value + 1, isSet: false));
  }

  void decrement() {
    if (_min$.value.value == null) _min$.value.value = 0;
    if (_min$.value.value > 0)
      _controller.sink.add(FPF(value: _min$.value.value - 1, isSet: false));
  }

  Stream<FPF> get stream$ => _min$.stream;

  int get current => _min$.value.value;

  void dispose() {
    _controller.close();
    _min$.close();
  }
}
