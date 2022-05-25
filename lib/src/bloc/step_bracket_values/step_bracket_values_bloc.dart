import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class StepBracketValuesBloc {
  int _curValue = 0;
  int _curValueBracket = 0;
  bool flash = false;
  List<String> steps = [
    "0.3",
    "0.7",
    "1",
    "1.3",
    "1.7",
    "2",
    "2.3",
    "2.7",
    "3",
    "3.3",
    "3.7",
    "4",
    "4.3",
    "4.7",
    "5",
    "5.7",
    "6",
    "6.3",
    "6.7",
    "7",
    "7.3",
    "7.7",
    "8",
    "8.3",
    "8.7",
    "9"
  ];

  List<String> brackets = ["3", "5", "7", "9", "11", "13", "15", "17", "19"];

  BehaviorSubject<String> stepsController;
  BehaviorSubject<String> bracketController;
  BehaviorSubject<StepBracket> stepBracketController;
  BehaviorSubject<bool> changesController;

  StepBracketValuesBloc({bool flash = false}) {
    this.flash = flash;

    // TODO TEMPORARY reformat this to generic component.
    if (this.flash) {
      steps = [
        "24mm",
        "28mm",
        "35mm",
        "50mm",
        "70mm",
        "80mm",
        "105mm",
      ];

      brackets = [
        "1/64",
        "1/64 +0.3",
        "1/64 +0.7",
        "1/32",
        "1/32 +0.3",
        "1/32 +0.7",
        "1/16",
        "1/16 +0.3",
        "1/16 +0.7",
        "1/8",
        "1/8 +0.3",
        "1/8 +0.7",
        "1/4",
        "1/4 +0.3",
        "1/4 +0.7",
        "1/2",
        "1/2 +0.3",
        "1/2 +0.7",
        "1/1",
      ];
    }
    stepBracketController = BehaviorSubject<StepBracket>();
    stepsController = BehaviorSubject<String>();
    bracketController = BehaviorSubject<String>();
    changesController = BehaviorSubject<bool>();
    bracketController.sink.add(brackets[_curValueBracket]);
    stepsController.sink.add(steps[_curValue]);

    stepBracketController.sink.add(StepBracket(
        bracket: brackets[_curValueBracket], step: steps[_curValue]));
  }

  Stream<String> get currentStep => stepsController.stream;
  Stream<String> get currentBracket => bracketController.stream;
  Stream<StepBracket> get currentStepBracket => stepBracketController.stream;
  Stream<bool> get currentChange => changesController.stream;

  incrementStep() {
    try {
      if (_curValue < steps.length - 1) {
        _curValue++;
      }

      String value = steps[_curValue];
      stepsController.sink.add(value);
      stepBracketController.sink.add(StepBracket(
          bracket: brackets[_curValueBracket], step: steps[_curValue]));
      changesController.sink.add(true);
    } catch (e) {
      print(e);
    }
  }

  decrementStep() {
    try {
      if (_curValue > 0) _curValue--;
      String value = steps[_curValue];
      stepsController.sink.add(value);
      stepBracketController.sink.add(StepBracket(
          bracket: brackets[_curValueBracket], step: steps[_curValue]));
      changesController.sink.add(true);
    } catch (e) {
      print(e);
    }
  }

  incrementBracket() {
    try {
      if (_curValueBracket < brackets.length - 1) {
        _curValueBracket++;
      }
      print("_curValue $_curValue");
      String value = brackets[_curValueBracket];
      bracketController.sink.add(value);
      stepBracketController.sink.add(StepBracket(
          bracket: brackets[_curValueBracket], step: steps[_curValue]));
      changesController.sink.add(true);
    } catch (e) {
      print(e);
    }
  }

  decrementBracket() {
    try {
      if (_curValueBracket != 0) {
        _curValueBracket--;
      }
      print("_curValue $_curValue");
      String value = brackets[_curValueBracket];
      bracketController.sink.add(value);
      stepBracketController.sink.add(StepBracket(
          bracket: brackets[_curValueBracket], step: steps[_curValue]));
      changesController.sink.add(true);
    } catch (e) {
      print(e);
    }
  }

  close() {
    stepsController.close();
    bracketController.close();
    stepBracketController.close();
    changesController.close();
  }
}

class StepBracket {
  String step;
  String bracket;
  StepBracket({
    @required this.step,
    @required this.bracket,
  });
}
