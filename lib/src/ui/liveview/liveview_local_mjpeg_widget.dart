import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class LiveViewLocalMjpeg extends StatefulWidget {
  @override
  _LiveViewLocalMjpegState createState() => _LiveViewLocalMjpegState();
}

class _LiveViewLocalMjpegState extends State<LiveViewLocalMjpeg> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    ImagePicker().pickVideo(source: ImageSource.gallery).then((XFile video) {
      _controller = VideoPlayerController.contentUri(Uri.file(video.path))
        ..initialize();
    }).then((_) async {
      await Future.delayed(Duration(milliseconds: 1000), () => print(2));
      _controller.addListener(() {
        //custom Listner
        setState(() {
          if (!_controller.value.isPlaying &&
              _controller.value.isInitialized &&
              (_controller.value.duration == _controller.value.position)) {
            //checking the duration and position every time
            //Video Completed//
            setState(() {});
          }
        });
      });
      _controller.setVolume(0);
      _controller.play().then((value) {
        setState(() {});
      });
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topLeft, children: [
      Center(
        child: _controller != null
            ? _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                      ],
                    ),
                  )
                : Container()
            : Container(),
      ),
      _controller != null && !_controller.value.isPlaying
          ? Positioned(
              child: Center(
                  child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.play().then((value) {
                    setState(() {});
                  });
                });
              },
                    //Fade play button..
              // child: SvgPicture.asset(
              //   "assets/icons/Button_Play_Idle.svg",
              //   height: 64.sp,
              //
              //   width: 64.sp,
              // ),
            )))
          : Container()
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
