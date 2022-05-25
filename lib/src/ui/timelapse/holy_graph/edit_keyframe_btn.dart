import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_event.dart';
import 'package:neo/src/bloc/timelapse/add_keyframe_state_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_hour_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/higlited_keyframe_bloc.dart';
import 'package:neo/src/listeners/expanded_listener.dart';
import 'package:neo/src/model/edit_key_frame_model.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';

class EditKeyFrameBtn extends StatefulWidget {
  @override
  _EditKeyFrameBtnState createState() => _EditKeyFrameBtnState();
}

class _EditKeyFrameBtnState extends State<EditKeyFrameBtn> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List<KeyFrameItem> items =
            context.read<HighLightedKeyFrameBloc>().state;
        context.read<GrapHourBloc>().setHour(items[0].dateTime.hour);
        context.read<GraphMinuteBloc>().setMin(items[0].dateTime.minute);

        context.read<EditKeyFrameModel>().addEditIndex(items[0].keyFrameINdex);

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
            ? "assets/icons/Button_Edit_Pressed.svg"
            : "assets/icons/Button_Edit_Idle.svg",
        height: 36.sp,
        width: 36.sp,
      ),
    );
  }
}
