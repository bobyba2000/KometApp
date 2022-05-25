import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/camera_controls/camera_controls_bloc.dart';
import 'package:neo/src/bloc/camera_controls/camera_controls_event.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_event.dart';
import 'package:neo/src/bloc/tab_bloc/tab_state.dart';
import 'package:neo/src/bloc/timelapse/add_keyframe_state_bloc.dart';
import 'package:neo/src/bloc/timelapse/basic_holy_grail_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/higlited_keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_event.dart';
import 'package:neo/src/ui/flash/flash_settings_scroller.dart';
import 'package:neo/src/ui/timelapse/tabs/basic_interval_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_duration/holy_grail_duration_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_fstop_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_interval/holy_grail_interval_interm_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_iso_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_shutter_speed_tab.dart';
import 'package:neo/src/ui/timelapse/tabs/keyframe_duration_tab.dart';

import 'scrollers/fstop_scroller.dart';
import 'scrollers/hdr_scroller.dart';
import 'scrollers/iso_scroller.dart';
import 'scrollers/shutters_speed/shutter_speed_intermediate.dart';
import 'scrollers/wb_scroller.dart';

class ScrollerValueSelecter extends StatelessWidget {
  final String url;

  final StepBracketValuesBloc stepBracketValuesBloc;

  const ScrollerValueSelecter({
    Key key,
    @required this.url,
    @required this.stepBracketValuesBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectedParamsTabBloc, int>(
        listener: (context, index) {
          context.read<HighLightedKeyFrameBloc>().removeAll();
          int isHoly = context.read<BasicHolyGrailBloc>().state;
          bool isKeyFRame = context.read<KeyFrameBloc>().state;
          print("object $index");
          print("isKeyFRame $isKeyFRame");
//prevents opening tabs when holygraph is displayed
          if (isKeyFRame) {
            if (index == 0) {
              context.read<KeyFrameTabBloc>().add(KeyFrameTabEventShutter());
            } else if (index == 1) {
              context.read<KeyFrameTabBloc>().add(KeyFrameTabEventFstop());
            } else if (index == 2) {
              context.read<KeyFrameTabBloc>().add(KeyFrameTabEventIso());
            } else if (index == 4) {
              context.read<KeyFrameTabBloc>().add(KeyFrameTabEventInterval());
            } else {
              context.read<KeyFrameTabBloc>().add(KeyFrameTabEventInitial());
              context.read<TabBloc>().add(TabEventSwitchInitial());
              context.read<AddKeyFrameStateBloc>().add(false);
              context.read<HighLightedKeyFrameBloc>().removeAll();
            }
            //  context.read<TabBloc>().add(TabEventSwitchHolyFstop());
          } else {
            if (index == 0) {
              context.read<TabBloc>().add(isHoly == 1
                  ? TabEventSwitchHolyShutterSp()
                  : TabEventSwitchShutterSpeed());
            } else if (index == 1) {
              context.read<TabBloc>().add(isHoly == 1
                  ? TabEventSwitchHolyFstop()
                  : TabEventSwitchFstop());
            } else if (index == 2) {
              context.read<TabBloc>().add(
                  isHoly == 1 ? TabEventSwitchHolyISO() : TabEventSwitchISO());
            } else if (index == 3) {
              context.read<TabBloc>().add(TabEventSwitchWB());
            } else if (index == 4) {
              context.read<TabBloc>().add(isHoly == 1
                  ? TabEventSwitchHolyInterval()
                  : TabEventSwitcBasicInterval());
            } else if (index == 5) {
              context.read<TabBloc>().add(TabEventSwitchHolyDuration());
            } else if (index == 11) {
              context.read<TabBloc>().add(TabEventFlashSettings());
            } else {
              context.read<TabBloc>().add(TabEventSwitchInitial());
            }
          }
        },
        builder: (context, index) => BlocListener<KeyFrameBloc, bool>(
              listener: (context, isOpen) {
                int isHoly = context.read<BasicHolyGrailBloc>().state;
                if (isOpen) {
                  // TabState tabState=  context.read<TabBloc>().state;
                  // if(tabState is TabStateShutterSpeed){
                  //   context.read<TabBloc>().add(TabEventSwitchInitial());
                  // }else{
                  //   context.read<TabBloc>().add(TabEventSwitchInitial());
                  // }

                  context.read<TabBloc>().add(TabEventSwitchInitial());
                } else {
                  if (index == 0 && isHoly == 1) {
                    context.read<TabBloc>().add(TabEventSwitchHolyShutterSp());
                  } else if (index == 1 && isHoly == 1) {
                    context.read<TabBloc>().add(TabEventSwitchHolyFstop());
                  } else if (index == 2 && isHoly == 1) {
                    context.read<TabBloc>().add(TabEventSwitchHolyISO());
                  }
                }
              },
              child: BlocListener<BasicHolyGrailBloc, int>(
                listener: (context, isHoly) {
                  TabState tabState = context.read<TabBloc>().state;
                  if (isHoly == 1) {
                    if (tabState is TabStateShutterSpeed) {
                      context
                          .read<TabBloc>()
                          .add(TabEventSwitchHolyShutterSp());
                    }
                    if (tabState is TabStateFstop) {
                      context.read<TabBloc>().add(TabEventSwitchHolyFstop());
                    }
                    if (tabState is TabStateISO) {
                      context.read<TabBloc>().add(TabEventSwitchHolyISO());
                    }
                  } else {
                    if (tabState is TabStateHolyShutterSp) {
                      context.read<TabBloc>().add(TabEventSwitchShutterSpeed());
                    }
                    if (tabState is TabStateHolyFstop) {
                      context.read<TabBloc>().add(TabEventSwitchFstop());
                    }
                    if (tabState is TabStateHolyISO) {
                      context.read<TabBloc>().add(TabEventSwitchISO());
                    }
                  }
                },
                child: BlocConsumer<TabBloc, TabState>(
                  listener: (context, state) {
                    if (state is TabStateShutterSpeed) {
                      context
                          .read<CameraControllsBloc>()
                          .add(CameraControllsEventFetchShutterSpeed());
                    }
                    if (state is TabStateISO) {
                      context
                          .read<CameraControllsBloc>()
                          .add(CameraControllsEventFetchISO());
                    }
                    if (state is TabStateFstop) {
                      context
                          .read<CameraControllsBloc>()
                          .add(CameraControllsEventFetchFstop());
                    }
                  },
                  builder: (context, _tabState) {
                    // print("tab state $_tabState");
                    Widget currentWidget = Container();
                    if (_tabState is TabStateInitial) {
                      return Container();
                    }
                    if (_tabState is TabStateShutterSpeed) {
                      currentWidget = ShutterSpeedIntermediate(url: url);
                    }

                    if (_tabState is TabStateFstop) {
                      currentWidget = FStopScroller(ulr: url);
                    }
                    if (_tabState is TabStateISO) {
                      currentWidget = ISOScroller(url: url);
                    }

                    if (_tabState is TabStateWB) {
                      currentWidget = WbScroller(url: url);
                    }

                    if (_tabState is TabStateHDR) {
                      currentWidget = HDRscroller(
                        stepBracketValuesBloc: stepBracketValuesBloc,
                        url: url,
                      );
                    }

                    if (_tabState is TabStateFlashSettings) {
                      currentWidget = FlashSettingsScroller(
                        stepBracketValuesBloc: stepBracketValuesBloc,
                        url: url,
                      );
                    }
                    if (_tabState is TabStateHolyISO) {
                      currentWidget = HolyGrailIsoTab(
                        url: url,
                      );
                    }

                    if (_tabState is TabStateBasicInterval) {
                      currentWidget = BasicIntervalTab();
                    }

                    if (_tabState is TabStateHolyShutterSp) {
                      currentWidget = HolyGrailShutterSpeed(
                        url: url,
                      );
                    }

                    if (_tabState is TabStateHolyFstop) {
                      currentWidget = HolyGrailFstopTab(
                        url: url,
                      );
                    }
                    if (_tabState is TabStateHolyInterval) {
                      currentWidget = HolyGrailIntervalIntermTab(
                        url: url,
                      );
                    }

                    if (_tabState is TabStateHolyDuration) {
                      currentWidget = HolyGrailDurationTab(
                        url: url,
                      );
                    }
                    if (_tabState is TabStateAddKeyFrame) {
                      currentWidget = KeyFrameDurationTab(
                        url: url,
                      );
                    }

                    return currentWidget;
                  },
                ),
              ),
            ));
  }

  String returnTitle(TabState state) {
    String title = "";
    if (state is TabStateShutterSpeed) {
      title = "SHUTTER SPEED";
    } else if (state is TabStateISO) {
      title = "ISO";
    } else if (state is TabStateFstop) {
      title = "F-STOP";
    }
    return title;
  }
}
