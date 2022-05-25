import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_state.dart';
import 'package:neo/src/ui/timelapse/tabs/fstop_keyframe_duration_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/interval_keyframe_duration_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/shutter_keyframe_duration_tab.dart';

import 'iso_keyframe_duration_tab.dart';

class KeyFrameDurationTab extends StatelessWidget {
  final String url;

  const KeyFrameDurationTab({Key key, @required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedParamsTabBloc, int>(
      builder: (context, index) {
        if (index == 2)
          return IsoKeyframeDurationTab(
            url: url,
          );
        if (index == 0) return ShutterKeyFrameDurationTab(url: url);

        if (index == 1) return FstopKeyFrameDurationTab(url: url);

        if (index == 4) return IntervalKeyframeDurationTab();

        return Container();
      },
    );
  }
}
