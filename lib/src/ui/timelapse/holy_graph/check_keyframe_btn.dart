import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/add_keyframe_state_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/midle_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/framekey_index_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/higlited_keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_state.dart';
import 'package:neo/src/model/edit_key_frame_model.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';
import 'package:neo/src/model/keyframe/keyframe_shutter_model.dart';

class CheckKeyFrame extends StatefulWidget {
  @override
  _CheckKeyFrameState createState() => _CheckKeyFrameState();
}

class _CheckKeyFrameState extends State<CheckKeyFrame> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("adding ");
        int index = context.read<SelectedParamsTabBloc>().state;
        int hour = context.read<GrapHourBloc>().hour;
        int min = context.read<GraphMinuteBloc>().min;
        HSelectedItem selectedItem = context.read<FrameKeyIndex>().state;
        int editIndex = context.read<EditKeyFrameModel>().editIndex;
        print("adding ${selectedItem.value} ");
        if (editIndex != null) {
          print("adding selectedItem.index ");
          if (index == 2) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            item.updateItemIso(
                KeyFrameItem(
                    dateTime: DateTime(0, 0, 0, hour, min, 0),
                    keyFrameValue: selectedItem.value,
                    keyFrameINdex: selectedItem.index,
                    type: "ISO"),
                editIndex);
            context.read<EditKeyFrameModel>().addEditIndex(null);
            context.read<HighLightedKeyFrameBloc>().removeAll();
          } else if (index == 0) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            item.updateItemShutter(
                KeyFrameItem(
                    dateTime: DateTime(0, 0, 0, hour, min, 0),
                    keyFrameValue: selectedItem.value,
                    keyFrameINdex: selectedItem.index,
                    type: "SHUTTER"),
                editIndex);
            context.read<EditKeyFrameModel>().addEditIndex(null);
            context.read<HighLightedKeyFrameBloc>().removeAll();
          } else if (index == 1) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            item.updateItemFstop(
                KeyFrameItem(
                    dateTime: DateTime(0, 0, 0, hour, min, 0),
                    keyFrameValue: selectedItem.value,
                    keyFrameINdex: selectedItem.index,
                    type: "FSTOP"),
                editIndex);
            context.read<EditKeyFrameModel>().addEditIndex(null);
            context.read<HighLightedKeyFrameBloc>().removeAll();
          } else if (index == 4) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            int sec = context.read<MidleIntervalBloc>().state;
            item.updateItemInterval(
                KeyFrameItem(
                    dateTime: DateTime(0, 0, 0, hour, min, 0),
                    keyFrameValue: "$sec",
                    keyFrameINdex: sec,
                    type: "INTERVAL"),
                editIndex);
            context.read<EditKeyFrameModel>().addEditIndex(null);
            context.read<HighLightedKeyFrameBloc>().removeAll();
          }
        } else {
          if (index == 2) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            item.addItemIso(KeyFrameItem(
                dateTime: DateTime(0, 0, 0, hour, min, 0),
                keyFrameValue: selectedItem.value,
                keyFrameINdex: selectedItem.index,
                type: "ISO"));
          } else if (index == 0) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            item.addItemShutter(KeyFrameItem(
                dateTime: DateTime(0, 0, 0, hour, min, 0),
                keyFrameValue: selectedItem.value,
                keyFrameINdex: selectedItem.index,
                type: "SHUTTER"));
          } else if (index == 1) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            item.addItemFstop(KeyFrameItem(
                dateTime: DateTime(0, 0, 0, hour, min, 0),
                keyFrameValue: selectedItem.value,
                keyFrameINdex: selectedItem.index,
                type: "FSTOP"));
          } else if (index == 4) {
            KeyFrameModel item = context.read<KeyFrameModel>();
            int sec = context.read<MidleIntervalBloc>().state;
            item.addItemInterval(KeyFrameItem(
                dateTime: DateTime(0, 0, 0, hour, min, 0),
                keyFrameValue: "$sec",
                keyFrameINdex: sec,
                type: "INTERVAL"));
          }
        }
        context.read<AddKeyFrameStateBloc>().add(false);
        context.read<TabBloc>().add(TabEventSwitchInitial());
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
            ? "assets/icons/Button_Accept_Pressed.svg"
            : "assets/icons/Button_Accept_Idle.svg",
        height: 36.sp,
        width: 36.sp,
      ),
    );
  }
}
