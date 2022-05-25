import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CaptureButtonModel extends ChangeNotifier {
  String bracket;
  String step;
  String shift;
  List<String> sequence;

  set setBracket(String bracket) {
    this.bracket = bracket;
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
