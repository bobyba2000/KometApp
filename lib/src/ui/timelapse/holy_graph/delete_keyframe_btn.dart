import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/higlited_keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_state.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';
import 'package:neo/src/model/keyframe/keyframe_shutter_model.dart';

class DeleteKeyFrameBtn extends StatefulWidget {
  @override
  _DeleteKeyFrameBtnState createState() => _DeleteKeyFrameBtnState();
}

class _DeleteKeyFrameBtnState extends State<DeleteKeyFrameBtn> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List<KeyFrameItem> hItems =
            context.read<HighLightedKeyFrameBloc>().state;
        int index = context.read<SelectedParamsTabBloc>().state;
        if (index == 2) {
          context.read<KeyFrameModel>().removeItemIso(hItems);
        }
        if (index == 0) {
          context.read<KeyFrameModel>().removeItemShutter(hItems);
        }
        if (index == 1) {
          context.read<KeyFrameModel>().removeItemFstop(hItems);
        }
        if (index == 4) {
          context.read<KeyFrameModel>().removeItemInterval(hItems);
        }
        context.read<HighLightedKeyFrameBloc>().removeAll();
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
            ? "assets/icons/Button_Delete_Pressed.svg"
            : "assets/icons/Button_Delete_Idle.svg",
        height: 36.sp,
        width: 36.sp,
      ),
    );
  }
}
