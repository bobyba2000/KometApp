import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/res/server_helpers/stream_helper.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/bloc/mjepg_histo/mjpeg_histo_bloc.dart';
import 'package:neo/src/model/live_view.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/io.dart';

import 'histogram/histogram_widget.dart';
import 'liveview_local_mjpeg_widget.dart';
import 'mjpeg/mjpeg_widget.dart';

class LiveViewWidget extends StatefulWidget {
  final String url;

  const LiveViewWidget({Key key, @required this.url}) : super(key: key);
  @override
  _LiveViewWidgetState createState() => _LiveViewWidgetState();
}

class _LiveViewWidgetState extends State<LiveViewWidget>
    with TickerProviderStateMixin {
  IOWebSocketChannel channel;
  MjpegHistoBloc mjpegHistoBloc;
  StreamHelper streamHelper;

  AnimationController expandController;
  Animation<double> animation;
  String liveViewUrl;

  ///Setting up the animation
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(widget.url);
    mjpegHistoBloc = MjpegHistoBloc();
    streamHelper = StreamHelper(mjpegHistoBloc);
    start(widget.url);

    prepareAnimations();

    super.initState();
  }

  Future start(String webUrl) async {
    print("start liveview");
    try {
      StreamSubscription streamController;
      final Map<dynamic, dynamic> map = {
        "CMD": {"LIVEVIEW": "START"}
      };
      channel.sink.add(jsonEncode(map));
      streamController = channel.stream.listen((event) async {
        try {
          print("event received $event");
          Map json = jsonDecode(event);
          if (json["RSP"] != null) {
            if (json["RSP"]["LIVEVIEW"] != null) {
              if (json["RSP"]["LIVEVIEW"] == "OK") {
                // context.read<ParamsIsoBloc>().add(curentvalue);
                LiveView fstop = LiveView.fromJson(jsonDecode(event));
                await Future.delayed(Duration(milliseconds: 5500), () {
                  setState(() {
                    liveViewUrl = fstop.rsp.stream;
                    // liveViewUrl = 'http://103.232.103.205:8090/feed.mjpeg';
                  });
                  // streamHelper.start(
                  //     true, 'http://103.232.103.205:8090/feed.mjpeg');
                });
                // streamController.cancel();
              }
            }
          }
        } catch (e) {
          print("error on fetch ISO $e");
        }
      }, onDone: () {
        print("done LiveView ");
        streamController.cancel();
      }, onError: (e) {
        print("error LiveView $e ");
        streamController.cancel();
      });
    } catch (error) {
      print("error on stream $error");
    }
  }

  @override
  void dispose() {
    channel.sink.add(
      jsonEncode(
        {
          'CMD': {
            'LIVEVIEW': 'STOP',
          }
        },
      ),
    );
    streamHelper.dispose();
    mjpegHistoBloc.close();
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    expandController.forward();
    return BlocProvider(
      create: (context) => LiveViewErrorBloc(),
      child: BlocListener<LiveViewBloc, bool>(
        listener: (context, isLiveView) {
          if (isLiveView) {
          } else {
            //  expandController.reverse();
          }
        },
        child: SizeTransition(
          sizeFactor: animation,
          child: GestureDetector(
            onTap: () {
              channel.sink.add(
                jsonEncode(
                  {
                    "CMD": {"FOCUS": "AUTO"}
                  },
                ),
              );
            },
            child: Container(
              height: 240.h,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        height: 240.h,
                        margin: EdgeInsets.symmetric(horizontal: 7.5.w),
                        child: liveViewUrl == null
                            ? Center(
                                child: Container(
                                  height: 50.h,
                                  width: 50.w,
                                  child: CircularProgressIndicator(
                                    semanticsLabel: 'Linear progress indicator',
                                  ),
                                ),
                              )
                            : liveViewUrl != 'demo'
                                ? FutureBuilder(
                                    future: Future.delayed(
                                      Duration(seconds: 5),
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: Container(
                                            height: 50.h,
                                            width: 50.w,
                                            child: CircularProgressIndicator(
                                              semanticsLabel:
                                                  'Linear progress indicator',
                                            ),
                                          ),
                                        );
                                      }
                                      return MjpegWidget(
                                        isLive: true,
                                        stream: "$liveViewUrl",
                                        mjpegHistoBloc: mjpegHistoBloc,
                                      );
                                    })
                                : LiveViewLocalMjpeg(),
                      ))
                    ],
                  ),
                  BlocBuilder<LiveViewErrorBloc, bool>(
                    builder: (context, state) {
                      if (state) {
                        return Container();
                      }
                      return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 70.h,
                            width: 225.w,
                            // height: 200,
                            // width: 300,
                            child: BlocBuilder<MjpegHistoBloc, MjpegHistoState>(
                                bloc: mjpegHistoBloc,
                                builder: (context, state) {
                                  if (state is MjpegHistoErrorState) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.errorMessage,
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    );
                                  }
                                  return SplineChart(
                                    chartDataBlue: state.blueBin,
                                    chartDataRed: state.redBin,
                                    chartDataGreen: state.greenBin,
                                  );
                                }),
                          ));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LiveViewErrorBloc extends Bloc<bool, bool> {
  LiveViewErrorBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}

class LocalVideoWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const LocalVideoWidget({Key key, this.controller}) : super(key: key);

  @override
  _LocalVideoWidgetState createState() => _LocalVideoWidgetState();
}

class _LocalVideoWidgetState extends State<LocalVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(widget.controller);
  }
}
