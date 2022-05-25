import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_bloc.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_event.dart';
import 'package:provider/provider.dart';

import 'row_bracket_step.dart';

class MinusButton extends StatefulWidget {
  final StepBracketValuesBloc stepBracketValuesBloc;

  const MinusButton({Key key, @required this.stepBracketValuesBloc})
      : super(key: key);
  @override
  _MinusButtonState createState() => _MinusButtonState();
}

class _MinusButtonState extends State<MinusButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HdrStepBloc, bool>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state) {
              widget.stepBracketValuesBloc.decrementStep();
            } else {
              widget.stepBracketValuesBloc.decrementBracket();
            }
          },
          onTapDown: (details) {
            setState(() {
              isPressed = true;
            });
          },
          onTapUp: (details) {
            setState(() {
              isPressed = false;
            });
          },
          child: SvgPicture.asset(
            isPressed
                ? "assets/icons/Button_Minus_Pressed.svg"
                : "assets/icons/Button_Minus_Idle.svg",
            width: 128.w,
            height: 28.h,
          ),
        );
      },
    );
  }
}
