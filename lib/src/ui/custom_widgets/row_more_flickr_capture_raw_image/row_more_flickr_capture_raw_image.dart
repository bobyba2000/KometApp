import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_state.dart';
import 'package:neo/src/bloc/video/video_active_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/capture_button.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/flickr_button.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/gallery_button.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/more_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/raw_button.dart';

class RowMoreFlickrCaptureRawImage extends StatelessWidget {
  final String url;
  final isCamera;

  const RowMoreFlickrCaptureRawImage(
      {Key key, @required this.url, this.isCamera})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor.fromHex("#0E1011"),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ), //horizontal: 10.4
      child: BlocBuilder<VideoActiveBloc, bool>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: MoreButton(),
              ),
              if (isCamera) FlickrButton(),
              CaptureButton(
                url: formUrl(url),
              ),
              if (isCamera) RawButton(),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: GallerButton(),
              ),
            ],
          );
        },
      ),
    );
  }
}
