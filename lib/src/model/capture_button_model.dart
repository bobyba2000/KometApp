import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CaptureButtonModel extends ChangeNotifier {
  String bracket;
  String step;
  String shift;
  TimeDelay delay = TimeDelay(h: 0, m: 0, s: 0);
  int multishots = 0;

  List<String> sequence;

  set setBracket(String bracket) {
    this.bracket = bracket;
    notifyListeners();
  }

  set setDelay(TimeDelay delay) {
    this.delay = delay;
    notifyListeners();
  }

  set setMultishots(int multishots) {
    this.multishots = multishots;
    notifyListeners();
  }

  set setStep(String step) {
    this.step = step;
    notifyListeners();
  }

  set setShift(String shift) {
    this.shift = shift;
    notifyListeners();
  }

  set setSequence(List<String> sequence) {
    this.sequence = sequence;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'bracket': bracket,
      'step': step,
      'shift': shift,
      'sequence': sequence,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CaptureButtonModel(bracket: $bracket, step: $step, shift: $shift, sequence: $sequence)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CaptureButtonModel &&
        other.bracket == bracket &&
        other.step == step &&
        other.shift == shift &&
        listEquals(other.sequence, sequence);
  }

  @override
  int get hashCode {
    return bracket.hashCode ^
        step.hashCode ^
        shift.hashCode ^
        sequence.hashCode;
  }
}

class TimeDelay {
  int h;
  int m;
  int s;
  TimeDelay({this.h, this.m, this.s});

  Map<String, dynamic> toMap() {
    return {'H': h, 'M': m, 'S': s};
  }
}
