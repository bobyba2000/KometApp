import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                          onPressed: () async {
                            context
                                .read<ButtonModeBloc>()
                                .add(ButtonModeEventManual());
                          },
                        ),
                        SizedBox(
                          width: 96.w,
                        ),
                        ButtonMode(
                          name: "B",
                          active: state is ButtonModeStateBulb,
                          onPressed: () async {
                            bool isConfirm = await showDialog(
                              context: context,
                              builder: (context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    contentPadding: const EdgeInsets.all(0),
                                    backgroundColor:
                                        HexColor.fromHex('#0E1011'),
                                    content: _DialogConfirm(
                                      onCancel: () =>
                                          Navigator.pop(context, false),
                                      onConfirm: () =>
                                          Navigator.pop(context, true),
                                    ),
                                  ),
                                );
                              },
                            );
                            if (isConfirm == true) {
                              context
                                  .read<ButtonModeBloc>()
                                  .add(ButtonModeEventBulb());
                            }
                          },
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

class _DialogConfirm extends StatefulWidget {
  final Function onConfirm;
  final Function onCancel;
  const _DialogConfirm({Key key, this.onConfirm, this.onCancel})
      : super(key: key);

  @override
  __DialogConfirmState createState() => __DialogConfirmState();
}

class __DialogConfirmState extends State<_DialogConfirm> {
  bool isShowAgain = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor.fromHex('#0E1011'),
        borderRadius: BorderRadius.circular(24),
      ),
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/icons/Icon_Notification.svg",
                width: 18.w,
                height: 18.h,
              ),
              SizedBox(width: 5.w),
              Text(
                'NOTIFICATION',
                style: latoSemiBold.copyWith(
                  color: HexColor.fromHex("#3E505B"),
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: HexColor.fromHex('#004561'),
              thickness: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Please make sure your Camera\'s Mode Dial is set to BULB.',
              style: latoSemiBold.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: Icon(
                  isShowAgain ? Icons.check_circle : Icons.circle,
                  size: 20,
                  color: isShowAgain
                      ? HexColor.neoBlue()
                      : HexColor.neoBlueDisable(),
                ),
                onTap: () {
                  setState(() {
                    isShowAgain = !isShowAgain;
                  });
                },
              ),
              const SizedBox(width: 4),
              Text(
                "Don't Show This Again",
                style: latoSemiBold.copyWith(
                  color: HexColor.fromHex("#3E505B"),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: widget.onCancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor.neoBlue(),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          24,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      'CANCEL',
                      style: latoSemiBold.copyWith(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: InkWell(
                  onTap: widget.onConfirm,
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor.neoBlue(),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          24,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      'CONFIRM',
                      style: latoSemiBold.copyWith(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
