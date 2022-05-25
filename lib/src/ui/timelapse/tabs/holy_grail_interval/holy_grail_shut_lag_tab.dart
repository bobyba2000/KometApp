import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_lag_sec_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/buttons/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/right_value_btn.dart';

class HolyGrailShutLagTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                text: TextSpan(children: [
                  TextSpan(
                    text: "INTERVAL | ",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                  ),
                  TextSpan(
                    text: 'Shutter Lag',
                    style: TextStyle(
                        color: HexColor.fromHex("#EDEFF0"), fontSize: 12.sp),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<ShutterLagSecBloc, int>(
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
                  context.read<ShutterLagSecBloc>().decrement();
                },
              ),
              PlusButton(
                onTap: () {
                  context.read<ShutterLagSecBloc>().increment();
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
