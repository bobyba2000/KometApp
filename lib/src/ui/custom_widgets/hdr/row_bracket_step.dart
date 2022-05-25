import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_bloc.dart';

import 'hdr_bracket_button.dart';
import 'hdr_step_button.dart';

class RowBracketStep extends StatelessWidget {
  final StepBracketValuesBloc stepBracketValuesBloc;

  const RowBracketStep({Key key, @required this.stepBracketValuesBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        HdrBracket(
          stepBracketValuesBloc: stepBracketValuesBloc,
        ),
        HdrStepButton(
          stepBracketValuesBloc: stepBracketValuesBloc,
        )
      ],
    );
  }
}

class HdrStepBloc extends Bloc<bool, bool> {
  HdrStepBloc({@required bool isStep}) : super(isStep);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
