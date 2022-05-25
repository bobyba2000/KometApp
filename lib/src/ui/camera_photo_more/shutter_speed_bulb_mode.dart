import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_min/bulb_min_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_min_sec/bulb_min_sec_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_min_sec/bulb_min_sec_event.dart';
import 'package:neo/src/bloc/more_option/bulb_min_sec/bulb_min_sec_state.dart';
import 'package:neo/src/bloc/more_option/bulb_time_counter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_state.dart';
import 'package:neo/src/bloc/more_option/capture_button_pressed_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/minus_button.dart';
import 'package:neo/src/ui/custom_widgets/plus_button.dart';

import 'bulb_min_sec_button.dart';

class ShutterSpeedBulbMode extends StatefulWidget {
  final String url;

  const ShutterSpeedBulbMode({Key key, @required this.url}) : super(key: key);

  @override
  _ShutterSpeedBulbModeState createState() => _ShutterSpeedBulbModeState();
}

class _ShutterSpeedBulbModeState extends State<ShutterSpeedBulbMode> {
  BulbMinSecBloc _bulbMinSecBloc;

  @override
  void initState() {
    _bulbMinSecBloc = BulbMinSecBloc();

    super.initState();
  }

  @override
  void dispose() {
    _bulbMinSecBloc.close();
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
          child: BlocBuilder<CaptureButtonPressedBloc, bool>(
            builder: (context, captureButtonPressed) {
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                      child: BlocBuilder<BulbTypeBloc, BulbTypeState>(
                        builder: (context, bulbType) => RichText(
                            text: TextSpan(
                                text: captureButtonPressed ||
                                        bulbType is! BulbTypeStateShot
                                    ? "SET SHUTTER SPEED | "
                                    : "SHUTTER SPEED | ",
                                style: latoSemiBold.copyWith(
                                    color: HexColor.fromHex("#3E505B"),
                                    fontSize: 12),
                                children: [
                              if (bulbType != null)
                                TextSpan(
                                  text: "${bulbType.name}",
                                  style: latoSemiBold.copyWith(
                                      color: HexColor.fromHex("#EDEFF0"),
                                      fontSize: 12),
                                )
                            ])),
                      ),
                    ),
                  ),
                  BlocBuilder<BulbTypeBloc, BulbTypeState>(
                    builder: (context, bulbType) {
                      return Column(
                        children: [
                          bulbType is BulbTypeStateShot && !captureButtonPressed
                              ? BlocBuilder<BulbMinSecBloc, BulbMinSecState>(
                                  bloc: _bulbMinSecBloc,
                                  builder: (context, state) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                            child:
                                                BlocBuilder<BulbMinBloc, int>(
                                          builder: (context, minutes) =>
                                              BulbMinSecButton(
                                            value: minutes < 10
                                                ? "0${minutes}m"
                                                : "${minutes}m",
                                            state:
                                                state is BulbMinSecStateMinute,
                                            onPressed: () {
                                              _bulbMinSecBloc
                                                  .add(BulbMinSecEventMinute());
                                            },
                                          ),
                                        )),
                                        Expanded(
                                            child:
                                                BlocBuilder<BulbSecBloc, int>(
                                          builder: (context, seconds) =>
                                              BulbMinSecButton(
                                            value: seconds < 10
                                                ? "0${seconds}s"
                                                : "${seconds}s",
                                            state:
                                                state is BulbMinSecStateSeconds,
                                            onPressed: () {
                                              _bulbMinSecBloc.add(
                                                  BulbMinSecEventSeconds());
                                            },
                                          ),
                                        ))
                                      ],
                                    );
                                  },
                                )
                              : BlocBuilder<BulbTimeCounterBloc, String>(
                                  builder: (context, time) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$time",
                                          style: latoHeavy.copyWith(
                                              color:
                                                  HexColor.fromHex("#EDEFF0"),
                                              fontSize: 20.sp),
                                        )
                                      ],
                                    );
                                  },
                                ),
                          SizedBox(
                            height: 12.h,
                          ),
                          if (bulbType is BulbTypeStateShot &&
                              !captureButtonPressed)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MinusButton(
                                  onTap: () {
                                    BulbMinSecState state =
                                        _bulbMinSecBloc.state;
                                    if (state is BulbMinSecStateMinute) {
                                      context.read<BulbMinBloc>().add(
                                          context.read<BulbMinBloc>().state -
                                              1);
                                    }
                                    if (state is BulbMinSecStateSeconds) {
                                      context.read<BulbSecBloc>().add(
                                          context.read<BulbSecBloc>().state -
                                              1);
                                    }
                                  },
                                ),
                                PlusButton(
                                  onTap: () {
                                    BulbMinSecState state =
                                        _bulbMinSecBloc.state;
                                    if (state is BulbMinSecStateMinute) {
                                      context.read<BulbMinBloc>().add(
                                          context.read<BulbMinBloc>().state +
                                              1);
                                    }
                                    if (state is BulbMinSecStateSeconds) {
                                      context.read<BulbSecBloc>().add(
                                          context.read<BulbSecBloc>().state +
                                              1);
                                    }
                                  },
                                )
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
