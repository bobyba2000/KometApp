import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class GrapHourBloc extends Bloc<String, String> {
  int hour = 0;
  GrapHourBloc() : super("0h");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }

  setHour(int hour) {
    this.hour = hour;
    add("${hour}h");
  }

  increment({@required int maxHour}) {
    if (hour < maxHour) {
      hour++;
      add("${hour}h");
    }
  }

  decrement() {
    if (hour > 0) {
      hour--;
      add("${hour}h");
    }
  }
}
