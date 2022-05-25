import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/pages/page_event.dart';
import 'package:neo/src/bloc/pages/pages_bloc.dart';
import 'package:provider/provider.dart';

class HomeMenuButton extends StatefulWidget {
  @override
  _HomeMenuButtonState createState() => _HomeMenuButtonState();
}

class _HomeMenuButtonState extends State<HomeMenuButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PagesBloc>().add(PageEventHome()),
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(top: 6.h, left: 20.w),
        child: SvgPicture.asset(
          isPressed
              ? "assets/icons/Button_Home_Pressed.svg"
              : "assets/icons/Button_Home_Idle.svg",
          height: 36.h,
          width: 36.w,
        ),
      ),
    );
  }
}
