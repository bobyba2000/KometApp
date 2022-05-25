import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/more_option/more_option_visibility_bloc.dart';
import 'package:neo/src/bloc/scroll/lock_main_scroll_bloc.dart';
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
import 'package:neo/src/bloc/video/video_active_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/model/url_holder.dart';
import 'package:neo/src/ui/camera_photo_more/basic_more_options.dart';
import 'package:neo/src/ui/custom_widgets/row_more_flickr_capture_raw_image/row_more_flickr_capture_raw_image.dart';
import 'package:neo/src/ui/flash/flash_list.dart';
import 'package:neo/src/ui/flash/flash_param_tabs.dart';
import 'package:neo/src/ui/focus/focus_row_tab.dart';
import 'package:neo/src/ui/high_speed/high_speed_main_content.dart';
import 'package:neo/src/ui/high_speed/high_speed_scroller.dart';
import 'package:neo/src/ui/timelapse/holy_graph/holy_graph_view.dart';
import 'package:neo/src/ui/timelapse/keyframe_btn.dart';
import 'package:neo/src/ui/timelapse/row_more_capture_image.dart';
import 'package:neo/src/ui/timelapse/timelapse_param_tabs.dart';
import 'package:provider/provider.dart';

import 'camera_photo_more/camera_photo_more.dart';
import 'custom_widgets/camera_shutterspeed/focus_menu_button.dart';
import 'custom_widgets/camera_shutterspeed/liveview_menu_button.dart';
import 'custom_widgets/camera_shutterspeed/parameter_tabs.dart';
import 'custom_widgets/camera_video/video_camera_scroller.dart';
import 'custom_widgets/custom_app_bar.dart';
import 'custom_widgets/scroller_value_scroller.dart';
import 'file/file_scroller.dart';
import 'file/sd_cards_list.dart';
import 'flash/flash_scroller/flash_scroller.dart';
import 'liveview/liveview_widget.dart';
import 'timelapse/basic_holy_grail_scroller.dart';

class CameraPhotoShutterSpeed extends StatefulWidget {
  @override
  _CameraPhotoShutterSpeedState createState() =>
      _CameraPhotoShutterSpeedState();
}

class _CameraPhotoShutterSpeedState extends State<CameraPhotoShutterSpeed> {
  bool isFocus = false;

  bool photo = true;

  ScrollController _scrollController = new ScrollController();

  StepBracketValuesBloc stepBracketValuesBloc;

  @override
  void initState() {
    stepBracketValuesBloc = StepBracketValuesBloc();
    _scrollController.addListener(() {
      print("Listener received");
    });

    super.initState();
  }

