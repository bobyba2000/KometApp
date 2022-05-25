import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_event.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_state.dart';
import 'package:neo/src/bloc/timelapse/basic_holy_grail_bloc.dart';
import 'package:neo/src/ui/camera_photo_more/button_mode.dart';
import 'package:neo/src/bloc/more_option/more_option_visibility_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/ui/camera_photo_more/manual_tab.dart';
import 'package:neo/src/ui/timelapse/more/holy_bulb.dart';
import 'package:neo/src/ui/timelapse/more/holy_manual.dart';

import 'bulb_tab.dart';
import 'more_divider.dart';
import 'preset_button.dart';

class CameraPhotMore extends StatelessWidget {
  final String url;
  final ScrollController scrollController;

  const CameraPhotMore(
      {Key key, @required this.scrollController, @required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreOptionVisibilityBloc, bool>(
      builder: (context, state) {
        if (!state) {
          return Container();
        }
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        });

        return Column(
          children: [
            MoreDivider(),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "SUTTER MODE MANUAL/BULB",
              style: latoSemiBold.copyWith(
                  fontSize: 15.sp, color: HexColor.fromHex("#3E505B")),
            ),
            SizedBox(
              height: 12.h,
            ),
            BlocBuilder<ButtonModeBloc, ButtonModeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonMode(
                          name: "M",
                          active: state is ButtonModeStateManual,
                          onPressed: () => context
                              .read<ButtonModeBloc>()
                              .add(ButtonModeEventManual()),
                        ),
                        SizedBox(
                          width: 96.w,
                        ),
                        ButtonMode(
                          name: "B",
                          active: state is ButtonModeStateBulb,
                          onPressed: () => context
                              .read<ButtonModeBloc>()
                              .add(ButtonModeEventBulb()),
                        ),
                      ],
                    ),
                    state is ButtonModeStateManual
                        ? BlocBuilder<BasicHolyGrailBloc, int>(
                            builder: (context, isHoly) {
                              return isHoly == 1
                                  ? HolyManual()
                                  : ManualTab(
                                      url: url,
                                    );
                            },
                          )
                        : BlocBuilder<BasicHolyGrailBloc, int>(
                            builder: (context, isHoly) {
                              return isHoly == 1 ? HolyBulb() : BulbTab();
                            },
                          ),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [PresetButton()],
            ),
          ],
        );
      },
    );
  }
}
