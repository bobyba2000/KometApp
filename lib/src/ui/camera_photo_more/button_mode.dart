import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_state.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class ButtonMode extends StatelessWidget {
  final bool active;
  final String name;
  final Function() onPressed;

  const ButtonMode(
      {Key key,
      @required this.name,
      @required this.active,
      @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<ButtonModeBloc, ButtonModeState>(
          builder: (context, state) {
            return SvgPicture.asset(
              active
                  ? "assets/icons/Button_Mode_Enable.svg"
                  : "assets/icons/Button_Mode_Disable.svg",
              height: 36,
              width: 36,
            );
          },
        ),
        Positioned.fill(
            child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Center(
                  child: Text(
                    "$name",
                    style: latoSemiBold.copyWith(
                        fontSize: 20.sp,
                        color: active
                            ? HexColor.fromHex("#EDEFF0")
                            : HexColor.fromHex("#959FA5")),
                  ),
                ),
                onPressed: onPressed))
      ],
    );
  }
}
