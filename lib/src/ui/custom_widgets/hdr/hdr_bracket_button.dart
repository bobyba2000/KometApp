import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/hdr/row_bracket_step.dart';
import 'package:neo/src/ui/custom_widgets/usable_widgets/underliner.dart';

class HdrBracket extends StatelessWidget {
  final StepBracketValuesBloc stepBracketValuesBloc;

  const HdrBracket({Key key, @required this.stepBracketValuesBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HdrStepBloc, bool>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            context.read<HdrStepBloc>().add(false);
          },
          child: StreamBuilder<String>(
            stream: stepBracketValuesBloc.currentBracket,
            builder: (context, stateBracket) {
              return Column(
                children: [
                  Text(
                    stateBracket.hasData ? "${stateBracket.data}" : "",
                    textAlign: TextAlign.center,
                    style: latoSemiBold.copyWith(
                      color: !state
                          ? HexColor.fromHex("#EDEFF0")
                          : HexColor.fromHex("#959FA5"),
                      fontSize: 20.sp,
                    ),
                  ),
                  UnderlineWidget(
                    isActive: !state,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
