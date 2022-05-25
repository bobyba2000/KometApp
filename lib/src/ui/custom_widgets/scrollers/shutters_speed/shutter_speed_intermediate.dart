import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_state.dart';
import 'package:neo/src/ui/camera_photo_more/shutter_speed_bulb_mode.dart';
import 'package:neo/src/ui/custom_widgets/scrollers/shutters_speed/shutter_speed_scroller.dart';

class ShutterSpeedIntermediate extends StatelessWidget {
  final String url;

  const ShutterSpeedIntermediate({Key key, @required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonModeBloc, ButtonModeState>(
      builder: (context, state) {
        if (state is ButtonModeStateBulb) {
          return ShutterSpeedBulbMode(
            url: url,
          );
        } else {
          return ShutterSpeedScroller(
            url: url,
          );
        }
      },
    );
  }
}
