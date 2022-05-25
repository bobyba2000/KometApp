import 'dart:async';

import 'package:neo/src/model/f_p_F.dart';
import 'package:rxdart/rxdart.dart';

class HourBloc {
  final _hour$ = BehaviorSubject<FPF>();
  final _controller = StreamController<FPF>();

  HourBloc() {
    setHour(FPF(value: 0, isSet: false));
    _controller.stream.listen((data) {
      _hour$.add(data);
    });
  }

  void setHour(FPF hour) {
    _controller.sink.add(hour);
  }

  void increment() {
    if (_hour$.value.value == null) _hour$.value.value = 0;
    if (_hour$.value.value < 24)
      _controller.sink.add(FPF(value: _hour$.value.value + 1, isSet: true));
  }

  void decrement() {
    if (_hour$.value.value == null) _hour$.value.value = 0;
    if (_hour$.value.value > 0)
      _controller.sink.add(FPF(value: _hour$.value.value - 1, isSet: true));
  }

  Stream<FPF> get stream$ => _hour$.stream;

  int get current => _hour$.value.value;

  void dispose() {
    _controller.close();
    _hour$.close();
  }
}
