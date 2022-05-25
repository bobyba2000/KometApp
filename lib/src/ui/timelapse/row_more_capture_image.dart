import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/add_keyframe_state_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/higlited_keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_state.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/model/edit_key_frame_model.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/gallery_button.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/more_button.dart';
import 'package:provider/provider.dart';

import 'holy_graph/add_keyframe_btn.dart';
import 'holy_graph/check_keyframe_btn.dart';
import 'holy_graph/close_keyframe_btn.dart';
import 'holy_graph/delete_keyframe_btn.dart';
import 'holy_graph/edit_keyframe_btn.dart';
import 'play_button.dart';

class RowMoreCaptureImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedParamsTabBloc, int>(
      builder: (context, index) => Container(
          height: 84.h,
          color: HexColor.fromHex("#0E1011"),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.4),
          child: BlocBuilder<KeyFrameBloc, bool>(
            builder: (context, isKeyFRameOpen) =>
                BlocBuilder<KeyFrameTabBloc, KeyFrameState>(
              builder: (context, keyFrameState) => BlocBuilder<
                      AddKeyFrameStateBloc, bool>(
                  builder: (context, isaddFrameState) =>
                      BlocBuilder<HighLightedKeyFrameBloc, List<KeyFrameItem>>(
                        builder: (context, highLitedKerframe) {
                          return Consumer<EditKeyFrameModel>(
                            builder: (context, editvalue, child) => Row(
                              mainAxisAlignment: index != null &&
                                      !isaddFrameState &&
                                      isKeyFRameOpen &&
                                      highLitedKerframe.length == 0
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                              children: index != null && isKeyFRameOpen
                                  ? highLitedKerframe.length > 0
                                      ? editvalue.editIndex != null
                                          ? [
                                              if (isaddFrameState)
                                                ClosKeyFrameBtn(),
                                              if (isaddFrameState)
                                                CheckKeyFrame(),
                                              if (!isaddFrameState)
                                                AddKeyFrameBtn()
                                            ]
                                          : [
                                              DeleteKeyFrameBtn(),
                                              BlocBuilder<
                                                      HighLightedKeyFrameBloc,
                                                      List<KeyFrameItem>>(
                                                  builder: (context,
                                                      highLitedKerframe) {
                                                if (highLitedKerframe.length >
                                                    1) return Container();
                                                return EditKeyFrameBtn();
                                              })
                                            ]
                                      : [
                                          if (isaddFrameState)
                                            ClosKeyFrameBtn(),
                                          if (isaddFrameState) CheckKeyFrame(),
                                          if (!isaddFrameState) AddKeyFrameBtn()
                                        ]
                                  : [
                                      MoreButton(),
                                      PlayButton(),
                                      GallerButton(),
                                    ],
                            ),
                          );
                        },
                      )),
            ),
          )),
    );
  }
}
