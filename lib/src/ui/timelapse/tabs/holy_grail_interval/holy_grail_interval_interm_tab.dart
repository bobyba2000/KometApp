import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/shut_lag_mot_co_bloc.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_interval/holy_grail_interval.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_interval/holy_grail_shut_lag_tab.dart';

import 'holy_grail_motion_control_tab.dart';

class HolyGrailIntervalIntermTab extends StatelessWidget {
  final String url;

  const HolyGrailIntervalIntermTab({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShutLagMotCotBloc, ShutLagMotCotState>(
      builder: (context, state) {
        if (state is ShutLagState) return HolyGrailShutLagTab();

        if (state is MotCotState) return HolyGrailMotionControlTab();

        return HolyGrailIntervalTab(
          url: url,
        );
      },
    );
  }
}
