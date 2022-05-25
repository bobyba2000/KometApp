import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/params_button/params_hdr_bloc.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/capture_button_model.dart';
import 'package:neo/src/ui/custom_widgets/hdr/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/hdr/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/hdr/row_bracket_step.dart';
import 'package:provider/provider.dart';

class FlashSettingsScroller extends StatefulWidget {
  final String url;
  final StepBracketValuesBloc stepBracketValuesBloc;

  const FlashSettingsScroller(
      {Key key, @required this.url, @required this.stepBracketValuesBloc})
      : super(key: key);
  @override
  _FlashSettingsScrollerState createState() => _FlashSettingsScrollerState();
}

class _FlashSettingsScrollerState extends State<FlashSettingsScroller>
    with TickerProviderStateMixin {
  StepBracketValuesBloc stepBracketValuesBloc;

  @override
  void initState() {
    stepBracketValuesBloc = StepBracketValuesBloc(flash: true);

    super.initState();
    CaptureButtonModel model =
        Provider.of<CaptureButtonModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      model.setStep = "±0.3";
      model.setBracket = "3";
      model.setShift = "0";
      model.setSequence = ["SHUTTERS", "SHUTTERS"];
    });

    stepBracketValuesBloc.currentBracket.listen((event) {
      model.setStep =
          stepBracketValuesBloc.stepsController.valueWrapper.value.toString();
      model.setBracket = event.toString();

      context.read<ParamsHdrBloc>().add(
          "  $event  ±${stepBracketValuesBloc.stepsController.valueWrapper.value}");
      stepBracketValuesBloc.currentStep.listen((event) {
        context.read<ParamsHdrBloc>().add(
            " ${stepBracketValuesBloc.bracketController.valueWrapper.value}  ±$event");
        CaptureButtonModel model =
            Provider.of<CaptureButtonModel>(context, listen: false);
        model.setBracket =
            "${stepBracketValuesBloc.bracketController.valueWrapper.value}";
        model.setStep = " $event";
      });
    });
  }

  @override
  dispose() {
    stepBracketValuesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveViewBloc, bool>(
      builder: (context, isLiveView) {
        return Container(
          margin: EdgeInsets.only(top: isLiveView ? 10.h : 0),
          width: double.infinity,
          decoration: decoration,
          child: Column(
            children: [
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "FLASH ENERGY",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex("#3E505B"), fontSize: 12),
                  ),
                  Text(
                    "FLASH ZOOM",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex("#3E505B"), fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              BlocProvider(
                create: (context) => HdrStepBloc(isStep: true),
                child: Column(
                  children: [
                    RowBracketStep(
                      stepBracketValuesBloc: stepBracketValuesBloc,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MinusButton(
                          stepBracketValuesBloc: stepBracketValuesBloc,
                        ),
                        PlusButton(
                          stepBracketValuesBloc: stepBracketValuesBloc,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
