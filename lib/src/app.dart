import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/demo_enabled_bloc.dart';
import 'package:neo/src/bloc/gallery/gallery_state_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_min/bulb_min_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_time_counter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_bloc.dart';
import 'package:neo/src/bloc/more_option/capture_button_pressed_bloc.dart';
import 'package:neo/src/bloc/more_option/more_option_visibility_bloc.dart';
import 'package:neo/src/bloc/more_option/seconds_reciever_bloc.dart';
import 'package:neo/src/bloc/pages/pages_bloc.dart';
import 'package:neo/src/bloc/scroll/lock_main_scroll_bloc.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/add_keyframe_state_bloc.dart';
import 'package:neo/src/bloc/timelapse/aperture_ramp_bloc.dart';
import 'package:neo/src/bloc/timelapse/basic_holy_grail_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/dur_frame_play_bloc.dart';
import 'package:neo/src/bloc/timelapse/frame_play_fps_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/final_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/initial_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/distance_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/final_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/initial_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/midle_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/final_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/initial_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/framekey_index_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/graph_minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/higlited_keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/bloc/timelapse/shutter_lag_sec_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/final_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/initial_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/switch_distance_bloc.dart';
import 'package:neo/src/bloc/video/video_active_bloc.dart';
import 'package:neo/src/ui/custom_widgets/hdr/collapse_button.dart';

import 'bloc/camera_controls/camera_controls_bloc.dart';
import 'bloc/flickr/flickr_state_bloc.dart';
import 'bloc/more_option/bulb_tap_bloc.dart';
import 'bloc/params_button/params_fstop_bloc.dart';
import 'bloc/params_button/params_hdr_bloc.dart';
import 'bloc/params_button/params_iso_bloc.dart';
import 'bloc/params_button/params_shutter_bloc.dart';
import 'bloc/params_button/params_wb_bloc.dart';
import 'bloc/timelapse/shut_lag_mot_co_bloc.dart';
import 'local_server.dart';
import 'ui/ip_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application
  FramePlayFpsBloc framePlayFpsBloc = FramePlayFpsBloc();

  @override
  void initState() {
    super.initState();

    Server.startServer();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 667),
      builder: () => NeoBlocProvider(
        bloc: framePlayFpsBloc,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TabBloc()),
            BlocProvider(
                create: (context) =>
                    GalleryStateBloc()..add(InitGalleryStateEvent())),
            BlocProvider(
                create: (context) =>
                    FlickrStateBloc()..add(InitFlickrStateEvent())),
            BlocProvider(create: (context) => CameraControllsBloc()),
            BlocProvider(create: (context) => ParamsShutterBloc()),
            BlocProvider(create: (context) => ParamsIsoBloc()),
            BlocProvider(create: (context) => ParamsFstopBloc()),
            BlocProvider(create: (context) => ParamsIsoBloc()),
            BlocProvider(create: (context) => ParamsWbBloc()),
            BlocProvider(create: (context) => ParamsHdrBloc()),
            BlocProvider(create: (context) => VideoActiveBloc()),
            BlocProvider(create: (context) => MoreOptionVisibilityBloc()),
            BlocProvider(create: (context) => ButtonModeBloc()),
            BlocProvider(create: (context) => BulbMinBloc()),
            BlocProvider(create: (context) => BulbSecBloc()),
            BlocProvider(create: (context) => BulbTypeBloc()),
            BlocProvider(create: (context) => CaptureButtonPressedBloc()),
            BlocProvider(create: (context) => BulbTimeCounterBloc()),
            BlocProvider(create: (context) => BulbTapBloc()),
            BlocProvider(create: (context) => LiveViewBloc()),
            BlocProvider(create: (context) => ExpandedBloc()),
            BlocProvider(create: (context) => SecondsRecieverBloc()),
            BlocProvider(create: (context) => HomeBloc()),
            BlocProvider(create: (context) => PagesBloc()),
            BlocProvider(create: (context) => BasicHolyGrailBloc()),
            BlocProvider(create: (context) => InitialIsoBloc()),
            BlocProvider(create: (context) => FinalIsoBloc()),
            BlocProvider(create: (context) => InitialShutterSpBloc()),
            BlocProvider(create: (context) => FinalShutterSpBloc()),
            BlocProvider(create: (context) => InitialFstopBloc()),
            BlocProvider(create: (context) => FinalFstopBloc()),
            BlocProvider(create: (context) => InitialIntervalBloc()),
            BlocProvider(create: (context) => FinalIntervalBloc()),
            BlocProvider(create: (context) => DurFramePlayBloc()),
            BlocProvider(create: (context) => KeyFrameBloc()),
            BlocProvider(create: (context) => KeyFrameTabBloc()),
            BlocProvider(create: (context) => AddKeyFrameStateBloc()),
            BlocProvider(create: (context) => GraphMinuteBloc()),
            BlocProvider(create: (context) => GrapHourBloc()),
            BlocProvider(create: (context) => FrameKeyIndex()),
            BlocProvider(create: (context) => HighLightedKeyFrameBloc()),
            BlocProvider(create: (context) => LockMainScrollBloc()),
            BlocProvider(create: (context) => MidleIntervalBloc()),
            BlocProvider(create: (context) => SwitchDistanceBloc()),
            BlocProvider(create: (context) => DistanceIntervalBloc()),
            BlocProvider(create: (context) => ApertureRampBloc()),
            BlocProvider(create: (context) => ShutLagMotCotBloc()),
            BlocProvider(create: (context) => ShutterLagSecBloc()),
            BlocProvider(create: (context) => SelectedParamsTabBloc()),
            BlocProvider(create: (context) => DemoEnabledBloc()),
          ],
          child: MaterialApp(
              title: 'Komet',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.blue,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: <TargetPlatform, PageTransitionsBuilder>{
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  },
                ),
              ),
              home: IpPage()),
        ),
      ),
    );
  }
}
