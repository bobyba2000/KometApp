import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/timelapse/interval/final_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/initial_interval_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/buttons/left_value_btn.dart';
import 'package:neo/src/ui/custom_widgets/buttons/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/right_value_btn.dart';

class HolyGrailIntervalTab extends StatefulWidget {
  final String url;

  const HolyGrailIntervalTab({Key key, this.url}) : super(key: key);
  @override
  _HolyGrailIntervalTabState createState() => _HolyGrailIntervalTabState();
}

class _HolyGrailIntervalTabState extends State<HolyGrailIntervalTab> {
  IntervalState intervalState = InitialState();
  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: EdgeInsets.only(top: isLiveView ? 10.h : 0),
      width: double.infinity,
      decoration: decoration,
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                intervalState.displayName,
                style: latoSemiBold.copyWith(
                    color: HexColor.fromHex("#3E505B"), fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<InitialIntervalBloc, String>(
                builder: (context, initialInterval) => LeftValueBtn(
                  value: initialInterval,
                  isActive: intervalState is InitialState,
                  onPressed: () {
                    setState(() {
                      intervalState = InitialState();
                    });
                  },
                ),
              ),
              BlocBuilder<FinalIntervalBloc, String>(
                builder: (context, finalInterval) => RightValueBtn(
                  isActive: intervalState is FinalState,
                  onPressed: () {
                    setState(() {
                      intervalState = FinalState();
                    });
                  },
                  value: finalInterval,
                ),
              )
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MinusButton(
                onTap: () {
                  if (intervalState is InitialState) {
                    context.read<InitialIntervalBloc>().decrement();
                  } else {
                    context.read<FinalIntervalBloc>().decrement();
                  }
                },
              ),
              PlusButton(
                onTap: () {
                  if (intervalState is InitialState) {
                    context.read<InitialIntervalBloc>().increment();
                  } else {
                    context.read<FinalIntervalBloc>().increment();
                  }
                },
              )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}

class IntervalState extends Equatable {
  final String displayName;

  IntervalState(this.displayName);
  @override
  List<Object> get props => [];
}

class InitialState extends IntervalState {
  InitialState() : super("INITIAL INTERVAL");
}

class FinalState extends IntervalState {
  FinalState() : super("FINAL INTERVAL");
}
