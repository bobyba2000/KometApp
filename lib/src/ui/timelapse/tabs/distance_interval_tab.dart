import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/basic_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/distance_interval_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/buttons/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/right_value_btn.dart';

class DistanceIntervalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: isLiveView ? 10.h : 0),
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
              RichText(
                  text: TextSpan(
                      text: "INTERVAL | ",
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                      children: [
                    TextSpan(
                      text: " Distance Interval",
                      style: latoSemiBold.copyWith(
                          color: HexColor.fromHex("#EDEFF0"), fontSize: 12.sp),
                    )
                  ])),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<DistanceIntervalBloc, int>(
                builder: (context, finalInterval) => RightValueBtn(
                  isActive: true,
                  onPressed: () {},
                  value: "${finalInterval}m",
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
                  context.read<DistanceIntervalBloc>().decrement();
                },
              ),
              PlusButton(
                onTap: () {
                  context.read<DistanceIntervalBloc>().increment();
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
