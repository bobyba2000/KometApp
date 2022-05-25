import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/final_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/midle_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/buttons/left_value_btn.dart';
import 'package:neo/src/ui/custom_widgets/buttons/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/right_value_btn.dart';

import 'holy_grail_duration/hour_min_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntervalKeyframeDurationTab extends StatefulWidget {
  @override
  _IntervalKeyframeDurationTabState createState() =>
      _IntervalKeyframeDurationTabState();
}

class _IntervalKeyframeDurationTabState
    extends State<IntervalKeyframeDurationTab> {
  HourMinState hourMinState = MinState();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: decoration,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
              child: Text(
                "INTERVAL KEYFRAME DURATION",
                style: latoSemiBold.copyWith(
                    color: HexColor.fromHex("#3E505B"), fontSize: 12),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<GrapHourBloc, String>(
                builder: (context, initialInterval) => LeftValueBtn(
                  value: initialInterval,
                  isActive: hourMinState is HourState,
                  onPressed: () {
                    setState(() {
                      hourMinState = HourState();
                    });
                  },
                ),
              ),
              BlocBuilder<GraphMinuteBloc, String>(
                builder: (context, finalInterval) => RightValueBtn(
                  isActive: hourMinState is MinState,
                  onPressed: () {
                    setState(() {
                      hourMinState = MinState();
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
                  if (hourMinState is HourState) {
                    context.read<GrapHourBloc>().decrement();
                  } else {
                    context.read<GraphMinuteBloc>().decrement();
                  }
                },
              ),
              PlusButton(
                onTap: () {
                  int hour = NeoBlocProvider.of(context).hourBloc.current;
                  int min = NeoBlocProvider.of(context).minBloc.current;
                  if (hour == 0 && min == 0) {
                    min = 30;
                  }
                  if (hourMinState is MinState) {
                    context.read<GraphMinuteBloc>().increment(maxMin: min);
                  } else {
                    context.read<GrapHourBloc>().increment(maxHour: hour);
                  }
                },
              )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
              child: Text(
                "INTERVAL KEYFRAME VALUE",
                style: latoSemiBold.copyWith(
                    color: HexColor.fromHex("#3E505B"), fontSize: 12),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<MidleIntervalBloc, int>(
                builder: (context, sec) => RightValueBtn(
                  isActive: true,
                  onPressed: () {},
                  value: "${sec}s",
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
                  context.read<MidleIntervalBloc>().decrement();
                },
              ),
              PlusButton(
                onTap: () {
                  context.read<MidleIntervalBloc>().increment();
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
