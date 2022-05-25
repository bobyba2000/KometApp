import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/home_bloc/home_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_state.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';

class PlayButton extends StatefulWidget {
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return GestureDetector(
        onTapDown: (details) {
          setState(() {
            isTapped = !isTapped;
          });

          if (state is HomeStateFile) {
            // context.read<KeyFrameBloc>().add(true);
            context.read<LiveViewBloc>().add(true);
          }
          if (state is HomeStateHighSpeed) {
            // context.read<KeyFrameBloc>().add(true);
            context.read<LiveViewBloc>().add(isTapped);
          }
        },
        onTapUp: (details) {
          // setState(() {
          //   isTapped = false;
          // });
        },
        child: SvgPicture.asset(
          isTapped
              ? "assets/icons/Button_Stop_Idle.svg"
              : "assets/icons/Button_Play_Idle.svg",
          height: 64.sp,
          width: 64.sp,
        ),
      );
    });
  }
}
