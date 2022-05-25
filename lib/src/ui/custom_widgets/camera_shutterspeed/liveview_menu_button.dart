import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';

typedef LiveViewCallback(bool live);

class LiveViewMenuButton extends StatefulWidget {
  final bool hide;

  const LiveViewMenuButton({Key key, @required this.hide}) : super(key: key);
  @override
  _LiveMenuButtonState createState() => _LiveMenuButtonState();
}

class _LiveMenuButtonState extends State<LiveViewMenuButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveViewBloc, bool>(
      builder: (context, isLiveView) {
        return AnimatedOpacity(
          opacity: widget.hide ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            height: 48.h,
            width: 48.h,
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                context.read<LiveViewBloc>().add(!isLiveView);
              },
              icon: SvgPicture.asset(
                isLiveView
                    ? "assets/icons/Button_LiveView_Enable.svg"
                    : "assets/icons/Button_LiveView_Disable.svg",
                height: 48.h,
                width: 48.h,
              ),
            ),
          ),
        );
      },
    );
  }
}
