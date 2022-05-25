import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_event.dart';
import 'package:neo/src/bloc/timelapse/add_keyframe_state_bloc.dart';
import 'package:neo/src/listeners/expanded_listener.dart';
import 'package:neo/src/model/edit_key_frame_model.dart';

class AddKeyFrameBtn extends StatefulWidget {
  @override
  _AddKeyFrameBtnState createState() => _AddKeyFrameBtnState();
}

class _AddKeyFrameBtnState extends State<AddKeyFrameBtn> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int keyIndex = context.read<EditKeyFrameModel>().editIndex;
        if (keyIndex == null) {}
        context.read<AddKeyFrameStateBloc>().add(true);
        context.read<TabBloc>().add(TabEventSwitchAddKeyFrame());
        ExpandedListener().dispatch(context);
      },
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTapped = false;
        });
      },
      child: SvgPicture.asset(
        isTapped
            ? "assets/icons/Button_Add_Pressed.svg"
            : "assets/icons/Button_Add_Idle.svg",
        height: 36.sp,
        width: 36.sp,
      ),
    );
  }
}
