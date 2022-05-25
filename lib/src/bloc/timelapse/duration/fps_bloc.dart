import 'dart:async';

import 'package:neo/src/model/f_p_F.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class FpsBloc {
  final _fps$ = BehaviorSubject<FPF>();
  final _incrementController = StreamController<FPF>();

  FpsBloc() {
    setFps(FPF(value: 24, isSet: false));
    _incrementController.stream.listen((data) {
      _fps$.add(data);
    });
  }

  void increment() {
    if (_fps$.value.value == 24) {
      _incrementController.sink.add(FPF(value: 30, isSet: true));
    }
  }

  void decrement() {
    if (_fps$.value.value == 30) {
      _incrementController.sink.add(FPF(value: 24, isSet: true));
    }
  }

  void setFps(FPF fps) {
    _incrementController.sink.add(fps);
  }

  Stream<FPF> get fps$ => _fps$.stream;

  FPF get current => _fps$.value;

  void dispose() {
    _incrementController.close();
    _fps$.close();
  }
}
