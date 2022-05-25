import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/basic_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/bloc/timelapse/switch_distance_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/f_p_F.dart';
import 'package:neo/src/ui/custom_widgets/buttons/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/plus_button.dart';
import 'package:neo/src/ui/custom_widgets/buttons/right_value_btn.dart';
import 'package:neo/src/ui/timelapse/tabs/distance_interval_tab.dart';

class BasicIntervalTab extends StatefulWidget {
  @override
  _BasicIntervalTabState createState() => _BasicIntervalTabState();
}

class _BasicIntervalTabState extends State<BasicIntervalTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchDistanceBloc, bool>(
      builder: (context, isDist) {
        if (isDist) return DistanceIntervalTab();

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
                  Text(
                    "INTERVAL  ",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex("#3E505B"), fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<FPF>(
                    stream: NeoBlocProvider.of(context).intervalBloc.stream$,
                    builder: (context, snapInter) => RightValueBtn(
                      isActive: true,
                      onPressed: () {},
                      value:
                          snapInter.hasData ? "${snapInter.data.value}s" : "--",
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
                      NeoBlocProvider.of(context).intervalBloc.decrement();
                    },
                  ),
                  PlusButton(
                    onTap: () {
                      NeoBlocProvider.of(context).intervalBloc.increment();
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
      },
    );
  }
}
