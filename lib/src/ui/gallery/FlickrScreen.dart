import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neo/src/bloc/flickr/flickr_state_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/url_holder.dart';
import 'package:neo/src/ui/custom_widgets/camera_shutterspeed/capture_button.dart';
import 'package:neo/src/ui/custom_widgets/camera_video/video_camera_scroller.dart';
import 'package:neo/src/ui/custom_widgets/custom_app_bar.dart';
import 'package:neo/src/ui/custom_widgets/row_more_flickr_capture_raw_image/row_more_flickr_capture_raw_image.dart';
import 'package:url_launcher/url_launcher.dart';

class FlickrScreen extends StatefulWidget {
  const FlickrScreen({Key key}) : super(key: key);

  @override
  _FlickrScreenState createState() => _FlickrScreenState();
}

class _FlickrScreenState extends State<FlickrScreen> {
  XFile _chooseImagefromPhone;
  int selectedImageIndex = 0;
  int selectedDirectory = 0;
  final ImagePicker _picker = ImagePicker();
  bool isJsonUI = false;
  UrlHolder urlHolder = UrlHolder();
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = 220.h;
    return BlocBuilder<FlickrStateBloc, FlickState>(
        builder: (BuildContext context, FlickState flickState) {
      return Scaffold(
        backgroundColor: HexColor.fromHex("#0E1011"),
        appBar: CustomeAppBar(Container()),
        body: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            children: [
              // SizedBox(height: 10.h),
              Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2)),
                        child: _chooseImagefromPhone == null &&
                                selectedImageIndex == 0
                            ? Container(
                                height: imageHeight,
                                color: Colors.black,
                                width: double.infinity,
                              )
                            : _chooseImagefromPhone != null &&
                                    selectedImageIndex == 0
                                ? Image.file(
                                    File(_chooseImagefromPhone.path),
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Image.memory(
                                    flickState
                                        .directoriesMap[FlickState
                                                .directories[selectedDirectory]]
                                            [selectedImageIndex]
                                        .imageBytes,
                                    height: imageHeight,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                      )),
                ],
              ),
              SizedBox(
                height: 7.h,
              ),
              isJsonUI
                  ? jsonUIWidget(flickState.directoriesMap[FlickState
                      .directories[selectedDirectory]][selectedImageIndex])
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: buildDirectoryNames(0, 4),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: buildDirectoryNames(4, 7),
                          ),
                        ],
                      ),
                    ),
             // Spacer(),
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: flickState
                      .directoriesMap[FlickState.directories[selectedDirectory]]
                      .length, // imageItemCount(),
                  itemBuilder: (BuildContext c, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 1.0,
                      ),
                      child: AspectRatio(
                          aspectRatio: 1.0,
                          child: GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: selectedImageIndex == index
                                          ? Colors.blueAccent
                                          : Colors.black,
                                      width: 4),
                                  color: HexColor.fromHex("#0E1011"),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(3.0),
                                    child: index == 0 &&
                                            _chooseImagefromPhone != null
                                        ? Image.file(
                                            File(_chooseImagefromPhone.path),
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                            width: 80.h,
                                          )
                                        : index == 0 &&
                                                _chooseImagefromPhone == null
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  height: 80.h,
                                                  color: Colors.black,
                                                  width: 80.h,
                                                ))
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                    height: 80.h,
                                                    width: 80.h,
                                                    child: SizedOverflowBox(
                                                        size: Size(80.h, 80.h),
                                                        // maxHeight: 100.h,
                                                        // maxWidth: double.infinity,
                                                        child: OverflowBox(
                                                           // maxHeight: 100.h,
                                                            maxWidth:
                                                                double.infinity,
                                                            child: Image.memory(
                                                              flickState
                                                                  .directoriesMap[
                                                                      FlickState
                                                                              .directories[
                                                                          selectedDirectory]]
                                                                      [index]
                                                                  .imageBytes,
                                                            )))),
                                              ))),
                            onTap: () {
                              setState(() {
                                selectedImageIndex = index;
                                if (index == 0) {
                                  isJsonUI = false;
                                } else {
                                  isJsonUI = true;
                                }
                              });
                              if (index == 0) {
                              } else {
                                // jsonCaller(index);
                              }
                            },
                          )),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: VideoCameraScroller(),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 25.h), //25
                  child: Container(
                    color: HexColor.fromHex("#0E1011"),
                    padding: EdgeInsets.symmetric(horizontal: 36.w,),
                    height: 54.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(
                            "assets/icons/Button_Cancel_Pressed.svg",
                            height: 36.h,
                            color: Colors.white,
                            width: 36.w,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        isJsonUI
            ? Padding(
              padding: const EdgeInsets.only(left: 5.0),
              // child: GestureDetector(
              //   child: SizedBox(
              //     width: 64.w,
              //     height: 64.h,
              //     child: SvgPicture.asset(
              //       "assets/icons/Button_Capture_Idle.svg",
              //     ),
              //   ),
              //   onTap: () {
              //     print('Hi');
              //     picFromPhone();
              //   },
              // ),
              child: Stack(
                            children: [
                              Positioned.fill(
                                  child: CircularProgressIndicator(
                                    value: 100,
                                    semanticsLabel: 'Linear progress indicator',
                                  )),
                              Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                                height:  50,
                                width:  50,
                              )
                            ],
                          ),
            )
                            : SizedBox.shrink(),
                        isJsonUI
                            ? SvgPicture.asset(
                                "assets/icons/Button_Add_Pressed.svg",
                                height: 36.h,
                                color: HexColor.fromHex("#0E1011"),
                                width: 36.w,
                              )
                            : GestureDetector(
                                child: SvgPicture.asset(
                                  "assets/icons/Button_Add_Pressed.svg",
                                  height: 36.h,
                                  color: Colors.white,
                                  width: 36.w,
                                ),
                                onTap: () {
                                  print('Hi');
                                  picFromPhone();
                                },
                              )
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // )
            ],
          ),
        ),
      );
    });
  }

  containerText({
    bool selected,
    String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blueAccent, width: 1),
          color: !selected ? HexColor.fromHex("#0E1011") : Color(0xFF2B84D2),
        ),
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        child: Row(
          children: [
            Text(text,
                style: latoSemiBold.copyWith(
                    fontSize: 14.sp,
                    color: selected
                        ? HexColor.fromHex("#EDEFF0")
                        : Colors.white70)),
          ],
        ),
      ),
    );
  }

  picFromPhone() async {
    _chooseImagefromPhone =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {});
  }

  List<Widget> buildDirectoryNames(start, end) {
    List<Widget> result = [];

    for (int i = start; i < end; i++) {
      String value = FlickState.directories[i];
      result.add(GestureDetector(
        child: containerText(
            selected: i == selectedDirectory,
            text: "${value[0].toUpperCase()}${value.substring(1)}"),
        onTap: () {
          setState(() {
            isJsonUI = false;
            selectedImageIndex = 0;
            selectedDirectory = i;
          });
        },
      ));
    }

    return result;
  }

  jsonUIWidget(FlickrStateItem item) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text.rich(
                        TextSpan(
                          text: item.owner + ' ',
                          style: latoSemiBold.copyWith(
                              fontSize: 12.sp,
                              color: HexColor.fromHex("EDEFF0")),
                          children: <TextSpan>[
                            TextSpan(
                                text: "\"",
                                style: latoSemiBold.copyWith(
                                    fontSize: 12.sp, color: Colors.white70)),
                            TextSpan(
                                text: item.title,
                                style: latoSemiBold.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.sp,
                                    color: Colors.white70)),
                            TextSpan(
                                text: "\"",
                                style: latoSemiBold.copyWith(
                                    fontSize: 12.sp, color: Colors.white70)),
                            // can add more TextSpans here...
                          ],
                        ),
                      ),
                      onTap: () async {
                        if (!item.url.startsWith("http")) {
                          item.url = 'https://' + item.url;
                        }
                        await canLaunch(item.url)
                            ? await launch(item.url)
                            : print('error');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 11.h,
              ),

              //Group_FlickrSuggestion
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("${item.shutter}", // //28.0-200.0 mm f/3.8-5.6
                            style: latoSemiBold.copyWith(
                                fontSize: 22.sp, color: Color(0xFF3498DB))),
                        Text("SHUTTER",
                            style: latoSemiBold.copyWith(
                                fontSize: 12.sp,
                                color: HexColor.fromHex("#3E505B"))), //#3E505B
                      ],
                    ),
                    Column(
                      children: [
                        Text("${item.fstop}", // //28.0-200.0 mm f/3.8-5.6
                            style: latoSemiBold.copyWith(
                                fontSize: 22.sp, color: Color(0xFF3498DB))),
                        Text("F-STOP",
                            style: latoSemiBold.copyWith(
                                fontSize: 12.sp,
                                color: HexColor.fromHex("#3E505B"))),
                      ],
                    ),
                    Column(
                      children: [
                        Text("${item.iso}", // //28.0-200.0 mm f/3.8-5.6
                            style: latoSemiBold.copyWith(
                                fontSize: 22.sp, color: Color(0xFF3498DB))),
                        Text("ISO",
                            style: latoSemiBold.copyWith(
                                fontSize: 12.sp,
                                color: HexColor.fromHex("#3E505B"))),
                      ],
                    ),
                    Column(
                      children: [
                        Text("${item.zoom}", // //28.0-200.0 mm f/3.8-5.6
                            style: latoSemiBold.copyWith(
                                fontSize: 22.sp, color: Color(0xFF3498DB))),
                        Text("ZOOM",
                            style: latoSemiBold.copyWith(
                                fontSize: 12.sp,
                                color: HexColor.fromHex("#3E505B"))),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                        "${item.camera} ${item.lens} ${item.fstop}", // //28.0-200.0 mm f/3.8-5.6
                        style: latoSemiBold.copyWith(
                            fontSize: 12.sp, color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
