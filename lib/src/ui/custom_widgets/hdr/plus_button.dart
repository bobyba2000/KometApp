import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_bloc.dart';
import 'package:neo/src/ui/custom_widgets/hdr/row_bracket_step.dart';

class PlusButton extends StatefulWidget {
  final StepBracketValuesBloc stepBracketValuesBloc;

  const PlusButton({Key key, @required this.stepBracketValuesBloc})
      : super(key: key);
  @override
  _PlusButtonState createState() => _PlusButtonState();
}

class _PlusButtonState extends State<PlusButton> {
  bool isPressed = false;

  validate({@required double step, @required int bracket}) {
    // if (step > 9) {
    //   throw ("step is out of bound, max is 9");
    // }

    // if (step > 3.7 && bracket == 5) {
    //   throw ("step is out of bound");
    // }
    // if (step > 2 && bracket == 7) {
    //   throw ("step is out of bound");
    // }
    // if (step > 2 && bracket == 9) {
    //   throw ("step is out of bound");
    // }
    // if (step > 1.7 && bracket == 11) {
    //   throw ("step is out of bound");
    // }
    // if (step > 1.3 && bracket == 13) {
    //   throw ("step is out of bound");
    // }
    // if (step > 1 && bracket == 15) {
    //   throw ("step is out of bound");
    // }
    // if (step > 1 && bracket == 17) {
    //   throw ("step is out of bound");
    // }
    // if (step > 1 && bracket == 19) {
    //   throw ("step is out of bound");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HdrStepBloc, bool>(
      builder: (context, state) {
        return StreamBuilder<StepBracket>(
          stream: widget.stepBracketValuesBloc.currentStepBracket,
          builder: (context, snapshot) {
            bool error = false;
            try {
              // validate(
              //     step: snapshot.data.step, bracket: snapshot.data.bracket);
            } catch (e) {
              error = true;
            }
            return GestureDetector(
              onTap: () {
                if (!error) if (state) {
                  widget.stepBracketValuesBloc.incrementStep();
                } else {
                  widget.stepBracketValuesBloc.incrementBracket();
                }
              },
              onTapDown: (details) {
                if (!error)
                  setState(() {
                    isPressed = true;
                  });
              },
              onTapUp: (details) {
                if (!error)
                  setState(() {
                    isPressed = false;
                  });
              },
              child: SvgPicture.asset(
                isPressed && !error
                    ? "assets/icons/Button_Plus_Pressed.svg"
                    : "assets/icons/Button_Plus_Idle.svg",
                width: 128.w,
                height: 28.h,
              ),
            );
          },
        );
      },
    );
  }
}
