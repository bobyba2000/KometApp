import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphMinuteBloc extends Bloc<String, String> {
  int min = 0;
  GraphMinuteBloc() : super("0m");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }

  setMin(int min) {
    this.min = min;
    add("${min}m");
  }

  increment({@required int maxMin}) {
    if (maxMin > min) {
      min++;
      add("${min}m");
    }
  }

  decrement() {
    if (min > 0) {
      min--;
      add("${min}m");
    }
  }
}