  @override
  void dispose() {
    stepBracketValuesBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: HexColor.fromHex("#0E1011"),
        backgroundColor: HexColor.fromHex("#fff"),
        appBar: CustomeAppBar(Consumer<UrlHolder>(
          builder: (context, value, child) => BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homeState) => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<LiveViewBloc, bool>(
                  builder: (context, isLiveView) {
                    return FocusMenuButton(
                      hide: isLiveView && homeState is HomeStateCamera,
                      focusListener: (isFocus) {
                        setState(() {
                          this.isFocus = isFocus;
                        });
                      },
                    );
                  },
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) {
                    return BlocBuilder<BasicHolyGrailBloc, int>(
                      builder: (context, state) {
                        return BlocBuilder<SelectedParamsTabBloc, int>(
                          builder: (context, index) => KeyFrameBtn(
                            focusListener: (bool isFocus) {
                              if (index == null) return;
                              context.read<KeyFrameBloc>().add(isFocus);
                            },
                            hide: homeState is HomeStateTimelapse &&
                                state == 1 &&
                                (index != 4 && index != 5 && index != null),
                          ),
                        );
                      },
                    );
                  },
                ),
                if (homeState is! HomeStateTimelapse &&
                    homeState is! HomeStateFlash &&
                    homeState is! HomeStateFile)
                  BlocBuilder<KeyFrameBloc, bool>(
                    builder: (context, isKeyFrame) =>
                        BlocBuilder<TabBloc, TabState>(
                      builder: (context, tabState) {
                        if (tabState is TabStateHDR) {
                          return Container();
                        }
                        if (isKeyFrame) {
                          return Container();
                        }
                        if (homeState is HomeStateHighSpeed) {
                          // return HighSpeedMenuButton();
                          return Container();
                        }
                        return LiveViewMenuButton(
                          hide: true,
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        )),
        body: Consumer<UrlHolder>(
          builder: (context, value, child) {
            return BlocBuilder<HomeBloc, HomeState>(
              builder: (context, homeState) => LayoutBuilder(
                builder: (context, constraint) {
                  return BlocConsumer<MoreOptionVisibilityBloc, bool>(
                    listener: (context, isMore) {
                      if (isMore) {}
                    },
                    builder: (context, isMore) {
                      return BlocConsumer<AddKeyFrameStateBloc, bool>(
                        listener: (context, state) {
                          // print("keyState");
                        },
                        builder: (context, isAddKeyFrame) =>
                            NotificationListener(
                                onNotification: (Notification t) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    // print(
                                    //     "NotificationListener ${_scrollController.position.maxScrollExtent}");

                                    bool isMore = context
                                        .read<MoreOptionVisibilityBloc>()
                                        .state;
                                    if (isMore) {
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        curve: Curves.easeOut,
                                        duration:
                                            const Duration(milliseconds: 30),
                                      );
                                    }

                                    bool lockScrollMain = context
                                        .read<LockMainScrollBloc>()
                                        .state;
                                    if (lockScrollMain) {
                                      //   print("lockScrollMain ");
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        curve: Curves.easeOut,
                                        duration:
                                            const Duration(milliseconds: 100),
                                      );
                                    }
                                  });

                                  return true;
                                },
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  physics: isMore
                                      ? NeverScrollableScrollPhysics()
                                      : null,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minHeight: constraint.maxHeight),
                                    child: IntrinsicHeight(
                                        child: BlocBuilder<LiveViewBloc, bool>(
                                            builder:
                                                (context, isLiveView) =>
                                                    BlocBuilder<KeyFrameBloc,
                                                        bool>(
                                                      builder: (context,
                                                              isKeyFrame) =>
                                                          Column(
                                                        children: <Widget>[
                                                          if (isKeyFrame &&
                                                              !isLiveView)
                                                            Container(
                                                              height: 300,
                                                              child: ListView(
                                                                shrinkWrap:
                                                                    true,
                                                                children: [
                                                                 HolyGraphView()
                                                                ],
                                                              ),
                                                            ),
                                                          if (isLiveView &&
                                                              !isKeyFrame &&
                                                              homeState
                                                                  is HomeStateCamera)
                                                            LiveViewWidget(
                                                              url: formUrl(
                                                                  value.url),
                                                            ),
                                                          if (isFocus &&
                                                              !isKeyFrame)
                                                            FocusRowTab(
                                                              url: formUrl(
                                                                  value.url),
                                                            ),
                                                          Expanded(
                                                            child: !isFocus
                                                                ? BlocListener<
                                                                TabBloc,
                                                                TabState>(
                                                              listener:  (context,  tabState) {
                                                                WidgetsBinding  .instance.addPostFrameCallback(
                                                                        (timeStamp) {
                                                                      // print(_scrollController
                                                                      //     .position
                                                                      //     .pixels);
                                                                      bool isMore = context.read<MoreOptionVisibilityBloc>() .state;
                                                                      if (isMore) {
                                                                        _scrollController
                                                                            .animateTo(
                                                                          _scrollController.position.maxScrollExtent,
                                                                          curve:
                                                                              Curves.easeOut,
                                                                          duration:
                                                                              const Duration(milliseconds: 300),
                                                                        );
                                                                      }
                                                                    });
                                                              },
                                                              child: BlocBuilder<
                                                                  HomeBloc,
                                                                  HomeState>(
                                                                builder:
                                                                    (context,
                                                                    state) {
                                                                  if (state
                                                                  is HomeStateCamera)
                                                                    return Container(
                                                                      child:
                                                                      ScrollerValueSelecter(
                                                                        stepBracketValuesBloc: stepBracketValuesBloc,
                                                                        url: formUrl(value.url),
                                                                      ),
                                                                    );
                                                                  if (state
                                                                  is HomeStateFile)
                                                                    return Container(
                                                                        child: Column(children: [
                                                                          Expanded(child: SdCardsList()),
                                                                          Container(
                                                                            child: ScrollerValueSelecter(
                                                                              stepBracketValuesBloc: stepBracketValuesBloc,
                                                                              url: formUrl(value.url),
                                                                            ),
                                                                          ),
                                                                        ]));
//
                                                                  if (state
                                                                  is HomeStateHighSpeed)
                                                                    return Container(
                                                                        child: Column(children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 13.h),
                                                                            child: HighSpeedMainContent()
                                                                          ),
                                                                          Container(
                                                                            child: ScrollerValueSelecter(
                                                                              stepBracketValuesBloc: stepBracketValuesBloc,
                                                                              url: formUrl(value.url),
                                                                            ),
                                                                          ),
                                                                        ]));
//
                                                                  if (state  is HomeStateFlash)
                                                                    return Container(
                                                                        child: Column(children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 13.h),
                                                                            child: FlashList(),
                                                                          )
                                                                        ]));

                                                                  return Container(
                                                                    child:
                                                                    ScrollerValueSelecter(
                                                                      stepBracketValuesBloc:
                                                                      stepBracketValuesBloc,
                                                                      url:
                                                                      formUrl(value.url),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                                : Container(),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Wrap(
                                                              children: [
                                                                BlocBuilder<
                                                                    HomeBloc,
                                                                    HomeState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    if (state
                                                                        is HomeStateFlash)
                                                                      return  Container(
                                                                        child: ScrollerValueSelecter(
                                                                          stepBracketValuesBloc: stepBracketValuesBloc,
                                                                          url: formUrl(value.url),
                                                                        ),
                                                                      );
                                                                    return Container();
                                                                  },
                                                                ),
                                                                if (!isFocus)
                                                                  Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child: BlocBuilder<
                                                                          HomeBloc,
                                                                          HomeState>(
                                                                        builder:
                                                                            (context,
                                                                                state) {
                                                                          if (state
                                                                              is HomeStateCamera)
                                                                            return ParameterTabs(
                                                                              paramTabSelected: (int index) {
                                                                                print("index is $index");

                                                                             setTabEvent(index, context);
                                                                              },
                                                                            );
                                                                          if (state
                                                                              is HomeStateFlash)
                                                                            return FlashParamsTabs(
                                                                              paramTabSelected: (int index) {
                                                                                print("index $index");

                                                                                setTabEvent(index, context);
                                                                              },
                                                                            );
                                                                          if (state
                                                                              is HomeStateTimelapse)
                                                                            return TimeLapseParamsTabs(
                                                                              paramTabSelected: (index) {
                                                                                context.read<HighLightedKeyFrameBloc>().removeAll();
                                                                                setTabHolyEvent(index, context);
                                                                              },
                                                                            );
                                                                          return Container();
                                                                        },
                                                                      )),
                                                                BlocBuilder<
                                                                    HomeBloc,
                                                                    HomeState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    if (state
                                                                        is HomeStateCamera)
                                                                      return VideoCameraScroller();

                                                                    if (state
                                                                        is HomeStateFlash)
                                                                      return FlashScroller();

                                                                    if (state
                                                                        is HomeStateHighSpeed)
                                                                      return HighSpeedScroller();

                                                                    if (state
                                                                        is HomeStateFile)
                                                                      return FileScroller();

                                                                    if (state
                                                                        is HomeStateTimelapse)
                                                                      return BasicHolyGrailScroller();

                                                                    return VideoCameraScroller();
                                                                  },
                                                                ),
                                                                BlocBuilder<
                                                                    HomeBloc,
                                                                    HomeState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    if (state
                                                                        is HomeStateCamera)
                                                                      return Padding(
                                                                        padding:  EdgeInsets.only(bottom: 20.h),
                                                                        child: RowMoreFlickrCaptureRawImage(
                                                                          url: value
                                                                              .url,
                                                                          isCamera: true,
                                                                        ),
                                                                      );
                                                                    if (state is HomeStateFlash) {
                                                                      context
                                                                          .read<
                                                                              VideoActiveBloc>()
                                                                          .add(
                                                                              true);
                                                                      return Padding(
                                                                        padding:  EdgeInsets.only(bottom: 20.h),
                                                                        child: RowMoreFlickrCaptureRawImage(
                                                                          url: value
                                                                              .url,
                                                                          isCamera: false,
                                                                        ),
                                                                      );
                                                                    }
                                                                    return Padding(
                                                                      padding:  EdgeInsets.only(bottom: 20.h),
                                                                      child: RowMoreCaptureImage(),
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          BlocBuilder<HomeBloc,
                                                              HomeState>(
                                                            builder: (context,
                                                                    homeSTate) =>
                                                                BlocBuilder<
                                                                    BasicHolyGrailBloc,
                                                                    int>(
                                                              builder: (context,
                                                                  holy) {
                                                                if (holy == 0 &&
                                                                    homeSTate
                                                                        is HomeStateTimelapse)
                                                                  return BasicMoreOptions(
                                                                    scrollController:
                                                                        _scrollController,
                                                                  );

                                                                return CameraPhotMore(
                                                                  url: formUrl(
                                                                      value
                                                                          .url),
                                                                  scrollController:
                                                                      _scrollController,
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ))),
                                  ),
                                )

                            ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ));
  }

  setTabEvent(int index, BuildContext context) {
    if (index == 0) {
      context.read<TabBloc>().add(TabEventSwitchShutterSpeed());
    } else if (index == 1) {
      context.read<TabBloc>().add(TabEventSwitchFstop());
    } else if (index == 2) {
      context.read<TabBloc>().add(TabEventSwitchISO());
    } else if (index == 3) {
      context.read<TabBloc>().add(TabEventSwitchWB());
    } else if (index == 4) {
      context.read<TabBloc>().add(TabEventSwitchHDR());
    } else {
      context.read<TabBloc>().add(TabEventSwitchInitial());
    }
  }
}

setTabHolyEvent(int index, BuildContext context) {
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
      context
          .read<TabBloc>()
          .add(isHoly == 1 ? TabEventSwitchHolyFstop() : TabEventSwitchFstop());
    } else if (index == 2) {
      context
          .read<TabBloc>()
          .add(isHoly == 1 ? TabEventSwitchHolyISO() : TabEventSwitchISO());
    } else if (index == 3) {
      context.read<TabBloc>().add(TabEventSwitchWB());
    } else if (index == 4) {
      context.read<TabBloc>().add(isHoly == 1
          ? TabEventSwitchHolyInterval()
          : TabEventSwitcBasicInterval());
    } else if (index == 5) {
      context.read<TabBloc>().add(TabEventSwitchHolyDuration());
    } else {
      context.read<TabBloc>().add(TabEventSwitchInitial());
    }
  }
}
